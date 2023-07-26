import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        'https://cdnl.iconscout.com/lottie/premium/preview-watermark/quotation-8756729-7079144.mp4?h=700', // Replace with your Lottie loader animation file path
        width: 100,
        height: 100,
        repeat: true, // Set repeat to true for the loader animation
      ),
    );
  }
}
