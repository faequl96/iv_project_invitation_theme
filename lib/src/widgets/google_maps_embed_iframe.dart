import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/models/google_maps_lat_long.dart';
import 'package:iv_project_invitation_theme/src/widgets/shared_personalize.dart';

class GoogleMapsEmbedIframe extends StatefulWidget {
  const GoogleMapsEmbedIframe({super.key});

  @override
  State<GoogleMapsEmbedIframe> createState() => _GoogleMapsEmbedIframeState();
}

class _GoogleMapsEmbedIframeState extends State<GoogleMapsEmbedIframe> {
  String? _iframe;

  GoogleMapsLatLong _parseGoogleMapsUrl(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;

    double? markerLat;
    double? markerLong;
    double? viewLat;
    double? viewLong;

    // 1. Ambil koordinat dari '@lat,lng'
    final atIndex = path.indexOf('@');
    if (atIndex != -1) {
      final atSubstring = path.substring(atIndex + 1);
      final coords = atSubstring.split(',');
      if (coords.length >= 2) {
        viewLat = double.tryParse(coords[0]);
        viewLong = double.tryParse(coords[1]);
      }
    }

    // 2. Ambil koordinat dari '3d...4d...' (marker sebenarnya)
    final regExp3d4d = RegExp(r'!3d(-?\d+(\.\d+)?)!4d(-?\d+(\.\d+)?)');
    final match = regExp3d4d.firstMatch(path);
    if (match != null && match.groupCount >= 3) {
      markerLat = double.tryParse(match.group(1)!);
      markerLong = double.tryParse(match.group(3)!);
    }

    return GoogleMapsLatLong(markerLat: markerLat, markerLong: markerLong, viewLat: viewLat, viewLong: viewLong);
  }

  String? _convertToGoogleMapsEmbedIframe(String googleMapsUrl, {double? width, double? height}) {
    final result = _parseGoogleMapsUrl(googleMapsUrl);

    final lat = result.markerLat ?? result.viewLat;
    final lng = result.markerLong ?? result.viewLong;

    if (lat == null || lng == null) return null;

    final embedUrl = 'https://maps.google.com/maps?q=$lat,$lng&z=15&output=embed';
    return '''
      <iframe
        width="$width"
        height="$height"
        src="$embedUrl"
        style="border:0;"
        allowfullscreen=""
        loading="lazy"
        referrerpolicy="no-referrer-when-downgrade">
      </iframe>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) {
        _iframe = _convertToGoogleMapsEmbedIframe(
          'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
          width: ScreenUtil.size.width - (SizeScale.widthX6s * 5),
          height: ScreenUtil.size.width - (SizeScale.widthX6s * 12),
        );

        if (_iframe == null) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: .5, color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeScale.widthX6s / 2),
              child: SizedBox(
                width: ScreenUtil.size.width - (SizeScale.widthX6s * 5),
                height: ScreenUtil.size.width - (SizeScale.widthX6s * 8),
              ),
            ),
          );
        }

        return Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(SizeScale.widthX6s / 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: ScreenUtil.size.width - (SizeScale.widthX6s * 5),
                    height: ScreenUtil.size.height - (SizeScale.heightX22l),
                    child: ColoredBox(
                      color: Colors.grey.shade300,
                      child: Center(child: SharedPersonalize.loadingWidget(color: Colors.grey.shade900)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeScale.widthX6s / 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                clipBehavior: Clip.hardEdge,
                child: HtmlWidget(_iframe!, factoryBuilder: () => GoogleMapsFactory()),
              ),
            ),
          ],
        );
      },
    );
  }
}

class GoogleMapsFactory extends WidgetFactory with WebViewFactory {}
