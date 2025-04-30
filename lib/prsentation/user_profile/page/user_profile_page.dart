import 'package:flutter/material.dart';
import 'package:job_seeker/core/widget/my_custom_icon_button.dart';
import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/user_profile/page/update_profile_page.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // A column to arrange widgets vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info section

            topbar(),
            profileNameAndEditButton(context),

            // Action buttons
            _buildListTile(Icons.person_outline, 'Personal information', () {}),
            _buildListTile(Icons.lock_outline, 'Login and security', () {}),
            _buildListTile(Icons.headset_mic, 'Customer Support', () {}),
            _buildListTile(Icons.language, 'Language', () {}),
            _buildListTile(Icons.security_outlined, 'Share the app', () {}),
            _buildListTile(Icons.power_settings_new, 'Log Out', () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            }),

            const SizedBox(height: 20),

            // Version info
            const Center(child: Text('Version- 03')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Padding profileNameAndEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          userName(context),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UpdateProfilePage()));
            },
            child: const Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Stack topbar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple, borderRadius: BorderRadius.all(
                      // bottomLeft: Radius.circular(20),
                      Radius.circular(12))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyCustomIconButton(
                      icon: Icons.arrow_back,
                      callback: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      "User Profile",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    MyCustomIconButton(
                      icon: Icons.notifications,
                      callback: () {},
                    ),
                  ],
                ),
              )),
        ),
        Positioned(
          left: 16,
          top: 100,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  context.watch<AuthProvider>().user!.avatar,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding userName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            "${context.watch<AuthProvider>().user!.name} ${context.watch<AuthProvider>().user!.lastName}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            '@userId',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback callback) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: callback,
    );
  }
}
