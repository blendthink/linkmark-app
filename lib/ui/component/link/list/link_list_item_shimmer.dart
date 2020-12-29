import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class LinkListItemShimmer extends StatelessWidget {
  const LinkListItemShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth - (80 + 48);

    const gapTextVerticalTitle = const Gap(4);
    final containerInfinityWidthTitle = Container(
      width: double.infinity,
      height: 12.0,
      color: Colors.white,
    );
    final containerHalfwayWidthTitle = Container(
      width: textWidth * 2 / 5,
      height: 12.0,
      color: Colors.white,
    );

    const gapTextVerticalSubTitle = const Gap(2);
    final containerInfinityWidthSubTitle = Container(
      width: double.infinity,
      height: 8.0,
      color: Colors.white,
    );
    final containerHalfwayWidthSubTitle = Container(
      width: textWidth / 5,
      height: 8.0,
      color: Colors.white,
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  containerInfinityWidthTitle,
                  gapTextVerticalTitle,
                  containerHalfwayWidthTitle,
                  gapTextVerticalTitle,
                  containerInfinityWidthSubTitle,
                  gapTextVerticalSubTitle,
                  containerInfinityWidthSubTitle,
                  gapTextVerticalSubTitle,
                  containerHalfwayWidthSubTitle,
                ],
              ),
            ),
            const Gap(16),
            Container(
              width: 80.0,
              height: 56.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
