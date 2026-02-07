import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      );

  final Widget page;
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.image, required this.tag});

  final Widget image;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GeneralEffectsButton(
            onTap: () => Navigator.pop(context),
            splashColor: ColorConverter.lighten(AppColor.primaryColor),
            borderRadius: BorderRadius.circular(30),
            child: const Icon(Icons.arrow_back_ios_rounded, size: 28, color: Colors.white),
          ),
        ),
        body: Center(
          child: Hero(
            tag: tag,
            flightShuttleBuilder: (_, _, _, _, _) => image,
            child: InteractiveViewer(clipBehavior: Clip.none, minScale: 1, maxScale: 4, child: image),
          ),
        ),
      ),
    );
  }
}
