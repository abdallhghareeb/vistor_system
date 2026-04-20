import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/local_notifications.dart';
import '../provider/main_page_provider.dart';
import '../widgets/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        if (event.data.isNotEmpty) {
          String payload = jsonEncode(event.data);
          clickNoti(payload);
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MainProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        // confirmDialog(LanguageProvider.translate('main', 'exit'), LanguageProvider.translate('main', 'logout'), () {
        //   exit(0);
        // });
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                // Expanded(
                //   child: SlideTransitionWidget(child: Container(key: ValueKey(model.index),
                //       child: model.bottomWidget[model.index])),
                // ),
                Expanded(
                  child: Container(key: ValueKey(model.index),
                      child: model.bottomWidget[model.index]),
                ),

                CustomBottomNavigationBar(),
              ],
            ),
            ),
      ),
    );
  }
}
