import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netspend/bloc/auth_bloc.dart';
import 'package:netspend/database.dart';

import 'screens/desktop.dart';
import 'screens/mobile.dart';
import 'screens/tablet.dart';

class ScreenSize {
  static double desktopScreenSize = 1200;
  static double tabletScreenSize = 700;
  static double mobileScreenSize = 420;
}

class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  static bool isMobile(context) =>
      MediaQuery.of(context).size.width < ScreenSize.tabletScreenSize;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width > ScreenSize.mobileScreenSize &&
      MediaQuery.of(context).size.width <= ScreenSize.tabletScreenSize;
  static bool isDesktop(context) =>
      MediaQuery.of(context).size.width >= ScreenSize.desktopScreenSize;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(database: Database()),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= ScreenSize.desktopScreenSize) {
          return const DesktopScreen(key: GlobalObjectKey(DesktopScreen));
        } else if (constraints.maxWidth < ScreenSize.desktopScreenSize &&
            constraints.maxWidth >= ScreenSize.tabletScreenSize) {
          return const TabletScreen(key: GlobalObjectKey(TabletScreen));
        } else {
          return const MobileScreen(key: GlobalObjectKey(MobileScreen));
        }
      }),
    );
  }
}
