import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'add_expense/add_expense.dart';

class RentalExpenses extends StatefulWidget {
  const RentalExpenses({super.key});

  @override
  State<RentalExpenses> createState() => _RentalExpensesState();
}

class _RentalExpensesState extends State<RentalExpenses> {
  List<Map<String, dynamic>> expenses = [];

  void _addExpense(String name, String amount, DateTime date) {
    setState(() {
      expenses.add({
        'name': name,
        'amount': amount,
        'date': date,
      });
    });
  }

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
      body: expenses.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/rental_expenses.png',
                    height: 30.h,
                    width: 90.w,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Your spending history is empty',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          expense['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${expense['amount']} \$',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${expense['date'].day}.${expense['date'].month}.${expense['date'].year}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff939393),
                      ),
                    ),
                    Divider(thickness: 2.sp),
                  ],
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpense()),
                );
                if (result != null) {
                  _addExpense(result['name'], result['amount'], result['date']);
                }
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
