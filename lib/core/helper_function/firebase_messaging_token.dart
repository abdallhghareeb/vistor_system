import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Returns an FCM token when Firebase Messaging is ready.
///
/// On Apple platforms, Firebase cannot create an FCM token until APNs has
/// supplied its token. This may take a moment after startup or permission is
/// granted, and it never happens on simulators that do not support APNs.
Future<String?> getFirebaseMessagingToken() async {
  try {
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();

      for (var attempt = 0; attempt < 10 && apnsToken == null; attempt++) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      }

      if (apnsToken == null) {
        debugPrint('FCM token skipped: APNs token is not available yet.');
        return null;
      }
    }

    return await FirebaseMessaging.instance.getToken();
  } on FirebaseException catch (error, stackTrace) {
    debugPrint('Unable to get FCM token (${error.code}): ${error.message}');
    debugPrintStack(stackTrace: stackTrace);
    return null;
  } catch (error, stackTrace) {
    debugPrint('Unable to get FCM token: $error');
    debugPrintStack(stackTrace: stackTrace);
    return null;
  }
}
