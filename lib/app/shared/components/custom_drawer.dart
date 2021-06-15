import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 70,
              child: Icon(Icons.person, size: 70),
            ),
          ),
          Center(
            child: Text(
              'Nome do usuário',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          const Divider(),
          DrawerListTile(
            title: 'Dashbord',
            pathImage: 'assets/icons/menu_dashbord.svg',
            press: () {},
            selected: Get.currentRoute == 'Dashbord',
          ),
          DrawerListTile(
            title: 'Task',
            pathImage: 'assets/icons/menu_task.svg',
            press: () {},
            selected: Get.currentRoute == 'Task',
          ),
          DrawerListTile(
            title: 'Notification',
            pathImage: 'assets/icons/menu_notification.svg',
            press: () {},
            selected: Get.currentRoute == 'Notification',
          ),
          DrawerListTile(
            title: 'Profile',
            pathImage: 'assets/icons/menu_profile.svg',
            press: () {},
            selected: Get.currentRoute == 'Profile',
          ),
          DrawerListTile(
            title: 'Settings',
            pathImage: 'assets/icons/menu_setting.svg',
            press: () {},
            selected: Get.currentRoute == 'Settings',
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, pathImage;
  final VoidCallback press;
  final bool selected;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.pathImage,
    required this.press,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: press,
      leading: Icon(
        Icons.add_alarm,
        color: selected ? Colors.blueAccent : Colors.black54,
        size: 16,
      ),
      title: Text(
        title,
        style: GoogleFonts.montserrat(
            color: selected ? Colors.blueAccent : Colors.black54,
            fontSize: 16,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500),
      ),
    );
  }
}
