import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EverymonthWidget extends StatelessWidget {
  final String? highlightedProperty;
  final Function(String) onSelect;
  final List<Map<String, dynamic>> properties;

  const EverymonthWidget({
    super.key,
    required this.highlightedProperty,
    required this.onSelect, required this.properties,
  });

  @override
  Widget build(BuildContext context) {
 

    return Container(
      height: 40.h,
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
                    color: const Color(0xff393937),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    onSelect(properties[index]['label']);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff325FD3)
                          : const Color(0xff393937),
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
  }
}
