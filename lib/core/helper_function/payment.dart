//
// import 'package:flutter/material.dart';
// import 'package:moyasar/moyasar.dart';
// import 'package:provider/provider.dart';
// import 'package:oil/features/settings/presentation/provider/settings_provider.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../features/language/presentation/provider/language_provider.dart';
// import '../constants/constants.dart';
// import '../dialog/snack_bar.dart';
// import 'navigation.dart';
//
// Future pay(num price,bool isApple,Future Function() onSuccess,)async{
//   final paymentConfig = PaymentConfig(
//     publishableApiKey: Provider.of<SettingsProvider>(Constants.globalContext(),listen: false).settingsEntity!.getActivePayment(),
//     amount: (price*100).toInt(), // SAR 257.58
//     description: 'new Operation',
//     metadata: {},
//     creditCard: CreditCardConfig(saveCard: false, manual: false),
//     currency: 'SAR',
//     applePay: ApplePayConfig(merchantId: 'merchant.com.oil', label: 'oil', manual: false),
//   );
//   await showModalBottomSheet(context: Constants.globalContext(),isScrollControlled: true, builder: (ctx){
//       return InkWell(
//         onTap: (){
//           FocusScope.of(Constants.globalContext()).unfocus();
//         },
//         child: Padding(
//           padding: EdgeInsets.only(bottom: MediaQuery.of(Constants.globalContext()).viewInsets.bottom,
//           right: 3.w,left: 3.w),
//           child: Container(
//             height: isApple?30.h: 80.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: 3.h,),
//                   isApple?ApplePay(
//                     config: paymentConfig,
//                     onPaymentResult: (result)async{
//                       navPop();
//                       if(result is PaymentResponse){
//                         if(result.status==PaymentStatus.paid){
//                           await onSuccess();
//                         }else{
//                           showToast(LanguageProvider.translate('validation', 'pay_field'),);
//                         }
//                       }
//                     },
//                   ):CreditCard(
//                     locale: Provider.of<LanguageProvider>
//                       (Constants.globalContext(),listen: false).appLocal.languageCode=='ar'?
//                     const Localization.ar():const Localization.en(),
//                     config: paymentConfig,
//                     onPaymentResult: (result)async{
//                       navPop();
//                       if(result is PaymentResponse){
//                         if(result.status==PaymentStatus.paid){
//                           await onSuccess();
//                         }else{
//                           showToast(LanguageProvider.translate('validation', 'pay_field'),);
//                         }
//                       }
//                     },
//                   ),
//                   SizedBox(height: 5.h,),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//
// }