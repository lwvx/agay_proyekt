import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:agay_proyekt/src/presentation/employees/widget/custom_textField2.dart';

class NewEmployee extends StatefulWidget {
  const NewEmployee({super.key});

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final nameCont = TextEditingController();
  final positionCont = TextEditingController();
  final salaryCont = TextEditingController();
  final notesCont = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String selectedStatus = 'Select Status';
  Color activeColor = Color(0xff1D914A),
      vacationColor = Color(0xffFF9500),
      inactiveColor = Color(0xffD02D24);
  Color? selectedContainerColor;

  bool isFormValid() {
    // Check if all necessary fields are filled out
    return nameCont.text.isNotEmpty &&
        positionCont.text.isNotEmpty &&
        salaryCont.text.isNotEmpty &&
        nameCont.text.isNotEmpty &&
        selectedStatus != 'Select Status';
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff141414),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: SizedBox(
          height: 25.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetItem("Replace", Color(0xff0A84FF), () {
                Navigator.pop(context);
                _pickImage();
              }),
              Divider(thickness: 2.sp, color: Colors.grey),
              _buildBottomSheetItem("Delete", Colors.red, () {
                setState(() => _image = null);
                Navigator.pop(context);
              }),
              _buildBottomSheetItem("Cancel", Color(0xff0A84FF), () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem(String text, Color color, VoidCallback onTap) {
    return ListTile(
      title: Center(
        child: Text(text, style: TextStyle(color: color, fontSize: 16.sp)),
      ),
      onTap: onTap,
    );
  }

  void _showStatusBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff141414),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: SizedBox(
          height: 53.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Column(
              children: [
                Container(
                  height: 0.5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text('Select Status',
                        style: GoogleFonts.tomorrow(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500)),
                    Spacer(),
                    _buildCloseButton(context),
                  ],
                ),
                SizedBox(height: 3.5.h),
                _buildStatusOption('Active', activeColor, () {
                  setState(() {
                    selectedStatus = 'Active';
                    selectedContainerColor = activeColor;
                  });
                  Navigator.pop(context);
                }),
                SizedBox(height: 2.h),
                _buildStatusOption('On Vacation', vacationColor, () {
                  setState(() {
                    selectedStatus = 'On Vacation';
                    selectedContainerColor = vacationColor;
                  });
                  Navigator.pop(context);
                }),
                SizedBox(height: 2.h),
                _buildStatusOption('Inactive', inactiveColor, () {
                  setState(() {
                    selectedStatus = 'Inactive';
                    selectedContainerColor = inactiveColor;
                  });
                  Navigator.pop(context);
                }),
                SizedBox(height: 3.5.h),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = status;
          selectedContainerColor = color;
        });
        onTap();
      },
      child: Container(
        height: 7.h,
        decoration: BoxDecoration(
            color: Color(0xff1E1E1E), borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Row(
            children: [
              Container(
                height: 1.5.h,
                width: 3.5.w,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(width: 2.w),
              Text(status,
                  style: GoogleFonts.tomorrow(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400)),
              Spacer(),
              _buildStatusIndicator(status),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    return Container(
      height: 3.h,
      width: 6.5.w,
      decoration: BoxDecoration(
          color: selectedStatus == status ? Colors.white : Color(0xff1E1E1E),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white)),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      height: 4.h,
      width: 9.w,
      decoration: BoxDecoration(
          color: Color(0xff1E1E1E), borderRadius: BorderRadius.circular(50)),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.close, color: Colors.white, size: 18.sp),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      height: 6.5.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: isFormValid()
              ? Color(0xff4A53E4)
              : Colors.grey, // Change color based on form validation
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text('Save',
            style: GoogleFonts.tomorrow(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildStatusContainer() {
    return Container(
      height: 6.5.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff141414),
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Row(
          children: [
            // Этот маленький цветной контейнер перед текстом
            Container(
              height: 1.5.h,
              width: 3.5.w,
              decoration: BoxDecoration(
                  color: selectedContainerColor ?? Color(0xff141414),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
                width: 2.w), // Немного пространства между контейнером и текстом
            Text(selectedStatus,
                style: GoogleFonts.tomorrow(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            Spacer(),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141414),
      appBar: AppBar(
        backgroundColor: Color(0xff141414),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBackButton(),
            Text('New Employee',
                style: GoogleFonts.tomorrow(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 10.w),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: _buildImagePicker()),
              SizedBox(height: 2.5.h),
              CustomTextField2(
                  hintText: 'Employee Name',
                  controller: nameCont,
                  labelText: 'Name'),
              SizedBox(height: 2.h),
              CustomTextField2(
                  controller: positionCont,
                  hintText: 'Work Position',
                  labelText: 'Position'),
              SizedBox(height: 2.h),
              CustomTextField2(
                  controller: salaryCont,
                  keyboardType: TextInputType.phone,
                  hintText: '\$0',
                  labelText: 'Salary'),
              SizedBox(height: 2.h),
              GestureDetector(
                  onTap: _showStatusBottomSheet,
                  child: _buildStatusContainer()),
              SizedBox(height: 2.h),
              CustomTextField2(
                  controller: notesCont,
                  hintText: 'Extra details',
                  labelText: 'Notes'),
              SizedBox(height: 2.5.h),
              GestureDetector(
                onTap: () {
                  if (isFormValid()) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 6.5.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: isFormValid()
                          ? Color(0xff4A53E4)
                          : Colors.grey, // Set the button color
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text('Save',
                        style: GoogleFonts.tomorrow(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      height: 5.h,
      width: 11.w,
      decoration: BoxDecoration(
          color: Color(0xff1E1E1E), borderRadius: BorderRadius.circular(13)),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_rounded,
            color: Colors.white, size: 16.sp),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        if (_image == null) {
          _pickImage();
        } else {
          _showBottomSheet();
        }
      },
      child: Container(
        height: 20.h,
        width: 45.w,
        decoration: BoxDecoration(
            color: Color(0xff141414),
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(_image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/svg_picker.svg'),
                  SizedBox(height: 0.5.h),
                  Text('Add Photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
      ),
    );
  }
}
