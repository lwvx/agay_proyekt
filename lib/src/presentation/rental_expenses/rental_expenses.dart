import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'add_expense/add_expense.dart';

class RentalExpenses extends StatelessWidget {
  const RentalExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171717),
      appBar: AppBar(
        backgroundColor: Color(0xff171717),
        title: Text(
          'Rental expenses',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/rental_expenses.png',
              height: 30.h,
              width: 90.w,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Your spending history is empty',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpense(),
                  ),
                );
              },
              child: Container(
                height: 7.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Color(0xff325FD3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Add expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
