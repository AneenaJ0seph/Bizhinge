
import 'package:biztrail/view/homescreen/profileee.dart';
import 'package:biztrail/view/homescreen/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/app_colors.dart';
import '../../../model/usermodel.dart';
import '../../common/textconstants.dart';
import 'cartscreen.dart';
import 'homescreen.dart';

class FirstScreen extends StatefulWidget {
  final String companyName;

  final BusinessUser? businessUser; // Added businessUser field

  FirstScreen({
    super.key,
    required this.companyName,

    this.businessUser, // Initialized businessUser
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int currentIndex = 0;
  List<Widget> pages = [];

  Future<void> _openWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/7510530121");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }

  @override
  void initState() {
    super.initState();
    // Pass businessUser to Profile
    pages = [
      HomeScreen(companyName: widget.companyName),
      SearchScreen(companyName: widget.companyName),
      CartScreen(),
      Profile(
        companyName: widget.companyName,

      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          rippleColor: Colors.transparent,
          hoverColor: Colors.transparent,
          haptic: true,textStyle: NeededTextstyles.style15,
          tabBorderRadius: 30,
          tabActiveBorder: Border.all(color: Colors.transparent),
          tabBorder: Border.all(color: Colors.transparent),
          tabShadow: [],
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 100),
          gap: 8,
          color: Colors.grey[800],
          activeColor: Darktheme1,
          iconSize: 24,
          tabBackgroundColor: lighttheme42,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          selectedIndex: currentIndex,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            const GButton(
              icon: Icons.search_outlined,
              text: 'Search',
            ),
            const GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',
            ),
            const GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: (currentIndex == 0 || currentIndex == 1 || currentIndex == 3)
          ? FloatingActionButton(
        elevation: 0,
        onPressed: _openWhatsApp,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.asset(
            'assets/img.png',
            fit: BoxFit.fill,
            width: 50.0,
            height: 50.0,
          ),
        ),
        heroTag: "whatsappBtn",
      )
          : null,
    );
  }
}