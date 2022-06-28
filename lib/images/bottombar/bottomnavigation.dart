import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testadmob/images/bottombar/contant.dart';
import 'package:testadmob/images/bottombar/first.dart';
import 'package:testadmob/images/bottombar/second.dart';
import 'package:testadmob/images/bottombar/spla.dart';
import 'package:testadmob/images/bottombar/third.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.grey.shade400,
      ),
      home: Splsh(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);

  List page = [
    Nature(),
    God(),
    Car(),
  ];

  void _onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Constant.bottomIndex,
          builder: (context, int isShow, Widget? child) {
            return page.elementAt(Constant.bottomIndex.value);
          }),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: Constant.bottomIndex,
        builder: (context, int isShow, Widget? child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: "Nature",
                icon: SizedBox(),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(),
                label: "Animal",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(),
                label: "Car",
              ),
            ],
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.purple,
                fontSize: 20,
                fontStyle: FontStyle.italic),
            unselectedLabelStyle: const TextStyle(
              color: Colors.amber,
              fontSize: 15,
            ),
            currentIndex: Constant.bottomIndex.value,
            // selectedItemColor: Colors.green,
            unselectedItemColor: Colors.orange,
            // selectedIconTheme:
            //     const IconThemeData(color: Colors.brown, opacity: 25, size: 25),
            // unselectedIconTheme:
            //     const IconThemeData(color: Colors.green, opacity: 25, size: 25),

            fixedColor: Colors.purple,
            backgroundColor: Colors.blueGrey,
            onTap: (int index) {
              Constant.bottomIndex.value = index;
            },
            elevation: 5,
          );
        },
      ),
    );
  }
}
