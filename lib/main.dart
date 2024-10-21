import 'package:first_one/domain/pages/login_page.dart';
import 'package:first_one/domain/pages/otp_page.dart';
import 'package:first_one/domain/pages/register_page.dart';
import 'package:first_one/domain/pages/splash_screen.dart';
import 'package:first_one/domain/pages/store_page.dart';
import 'package:first_one/ui/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Онлайн Магазин',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/test',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/productList': (context) => ProductListScreen(),
        '/register': (context) => SignUpScreen(),
        '/otp': (context) => OTPVerificationScreen(),
        '/test': (context) => TestLoginPage(),
      },
    );
  }
}
