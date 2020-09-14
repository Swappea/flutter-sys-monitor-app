import 'package:flutter/material.dart';
import 'package:sys_monitor/pages/flight_monitor.dart';
import 'package:sys_monitor/pages/sys_monitor.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SysMonitor(),
      '/flight-monitor': (context) => FlightMonitor(),
    },
  ));
}


