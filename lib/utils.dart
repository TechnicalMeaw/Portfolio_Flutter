import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:portfolio/resources/asset_constants.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:portfolio/resources/color_constants.dart';

class Utils {
    Utils._();

    static Html convertTextToHtml({required String text, required TextStyle style, TextOverflow? overflow, bool shrinkLine = true}) {
      return Html(
        data: "<p>$text</p>",
        shrinkWrap: true,
        style: {
          "p": Style(
            fontSize: FontSize(style.fontSize ?? 14),
            fontWeight: style.fontWeight,
            color: style.color,
            fontStyle: style.fontStyle,
            fontFamily: style.fontFamily,
            letterSpacing: style.letterSpacing,
            wordSpacing: style.wordSpacing,
            textDecoration: style.decoration,
            textDecorationStyle: style.decorationStyle,
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
            textOverflow: overflow,
            display: Display.inlineBlock,
            lineHeight: !shrinkLine
                ? LineHeight.em(1.2)
                : LineHeight.em(0.5),
          ),
        },
      );
    }

    static Future<void> openResumePopup(BuildContext context) async {
      final viewType = "pdf-iframe-${DateTime.now().millisecondsSinceEpoch}";

      // Register the iframe view for web
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        viewType,
            (int id) {
          final iframe = html.IFrameElement()
            ..src = AssetConstants.pdfProdResume
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%';
          return iframe;
        },
      );

      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.35),
        builder: (ctx) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                // full-screen dismiss area
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(ctx).pop(),
                    child: const SizedBox.expand(),
                  ),
                ),

                // centered glass dialog
                Center(
                  child: GestureDetector(
                    onTap: () {}, // absorb inside taps
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          width: 900,
                          height: 600,
                          // Outer container: white 1px border + frosty color
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: ColorConstants.glassWhite.withOpacity(0.04),
                            border: Border.all(color: ColorConstants.glassWhite.withOpacity(0.95), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          // Important: 2px padding to create the exact inset line you showed
                          child: Column(
                            children: [
                              // Top toolbar (keeps rounded corners visually intact)
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants.glassWhite.withOpacity(0.02),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(24), // slightly smaller than outer to match inset
                                      topRight: Radius.circular(24),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          // optional tiny mac-like buttons can go here if needed
                                          const SizedBox(width: 16),
                                          const Expanded(
                                            child: Text(
                                              'Resume Preview',
                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.download),
                                            color: Colors.white,
                                            tooltip: "Download",
                                            onPressed: () {
                                              final anchor = html.AnchorElement(href: AssetConstants.pdfProdResume)
                                                ..download = "Santanu_Mukherjee_Resume.pdf"
                                                ..click();
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            color: Colors.white,
                                            onPressed: () => Navigator.of(ctx).pop(),
                                          ),
                                          const SizedBox(width: 16),
                                        ],
                                      ),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(24),
                                            bottomRight: Radius.circular(24),
                                          ), // inner radius slightly smaller than outer
                                          child: Container(
                                            // inner decoration to create a subtle inner border line (like your screenshot)
                                            decoration: BoxDecoration(
                                              color: ColorConstants.glassBlack.withOpacity(0.06),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomLeft: Radius.circular(24),
                                                bottomRight: Radius.circular(24),
                                              ),
                                            ),

                                            // The iframe fills this inner container
                                            child: HtmlElementView(viewType: viewType),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // The preview area: inner rounded clip so the iframe corners are perfect

                            ],
                          ), // end Padding(2px)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

}