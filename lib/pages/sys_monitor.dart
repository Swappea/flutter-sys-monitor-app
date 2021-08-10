import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sys_monitor/get_hw_data_service.dart';
import 'package:sys_monitor/navigation_drawer.dart';
import 'package:activity_ring/activity_ring.dart';
import 'package:wakelock/wakelock.dart';

class SysMonitor extends StatefulWidget {
  static const String routeName = '/';

  @override
  _SysMonitorState createState() => _SysMonitorState();
}

class _SysMonitorState extends State<SysMonitor> {
  Map data = {
    'cpuLoad': 0.0,
    'cpuTemp': 0.0,
    'gpuLoad': 0.0,
    'ramLoad': 0.0,
    'gpuTemp': 0.0,
    'gpuMemSize': 0.0,
    'gpuMemLoad': 0.0,
    'maxCpuLoad': 0.0,
    'maxGpuLoad': 0.0,
    'maxCpuTemp': 0.0,
    'maxGpuTemp': 0.0,
    'maxRamLoad': 0.0,
    'maxGpuMem': 0.0
  };

  String formattedTitle = '';
  Timer _timer;
  String errorMessage = '';

  void setupHwData() async {
    HwData instance = HwData();
    await instance.getData();
    if (!mounted) return;
    DateTime now = DateTime.now();
    String formattedTitle1 =
        'System Monitor - Swapnesh - ' + DateFormat('kk:mm:ss').format(now);
    setState(() {
      data = {
        'cpuLoad': instance.cpuLoad,
        'cpuTemp': instance.cpuTemp,
        'gpuLoad': instance.gpuLoad,
        'ramLoad': instance.ramLoad,
        'gpuTemp': instance.gpuTemp,
        'gpuMemSize': instance.gpuMemSize,
        'gpuMemLoad': instance.gpuMemLoad,
        'maxCpuLoad': instance.maxCpuLoad,
        'maxGpuLoad': instance.maxGpuLoad,
        'maxCpuTemp': instance.maxCpuTemp,
        'maxGpuTemp': instance.maxGpuTemp,
        'maxRamLoad': instance.maxRamLoad,
        'maxGpuMem': instance.maxGpuMem
      };
      formattedTitle = formattedTitle1;
      errorMessage = instance.errorMessage;
    });
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setupHwData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$formattedTitle',
            style: TextStyle(color: Color.fromRGBO(220, 20, 60, 0.5)),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 40,
          iconTheme: new IconThemeData(color: Color.fromRGBO(220, 20, 60, 0.5)),
        ),
        drawer: NavigationDrawer(),
        body: Container(
          color: Colors.black,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'CPU Load',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              // center: Offset(20, 10),
                              percent: data['cpuLoad'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(10, 129, 0, 1)),
                              radius: 55,
                              width: 10,
                              child: Text(
                                '${data['cpuLoad']} %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'GPU Load',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              // center: Offset(70, 10),
                              percent: data['gpuLoad'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(124, 7, 13, 1)),
                              radius: 55,
                              width: 10,
                              child: Center(
                                  child: Text(
                                '${data['gpuLoad']} %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'RAM Load',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              center: Offset(70, 10),
                              percent: data['ramLoad'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(48, 59, 216, 1)),
                              radius: 55,
                              width: 10,
                              child: Center(
                                  child: Text(
                                '${data['ramLoad']} %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Max CPU Load: ${data['maxCpuLoad']} %',
                              style: TextStyle(
                                  color: Color.fromRGBO(210, 105, 30, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              'Max CPU Temp: ${data['maxCpuTemp']} \u00B0C',
                              style: TextStyle(
                                  color: Color.fromRGBO(210, 105, 30, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              'Max RAM Load: ${data['maxRamLoad']} %',
                              style: TextStyle(
                                  color: Color.fromRGBO(210, 105, 30, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'CPU Temp',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              // center: Offset(70, 10),
                              percent: data['cpuTemp'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(10, 129, 0, 1)),
                              radius: 55,
                              width: 10,
                              child: Center(
                                  child: Text(
                                '${data['cpuTemp']} \u00B0C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'GPU Temp',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              center: Offset(70, 10),
                              percent: data['gpuTemp'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(124, 7, 13, 1)),
                              radius: 55,
                              width: 10,
                              child: Center(
                                  child: Text(
                                '${data['gpuTemp']} \u00B0C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Text(
                                'GPU Mem',
                                style: TextStyle(
                                    color: Color.fromRGBO(210, 105, 30, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 90,
                            ),
                            Ring(
                              center: Offset(70, 10),
                              percent: data['gpuMemLoad'],
                              color: RingColorScheme(
                                  gradient: false,
                                  backgroundColor: Colors.white12,
                                  ringColor: Color.fromRGBO(48, 59, 216, 1)),
                              radius: 55,
                              width: 10,
                              child: Center(
                                  child: Text(
                                '${data['gpuMemSize']} \n   MB',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Max GPU Load: ${data['maxGpuLoad']} %',
                              style: TextStyle(
                                  color: Color.fromRGBO(210, 105, 30, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              'Max GPU Temp: ${data['maxGpuTemp']} \u00B0C',
                              style: TextStyle(
                                  color: Color.fromRGBO(210, 105, 30, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
