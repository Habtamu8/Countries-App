import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryShimmer extends StatelessWidget {
  const CountryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,  
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: Container(width: 50, height: 30, color: Colors.white),
        title: Container(width: double.infinity, height: 10, color: Colors.white),
        subtitle: Container(width: double.infinity, height: 10, color: Colors.white),
      ),
    );
  }
}
