import 'package:flutter/material.dart';

class AttachmentWidget extends StatelessWidget {
  final dynamic image;

  const AttachmentWidget({
    super.key,this.image
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Image.asset(
          image,
          fit: BoxFit.cover, // Adjust the fit as needed
        ),
      ),
    );
  }
}