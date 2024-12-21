import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({
    super.key,
    // ignore: non_constant_identifier_names
    required this.PersonalInformation,
  });

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  final PersonalInformation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 90.w,
          height: 33.h,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Image.network(
                  PersonalInformation["avatar"] ?? " no avatar",
                ),
              ),
              Text(
                PersonalInformation["email"] ?? "no email",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                PersonalInformation["first_name"] ?? "no first_name",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                PersonalInformation["last_name"] ?? "no last_name",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
