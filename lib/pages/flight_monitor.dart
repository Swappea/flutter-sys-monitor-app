import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sys_monitor/navigation_drawer.dart';

class FlightMonitor extends StatefulWidget {
  static const String routeName = '/flight-monitor';

  @override
  _FlightMonitorState createState() => _FlightMonitorState();
}

class _FlightMonitorState extends State<FlightMonitor> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    print('FlightMonitorInit');
  }

  @override
  Widget build(BuildContext context) {
    print('FlightMonitorBuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Monitor'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      drawer: NavigationDrawer(),
      body: Text('Flight_Monitor'),
    );
  }
}
