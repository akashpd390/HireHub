import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/auth/page/login_page.dart';
import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/home/page/home_page.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    // Call currentSession once the widget is built
    Future.microtask(() {
      Provider.of<AuthProvider>(context, listen: false).currentSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      // Print current user data for debugging
      print("Current User: ${value.user}");

      // Show a loading indicator while the data is being fetched
      if (value.isLoading) {
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      if (value.user != null) {
        return const MyHomePage();
      } else {
        return LoginPage();
      }
      // Based on user authentication status, show different pages
    });
  }
}
