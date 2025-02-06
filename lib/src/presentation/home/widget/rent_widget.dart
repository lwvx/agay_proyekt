import 'package:agay_proyekt/src/presentation/home/widget/choose_date.dart';
import 'package:agay_proyekt/src/presentation/home/widget/custom_textfild.dart';
import 'package:agay_proyekt/src/presentation/home/widget/date_of_payment.dart';
import 'package:agay_proyekt/src/presentation/home/widget/every_month_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RentWidget extends StatefulWidget {
  final TabController tabControlle;
  final TextEditingController name;
  final TextEditingController adres;
  const RentWidget(
      {super.key,
      required this.tabControlle,
      required this.name,
      required this.adres});

  @override
  State<RentWidget> createState() => _RentWidgetState();
}

class _RentWidgetState extends State<RentWidget> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> properties = [
    {'label': 'Every day'},
    {'label': 'Every week'},
    {'label': 'Every 2 weeks'},
    {'label': 'Every 3 weeks'},
    {'label': 'Every month'},
  ];
  String selectedM = 'Property type';
  String? highlightedM;
  bool isContainerM = false;

  void _showBottomMonthSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff171717),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return EverymonthWidget(
          properties: properties,
          highlightedProperty: highlightedM,
          onSelect: (String property) {
            setState(() {
              selectedM = property;
              highlightedM = property;
              isContainerM = true;
            });
          },
        );
      },
    );
  }

  DateTime? selectedDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final tenant = TextEditingController();
  final contact = TextEditingController();
  final contactDeteil = TextEditingController();

  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    // Добавляем слушателей на изменение полей
    tenant.addListener(_validateFields);
    contact.addListener(_validateFields);
    contactDeteil.addListener(_validateFields);
  }

  @override
  void dispose() {
    tenant.dispose();
    contact.dispose();
    contactDeteil.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      isButtonActive = tenant.text.isNotEmpty &&
          contact.text.isNotEmpty &&
          contactDeteil.text.isNotEmpty &&
          selectedDate != null &&
          selectedStartDate != null &&
          selectedEndDate != null;
    });
  }

  void _selectDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return DateOfPayment(
          selectedDate: selectedDate,
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
              _validateFields();
            });
          },
        );
      },
    );
  }

  void _selectTermDate(BuildContext context, bool isStartDate) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ChooseDate(
          isStartDate: isStartDate,
          selectedStartDate: selectedStartDate,
          selectedEndDate: selectedEndDate,
          onDateSelected: (date) {
            setState(() {
              if (isStartDate) {
                selectedStartDate = date;
              } else {
                selectedEndDate = date;
              }
              _validateFields();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: widget.tabControlle,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 1.5.h),
                CustomTextField(
                  controller: tenant,
                  hintText: 'Tenant',
                  labelText: 'Tenant',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xff4B4B4B),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  controller: contact,
                  hintText: 'Contact details',
                  labelText: 'Contact details',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xff4B4B4B),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  controller: contactDeteil,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(13.sp),
                      child: SvgPicture.asset('assets/svg/dollar.svg'),
                    ),
                    hintText: 'Contact details',
                    labelText: 'Contact details',
                    filled: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: SvgPicture.asset('assets/svg/\$.svg'),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xff4B4B4B),
                    ),
                    fillColor: Color(0xff171717),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xff325FD3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xff325FD3),
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 13.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff171717),
                    border: Border.all(
                      color: Color(0xff393937),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.sp, vertical: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/calendar.svg'),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                selectedDate == null
                                    ? 'Date of payment'
                                    : '${selectedDate!.day.toString().padLeft(2, '0')}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.year}',
                                style: TextStyle(
                                  color: selectedDate == null
                                      ? const Color(0xff4B4B4B)
                                      : Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xff4B4B4B),
                          indent: 20.sp,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showBottomMonthSheet(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/Vector.svg'),
                              SizedBox(
                                width: 2.5.w,
                              ),
                              Text(
                                selectedM,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.time, color: Color(0xff4B4B4B)),
                    SizedBox(width: 2.w),
                    Text('Lease term:',
                        style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                    SizedBox(width: 1.w),
                    GestureDetector(
                      onTap: () => _selectTermDate(context, true),
                      child: _buildDateContainer(selectedStartDate),
                    ),
                    SizedBox(width: 1.w),
                    Text('-',
                        style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                    SizedBox(width: 1.w),
                    GestureDetector(
                      onTap: () => _selectTermDate(context, false),
                      child: _buildDateContainer(selectedEndDate),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 7.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: isButtonActive ? Color(0xff325FD3) : Colors.grey,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateContainer(DateTime? date) {
    return Container(
      height: 5.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: Color(0xff171717),
        border: Border.all(color: Color(0xff393937)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          date == null
              ? '00.00.0000'
              : '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}',
          style: TextStyle(
              fontSize: 15.sp,
              color: date == null ? Color(0xff393937) : Colors.white),
        ),
      ),
    );
  }
}
