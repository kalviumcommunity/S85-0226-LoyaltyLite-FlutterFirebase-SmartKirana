import 'package:flutter/material.dart';

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
  // Simulated map state
  bool _myLocationEnabled = true;
  String _currentMapType = 'normal';
  double _currentZoom = 12;
  List<String> _mapEvents = [];
  List<MapLocation> _locations = [];

  // Predefined locations for markers
  final List<MapLocation> _allLocations = [
    MapLocation(
      id: 'san_francisco',
      name: 'San Francisco',
      description: 'Golden Gate Bridge',
      position: const MapPosition(37.8199, -122.4783),
      color: Colors.red,
    ),
    MapLocation(
      id: 'new_york',
      name: 'New York',
      description: 'Times Square',
      position: const MapPosition(40.7580, -73.9855),
      color: Colors.blue,
    ),
    MapLocation(
      id: 'london',
      name: 'London',
      description: 'Big Ben',
      position: const MapPosition(51.5074, -0.1278),
      color: Colors.green,
    ),
    MapLocation(
      id: 'tokyo',
      name: 'Tokyo',
      description: 'Tokyo Tower',
      position: const MapPosition(35.6586, -139.7454),
      color: Colors.purple,
    ),
    MapLocation(
      id: 'sydney',
      name: 'Sydney',
      description: 'Opera House',
      position: const MapPosition(-33.8568, -151.2153),
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _locations = List.from(_allLocations);
    _addToLogs('Google Maps initialized (Demo Mode)');
    _addToLogs('Added ${_locations.length} initial markers');
  }

  void _addToLogs(String event) {
    setState(() {
      _mapEvents.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
      if (_mapEvents.length > 15) {
        _mapEvents = _mapEvents.take(15).toList();
      }
    });
  }

  void _toggleMyLocation() {
    setState(() {
      _myLocationEnabled = !_myLocationEnabled;
    });
    _addToLogs('My location ${_myLocationEnabled ? 'enabled' : 'disabled'}');
  }

  void _changeMapType(String type) {
    setState(() {
      _currentMapType = type;
    });
    _addToLogs('Map type changed to: $type');
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 20.0);
    });
    _addToLogs('Zoomed in to ${_currentZoom.toStringAsFixed(1)}');
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 20.0);
    });
    _addToLogs('Zoomed out to ${_currentZoom.toStringAsFixed(1)}');
  }

  void _resetMapView() {
    setState(() {
      _currentZoom = 12;
      _locations = List.from(_allLocations);
    });
    _addToLogs('Reset map view to initial position');
  }

  void _clearAllMarkers() {
    setState(() {
      _locations.clear();
    });
    _addToLogs('Cleared all markers');
  }

  void _restoreMarkers() {
    setState(() {
      _locations = List.from(_allLocations);
    });
    _addToLogs('Restored all markers');
  }

  void _showMarkerInfo(MapLocation location) {
    _addToLogs('Tapped marker: ${location.name}');
    
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
              _moveToLocation(location);
            },
            child: const Text('Go to Location'),
          ),
        ],
      ),
    );
  }

  void _moveToLocation(MapLocation location) {
    _addToLogs('Moved to location: ${location.position.latitude.toStringAsFixed(4)}, '
        '${location.position.longitude.toStringAsFixed(4)}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Moved to ${location.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addRandomMarker() {
    final random = DateTime.now().millisecondsSinceEpoch;
    final lat = (37.7749 + (random % 20 - 10) / 100);
    final lng = (-122.4194 + (random % 20 - 10) / 100);
    
    final randomLocation = MapLocation(
      id: 'random_$random',
      name: 'Random Location $random',
      description: 'Generated at ${DateTime.now().toString().substring(11, 19)}',
      position: MapPosition(lat, lng),
      color: Colors.amber,
    );
    
    setState(() {
      _locations.add(randomLocation);
    });
    _moveToLocation(randomLocation);
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
            Text('• Interactive Google Map (Demo Mode)'),
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
            SizedBox(height: 8),
            Text('Note: This is a demo mode. For real maps,'),
            Text('deploy to Android/iOS device with API key.'),
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
                      ...['normal', 'satellite', 'hybrid', 'terrain'].map((type) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(type.toUpperCase()),
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
          
          // Simulated Map View
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade100,
                          Colors.green.shade100,
                        ],
                      ),
                    ),
                  ),
                  
                  // Map Type Overlay
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        _currentMapType.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  
                  // Location Indicator
                  if (_myLocationEnabled)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  
                  // Zoom Indicator
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Zoom: ${_currentZoom.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  
                  // Markers
                  ..._locations.map((location) => Positioned(
                    top: 100 + (location.position.latitude.abs() * 10) % 300,
                    left: 50 + (location.position.longitude.abs() * 10) % 300,
                    child: GestureDetector(
                      onTap: () => _showMarkerInfo(location),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: location.color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )),
                  
                  // Center Crosshair
                  Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.center_focus_strong,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                        'Current Center: 37.7749, -122.4194',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Zoom Level: ${_currentZoom.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Markers: ${_locations.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Location: ${_myLocationEnabled ? 'Enabled' : 'Disabled'}',
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
            onPressed: () {
              _addToLogs('Moved to current location');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Moved to current location'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
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
}

class MapLocation {
  final String id;
  final String name;
  final String description;
  final MapPosition position;
  final Color color;

  MapLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
    required this.color,
  });
}

class MapPosition {
  final double latitude;
  final double longitude;

  const MapPosition(this.latitude, this.longitude);
}
