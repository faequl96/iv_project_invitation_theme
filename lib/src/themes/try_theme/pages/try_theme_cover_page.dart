import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class TryThemeCoverPage extends StatelessWidget {
  const TryThemeCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          ColoredBox(
            color: Colors.green,
            child: Image.asset(
              // 'https://iv-project-web-app.vercel.app/assets/packages/iv_project_invitation_theme/assets/dummys/try_theme_cover_image.jpg',
              'assets/dummys/try_theme_cover_image.jpg',
              package: 'iv_project_invitation_theme',
              height: ScreenUtil.size.height / 1.2,
              width: ScreenUtil.size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.3,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.grey.shade700],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 2,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pernikahan Dari',
                      style: TextStyle(fontSize: FontScale.x2l, color: ColorConverter.darken(Colors.grey.shade300, 7)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rahma &',
                      style: GoogleFonts.pacifico(
                        fontSize: FontScale.x11l,
                        fontWeight: FontWeight.w500,
                        color: ColorConverter.darken(Colors.grey.shade300, 5),
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'Faiq',
                      style: GoogleFonts.pacifico(
                        fontSize: FontScale.x11l,
                        fontWeight: FontWeight.w500,
                        color: ColorConverter.darken(Colors.grey.shade300, 5),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
