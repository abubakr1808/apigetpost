import 'package:apigetpost/src/presentation/api_post_get/view/get_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ApiPostGet(),
      ),
    );
  }
}
