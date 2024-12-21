import 'package:apigetpost/src/presentation/api_post_get/view/api_post.dart';
import 'package:apigetpost/src/presentation/api_post_get/view/user_info_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ApiPostGet extends StatefulWidget {
  const ApiPostGet({super.key});

  @override
  State<ApiPostGet> createState() => _ApiPostGetState();
}

class _ApiPostGetState extends State<ApiPostGet> {
  // ignore: non_constant_identifier_names
  List<dynamic> PersonalInformation = [];
  Future<void> getDAta() async {
    try {
      Dio dio = Dio();
      dynamic respons = await dio.get("https://reqres.in/api/users");
      if (respons.statusCode == 200) {
        setState(() {
          PersonalInformation = respons.data["data"];
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  @override
  void initState() {
    getDAta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Api, Get",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 19.sp,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Apipost(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 21.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 90.h,
              child: ListView.builder(
                itemCount: PersonalInformation.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoPage(
                            PersonalInformation: PersonalInformation[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      width: double.infinity,
                      height: 230,
                      color: Colors.amber,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.sp),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                PersonalInformation[index]["avatar"] ??
                                    " no avatar",
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PersonalInformation[index]["email"] ??
                                      "no email",
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  PersonalInformation[index]["first_name"] ??
                                      "no first_name",
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  PersonalInformation[index]["last_name"] ??
                                      " no last_name",
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
