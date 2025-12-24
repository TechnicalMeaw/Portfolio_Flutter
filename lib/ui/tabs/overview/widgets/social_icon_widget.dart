// Helper method for social media icons
import 'package:flutter/material.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconWidget extends StatelessWidget {
  SocialIconWidget({super.key, required this.assetPath,
    this.url,
    this.normalColor = ColorConstants.glassWhite, // Corrected from glassBlack based on usage
    this.hoverColor = ColorConstants.white, this.onTap,});

  final String assetPath;
  final String? url;
  final Color normalColor; // Corrected from glassBlack based on usage
  final Color hoverColor;
  bool isHovered = false;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onTap: onTap ?? () async {
            if (url != null && url!.isNotEmpty) {
              final Uri parsedUrl = Uri.parse(url!);
              if (!await launchUrl(parsedUrl)) {
                throw Exception('Could not launch $parsedUrl');
              }
            }

          },
          child: Image(
              height: 18,
              width: 18,
              image: AssetImage(assetPath),
              color: isHovered ? hoverColor : normalColor,
            ),
          )
      ),
    );
  }
}