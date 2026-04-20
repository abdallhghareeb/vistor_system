import '../../features/language/presentation/provider/language_provider.dart';
import '../helper_function/navigation.dart';
import 'confirm_dialog.dart';

void showGuestDialog(){
  confirmDialog( LanguageProvider.translate("login", "must_login"),
      LanguageProvider.translate("buttons", "login"), () {
    // navPARU(LoginPage());
  });
  // navPARU(LoginPage());
}