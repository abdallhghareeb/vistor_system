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
    MainProvider main = Provider.of(context, listen: true);

    return Stack(clipBehavior: Clip.none,alignment: Alignment.center,
      children: [
        Container(
          decoration:  BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(main.items.length, (index) {
              return InkWell(
                onTap: () {
                  main.setIndex(index);
                },
                child: SizedBox(
                  width:  24.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    key: ValueKey<int>(index),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 1.h),
                      SvgWidget(
                            svg:index == main.index? main.items[index]['active_image']: main.items[index]['image'],
                            fit: BoxFit.cover, width: 6.w,color: AppColor.defaultColor,
                        ),
                      SizedBox(height: 0.5.h),
                      Text(LanguageProvider.translate("home", main.items[index]['title']),
                        style: TextStyleClass.normalStyle(
                            color:main.index==index?AppColor.defaultColor:Color(0xff808080)  ),
                      ),
                      SizedBox(height: 1.h),

                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
