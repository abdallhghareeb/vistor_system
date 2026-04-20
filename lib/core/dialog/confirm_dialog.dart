import 'package:flutter/material.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';

void confirmDialog(
    String title,
    String confirm,
    void Function() confirmTap, {
      String? cancel,
      void Function()? cancelTap,
      bool isDismiss = true,
      String? message,
    }) {
  final context = Constants.globalContext();

  showGeneralDialog(
    context: context,
    barrierDismissible: isDismiss,
    barrierLabel: "",
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);

      return Transform.scale(
        scale: curved.value,
        child: Opacity(
          opacity: anim.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: message != null
                ? Text(
              message,
              style: const TextStyle(fontSize: 14),
            )
                : null,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            actions: [
                TextButton(
                  onPressed: cancelTap ?? () => navPop(),
                  child: Text(
                    cancel ?? LanguageProvider.translate("buttons", "cancel"),
                    style: TextStyleClass.normalStyle(color:Colors.red ),
                  ),
                ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  confirmTap();
                },
                child: Text(
                  confirm,
                  style: TextStyleClass.normalStyle(),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
