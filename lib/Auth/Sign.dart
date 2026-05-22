import 'package:bloc_test/Api_Call/CRUD.dart';
import 'package:bloc_test/Api_Call/LinkApi.dart' show SignUrl;
import 'package:bloc_test/main.dart';
import 'package:bloc_test/widget/request_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc_test/main.dart' show sharedPerf;

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formState = GlobalKey<FormState>();

  Crud crud = Crud();

  Future<void> SignUP() async {
    if (formState.currentState!.validate()) {
      var response = await crud.POST(SignUrl, {
        "Name": nameController.text,
        "Email": emailController.text,
      });

      if (response["status"] == "success") {
        //Save Data
        sharedPerf.setString("routes", "HomeRequest");
        sharedPerf.setString("Name", nameController.text);
        sharedPerf.setString("Email", emailController.text);

        // 2. Navigate to home
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => RequestHome()));
      } else {
        print("Sign Fail ==========================");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF2D2D2D)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 120.h),

              // Title
              Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign up to get started',
                style: TextStyle(
                  color: Color(0xFF2D2D2D).withAlpha(120),
                  fontSize: 16.sp,
                ),
              ),

              SizedBox(height: 40.h),

              // Name Field
              Text(
                'Name',
                style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Name";
                  }

                  return null;
                },
                controller: nameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Color(0xFF2D2D2D)),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Color(0xFF2D2D2D)),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Color(0xFF2D2D2D)),
                  prefixIcon: Icon(Icons.person, color: Color(0xFF2D2D2D)),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Email Field
              Text(
                'Email',
                style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Email";
                  }

                  return null;
                },

                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Color(0xFF2D2D2D)),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Color(0xFF2D2D2D)),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Color(0xFF2D2D2D)),
                  prefixIcon: Icon(Icons.email, color: Color(0xFF2D2D2D)),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await SignUP();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
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

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}


//  Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),