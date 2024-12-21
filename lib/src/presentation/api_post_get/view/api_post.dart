import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Apipost extends StatefulWidget {
  const Apipost({super.key});

  @override
  State<Apipost> createState() => _ApipostState();
}

class _ApipostState extends State<Apipost> {
  dynamic _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          _selectedImage = pickedFile.path;
        } else {
          _selectedImage = File(pickedFile.path);
        }
      });
    }
  }

  TextEditingController? emailcontroller = TextEditingController();
  TextEditingController? firstnamecontroller = TextEditingController();
  TextEditingController? lastnamecontroller = TextEditingController();

  Future<void> _sendData() async {
    try {
      final Uri url = Uri.parse("https://reqres.in/api/users");
      final Map<String, String> data = {
        'email': emailcontroller!.text,
        'firstname': firstnamecontroller!.text,
        'lastname': lastnamecontroller!.text,
      };

      String? base64Image;
      if (_selectedImage != null) {
        final bytes = await File(_selectedImage.path).readAsBytes();
        base64Image = base64Encode(bytes);
      }

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        }, // Content-Typeni to'g'ri yozish
        body: json.encode({
          "email": data["email"],
          "firstname": data["firstname"],
          "lastname": data["lastname"],
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Ma\'lumotlar muvaffaqiyatli yuborildi!');
      } else {
        // ignore: avoid_print
        print('Xatolik yuz berdi: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Xatolik: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Api Post",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 19.sp,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? GestureDetector(
                    onTap: _pickImage,
                    child: Icon(
                      Icons.photo_album,
                      size: 27.sp,
                    ),
                  )
                : kIsWeb
                    ? ClipOval(
                        child: Image.network(
                          _selectedImage,
                          width: 15.w,
                          height: 15.h,
                          fit: BoxFit.contain,
                        ),
                      )
                    : const ClipOval(),
            SizedBox(height: 5.h),
            SizedBox(
              width: 90.w,
              height: 50.h,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TextField(
                    controller: index == 0
                        ? emailcontroller
                        : index == 1
                            ? firstnamecontroller
                            : index == 2
                                ? lastnamecontroller
                                : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: index == 0
                          ? 'Email'
                          : index == 1
                              ? 'First Name'
                              : 'Last Name',
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _sendData(); // _sendData funktsiyasini chaqirish
              },
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
