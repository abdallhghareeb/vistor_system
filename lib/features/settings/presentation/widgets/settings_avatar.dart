import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/core/constants/images.dart';

import '../../../../config/app_color.dart';

class SettingsAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const SettingsAvatar({this.imageUrl, this.size = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: AppColor.defaultColor.withValues(alpha: 0.18),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.trim().isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _fallback(),
              )
            : _fallback(),
      ),
    );
  }

  Widget _fallback() => Image.asset(Images.logo, fit: BoxFit.cover);
}
