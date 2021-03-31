import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class LinkListItemShimmer extends StatelessWidget {
  const LinkListItemShimmer({Key? key}) : super(key: key);

  static const _titleShimmerHeight = 12.0;
  static const _titleVerticalGap = Gap(4);

  static const _subTitleShimmerHeight = 8.0;
  static const _subTitleVerticalGap = Gap(2);

  static const _imageWidth = 80.0;
  static const _imageHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth - (80 + 48);

    final titleContainerInfinityWidth = Container(
      width: double.infinity,
      height: _titleShimmerHeight,
      color: Colors.white,
    );
    final titleContainerHalfwayWidth = Container(
      width: textWidth * 2 / 5,
      height: _titleShimmerHeight,
      color: Colors.white,
    );

    final subTitleContainerInfinityWidth = Container(
      width: double.infinity,
      height: _subTitleShimmerHeight,
      color: Colors.white,
    );
    final subTitleContainerHalfwayWidth = Container(
      width: textWidth / 5,
      height: _subTitleShimmerHeight,
      color: Colors.white,
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  titleContainerInfinityWidth,
                  _titleVerticalGap,
                  titleContainerHalfwayWidth,
                  _titleVerticalGap,
                  subTitleContainerInfinityWidth,
                  _subTitleVerticalGap,
                  subTitleContainerInfinityWidth,
                  _subTitleVerticalGap,
                  subTitleContainerHalfwayWidth,
                ],
              ),
            ),
            const Gap(16),
            Container(
              width: _imageWidth,
              height: _imageHeight,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
