import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sys_monitor/navigation_drawer.dart';
import 'package:wakelock/wakelock.dart';

class FlightMonitor extends StatefulWidget {
  static const String routeName = '/flight-monitor';

  @override
  _FlightMonitorState createState() => _FlightMonitorState();
}

class _FlightMonitorState extends State<FlightMonitor> {
  Socket socket;

  Map data = {
    'nav1_active': '000.00',
    'nav1_stdby': '000.00',
    'nav2_active': '000.00',
    'nav2_stdby': '000.00',
    'dme_1': '000',
    'dme_2': '000',
    'course_1': '000',
    'course_2': '000',
    'heading': '000',
    'altitude': '00000',
    'speed': '000',
  };

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    connectToServer();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
    socket.dispose();
  }

  void connectToServer() {
    try {
      // Configure socket transports must be specified
      socket = io('http://192.168.1.12:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'forceNew':true
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('xplanedata', handleXplaneDataListener);
      socket.on('disconnect', (_) => socket.dispose());
    } catch (e) {
      print(e.toString());
    }
  }

  // Listen to Location updates of connected users from server
  handleXplaneDataListener(response) async {
    setState(() {
      data = {
        'nav1_active': response[0]["nav1_active"],
        'nav1_stdby': response[0]["nav1_stdby"],
        'nav2_active': response[0]["nav2_active"],
        'nav2_stdby': response[0]["nav2_stdby"],
        'dme_1': response[0]["dme_1"],
        'dme_2': response[0]["dme_2"],
        'course_1': response[0]["course_1"],
        'course_2': response[0]["course_2"],
        'heading': response[0]["heading"],
        'altitude': response[0]["altitude"],
        'speed': response[0]["speed"]
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print('FlightMonitorBuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Monitor'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: NavigationDrawer(),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'NAV 1 Active',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['nav1_active'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'NAV 1 Standby',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['nav1_stdby'],
                            style: TextStyle(
                                color: Color.fromRGBO(124, 7, 13, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'NAV 2 Active',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['nav2_active'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'NAV 2 Standby',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['nav2_stdby'],
                            style: TextStyle(
                                color: Color.fromRGBO(124, 7, 13, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'DME 1',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['dme_1'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Course 1',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['course_1'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'DME 2',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['dme_2'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Course 2',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['course_2'],
                            style: TextStyle(
                                color: Color.fromRGBO(10, 129, 0, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Speed',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['speed'],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Altitude',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['altitude'],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Heading',
                            style: TextStyle(
                                color: Color.fromRGBO(210, 105, 30, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            data['heading'],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),

        )
      ),
    );
  }
}
