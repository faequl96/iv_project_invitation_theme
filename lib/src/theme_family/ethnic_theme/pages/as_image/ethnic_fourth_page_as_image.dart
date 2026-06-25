import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class EthnicFourthPageAsImage extends StatelessWidget {
  const EthnicFourthPageAsImage({super.key, required this.config, required this.receptionEvent});

  final EthnicFourthPageConfig config;
  final EventResponse receptionEvent;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final contentPadding = EdgeInsets.only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76);

    return Stack(
      children: [
        if (config.firstGradientBackgroundColor != null &&
            config.secondGradientBackgroundColor != null)
          Positioned(
            top: 0,
            height: Screen.height / 1.2,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    config.firstGradientBackgroundColor!,
                    config.secondGradientBackgroundColor!,
                  ],
                  stops: const [.2, .8],
                ),
              ),
            ),
          ),

        ?config.background,

        Positioned(top: 0, child: _buildTitle(langCode)),

        Positioned(
          bottom: 0,
          height: Screen.height,
          width: Screen.width,
          child: Padding(
            padding: contentPadding,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: .circular(20),
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          height: Screen.height,
          width: Screen.width,
          child: Padding(
            padding: contentPadding,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
              child: ClipRect(
                child: Column(
                  children: [
                    SizedBox(height: H.lg),
                    _buildPlace(),
                    const SizedBox(height: 8),
                    _buildAddress(),
                    const Spacer(),
                    Maps(
                      borderColor: config.mapsBorderColor,
                      width: Screen.width - (W.x6s * 5),
                      height: Screen.height - (H.x22l),
                      delayBeforeStart: const Duration(milliseconds: 1000),
                      url: receptionEvent.mapsUrl,
                    ),
                    SizedBox(height: H.x2s),
                    _buildGetDirection(langCode),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),

        ?config.foreground,
      ],
    );
  }

  Widget _buildTitle(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.location_pin, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'Event Location' : 'Lokasi Acara',
          style: AppFonts.inter(
            color: config.titlePageColor,
            fontSize: FontSize.x3l,
            fontWeight: .w700,
          ),
        ),
      ],
    ),
  );

  Widget _buildPlace() => Column(
    children: [
      Icon(Icons.maps_home_work_rounded, size: 32, color: config.placeIconColor),
      const SizedBox(height: 4),
      Text(
        receptionEvent.place,
        style: AppFonts.inter(
          color: config.placeTextColor,
          fontSize: FontSize.xl,
          fontWeight: .w600,
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: config.dividingLineWidth,
        width: W.x18l,
        child: ColoredBox(color: config.dividingLineColor),
      ),
    ],
  );

  Widget _buildAddress() => Padding(
    padding: const .symmetric(horizontal: 20),
    child: Text(
      receptionEvent.address,
      style: AppFonts.inter(
        color: config.addressTextColor,
        fontSize: FontSize.xs,
        fontWeight: .w400,
      ),
      textAlign: .center,
    ),
  );

  Widget _buildGetDirection(String langCode) => QuickButton(
    onTap: () {},
    style: QuickButtonStyle(
      padding: const .symmetric(horizontal: 24),
      height: W.lg + H.x10s,
      borderRadius: .circular(30),
      border: .all(
        width: config.getDirectionsButtonBorderWidth,
        color: config.getDirectionsButtonBorderColor,
      ),
      color: config.getDirectionsButtonColor,
      elevation: 0,
    ),
    child: Stack(
      alignment: .center,
      children: [
        Text(
          langCode == 'en' ? 'Get Directions' : 'Dapatkan Petunjuk Arah',
          style: AppFonts.inter(
            color: config.getDirectionsButtonLabelColor,
            fontSize: FontSize.md,
            fontWeight: .w600,
          ),
        ),
      ],
    ),
  );
}
