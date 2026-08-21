import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/scan_provider.dart';

class ScanConfirmationSheet extends StatelessWidget {
  const ScanConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final scanProvider = context.watch<ScanProvider>();
    final invitation = scanProvider.invitation!;
    final isLoading = scanProvider.stage == ScanStage.creating;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: isLoading ? null : scanProvider.scanAgain,
                child: Container(
                  width: 10.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffC9D8E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  _VisitorAvatar(
                    imageUrl: invitation.visitorImage,
                    name: invitation.fullName,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invitation.fullName.isEmpty
                              ? LanguageProvider.translate(
                                  'visitors',
                                  'visitor',
                                )
                              : invitation.fullName,
                          style: TextStyleClass.normalStyle(
                            color: const Color(0xff27313A),
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 0.3.h),
                        Text("ID : ${invitation.documentId}",
                          style: TextStyleClass.smallStyle(
                            color: const Color(0xff27313A),
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),

                        SizedBox(height: 0.3.h),
                        Row(
                          children: [
                            Container(
                              width: 1.8.w,
                              height: 1.8.w,
                              decoration: const BoxDecoration(
                                color: Color(0xff16A34A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Text(
                                invitation.statusValue.isEmpty
                                    ? LanguageProvider.translate(
                                        'scan',
                                        'valid_invitation',
                                      )
                                    : invitation.statusValue,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleClass.normalStyle(
                                  color: const Color(0xff16A34A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xff16A34A),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  Expanded(
                    child: _VisitorInfo(
                      label: LanguageProvider.translate('scan', 'host_name'),
                      value: invitation.areaNames,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              // Row(
              //   children: [
              //     Expanded(
              //       child: _TransactionOption(
              //         label: LanguageProvider.translate('visitors', 'check_in'),
              //         selected:
              //         selectedTransaction == ScanTransactionType.checkIn,
              //         onTap: () =>
              //             onTransactionChanged(ScanTransactionType.checkIn),
              //       ),
              //     ),
              //     SizedBox(width: 3.w),
              //     Expanded(
              //       child: _TransactionOption(
              //         label: LanguageProvider.translate(
              //           'visitors',
              //           'check_out',
              //         ),
              //         selected:
              //             selectedTransaction == ScanTransactionType.checkOut,
              //         onTap: () =>
              //             onTransactionChanged(ScanTransactionType.checkOut),
              //       ),
              //     ),
              //   ],
              // ),
              // if (errorMessage != null) ...[
              //   SizedBox(height: 1.h),
              //   Text(
              //     errorMessage!,
              //     textAlign: TextAlign.center,
              //     style: TextStyleClass.normalStyle(
              //       color: const Color(0xffE23D3D),
              //     ),
              //   ),
              // ],
              // SizedBox(height: 1.5.h),
              if (invitation.transactionType != 'out')
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : scanProvider.confirmTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.defaultColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColor.defaultColor.withValues(
                        alpha: 0.65,
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 5.w,
                            height: 5.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            invitation.transactionType == 'in'
                                ? LanguageProvider.translate(
                                    'scan',
                                    'confirm_check_out',
                                  )
                                : LanguageProvider.translate(
                                    'scan',
                                    'confirm_check_in',
                                  ),
                            style: TextStyleClass.normalStyle(
                              color: Colors.white,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisitorAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const _VisitorAvatar({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return CircleAvatar(
      radius: 7.w,
      backgroundColor: const Color(0xffEAF3F9),
      backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      child: hasImage
          ? null
          : Text(
              name.isEmpty ? 'V' : name.substring(0, 1).toUpperCase(),
              style: TextStyleClass.normalStyle(
                color: AppColor.defaultColor,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
    );
  }
}

class _VisitorInfo extends StatelessWidget {
  final String label;
  final String value;

  const _VisitorInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
        color: const Color(0xffF6F8FA),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
          ),
          SizedBox(height: 0.6.h),
          Text(
            value.isEmpty ? '-' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleClass.normalStyle(
              color: const Color(0xff3C454D),
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
