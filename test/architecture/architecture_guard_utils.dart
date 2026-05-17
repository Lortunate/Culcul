import 'dart:io';

final String packageName = _readPackageName();

List<File> dartFiles(String root) {
  return Directory(root)
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .where((file) => normalizePath(file.path).endsWith('.dart'))
      .toList()
    ..sort((a, b) => normalizePath(a.path).compareTo(normalizePath(b.path)));
}

List<File> authoredDartFiles(Directory root) => sourceDartFiles(root.path);

List<File> sourceDartFiles(String root) {
  return dartFiles(
    root,
  ).where((file) => !isGeneratedDartPath(normalizePath(file.path))).toList();
}

List<File> generatedDartFiles(String root) {
  return dartFiles(
    root,
  ).where((file) => isGeneratedDartPath(normalizePath(file.path))).toList();
}

bool isGeneratedDartPath(String path) {
  final normalizedPath = normalizePath(path);
  return normalizedPath.endsWith('.g.dart') ||
      normalizedPath.endsWith('.freezed.dart') ||
      normalizedPath.startsWith('lib/protos/') ||
      RegExp(r'^lib/i18n/strings(?:_[A-Za-z_]+)?\.g\.dart$').hasMatch(normalizedPath);
}

String normalizePath(String path) => path.replaceAll(r'\', '/');

List<String> meaningfulLines(File file) {
  return file
      .readAsLinesSync()
      .map((line) => line.trim())
      .where(
        (line) =>
            line.isNotEmpty &&
            !line.startsWith('//') &&
            !line.startsWith('/*') &&
            !line.startsWith('*'),
      )
      .toList();
}

List<DartCodeLine> authoredDartCodeLines(File file) {
  final sourceLines = file.readAsLinesSync();
  final maskedLines = <DartCodeLine>[];
  var inBlockComment = false;
  var inString = false;
  var stringQuote = '';
  var isTripleQuotedString = false;
  var isRawString = false;

  for (var lineIndex = 0; lineIndex < sourceLines.length; lineIndex++) {
    final line = sourceLines[lineIndex];
    final buffer = StringBuffer();
    var index = 0;

    while (index < line.length) {
      final char = line[index];
      final next = index + 1 < line.length ? line[index + 1] : '';

      if (inBlockComment) {
        if (char == '*' && next == '/') {
          buffer.write('  ');
          index += 2;
          inBlockComment = false;
        } else {
          buffer.write(' ');
          index++;
        }
        continue;
      }

      if (inString) {
        final tripleQuote = '$stringQuote$stringQuote$stringQuote';
        if (isTripleQuotedString &&
            index + 2 < line.length &&
            line.substring(index, index + 3) == tripleQuote) {
          buffer.write('   ');
          index += 3;
          inString = false;
          continue;
        }

        if (!isTripleQuotedString && char == stringQuote) {
          buffer.write(' ');
          index++;
          inString = false;
          continue;
        }

        if (!isRawString && !isTripleQuotedString && char == r'\') {
          buffer.write(' ');
          if (index + 1 < line.length) {
            buffer.write(' ');
            index += 2;
          } else {
            index++;
          }
          continue;
        }

        buffer.write(' ');
        index++;
        continue;
      }

      if (char == '/' && next == '/') {
        buffer.write(' ' * (line.length - index));
        break;
      }

      if (char == '/' && next == '*') {
        buffer.write('  ');
        index += 2;
        inBlockComment = true;
        continue;
      }

      final rawStringPrefix =
          (char == 'r' || char == 'R') && next.isNotEmpty && (next == "'" || next == '"');
      if (rawStringPrefix) {
        buffer.write(' ');
        index++;
        isRawString = true;
      } else {
        isRawString = false;
      }

      final quote = line[index];
      if (quote == "'" || quote == '"') {
        final tripleQuote = '$quote$quote$quote';
        final triple =
            index + 2 < line.length && line.substring(index, index + 3) == tripleQuote;
        buffer.write(triple ? '   ' : ' ');
        index += triple ? 3 : 1;
        inString = true;
        stringQuote = quote;
        isTripleQuotedString = triple;
        continue;
      }

      buffer.write(char);
      index++;
    }

    maskedLines.add(DartCodeLine(lineIndex + 1, buffer.toString()));
  }

  return maskedLines;
}

List<DartCodeLine> commentStrippedDartCodeLines(File file) {
  final sourceLines = file.readAsLinesSync();
  final strippedLines = <DartCodeLine>[];
  var inBlockComment = false;
  var inMultilineString = false;
  var stringQuote = '';
  var isTripleQuotedString = false;

  for (var lineIndex = 0; lineIndex < sourceLines.length; lineIndex++) {
    final line = sourceLines[lineIndex];
    final buffer = StringBuffer();
    var index = 0;

    while (index < line.length) {
      final char = line[index];
      final next = index + 1 < line.length ? line[index + 1] : '';

      if (inBlockComment) {
        if (char == '*' && next == '/') {
          buffer.write('  ');
          index += 2;
          inBlockComment = false;
        } else {
          buffer.write(' ');
          index++;
        }
        continue;
      }

      if (inMultilineString) {
        final tripleQuote = '$stringQuote$stringQuote$stringQuote';
        if (isTripleQuotedString &&
            index + 2 < line.length &&
            line.substring(index, index + 3) == tripleQuote) {
          buffer.write('   ');
          index += 3;
          inMultilineString = false;
        } else {
          buffer.write(' ');
          index++;
        }
        continue;
      }

      if (char == '/' && next == '/') {
        buffer.write(' ' * (line.length - index));
        break;
      }

      if (char == '/' && next == '*') {
        buffer.write('  ');
        index += 2;
        inBlockComment = true;
        continue;
      }

      final quoteIndex =
          (char == 'r' || char == 'R') && next.isNotEmpty && (next == "'" || next == '"')
          ? index + 1
          : index;
      final quote = line[quoteIndex];
      if (quote == "'" || quote == '"') {
        final tripleQuote = '$quote$quote$quote';
        final triple =
            quoteIndex + 2 < line.length &&
            line.substring(quoteIndex, quoteIndex + 3) == tripleQuote;
        if (triple) {
          buffer.write(' ' * (quoteIndex - index));
          buffer.write('   ');
          index = quoteIndex + 3;
          inMultilineString = true;
          stringQuote = quote;
          isTripleQuotedString = true;
          continue;
        }
      }

      buffer.write(char);
      index++;
    }

    strippedLines.add(DartCodeLine(lineIndex + 1, buffer.toString()));
  }

  return strippedLines;
}

List<DartImport> dartImports(File file) {
  final path = normalizePath(file.path);
  final imports = <DartImport>[];
  final importPattern = RegExp(r'''^\s*import\s+['"]([^'"]+)['"]''');

  for (final line in commentStrippedDartCodeLines(file)) {
    final match = importPattern.firstMatch(line.text);
    if (match == null) {
      continue;
    }

    final uri = match.group(1)!;
    imports.add(
      DartImport(
        importerPath: path,
        lineNumber: line.lineNumber,
        uri: uri,
        resolvedPath: resolveImportPath(path, uri),
      ),
    );
  }

  return imports;
}

String? resolveImportPath(String importerPath, String importUri) {
  if (importUri.startsWith('dart:')) {
    return null;
  }

  final packagePrefix = 'package:$packageName/';
  if (importUri.startsWith(packagePrefix)) {
    return normalizePath('lib/${importUri.substring(packagePrefix.length)}');
  }

  if (importUri.startsWith('package:')) {
    return null;
  }

  final importerDirectory = importerPath.substring(0, importerPath.lastIndexOf('/'));
  return _normalizeSegments('$importerDirectory/$importUri');
}

String? featureNameFromPath(String path) {
  final match = RegExp(r'^lib/features/([^/]+)/').firstMatch(path);
  return match?.group(1);
}

String formatLocation(String path, int lineNumber) => '$path:$lineNumber';

String _normalizeSegments(String path) {
  final result = <String>[];
  for (final segment in normalizePath(path).split('/')) {
    if (segment.isEmpty || segment == '.') {
      continue;
    }
    if (segment == '..') {
      if (result.isNotEmpty) {
        result.removeLast();
      }
      continue;
    }
    result.add(segment);
  }
  return result.join('/');
}

String _readPackageName() {
  final pubspec = File('pubspec.yaml').readAsLinesSync();
  for (final line in pubspec) {
    final match = RegExp(r'^\s*name:\s*([A-Za-z0-9_]+)\s*$').firstMatch(line);
    if (match != null) {
      return match.group(1)!;
    }
  }
  throw StateError('Could not read package name from pubspec.yaml.');
}

class DartImport {
  const DartImport({
    required this.importerPath,
    required this.lineNumber,
    required this.uri,
    required this.resolvedPath,
  });

  final String importerPath;
  final int lineNumber;
  final String uri;
  final String? resolvedPath;
}

class DartCodeLine {
  const DartCodeLine(this.lineNumber, this.text);

  final int lineNumber;
  final String text;
}
