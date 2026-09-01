import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitor/features/main/presentation/provider/main_page_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/guest_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/firebase_messaging_token.dart';
import '../../../../core/models/pagination_class.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/use_cases/notification_usecaese.dart';
import '../pages/notification_details_page.dart';
import '../pages/notification_page.dart';

class NotificationProvider extends ChangeNotifier implements PaginationClass {
  List<NotificationEntity>? notifications;

  final NotificationUseCases notificationUseCases;
  NotificationProvider(this.notificationUseCases) {
    pagination();
  }

  @override
  int pageIndex = 1;
  void clear() {
    notifications = null;
    paginationStarted = false;
    paginationFinished = false;
    pageIndex = 1;
    notifyListeners();
  }

  Future getNotifications() async {
    Map<String, dynamic> data = {};
    data['page'] = pageIndex;
    Either<DioException, List<NotificationEntity>> value =
        await notificationUseCases.getNotifications(data);
    value.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        pageIndex++;
        notifications ??= [];
        notifications?.addAll(r);
        if (r.isEmpty) {
          paginationFinished = true;
          notifyListeners();
        }
      },
    );
    paginationStarted = false;
    notifyListeners();
  }

  bool listNotEmpty() {
    return notifications != null && notifications!.isNotEmpty;
  }

  void refresh() {
    clear();
    getNotifications();
  }

  @override
  bool paginationFinished = false;

  @override
  bool paginationStarted = false;
  ScrollController controller = ScrollController();
  @override
  void pagination() {
    controller.addListener(() async {
      if (controller.position.atEdge && controller.position.pixels > 50) {
        if (!paginationFinished &&
            !paginationStarted &&
            notifications != null &&
            notifications!.isNotEmpty) {
          paginationStarted = true;
          notifyListeners();
          await getNotifications();
        }
      }
    });
  }

  void goToNotificationPage() {
    if (AuthProvider.isGuestMode()) {
      showGuestDialog();
      return;
    }
    refresh();
    navP(
      NotificationPage(),
      then: (val) {
        Provider.of<AuthProvider>(
          Constants.globalContext(),
          listen: false,
        ).getProfile();
      },
    );
  }

  void goToNotificationDetailsPage({
    required String title,
    required String data,
    required String id,
  }) {
    read(id: id);
    navP(
      NotificationDetailsPage(title: title, data: data),
      then: (val) {
        unreadCount();
      },
    );
  }

  num unReadNum = 0;
  Future<void> unreadCount() async {
    Map<String, dynamic> data = {};
    Either<DioException, num> value = await notificationUseCases.unreadCount(
      data,
    );
    value.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        unReadNum = r;
        notifyListeners();
      },
    );
  }

  Future<void> read({required String id}) async {
    Map<String, dynamic> data = {};
    data['id'] = id;
    Either<DioException, bool> value = await notificationUseCases.read(data);
    value.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        notifications?.firstWhere((element) => element.id == id).isRead = true;
        notifyListeners();
      },
    );
  }

  Future<void> readAll() async {
    Map<String, dynamic> data = {};
    Either<DioException, bool> value = await notificationUseCases.readAll(data);
    value.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        for (var i in notifications!) {
          i.isRead = true;
        }
        unReadNum = 0;
        notifyListeners();
      },
    );
  }

  Future<void> registerDevice() async {
    final deviceToken = await getFirebaseMessagingToken();
    if (deviceToken == null) return;

    Map<String, dynamic> data = {};
    data['deviceToken'] = deviceToken;
    data['deviceType'] = getDeviceType();
    Either<DioException, bool> value = await notificationUseCases
        .registerDevice(data);
    value.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        unreadCount();
      },
    );
  }

  Future<void> unregisterDevice() async {
    final deviceToken = await getFirebaseMessagingToken();
    if (deviceToken == null) return;

    Map<String, dynamic> data = {};
    data['deviceToken'] = deviceToken;
    Either<DioException, bool> value = await notificationUseCases
        .unRegisterDevice(data);
    value.fold((l) {
      showToast(
        l.response?.data['error'] ??
            l.message ??
            LanguageProvider.translate('error', 'error'),
      );
    }, (r) {});
  }

  void rebuild() {
    notifyListeners();
  }

  String getDeviceType() {
    if (kIsWeb) {
      return "WEB";
    } else if (Platform.isAndroid) {
      return "ANDROID";
    } else if (Platform.isIOS) {
      return "IOS";
    } else {
      return "Unknown";
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
