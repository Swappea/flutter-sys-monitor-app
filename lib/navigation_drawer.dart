import 'package:flutter/material.dart';
import 'package:sys_monitor/routes/page_routes.dart';

class NavigationDrawer extends StatelessWidget {
  String getCurrentRouteName(context) {
    String currentRouteName;

    Navigator.popUntil(context, (route) {
      currentRouteName = route.settings.name;
      return true;
    });

    return currentRouteName;
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = getCurrentRouteName(context);

    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Color.fromRGBO(20, 14, 12, 1)),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80.0,
              child: DrawerHeader(
                child: Text(
                  'Setting',
                  style: TextStyle(
                      color: Color.fromRGBO(220, 20, 60, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(color: Color.fromRGBO(20, 14, 12, 1)),
              ),
            ),
            ListTileTheme(
              selectedColor: Colors.blue[900],
              child: ListTile(
                title: Text(
                  'System Monitor',
                  style: TextStyle(color: Colors.white),
                ),
                selected: currentRoute == Routes.sysMonitor,
                onTap: () {
                  if (currentRoute == Routes.sysMonitor) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacementNamed(context, Routes.sysMonitor);
                },
              ),
            ),
            ListTileTheme(
              selectedColor: Colors.blue[900],
              child: ListTile(
                title: Text('Flight Monitor',
                    style: TextStyle(color: Colors.white)),
                selected: currentRoute == Routes.flightMonitor,
                onTap: () {
                  if (currentRoute == Routes.flightMonitor) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacementNamed(context, Routes.flightMonitor);
                  // Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
