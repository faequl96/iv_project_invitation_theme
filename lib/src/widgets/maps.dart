import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatefulWidget {
  const Maps({super.key, required this.height, required this.width, this.delayBeforeStart = Duration.zero, required this.url});

  final double height;
  final double width;
  final Duration delayBeforeStart;
  final String url;

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
    final latLng = _getLatLngFromGoogleMaps(widget.url);

    if (latLng == null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: .all(width: .5, color: Colors.grey.shade500),
          borderRadius: .circular(8),
        ),
        child: Padding(
          padding: .all(W.x6s / 2),
          child: SizedBox(height: widget.height, width: widget.width),
        ),
      );
    }

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: .all(width: 2, color: Colors.grey.shade400),
            borderRadius: .circular(8),
          ),
          child: Padding(
            padding: .all(W.x6s / 2),
            child: ClipRRect(
              borderRadius: .circular(2),
              clipBehavior: .hardEdge,
              child: SizedBox(
                height: widget.height,
                width: widget.width,
                child: ColoredBox(
                  color: Colors.grey.shade300,
                  child: Center(child: SharedPersonalize.loadingWidget(color: Colors.grey.shade900)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: .all(W.x6s / 2),
          child: ClipRRect(
            borderRadius: .circular(2),
            clipBehavior: .hardEdge,
            child: MapsWidget(
              latitude: latLng.latitude,
              longitude: latLng.longitude,
              height: widget.height,
              width: widget.width,
              delayBeforeStart: widget.delayBeforeStart,
            ),
          ),
        ),
      ],
    );
  }
}

class MapsWidget extends StatefulWidget {
  const MapsWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.height,
    required this.width,
    required this.delayBeforeStart,
  });

  final double latitude;
  final double longitude;
  final double height;
  final double width;
  final Duration delayBeforeStart;

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  bool _initComplete = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(widget.delayBeforeStart);
      if (mounted) setState(() => _initComplete = true);
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
