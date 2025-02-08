import 'package:agay_proyekt/src/model/info_model.dart';
import 'package:agay_proyekt/src/presentation/employees/new_employee/new_employee.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  List<Employee> employees = [];

  void _addEmployee(Employee employee) {
    setState(() {
      employees.add(employee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141414),
      appBar: AppBar(
        backgroundColor: Color(0xff141414),
        title: Text(
          'EMPLOYEES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Container(
              height: 5.h,
              width: 11.w,
              decoration: BoxDecoration(
                color: Color(0xff1E1E1E),
                borderRadius: BorderRadius.circular(13),
              ),
              child: IconButton(
                onPressed: () async {
                  final newEmployee = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewEmployee(),
                    ),
                  );
                  if (newEmployee != null && newEmployee is Employee) {
                    _addEmployee(newEmployee);
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: Color(0xff4A53E4),
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: employees.isEmpty
          ? Center(
              child: Text(
                'No employees',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white30,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return _buildEmployeeCard(employee);
                },
              ),
            ),
    );
  }

  Widget _buildEmployeeCard(Employee employee) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
        color: Color(0xff1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                employee.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          employee.image!,
                          height: 12.h,
                          width: 12.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/image 1.png',
                        height: 12.h,
                      ),
                SizedBox(width: 2.5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: GoogleFonts.tomorrow(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.7.h),
                    Text(
                      employee.position,
                      style: GoogleFonts.tomorrow(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 0.7.h),
                    Text(
                      '\$${employee.salary} / month',
                      style: GoogleFonts.tomorrow(
                        color: Colors.green,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 0.7.h),
                    Row(
                      children: [
                        Container(
                          height: 2.h,
                          width: 2.h,
                          decoration: BoxDecoration(
                            color: employee.statusColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        SizedBox(width: 1.5.w),
                        Text(
                          employee.status,
                          style: GoogleFonts.tomorrow(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Text(
              employee.notes,
              style: GoogleFonts.tomorrow(
                color: Colors.white60,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
