import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DateOfPayment extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateOfPayment({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  _DateOfPaymentState createState() => _DateOfPaymentState();
}

class _DateOfPaymentState extends State<DateOfPayment> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',
                    style: TextStyle(color: CupertinoColors.systemBlue)),
              ),
              CupertinoButton(
                onPressed: () {
                  widget.onDateSelected(selectedDate);
                  Navigator.pop(context);
                },
                child: const Text('Done',
                    style: TextStyle(color: CupertinoColors.systemBlue)),
              ),
            ],
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              onDateTimeChanged: (date) {
                setState(() => selectedDate = date);
              },
            ),
          ),
        ],
      ),
    );
  }
}
