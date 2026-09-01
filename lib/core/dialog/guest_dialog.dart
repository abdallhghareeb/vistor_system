import 'package:provider/provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../../features/splash/presentation/pages/select_domain_page.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';
import '../helper_function/prefs.dart';
import 'confirm_dialog.dart';

void showGuestDialog() {
  confirmDialog(
    LanguageProvider.translate("auth", "guest_mode"),
    LanguageProvider.translate("buttons", "login"),
    () {
      final domain = sharedPreferences.getString('domain');
      if (domain == null || domain.trim().isEmpty) {
        sharedPreferences.remove('guest_mode');
        navPARU(const SelectDomainPage());
        return;
      }
      Provider.of<AuthProvider>(
        Constants.globalContext(),
        listen: false,
      ).goToLoginPage();
    },
    message: LanguageProvider.translate("auth", "guest_login_required"),
  );
}
