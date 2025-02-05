import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../presentation.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _UnbordingState createState() => _UnbordingState();
}

class _UnbordingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff04091D),
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: contents.length,
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    Positioned(
                      top: 5.sp,
                      child: SizedBox(
                        height: 75.h,
                        width: 100.w,
                        child: Image.asset(
                          contents[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 35.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xff171717),
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(15),
                            topEnd: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 22.sp, horizontal: 20.sp),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  contents[i].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 11.sp),
                                  child: Text(
                                    contents[i].discripton,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (_currentPage < contents.length - 1) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeView(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 8.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4674FF),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _currentPage == contents.length - 1
                                            ? 'Start'
                                            : 'Continue',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
