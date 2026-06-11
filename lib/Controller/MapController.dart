import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Resource/Colors.dart';
import '../Configs/ApiConfigs.dart';
import '../View/SuccessPages/NurseBookingsSuccess/ShareLocationSucccess.dart';

class MapController extends FullLifeCycleController with FullLifeCycleMixin {
  Set<Marker> marker = {};
  GoogleMapController? mapController;
  LatLng? currentPosition = const LatLng(
    37.7749,
    -122.4194,
  ); // Example coordinates
  RxString location = ''.obs;
  Placemark? place;
  var isLoading = true.obs;
  var isLoading1 = true.obs;
  RxBool isSearch = false.obs;
  String kplacesApiKey = "AIzaSyDFSyZhayfNWiFj0zdROZO7zi4Od5WiER0";
  List<dynamic> placeList = <String>[].obs;
  Dio dio = ApiConfigs.dio;
  var isSharingLoading = false.obs;
  var isLiveMode = true.obs;
  String route = "";
  TextEditingController searchController = TextEditingController();
  bool permissionDenied = false;
  DateTime lastProgrammaticMoveTime = DateTime.now().subtract(
    const Duration(seconds: 5),
  );

  @override
  void onClose() {
    mapController?.dispose();
    searchController.dispose();
    super.onClose();
  }

