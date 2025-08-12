import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/shared_personalize.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  LatLng? _getLatLngFromGoogleMaps(String url) {
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

    final lat = markerLat ?? viewLat;
    final lng = markerLong ?? viewLong;

    if (lat == null || lng == null) return null;

    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) {
        final latLng = _getLatLngFromGoogleMaps(
          'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
        );

        if (latLng == null) {
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
                border: Border.all(width: 2, color: Colors.grey.shade400),
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
                child: MapsWidget(
                  latitude: latLng.latitude,
                  longitude: latLng.longitude,
                  width: ScreenUtil.size.width - (SizeScale.widthX6s * 5),
                  height: ScreenUtil.size.height - (SizeScale.heightX22l),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key, required this.latitude, required this.longitude, required this.height, required this.width});

  final double latitude;
  final double longitude;
  final double height;
  final double width;

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  bool _initComplete = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() => _initComplete = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initComplete) return const SizedBox.shrink();
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FlutterMap(
        options: MapOptions(initialCenter: LatLng(widget.latitude, widget.longitude), initialZoom: 15),
        children: [
          // Layer untuk tile peta
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.iv_project_web.app',
          ),
          // Layer untuk marker
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(widget.latitude, widget.longitude),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_pin, color: Colors.red, size: 50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
