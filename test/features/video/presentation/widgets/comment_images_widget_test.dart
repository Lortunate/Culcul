import 'package:culcul/shared/contracts/comment_contract.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_images.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('single comment image uses bounded decode dimensions', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(devicePixelRatio: 2),
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: CommentImagesWidget(
                pictures: [
                  CommentPicture(
                    imgSrc: 'https://example.com/cover.jpg',
                    imgWidth: 400,
                    imgHeight: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final imageWidget = tester.widget<ExtendedImage>(find.byType(ExtendedImage).first);
    final resized = imageWidget.image as ExtendedResizeImage;
    expect(resized.width, 400);
    expect(resized.height, 200);
  });

  testWidgets('grid images use item-size based decode dimensions', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(devicePixelRatio: 2),
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: CommentImagesWidget(
                pictures: [
                  CommentPicture(imgSrc: 'https://example.com/1.jpg'),
                  CommentPicture(imgSrc: 'https://example.com/2.jpg'),
                  CommentPicture(imgSrc: 'https://example.com/3.jpg'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final imageWidget = tester.widget<ExtendedImage>(find.byType(ExtendedImage).first);
    final resized = imageWidget.image as ExtendedResizeImage;
    expect(resized.width, 189);
    expect(resized.height, 189);
  });

  testWidgets('empty picture list renders nothing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CommentImagesWidget(pictures: [])),
      ),
    );

    expect(find.byType(ExtendedImage), findsNothing);
  });
}
