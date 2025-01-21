import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/media_query_values.dart';
import '/core/widgets/my_default_button.dart';
import '../../injection_container.dart';
import '../utils/constants.dart';
import '../utils/values/text_styles.dart';

class MyMapView extends StatefulWidget {
  final LatLng location;
  const MyMapView({super.key, required this.location});

  @override
  State<MyMapView> createState() => _MapViewState();
}

class _MapViewState extends State<MyMapView> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng? _selectedLocation;
  late AppLocalizations locale;
  late TextTheme theme;

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);

    MarkerId markerId = MarkerId(_markerIdVal());
    LatLng position = widget.location;
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      _markers[markerId] = marker;
    });

    Future.delayed(const Duration(seconds: 1), () async {
      GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void _onSelect() {
    if (_selectedLocation == null) {
      Constants.showSnakToast(
          context: context, message: locale.text('selectPosition'), type: 2);
    } else {
      Navigator.of(context).pop(_selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context)!;
    theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colors.baseColor,
        ),
        backgroundColor: colors.main,
        title: Text(
          locale.text('yourPosition'),
          style: TextStyles.bold16(
            color: colors.baseColor,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          markers: Set<Marker>.of(_markers.values),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget.location,
            zoom: 15.0,
          ),
          myLocationEnabled: true,
          onCameraMove: (CameraPosition position) {
            if (_markers.isNotEmpty) {
              MarkerId markerId = MarkerId(_markerIdVal());
              Marker? marker = _markers[markerId];
              Marker? updatedMarker = marker?.copyWith(
                positionParam: position.target,
              );

              setState(() {
                _markers[markerId] = updatedMarker!;
                _selectedLocation = position.target;
              });
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQueryValues(context).width * 0.15, vertical: 8),
        child: MyDefaultButton(
          onPressed: _onSelect,
          btnText: 'save',
        ),
      ),
    );
  }
}
