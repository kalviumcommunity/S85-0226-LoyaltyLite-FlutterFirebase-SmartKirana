import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const GoogleMapsDemo(),
    );
  }
}

class GoogleMapsDemo extends StatefulWidget {
  const GoogleMapsDemo({super.key});

  @override
  State<GoogleMapsDemo> createState() => _GoogleMapsDemoState();
}

class _GoogleMapsDemoState extends State<GoogleMapsDemo> {
  // Map controller
  GoogleMapController? _mapController;
  
  // Initial camera position (San Francisco)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12,
  );

  // Markers set
  final Set<Marker> _markers = {};
  
  // State variables
  bool _myLocationEnabled = true;
  bool _myLocationButtonEnabled = true;
  MapType _currentMapType = MapType.normal;
  double _currentZoom = 12;
  LatLng? _currentCenter;
  List<String> _mapEvents = [];

  // Predefined locations for markers
  final List<MapLocation> _locations = [
    MapLocation(
      id: 'san_francisco',
      name: 'San Francisco',
      description: 'Golden Gate Bridge',
      position: const LatLng(37.8199, -122.4783),
      color: Colors.red,
    ),
    MapLocation(
      id: 'new_york',
      name: 'New York',
      description: 'Times Square',
      position: const LatLng(40.7580, -73.9855),
      color: Colors.blue,
    ),
    MapLocation(
      id: 'london',
      name: 'London',
      description: 'Big Ben',
      position: const LatLng(51.5074, -0.1278),
      color: Colors.green,
    ),
    MapLocation(
      id: 'tokyo',
      name: 'Tokyo',
      description: 'Tokyo Tower',
      position: const LatLng(35.6586, -139.7454),
      color: Colors.purple,
    ),
    MapLocation(
      id: 'sydney',
      name: 'Sydney',
      description: 'Opera House',
      position: const LatLng(-33.8568, -151.2153),
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentCenter = _initialPosition.target;
    _addInitialMarkers();
    _addToLogs('Google Maps initialized');
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _addToLogs(String event) {
    setState(() {
      _mapEvents.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
      if (_mapEvents.length > 15) {
        _mapEvents = _mapEvents.take(15).toList();
      }
    });
  }

  void _addInitialMarkers() {
    for (final location in _locations) {
      _addMarker(location);
    }
    _addToLogs('Added ${_locations.length} initial markers');
  }

  void _addMarker(MapLocation location) {
    final marker = Marker(
      markerId: MarkerId(location.id),
      position: location.position,
      infoWindow: InfoWindow(
        title: location.name,
        snippet: location.description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        _getColorHue(location.color),
      ),
      onTap: () {
        _showMarkerInfo(location);
        _addToLogs('Tapped marker: ${location.name}');
      },
    );

    setState(() {
      _markers.add(marker);
    });
  }

  double _getColorHue(Color color) {
    if (color == Colors.red) return BitmapDescriptor.hueRed;
    if (color == Colors.blue) return BitmapDescriptor.hueBlue;
    if (color == Colors.green) return BitmapDescriptor.hueGreen;
    if (color == Colors.purple) return BitmapDescriptor.hueViolet;
    if (color == Colors.orange) return BitmapDescriptor.hueOrange;
    return BitmapDescriptor.hueRed;
  }

  void _showMarkerInfo(MapLocation location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${location.description}'),
            const SizedBox(height: 8),
            Text('Latitude: ${location.position.latitude.toStringAsFixed(6)}'),
            Text('Longitude: ${location.position.longitude.toStringAsFixed(6)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _moveToLocation(location.position);
            },
            child: const Text('Go to Location'),
          ),
        ],
      ),
    );
  }

  void _moveToLocation(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 15,
        ),
      ),
    );
    _addToLogs('Moved to location: ${position.latitude}, ${position.longitude}');
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _addToLogs('Google Map controller created');
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentCenter = position.target;
      _currentZoom = position.zoom;
    });
  }

  void _onCameraMoveEnd(CameraPosition position) {
    _addToLogs('Camera moved to: ${position.target.latitude.toStringAsFixed(4)}, '
        '${position.target.longitude.toStringAsFixed(4)} (Zoom: ${position.zoom.toStringAsFixed(2)})');
  }

  void _toggleMyLocation() {
    setState(() {
      _myLocationEnabled = !_myLocationEnabled;
      _myLocationButtonEnabled = !_myLocationButtonEnabled;
    });
    _addToLogs('My location ${_myLocationEnabled ? 'enabled' : 'disabled'}');
  }

  void _changeMapType(MapType type) {
    setState(() {
      _currentMapType = type;
    });
    _addToLogs('Map type changed to: ${type.toString().split('.').last}');
  }

  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
    _addToLogs('Zoomed in');
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
    _addToLogs('Zoomed out');
  }

  void _resetMapView() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(_initialPosition),
    );
    _addToLogs('Reset map view to initial position');
  }

  void _clearAllMarkers() {
    setState(() {
      _markers.clear();
    });
    _addToLogs('Cleared all markers');
  }

  void _restoreMarkers() {
    setState(() {
      _markers.clear();
    });
    _addInitialMarkers();
    _addToLogs('Restored all markers');
  }

  void _goToMyLocation() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentCenter ?? _initialPosition.target,
            zoom: 15,
          ),
        ),
      );
      _addToLogs('Moved to current location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showMapInfo(),
            tooltip: 'Map Info',
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Controls
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                // Map Type Selector
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text('Map Type: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...MapType.values.map((type) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(_getMapTypeName(type)),
                          selected: _currentMapType == type,
                          onSelected: (selected) {
                            if (selected) _changeMapType(type);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Action Buttons
                Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleMyLocation,
                      icon: Icon(
                        _myLocationEnabled ? Icons.location_on : Icons.location_off,
                      ),
                      label: Text(_myLocationEnabled ? 'Disable Location' : 'Enable Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _myLocationEnabled ? Colors.green : Colors.grey,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _zoomIn,
                      icon: const Icon(Icons.zoom_in),
                      label: const Text('Zoom In'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _zoomOut,
                      icon: const Icon(Icons.zoom_out),
                      label: const Text('Zoom Out'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _resetMapView,
                      icon: const Icon(Icons.home),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Google Map
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
              onCameraMove: _onCameraMove,
              onCameraIdle: () => _onCameraMoveEnd(CameraPosition(
                target: _currentCenter ?? _initialPosition.target,
                zoom: _currentZoom,
              )),
              mapType: _currentMapType,
              myLocationEnabled: _myLocationEnabled,
              myLocationButtonEnabled: _myLocationButtonEnabled,
              markers: _markers,
              zoomControlsEnabled: false, // We'll use custom controls
              compassEnabled: true,
              mapToolbarEnabled: false,
              trafficEnabled: false,
              buildingsEnabled: true,
              indoorViewEnabled: false,
              liteModeEnabled: false,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
            ),
          ),
          
          // Bottom Info Panel
          Container(
            height: 200,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Map Info',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _clearAllMarkers,
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'Clear Markers',
                    ),
                    IconButton(
                      onPressed: _restoreMarkers,
                      icon: const Icon(Icons.restore),
                      tooltip: 'Restore Markers',
                    ),
                    IconButton(
                      onPressed: () => setState(() => _mapEvents.clear()),
                      icon: const Icon(Icons.clear),
                      tooltip: 'Clear Logs',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Current Position Info
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Center: ${_currentCenter?.latitude.toStringAsFixed(4) ?? 'N/A'}, '
                        '${_currentCenter?.longitude.toStringAsFixed(4) ?? 'N/A'}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Zoom Level: ${_currentZoom.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Markers: ${_markers.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Event Log
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _mapEvents.isEmpty
                        ? const Center(
                            child: Text(
                              'No events yet. Interact with the map!',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _mapEvents.length,
                            itemBuilder: (context, index) {
                              return Text(
                                _mapEvents[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _goToMyLocation,
            heroTag: "location",
            child: const Icon(Icons.my_location),
            tooltip: 'Go to Current Location',
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _addRandomMarker,
            heroTag: "add",
            child: const Icon(Icons.add_location),
            tooltip: 'Add Random Marker',
          ),
        ],
      ),
    );
  }

  void _addRandomMarker() {
    final random = DateTime.now().millisecondsSinceEpoch;
    final lat = (_initialPosition.target.latitude + (random % 20 - 10) / 100);
    final lng = (_initialPosition.target.longitude + (random % 20 - 10) / 100);
    
    final randomLocation = MapLocation(
      id: 'random_$random',
      name: 'Random Location $random',
      description: 'Generated at ${DateTime.now().toString().substring(11, 19)}',
      position: LatLng(lat, lng),
      color: Colors.amber,
    );
    
    _addMarker(randomLocation);
    _moveToLocation(randomLocation.position);
  }

  void _showMapInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Google Maps Demo'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Features demonstrated:'),
            SizedBox(height: 8),
            Text('• Interactive Google Map'),
            Text('• Multiple map types (Normal, Satellite, Hybrid, Terrain)'),
            Text('• Custom markers with info windows'),
            Text('• User location tracking'),
            Text('• Camera controls (zoom, pan)'),
            Text('• Real-time event logging'),
            Text('• Custom UI overlays'),
            SizedBox(height: 8),
            Text('Instructions:'),
            SizedBox(height: 4),
            Text('• Tap markers to see details'),
            Text('• Use map controls to navigate'),
            Text('• Enable/disable location tracking'),
            Text('• Add custom markers'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getMapTypeName(MapType type) {
    switch (type) {
      case MapType.normal:
        return 'Normal';
      case MapType.satellite:
        return 'Satellite';
      case MapType.hybrid:
        return 'Hybrid';
      case MapType.terrain:
        return 'Terrain';
      default:
        return 'Normal';
    }
  }
}

class MapLocation {
  final String id;
  final String name;
  final String description;
  final LatLng position;
  final Color color;

  MapLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
    required this.color,
  });
}
