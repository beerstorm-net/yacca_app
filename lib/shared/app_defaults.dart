// used for AppNavigatorBloc
import 'package:flutter/material.dart';

class AppNavigatorPage {
  String id;
  Widget icon;
  Widget activeIcon;
  String label;
  Widget widgetContainer; // container to display
  AppNavigatorPage(
      {this.id, this.icon, this.label, this.activeIcon, this.widgetContainer});
}

final List<AppNavigatorPage> appNavigatorPages = List()
  ..add(AppNavigatorPage(
    id: "HOME",
    icon: Icon(
      Icons.home,
      size: 28,
    ),
    label: "HOME",
  ))
  ..add(AppNavigatorPage(
    id: "TRADING",
    icon: Icon(
      Icons.monetization_on,
      size: 28,
    ),
    label: "TRADING",
  ));

// to be used for AuthBloc
enum ORIGIN {
  LOGIN,
  LOGOUT,
  RELOAD,
  REFRESH_TOKEN,
}
