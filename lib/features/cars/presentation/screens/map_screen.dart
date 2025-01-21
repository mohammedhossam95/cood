import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/injection_container.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};
  initMarkers() async {
    markers = {};

    markers.add(Marker(
      markerId: const MarkerId("1"),
      position: const LatLng(31.06976262630338, 31.23652808368206),
      icon: await const CountWidget(count: 1).toBitmapDescriptor(
          logicalSize: const Size(100, 100), imageSize: const Size(300, 300)),
    ));
    markers.add(Marker(
      markerId: const MarkerId("2"),
      position: const LatLng(30.418868934059237, 31.22851464897394),
      icon: await const MarkerWidget().toBitmapDescriptor(),
    ));
    markers.add(Marker(
      markerId: const MarkerId("3"),
      position: const LatLng(30.01124477440843, 30.78459296375513),
      icon: await const MarkerWidget().toBitmapDescriptor(),
    ));
    setState(() {});
  }

  @override
  void initState() {
    initMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = AppLocalizations.of(context)!.isArLocale;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: ScreenUtil().screenWidth,
            alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
            child: Text('map'.tr),
          ),
          elevation: 4,
        ),
        body: Center(
            child: GoogleMap(
          initialCameraPosition: const CameraPosition(
              target: LatLng(30.488774662306618, 31.032559163868427), zoom: 9),
          markers: markers,
          onTap: (s) {
            if (kDebugMode) {
              print(s);
            }
          },
        )));
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({super.key, required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text('$count'),
    );
  }
}

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(90.r)),
        color: const Color(0xff00D1D1),
      ),
      child: Text(
        '150 ${"reyal".tr}',
        style: TextStyles.regular20(
          color: colors.upBackGround,
        ),
      ),
    );
  }
}

class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(
          image: AssetImage(
            "assets/marker.png",
          ),
          height: 150,
          width: 150,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
