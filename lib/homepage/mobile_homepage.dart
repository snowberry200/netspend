import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/mobile.dart';

void main() {
  runApp(const MobileHomepage());
}

class MobileHomepage extends StatefulWidget {
  const MobileHomepage({super.key});

  @override
  State<MobileHomepage> createState() => _MobileHomepageState();
}

class _MobileHomepageState extends State<MobileHomepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 210, 210, 230)),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MobileScreen()));
                  },
                  child: const Center(
                    child: Text('Sign Out',
                        style: TextStyle(
                            fontSize: 16, color: CupertinoColors.systemGrey)),
                  ),
                ),
              ],
            )));
  }
}
