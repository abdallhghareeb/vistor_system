import 'package:flutter/services.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../settings/presentation/provider/permissions_provider.dart';
import '../provider/connection_provider.dart';
import '../provider/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await delay(100);
      Provider.of<SplashProvider>(context, listen: false).startApp();
    });
    Future.microtask(() {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.bottom],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child:  Stack(
          alignment: Alignment.center,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.logo),
                    )
                ),
              ),
            ],
            ),
          ],
        ),
      ),
    );
  }
}
