import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TabletHomepage());
}

class TabletHomepage extends StatefulWidget {
  const TabletHomepage({super.key});

  @override
  State<TabletHomepage> createState() => _TabletHomepageState();
}

class _TabletHomepageState extends State<TabletHomepage> {
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const TextfieldContainer()));
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
