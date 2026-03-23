import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateMeScreen extends StatefulWidget {
  const LocateMeScreen({super.key});

  @override
  State<LocateMeScreen> createState() => _LocateMeScreenState();
}

class _LocateMeScreenState extends State<LocateMeScreen> {
  static const LatLng _defaultCenter = LatLng(20.5937, 78.9629);

  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStreamSubscription;

  LatLng? _currentLatLng;
  bool _isLoading = false;
  bool _permissionDeniedForever = false;
  String _statusText = 'Tap Locate Me to fetch your live GPS location.';

  Set<Marker> _markers = const <Marker>{};

  @override
  void initState() {
    super.initState();
    _locateMe();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _locateMe() async {
    setState(() {
      _isLoading = true;
      _statusText = 'Checking location permissions...';
      _permissionDeniedForever = false;
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _statusText = 'Location service is off. Please enable GPS and try again.';
      });
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _statusText = 'Location permission denied.';
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _permissionDeniedForever = true;
        _statusText = 'Permission denied forever. Open app settings to allow location.';
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) {
        return;
      }

      _updatePosition(position, animateCamera: true);
      _startLiveLocationStream();

      setState(() {
        _isLoading = false;
        _statusText = 'Live location active. Marker updates with your movement.';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _statusText = 'Could not fetch current location: $error';
      });
    }
  }

  void _startLiveLocationStream() {
    _positionStreamSubscription?.cancel();

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 5,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((position) {
      _updatePosition(position, animateCamera: false);
    });
  }

  void _updatePosition(Position position, {required bool animateCamera}) {
    final latLng = LatLng(position.latitude, position.longitude);

    final marker = Marker(
      markerId: const MarkerId('user_location'),
      position: latLng,
      infoWindow: const InfoWindow(
        title: 'You are here',
        snippet: 'Live GPS position',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _currentLatLng = latLng;
      _markers = <Marker>{marker};
    });

    if (animateCamera && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17),
        ),
      );
    }
  }

  Future<void> _openLocationSettings() async {
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    final target = _currentLatLng ?? _defaultCenter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Me'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: target,
                zoom: _currentLatLng == null ? 5 : 17,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,
              myLocationEnabled: _currentLatLng != null,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              border: Border(
                top: BorderSide(color: Colors.deepPurple.shade100),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _statusText,
                  style: TextStyle(
                    color: Colors.deepPurple.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _currentLatLng == null
                      ? 'Coordinates: unavailable'
                      : 'Coordinates: ${_currentLatLng!.latitude.toStringAsFixed(6)}, ${_currentLatLng!.longitude.toStringAsFixed(6)}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _locateMe,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location),
                      label: const Text('Locate Me'),
                    ),
                    if (_permissionDeniedForever)
                      OutlinedButton.icon(
                        onPressed: _openLocationSettings,
                        icon: const Icon(Icons.settings),
                        label: const Text('Open App Settings'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