  //Permission
  Future<bool> _handleLocationPermissionAndroid() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text(
            "Location services are disabled. Please enable the services",
          ),
          action: SnackBarAction(
            label: "OK",
            onPressed: () {
              Geolocator.openLocationSettings().then(
                (value) => _handleLocationPermissionAndroid(),
              );
            },
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && permissionDenied == false) {
      permission = await Geolocator.requestPermission();
      permissionDenied = true;
      if (permission == LocationPermission.denied && permissionDenied) {
        dynamic value;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              "Location services are disabled. Please enable the services",
            ),
            action: SnackBarAction(
              label: "OK",
              onPressed: () async {
                value = await Geolocator.openAppSettings().then((value) {
                  getCurrentPosition();
                });
                return value;
              },
            ),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      dynamic value;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text(
            "Location services are disabled. Please enable the services",
          ),
          action: SnackBarAction(
            label: "OK",
            onPressed: () async {
              value = await Geolocator.openAppSettings().then((value) {
                getCurrentPosition();
              });
              return value;
            },
          ),
        ),
      );
      return false;
    }
    return true;
  }

  //Permission
  Future<bool> handleLocationPermissionIos() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      requestLocationPermission(Get.context!);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && permissionDenied == false) {
      permission = await Geolocator.requestPermission();
      permissionDenied = true;
      if (permission == LocationPermission.denied && permissionDenied) {
        // requestLocationPermission(Get.context!);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // requestLocationPermission(Get.context!);
      return false;
    }
    return true;
  }

  showLocationAlertDialog(BuildContext context) {
    dynamic value;
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        value = await Geolocator.openAppSettings().then((value) {
          if (permissionDenied) {
            if (Platform.isIOS) {
              Get.back();
              Get.back();
            }
            // permissionDenied = false;
          }
          getCurrentPosition();
        });
        return value;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Enable Location Permission"),
      content: const Text(
        "This app need location permission to show the nearest facilities.",
      ),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> requestLocationPermission(BuildContext context) async {
    var permissionStatus = await Permission.location.request();
    // try {
    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isDenied) {
      return false;
    } else if (permissionStatus.isPermanentlyDenied) {
      return Platform.isAndroid
          ? await showDialog<bool>(
                context: context,
                builder:
                    (BuildContext context) => AlertDialog(
                      title: const Text("Enable Location Service"),
                      content: const Text(
                        "Please go to Settings and enable location services for  MedChoice Healthcare Jobs",
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("CANCEL"),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        // TextButton(
                        //   child: const Text("OPEN SETTINGS"),
                        //   onPressed: () {
                        //     Navigator.pop(context, false);
                        //     openAppSettings();
                        //   },
                        // ),
                      ],
                    ),
              ) ??
              false
          : await showCupertinoDialog<bool>(
                context: context,
                builder:
                    (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Enable Location Service"),
                      content: const Text(
                        "Please go to Settings and enable location services for MedChoice Healthcare Jobs",
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: colorPrimary),
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        // TextButton(
                        //   child: const Text("OPEN SETTINGS"),
                        //   onPressed: () {
                        //     Navigator.pop(context, false);
                        //     openAppSettings();
                        //   },
                        // ),
                      ],
                    ),
              ) ??
              false;
    } else {
      return true;
    }
    // }
    // on PlatformException {
    //   return true;
    // }
  }

  //Fetching location
  Future<void> getCurrentPosition({double? lat, double? long}) async {
    lastProgrammaticMoveTime = DateTime.now();
    if (Platform.isAndroid
        ? await _handleLocationPermissionAndroid()
        : await handleLocationPermissionIos()) {
      try {
        if (lat == null && long == null) {
          Position? position;
          position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          currentPosition = LatLng(position.latitude, position.longitude);
          marker.clear();
          if (mapController != null) {
            // Get.back();
            mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 18,
                ),
              ),
            );
          }
        } else {
          currentPosition = LatLng(lat!, long!);
          marker.clear();
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat, long), zoom: 18),
              ),
            );
          }
        }
        await getAddressFromLatLng(currentPosition!);
        isLoading(false);
        update();
      } catch (e) {
        // Get.back();
        debugPrint(e.toString());
        // update();
      }
    }
  }

  //Fetching locality
  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        place = placemarks[0];
        location.value = [
          place?.name,
          place?.street,
          place?.subLocality,
          place?.locality,
          place?.administrativeArea,
          place?.postalCode,
        ].where((value) => value != null && value.isNotEmpty).join(', ');
        if (location.value.isEmpty) {
          location.value = "${position.latitude}, ${position.longitude}";
        }
      } else {
        location.value = "${position.latitude}, ${position.longitude}";
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
      location.value = "${position.latitude}, ${position.longitude}";
      update();
    }
  }

  //Place Search
  Future getSuggestion(String input) async {
    print("Called");

    // Check if input is a coordinate pair (e.g., "8.57, 76.93")
    final latLongRegex = RegExp(
      r'^\s*(-?\d+(\.\d+)?)\s*,\s*(-?\d+(\.\d+)?)\s*$',
    );
    final match = latLongRegex.firstMatch(input);

    if (match != null) {
      double? lat = double.tryParse(match.group(1)!);
      double? long = double.tryParse(match.group(3)!);
      if (lat != null && long != null) {
        LatLng newPos = LatLng(lat, long);
        await getCurrentPosition(lat: lat, long: long);
        placeList.clear();
        update();
        return;
      }
    }

    isLoading1(true);
    placeList.clear();
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String requests =
        '$baseURL?input=$input&key=$kplacesApiKey&components=country:IN&language';
    // &components=country:IN
    //for country specific add this &components=country:SOM
    try {
      var response = await dio.get(requests);
      print(response.data);
      var palace = response.data['predictions'];
      palace.map((e) async {
        placeList.add(e['description']);
      }).toList();
      update();
    } catch (error) {
      print(error);
    } finally {
      isLoading1(false);
    }
  }

  Future<void> resolvePlace(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        await getCurrentPosition(
          lat: locations.first.latitude,
          long: locations.first.longitude,
        );
      }
    } catch (e) {
      debugPrint("Resolve place error: $e");
    }
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed
    // var latitude = await getSavedObject("latitude");
    // var longitude = await getSavedObject("longitude");
    // if (latitude == null && longitude == null) {
    //   getCurrentPosition();
    // } else {
    //   getCurrentPosition(lat: latitude, long: longitude);
    // }
  }

  Future<void> shareLocation({required String bookingId}) async {
    try {
      isSharingLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.shareLocation}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final Map<String, dynamic> data = {
        'booking_id': bookingId,
        'latitude': currentPosition?.latitude,
        'longitude': currentPosition?.longitude,
        'location': location.value,
      };

      final response = await dio.post(
        url,
        data: FormData.fromMap(data),
        options: Options(headers: headers),
      );

      final responseData = response.data;
      bool isSuccess = false;

      if (responseData is Map) {
        isSuccess =
            responseData['success'] == true ||
            responseData['success'].toString() == "true" ||
            responseData['status'] == true ||
            responseData['status'].toString() == "true";
      } else if (responseData is String) {
        isSuccess =
            responseData.contains('"success":true') ||
            responseData.contains('"success":"true"') ||
            responseData.contains('"status":true') ||
            responseData.contains('"status":"true"');
      }

      if (response.statusCode == 200 && isSuccess) {
        String message = "Customer location shared successfully.";
        if (responseData is Map) {
          message = responseData['message'] ?? message;
        }
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text(message)));
        Get.back(); // Go back to the previous screen (Home) after sharing
      } else {
        String message = "Failed to share location";
        if (responseData is Map) {
          message = responseData['message'] ?? message;
        }
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      debugPrint("Share location error: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("An error occurred while sharing location"),
        ),
      );
    } finally {
      isSharingLoading(false);
    }
  }
}
