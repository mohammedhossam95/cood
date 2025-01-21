import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/cars/domain/entities/branch_entity.dart';
import '/features/cars/presentation/cubit/get_agents_cubit/get_agents_cubit.dart';
import '/features/cars/presentation/cubit/get_cars_cubit/get_cars_cubit.dart';
import '/injection_container.dart';

class NewMapScreen extends StatefulWidget {
  final CarParams params;
  const NewMapScreen({super.key, required this.params});

  @override
  State<NewMapScreen> createState() => _NewMapScreenState();
}

class _NewMapScreenState extends State<NewMapScreen> {
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  String? selectedMarkerName;
  String? branchId;
  String? customerId;
  LatLng? selectedMarkerPosition;

  void addMarker({
    required String name,
    required String id,
    required String branch,
    required String customer,
    required double lat,
    required double lng,
  }) async {
    final newMarker = Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, lng),
      icon: await MarkerWidget(
        iD: id,
      ).toBitmapDescriptor(),
      onTap: () {
        setState(() {
          selectedMarkerName = name;
          customerId = customer;
          branchId = branch;
          selectedMarkerPosition = LatLng(lat, lng);
        });
      },
    );
    setState(() {
      markers.add(newMarker);
    });
    if (markers.isNotEmpty) {
      final bounds = _calculateBounds();
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

  LatLngBounds _calculateBounds() {
    double south = markers.first.position.latitude;
    double north = markers.first.position.latitude;
    double west = markers.first.position.longitude;
    double east = markers.first.position.longitude;

    for (var marker in markers) {
      if (marker.position.latitude < south) south = marker.position.latitude;
      if (marker.position.latitude > north) north = marker.position.latitude;
      if (marker.position.longitude < west) west = marker.position.longitude;
      if (marker.position.longitude > east) east = marker.position.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAgentsCubit>(context).getAgents(
      params: CarParams(fromBranchId: widget.params.city?.id.toString()),
    );
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
      body: BlocConsumer<GetAgentsCubit, GetAgentsState>(
        listener: (context, state) {
          if (state is GetAgentsSuccess) {
            final branches = state.response.data as List<Branch>;
            for (var branch in branches) {
              addMarker(
                id: branch.id.toString(),
                customer: branch.customerId.toString(),
                branch: branch.id.toString(),
                name: appLocalizations.isArLocale
                    ? branch.nameAr ?? ''
                    : branch.nameEn ?? '',
                lat: branch.latitude ?? 0.0,
                lng: branch.longitude ?? 0.0,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is GetAgentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAgentsSuccess) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Temporary initial position
                    zoom: 2, // Default zoom level
                  ),
                  onMapCreated: (controller) {
                    mapController = controller;

                    // Adjust camera when map is created and markers exist
                    if (markers.isNotEmpty) {
                      final bounds = _calculateBounds();
                      mapController!.animateCamera(
                        CameraUpdate.newLatLngBounds(bounds, 100),
                      );
                    }
                  },
                  markers: markers,
                  onTap: (LatLng position) {
                    setState(() {
                      selectedMarkerName = null;
                    });
                  },
                ),
                if (selectedMarkerName != null &&
                    selectedMarkerPosition != null)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedMarkerName!,
                              style: TextStyles.semiBold20(),
                            ),
                            Gaps.vGap10,
                            Padding(
                              padding: EdgeInsets.all(16.r),
                              child: MyDefaultButton(
                                onPressed: () {
                                  final params = CarParams(
                                    branchId: branchId,
                                    customerId: customerId,
                                  );
                                  log('params: $params');
                                  BlocProvider.of<GetCarsCubit>(context)
                                      .getCars(params: params);

                                  Navigator.pop(context);
                                },
                                btnText: 'available_cars',
                                color: colors.main,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else if (state is GetAgentsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyles.semiBold20(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class MarkerWidget extends StatelessWidget {
  final String iD;
  const MarkerWidget({
    super.key,
    required this.iD,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50.h,
      width: 60.w,
      padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(90.r)),
        color: const Color(0xff00D1D1),
      ),
      child: Text(
        iD,
        style: TextStyles.regular20(
          color: colors.upBackGround,
        ),
      ),
    );
  }
}
