import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/permissions_provider.dart';
import '../widgets/permission_widget.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionsProvider permissionsProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar : AppBar(title: Text(LanguageProvider.translate("settings", "permissions")),),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.w),
                  child: Wrap(runSpacing: 2.h,
                    children: List.generate(permissionsProvider.permissionsList.length,
                          (index) => PermissionWidget(data: permissionsProvider.permissionsList[index],),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
