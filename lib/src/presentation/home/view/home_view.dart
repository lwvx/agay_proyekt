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
    List<Map<String, dynamic>> properties = [
      {'label': 'Apartment'},
      {'label': 'House'},
      {'label': 'Room'},
      {'label': 'Office premises'},
      {'label': 'Commercial'},
      {'label': 'Warehouse'},
      {'label': 'Specialized premises '},
      {'label': 'Holiday home'},
      {'label': 'Cottage'},
      {'label': 'Hangar'},
      {'label': 'Land plot'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff171717),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Container(
          height: 70.h,
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 6.w),
                  Text(
                    'Select the type of real estate',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 2.5.h,
                      width: 5.5.w,
                      decoration: BoxDecoration(
                        color: Color(0xff393937),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        properties[index]['label'] == highlightedProperty;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedProperty = properties[index]['label'];
                          highlightedProperty = properties[index]['label'];
                          isContainerSelected = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xff325FD3)
                              : Color(0xff393937),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            properties[index]['label'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
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
                              TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xff4B4B4B),
                                  ),
                                  hintText: 'Tenant',
                                  labelText: 'Tenant',
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
                              SizedBox(
                                height: 1.h,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Color(0xff4B4B4B),
                                  ),
                                  hintText: 'Contact details',
                                  labelText: 'Contact details',
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
                                keyboardType: TextInputType.phone,
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
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/calendar.svg'),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              'Date of payment',
                                              style: TextStyle(
                                                color: Color(0xff4B4B4B),
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
                                      Row(
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
                                    ],
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
