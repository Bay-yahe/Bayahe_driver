import 'package:driver/Home/IconPages/Tricycle/tricycle_output.dart';
import 'package:driver/profile/profile_screen/Wallet/Wallet.dart';
import 'package:driver/profile/profile_screen/account_screen.dart';
import 'package:driver/profile/profile_screen/help_center/help_center.dart';
import 'package:driver/provider/auth_provider.dart';
import 'package:driver/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/Logo/icons8-account-50.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          ProfileMenu(
            text: "Wallet",
            icon: "assets/Logo/mobile.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Wallet()),
              );
            },
          ),
          ProfileMenu(
            text: "Vehicle Info",
            icon: "assets/Logo/icons8-settings-100.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TricycleDetailsScreen()), // Use SettingScreen instead of SettingsList
              );
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/Logo/icons8-help-50.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const HelpCenterPage()), // Use SettingScreen instead of SettingsList
              );
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/Logo/icons8-log-out-30.png",
            press: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
