import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/cupertino.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? selectedDate;
  bool isDateFocused = false;
  bool isButtonActive = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _validateFields() {
    setState(() {
      isButtonActive = _nameController.text.isNotEmpty &&
          _amountController.text.isNotEmpty &&
          selectedDate != null;
    });
  }

  void _showDatePicker() {
    setState(() {
      isDateFocused = true;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 33.h,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(
                  children: [
                    Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isDateFocused = false;
                          _validateFields();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 23.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                    _validateFields();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateFields);
    _amountController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171717),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff171717),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 5.h,
              width: 9.w,
              decoration: BoxDecoration(
                color: Color(0xff242424),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(
                      (context),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            Text(
              'Add expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 13.w,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                filled: true,
                fillColor: Color(0xff171717),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff393937)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xff325FD3),
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Amount',
                labelText: 'Amount',
                filled: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: SvgPicture.asset('assets/svg/\$.svg'),
                ),
                fillColor: Color(0xff171717),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xff325FD3),
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 1.h),
            GestureDetector(
              onTap: _showDatePicker,
              child: Container(
                height: 6.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff171717),
                  border: Border.all(
                    color:
                        isDateFocused ? Color(0xff325FD3) : Color(0xff4B4B4B),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDate == null
                          ? 'Date'
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: TextStyle(
                        color: selectedDate == null
                            ? Color(0xff4B4B4B)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: isButtonActive
                  ? () {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'amount': _amountController.text,
                        'date': selectedDate,
                      });
                    }
                  : null,
              child: Container(
                height: 7.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: isButtonActive ? Color(0xff325FD3) : Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Add',
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
