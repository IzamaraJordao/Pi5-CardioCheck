import 'dart:math';
import 'package:intl/intl.dart';
import 'package:bank/route/app_routes.dart';
import 'package:bank/view/contact-form.dart';
import 'package:bank/view/initial.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      BanckApp(),
    );

class BanckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRoutes.HOME: (_) => Initial(),
        AppRoutes.CONTACT_FORM: (_) => CardioForm(),
      },
      // debugShowCheckedModeBanner: false,
    );
  }
}
