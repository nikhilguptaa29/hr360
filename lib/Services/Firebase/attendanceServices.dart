import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Attendanceservices {
  // Create the instance of FirebaseFirestore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permissions are permanently denied, we cannot request permissions",
      );
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        throw Exception("Location permissions are denied");
      }
    }
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  Future<bool> checkIn(String userName,String userId) async {
    Position? pos = await _getCurrentLocation();
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    try {
      await _firestore
          .collection("Attendance")
          .doc(userName)
          .collection(userId)
          .doc(todayDate)
          .set({
            "checkIn": {
              "time": FieldValue.serverTimestamp(),
              "latitude": pos?.latitude,
              "longitude": pos?.longitude,
            },
          }, SetOptions(merge: true));
      return true;
    } catch (e) {
      // return false;
      throw Exception("Error :$e");
    }
  }

  Future<bool> checkOut(String userId, String userName) async {
    Position? pos = await _getCurrentLocation();
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    try {
      await _firestore
          .collection("Attendance")
          .doc(userName)
          .collection(userId)
          .doc(todayDate)
          .set({
            "checkOut": {
              "time": FieldValue.serverTimestamp(),
              "latitude": pos?.latitude,
              "longitude": pos?.longitude,
            },
          }, SetOptions(merge: true));
      return true;
    } catch (e) {
      throw Exception("Error :$e");
      // return false;
    }
  }

  Future<void> getCheckIn(String userId, String todayDate) async {}
}
