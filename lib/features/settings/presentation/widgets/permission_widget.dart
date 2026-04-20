import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/permissions_provider.dart';

class PermissionWidget extends StatelessWidget {
  const PermissionWidget({super.key, required this.data});
  final Map<String,dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgWidget(svg: data['image'],width: 6.w,color: AppColor.defaultColor,),
        SizedBox(width: 2.w,),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LanguageProvider.translate("permissions", data['title']),
                style: TextStyleClass.normalStyle(),),
              Text(LanguageProvider.translate("permissions", data['description']),
                style: TextStyleClass.smallStyle(color: Color(0xff898E99)),),
            ],
          ),
        ),
        SizedBox(width: 2.w,),
        Switch(value: data['allow'], onChanged: (value) {
          Provider.of<PermissionsProvider>(context, listen: false).changeAllowElement(data);
        },)
      ],
    );
  }
}
