import 'package:bloc_test/Api_Call/CRUD.dart';
import 'package:bloc_test/Api_Call/LinkApi.dart' show LoginUrl;
import 'package:bloc_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc_test/main.dart' show sharedPerf;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  final formstate = GlobalKey<FormState>();

  String? Function(String?)? valid;

  final crud = Crud();
  Future<dynamic> Login_function() async {
    if (formstate.currentState!.validate()) {
      var response = await crud.POST(LoginUrl, {
        "Name": NameController.text,
        "Email": EmailController.text,
      });
      if (response["status"] == "success") {
        //Sava Data
        sharedPerf.setString("routes", "HomeRequest");
        sharedPerf.setString("Name", NameController.text);
        sharedPerf.setString("Email", EmailController.text);
        //Navigator
        return Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("HomeRequest", (route) => false);
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF2D2D2D),
            duration: Duration(seconds: 2),
            content: const Text(
              'Name or Email Wrong...!\nTry Again 😊',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF5F0EB),
              ),
            ),
          ),
        );
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
          key: formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 120.h),

              // Title
              Text(
                'Welcome Back!',
                style: TextStyle(
                  backgroundColor: const Color(0xFFF5F0EB),
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Login to your account',
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
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
                controller: NameController,
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
                controller: EmailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Email";
                  }
                  return null;
                },
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

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await Login_function();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
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
            ],
          ),
        ),
      ),
    );
  }
}
