// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
import 'config/theme.dart';
import 'core/constants/constants.dart';
import 'core/helper_function/api.dart';
import 'core/helper_function/notifications.dart';
import 'core/helper_function/prefs.dart';
import 'core/models/local_notifications.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/complete_data_provider.dart';
import 'features/auth/presentation/providers/otp_provider.dart';
import 'features/auth/presentation/providers/reset_password_provider.dart';
import 'features/language/domain/entities/app_localizations.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/main/presentation/provider/main_page_provider.dart';
import 'features/notification/presentation/provider/notification_provider.dart';
import 'features/settings/presentation/provider/settings_provider.dart';
import 'features/scan/presentation/providers/scan_provider.dart';
import 'features/splash/presentation/provider/select_domain_provider.dart';
import 'features/visitors/presentation/providers/visitors_provider.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/splash/presentation/provider/splash_provider.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  if (event.notification != null) {
    appNotifications(
      event.notification!,
      click: true,
      fromWhereClicked: 3,
      payload: event.data,
    );
  }
}

Future<void> localMessagingBackgroundHandler(NotificationResponse pay) async {
  clickNoti(pay.payload!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await startSharedPref();
  await ApiHandel.getInstance.init();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await notificationsFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationLocalClass.init();
  await initializeDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.bottom]);
  LanguageProvider language = LanguageProvider();
  language.fetchLocale();

  runApp(MyApp(language: language));
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  final LanguageProvider language;

  const MyApp({required this.language, super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider(sl.get())),
        ChangeNotifierProvider(
          create: (context) => CompleteDataProvider(sl.get()),
        ),
        ChangeNotifierProvider(create: (context) => OtpProvider(sl.get())),
        ChangeNotifierProvider(
          create: (context) => ResetPasswordProvider(sl.get()),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(sl.get()),
        ),
        ChangeNotifierProvider(create: (context) => SettingsProvider(sl.get())),
        ChangeNotifierProvider(create: (context) => ScanProvider(sl.get())),
        ChangeNotifierProvider(create: (context) => VisitorsProvider(sl.get())),
        ChangeNotifierProvider(
          create: (context) => SelectDomainProvider(sl.get()),
        ),
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: ChangeNotifierProvider<LanguageProvider>(
        create: (_) => language,
        child: Consumer<LanguageProvider>(
          builder: (context, lang, _) {
            return ToastificationWrapper(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: AnnotatedRegion(
                  value: barColor(),
                  child: Sizer(
                    builder: (context, orientation, deviceType) {
                      Constants.isTablet = (deviceType == deviceType);
                      return MaterialApp(
                        // showPerformanceOverlay: true,
                        title: 'AVMS',
                        debugShowCheckedModeBanner: false,
                        navigatorObservers: [routeObserver],
                        navigatorKey: Constants.navState,
                        locale: lang.appLocal,
                        supportedLocales: LanguageProvider.languages,
                        builder: (context, child) {
                          return Container(
                            color: Colors.white,
                            child: SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: child!,
                            ),
                          );
                        },
                        localizationsDelegates: const [
                          CountryLocalizations.delegate,
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        theme: defaultTheme,
                        home: const SplashPage(),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
