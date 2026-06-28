final class CountryCode {
  const CountryCode({required this.id, required this.name, required this.code});

  final int id;
  final String name;
  final String code;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is CountryCode &&
            other.id == id &&
            other.name == name &&
            other.code == code;
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, code);

  @override
  String toString() => 'CountryCode(id: $id, name: $name, code: $code)';
}

const List<CountryCode> defaultCountryCodes = [
  CountryCode(id: 86, name: '中国大陆', code: '+86'),
  CountryCode(id: 1, name: '美国', code: '+1'),
  CountryCode(id: 81, name: '日本', code: '+81'),
  CountryCode(id: 886, name: '中国台湾', code: '+886'),
  CountryCode(id: 852, name: '中国香港', code: '+852'),
  CountryCode(id: 853, name: '中国澳门', code: '+853'),
];
