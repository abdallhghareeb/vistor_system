import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/main_page_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final main = context.watch<MainProvider>();

    return Container(
      padding: EdgeInsets.only(top: 1.h, bottom: 0.8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(main.items.length, (index) {
          final selected = main.index == index;
          return Expanded(
            child: InkWell(
              onTap: () => main.setIndex(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgWidget(
                    svg: main.items[index]['image'],
                    width: 5.5.w,
                    color: selected
                        ? AppColor.defaultColor
                        : const Color(0xff6F7A85),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    LanguageProvider.translate(
                      'home',
                      main.items[index]['title'],
                    ),
                    style:
                        TextStyleClass.normalStyle(
                          color: selected
                              ? AppColor.defaultColor
                              : const Color(0xff6F7A85),
                        ).copyWith(
                          fontWeight: selected
                              ? FontWeight.w500
                              : FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
