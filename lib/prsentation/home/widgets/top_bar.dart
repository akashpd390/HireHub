import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:job_seeker/core/widget/my_custom_icon_button.dart";
import "package:job_seeker/prsentation/auth/provider/auth_provider.dart";
import "package:job_seeker/prsentation/home/widgets/search_bar_widgets.dart";
import "package:job_seeker/prsentation/user_profile/page/user_profile_page.dart";
import "package:provider/provider.dart";

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _redirectProfile(context);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            context.watch<AuthProvider>().user!.avatar,
                            scale: 0.025),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Hello, ${context.watch<AuthProvider>().user!.name}",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                MyCustomIconButton(
                  icon: Icons.notifications,
                  callback: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Find a Job, \nthat Suits you",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SearchBarWidget(),
          ],
        ),
      ),
    );
  }

  void _redirectProfile(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UserProfilePage()));
  }
}
