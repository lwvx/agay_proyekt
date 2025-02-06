import 'package:agay_proyekt/src/presentation/rental_expenses/rental_expenses.dart';
import 'package:agay_proyekt/src/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RentalExpenses(),
      ),
    );
  }
}
