import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseDate extends StatefulWidget {
  final bool isStartDate;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime) onDateSelected;

  const ChooseDate({
    super.key,
    required this.isStartDate,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onDateSelected,
  });

  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.isStartDate
        ? widget.selectedStartDate ?? DateTime.now()
        : widget.selectedEndDate ?? DateTime.now();
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
