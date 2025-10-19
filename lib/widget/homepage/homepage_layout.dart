import 'package:flutter/widgets.dart';

import '../../layout.dart';
import 'desktop_homepage.dart';
import 'mobile_homepage.dart';
import 'tablet_homepage.dart';

class LayoutHomepage extends StatefulWidget {
  const LayoutHomepage({super.key});

  @override
  State<LayoutHomepage> createState() => _LayoutHomepageState();
}

class _LayoutHomepageState extends State<LayoutHomepage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth >= ScreenSize.desktopScreenSize) {
        return const DesktopHomepage();
      } else if (constraints.maxWidth < ScreenSize.desktopScreenSize &&
          constraints.maxWidth >= ScreenSize.tabletScreenSize) {
        return const TabletHomepage();
      } else if (constraints.maxWidth < ScreenSize.tabletScreenSize &&
          constraints.maxWidth <= ScreenSize.mobileScreenSize) {
        return const MobileHomepage();
      } else {
        return const MobileHomepage();
      }
    }));
  }
}
