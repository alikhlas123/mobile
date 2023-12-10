import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/HalamanUtama.dart';

FirebaseApp? app;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBh8jMDCP9tKzxf2Dc1rSxeiFiD1VWsw8s",
      appId: "1:894664734693:android:dc8b462d4392c08dd6610c",
      messagingSenderId: "Messaging sender id here",
      projectId: "vendorbanjari",
      storageBucket: "gs://vendorbanjari.appspot.com",
    ),
  );
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vendor UKM Banjari',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: HalamanUtama(),
    );
  }
}
