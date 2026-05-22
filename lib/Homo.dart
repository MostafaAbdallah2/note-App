import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Welcome👋',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 90,
              left: 15,
              // right: 8,
            ),
            child: Image.asset("images/Login.png"),
          ),
          SizedBox(height: 50.h),
          // Login Button
          SizedBox(
            width: 250.w,
            height: 55.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("Login");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Sign Up Button
          SizedBox(
            width: 250.w,
            height: 55.h,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("Sign");
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFF2D2D2D), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Spacer(),

          // Bottom Text
          Text(
            "By continuing, you agree to our Terms & Privacy Policy",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 13.sp),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
