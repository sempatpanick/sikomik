import 'package:flutter/material.dart';

import 'shimmer_loading_widget.dart';

class SkeletonTextWidget extends StatelessWidget {
  final double? width;
  const SkeletonTextWidget({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingWidget(
      isLoading: true,
      child: Container(
        height: 15,
        width: width ?? double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
