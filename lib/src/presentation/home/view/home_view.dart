import 'package:agay_proyekt/src/presentation/home/widget/custom_textfild.dart';
import 'package:agay_proyekt/src/presentation/home/widget/every_month_widget.dart';
import 'package:agay_proyekt/src/presentation/home/widget/property_type_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  String selectedProperty = 'Property type';
  String? highlightedProperty;
  bool isContainerSelected = false;
  String selectedM = 'Property type';
  String? highlightedM;
  bool isContainerM = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff171717),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return PropertytypeWidget(
          highlightedProperty: highlightedProperty,
          onSelect: (String property) {
            setState(() {
              selectedProperty = property;
              highlightedProperty = property;
              isContainerSelected = true;
            });
          },
        );
      },
    );
  }

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

  void _selectDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 40.h,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate ?? DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      selectedDate = dateTime;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  void _selectTermDate(BuildContext context, bool isStartDate) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 40.h,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: isStartDate
                      ? selectedStartDate ?? DateTime.now()
                      : selectedEndDate ?? DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      if (isStartDate) {
                        selectedStartDate = dateTime;
                      } else {
                        selectedEndDate = dateTime;
                      }
                    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171717),
      appBar: AppBar(
        title: Text(
          'Add your first property',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color(0xff171717),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showBottomSheet(context),
              child: Container(
                height: 6.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff171717),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isContainerSelected
                        ? Color(0xff325FD3)
                        : Color(0xff393937),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/Frame.svg'),
                      SizedBox(width: 3.w),
                      Text(
                        selectedProperty,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff939393),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                hintStyle: TextStyle(
                  color: Color(0xff4B4B4B),
                ),
                labelStyle: TextStyle(
                  color: Color(0xff4B4B4B),
                ),
                filled: true,
                fillColor: Color(0xff171717),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xff393937),
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
            ),
            SizedBox(height: 1.h),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on_sharp,
                  color: Color(0xff4B4B4B),
                ),
                hintText: 'Address',
                labelText: 'Address',
                filled: true,
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
            ),
            SizedBox(height: 1.5.h),
            Expanded(
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 8.sp),
                      decoration: BoxDecoration(
                        color: Color(0xff242424),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        dividerHeight: 0,
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Color(0xff325FD3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: "Rent"),
                          Tab(text: "No rent"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 1.5.h),
                              CustomTextField(
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
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(13.sp),
                                    child: SvgPicture.asset(
                                        'assets/svg/dollar.svg'),
                                  ),
                                  hintText: 'Contact details',
                                  labelText: 'Contact details',
                                  filled: true,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(15.sp),
                                    child:
                                        SvgPicture.asset('assets/svg/\$.svg'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/calendar.svg'),
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
                                            SvgPicture.asset(
                                                'assets/svg/Vector.svg'),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Text(
                                              'Every month',
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
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Icon(
                                    CupertinoIcons.time,
                                    color: Color(0xff4B4B4B),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    'Lease term:',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _selectTermDate(
                                          context, true); // Start date
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xff171717),
                                        border: Border.all(
                                          color: Color(0xff393937),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          selectedStartDate == null
                                              ? '00.00.0000'
                                              : '${selectedStartDate!.day.toString().padLeft(2, '0')}.${selectedStartDate!.month.toString().padLeft(2, '0')}.${selectedStartDate!.year}',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: selectedStartDate == null
                                                ? Color(0xff393937)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _selectTermDate(
                                          context, false); // End date
                                    },
                                    child: Container(
                                      height: 5.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xff171717),
                                        border: Border.all(
                                          color: Color(0xff393937),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          selectedEndDate == null
                                              ? '00.00.0000'
                                              : '${selectedEndDate!.day.toString().padLeft(2, '0')}.${selectedEndDate!.month.toString().padLeft(2, '0')}.${selectedEndDate!.year}',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: selectedEndDate == null
                                                ? Color(0xff393937)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff325FD3),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
