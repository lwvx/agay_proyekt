import 'package:agay_proyekt/src/presentation/home/widget/custom_textfild.dart';
import 'package:agay_proyekt/src/presentation/home/widget/property_type_widget.dart';
import 'package:agay_proyekt/src/presentation/home/widget/rent_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController _tabController;

  String? highlightedProperty;
  bool isContainerSelected = false;
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

  String selectedProperty = 'Property type';
  final nameCon = TextEditingController();
  final adresCon = TextEditingController();
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
            CustomTextField(
              hintText: 'Name',
              controller: nameCon,
              labelText: 'Name',
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              controller: adresCon,
              prefixIcon: Icon(
                Icons.location_on_sharp,
                color: Color(0xff4B4B4B),
              ),
              hintText: 'Address',
              labelText: 'Address',
            ),
            SizedBox(height: 1.5.h),
            SizedBox(
              height: 6.h,
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: Size.fromHeight(20),
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
                ],
              ),
            ),
            RentWidget(
              tabControlle: _tabController,
              adres: adresCon,
              name: nameCon,
            ),
          ],
        ),
      ),
    );
  }

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
}
