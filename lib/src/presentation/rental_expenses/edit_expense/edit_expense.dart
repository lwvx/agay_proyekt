import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditExpense extends StatefulWidget {
  final Map<String, dynamic> expense;
  final int index;

  const EditExpense({super.key, required this.expense, required this.index});

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.expense['name']);
    _amountController = TextEditingController(text: widget.expense['amount']);
    _selectedDate = widget.expense['date'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveExpense() {
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    Navigator.pop(context, {
      'index': widget.index,
      'updatedExpense': {
        'name': _nameController.text,
        'amount': _amountController.text,
        'date': _selectedDate,
      }
    });
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
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Color(0xff939393),
                ),
                filled: true,
                fillColor: Color(0xff242424),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color: Color(0xff939393),
                ),
                filled: true,
                fillColor: Color(0xff242424),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 1.h),
            GestureDetector(
              onTap: _showDatePicker,
              child: Container(
                height: 6.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff242424),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xff393937),
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _saveExpense,
              child: Container(
                height: 7.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Color(0xff325FD3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Save',
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
