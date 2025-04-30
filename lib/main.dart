import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_seeker/core/dependency_injection.dart';
import 'package:job_seeker/core/provider_config/mult_provider_config.dart';
import 'package:job_seeker/core/network_supabase_config.dart';
import 'package:job_seeker/prsentation/auth/page/auth_gate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await initialize dotenv
  // await dotenv.load(fileName: ".env");

  await supabaseConfig();

  setup();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes the status bar transparent
      statusBarIconBrightness:
          Brightness.dark, // Adjusts the icon brightness (light or dark)
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
