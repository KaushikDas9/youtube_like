import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/1.Data/FileStroage/GetVideo.dart';
import 'package:youtube_clone/3.Presentation/AddVideo/Add_Video.dart';
import 'package:youtube_clone/3.Presentation/AddVideo/Add_Video_Screen.dart';
import 'package:youtube_clone/3.Presentation/HomeScreen/Home_Page.dart';
import 'package:youtube_clone/3.Presentation/ProfileScreen/Profile_Screen.dart';
import 'package:youtube_clone/3.Presentation/ShortVideoScreen/Short_Screen.dart';
import 'package:youtube_clone/3.Presentation/View/HomeVideoView/Home_Video_View.dart';

class Manage_All_Screen extends StatefulWidget {
  const Manage_All_Screen({super.key});

  @override
  State<Manage_All_Screen> createState() => _Manage_All_ScreenState();
}

class _Manage_All_ScreenState extends State<Manage_All_Screen> {
  

  var currentIndex = 0.obs;
  List<Widget>  all_screen = [
    const HomePage(),
    const Add_Video_Screen(),
    const Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => all_screen[currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            currentIndex.value = index;
            if (index == 1) {
              Add_Video().add(context);
            }
          },
          currentIndex: currentIndex.value,
          selectedItemColor: Colors.amber,
          unselectedItemColor : Colors.amber,
          elevation: 0,
          backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
             
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.smart_display),
            //   label: 'Shorts',
            //   backgroundColor: Colors.black,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              
            ),
          ],
        ),
      ),
    );
  }
}
