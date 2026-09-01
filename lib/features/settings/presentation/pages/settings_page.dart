import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/dialog/guest_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';
import '../../../splash/presentation/provider/select_domain_provider.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_avatar.dart';
import '../widgets/settings_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final settingsProvider = context.read<SettingsProvider>();
    final user = authProvider.userEntity;
    final isGuest = AuthProvider.isGuestMode();
    final userName = isGuest
        ? LanguageProvider.translate('settings', 'guest_name')
        : user?.username?.trim().isNotEmpty == true
        ? user!.username!
        : LanguageProvider.translate('home', 'guest');
    CompleteDataProvider completeDataProvider =
        Provider.of<CompleteDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: const SettingsAppBar(title: 'settings', showBackButton: false),
      body: ListView(
        padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
        children: [
          _ProfileCard(
            name: userName,
            imageUrl: user?.pictureUrl,
            showEdit: !isGuest,
            onEdit: () {
              settingsProvider.prepareProfile(name: userName);
              completeDataProvider.goToRegisterPage();
            },
          ),
          SizedBox(height: 2.h),
          SettingsSection(
            title: 'account_settings',
            items: [
              SettingsTileData(
                title: 'change_password',
                icon: Icons.lock_outline_rounded,
                onTap: () {
                  if (isGuest) {
                    showGuestDialog();
                  } else {
                    completeDataProvider.goToChangePasswordPage();
                  }
                },
              ),
              SettingsTileData(
                title: 'language',
                icon: Icons.translate_rounded,
                onTap: () {
                  settingsProvider.prepareLanguage(
                    LanguageProvider.languageCode() ?? 'ar',
                  );
                  settingsProvider.goToLanguagePage();
                },
              ),
              SettingsTileData(
                title: 'notification',
                icon: Icons.notifications_none_rounded,
                onTap: () {
                  Provider.of<NotificationProvider>(
                    context,
                    listen: false,
                  ).goToNotificationPage();
                },
              ),
              SettingsTileData(
                title: 'logout',
                icon: Icons.logout,
                onTap: () {
                  if (isGuest) {
                    context.read<SelectDomainProvider>().exitGuest();
                  } else {
                    authProvider.confirmLogoutAccount();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SettingsSection(
            title: 'app_info',
            items: [
              SettingsTileData(
                title: 'about_avms',
                icon: Icons.info_outline_rounded,
                onTap: () {
                  settingsProvider.goToPrivacyPage();
                },
              ),
              SettingsTileData(
                title: 'version',
                icon: Icons.system_update_alt_rounded,
                version: true,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 3.h),
          InkWell(
            onTap: () {
              if (isGuest) {
                showGuestDialog();
              } else {
                authProvider.confirmDeleteAccount();
              }
            },
            child: Center(
              child: Text(
                LanguageProvider.translate("settings", "delete_account"),
                style: TextStyleClass.normalStyle(color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback onEdit;
  final bool showEdit;

  const _ProfileCard({
    required this.name,
    required this.imageUrl,
    required this.onEdit,
    required this.showEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: const Color(0xffEDF1F4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1C3550).withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          SettingsAvatar(imageUrl: imageUrl),
          SizedBox(height: 1.h),
          Text(
            name,
            style: TextStyleClass.normalStyle(
              color: AppColor.defaultBlackColor,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          if (showEdit) ...[
            SizedBox(height: 0.4.h),
            InkWell(
              onTap: onEdit,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                child: Text(
                  LanguageProvider.translate("settings", "update_profile"),
                  style: TextStyleClass.smallStyle(color: AppColor.defaultColor)
                      .copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.defaultColor,
                      ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
