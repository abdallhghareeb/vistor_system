import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/scan_provider.dart';
import '../widgets/scan_confirmation_sheet.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  void initState() {
    super.initState();
    context.read<ScanProvider>().prepareScanner();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScanProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff10233A),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/scan/scan_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withAlpha((0.7 * 255).toInt()),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 4.h),
                Text(
                  LanguageProvider.translate('scan', 'scan_code'),
                  style: TextStyleClass.normalStyle(
                    color: Colors.white,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 0.8.h),
                Text(
                  LanguageProvider.translate('scan', 'scan_description'),
                  style: TextStyleClass.smallStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),

                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: MobileScanner(
                              controller: provider.scannerController,
                              onDetect: provider.onDetect,
                              errorBuilder: (context, error) => Center(
                                child: Text(
                                  LanguageProvider.translate(
                                    'scan',
                                    'camera_unavailable',
                                  ),
                                  style: TextStyleClass.labelStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   right: 3.w,
                        //   top: 2.h,
                        //   child: IconButton(
                        //     onPressed: provider.toggleFlash,
                        //     style: IconButton.styleFrom(
                        //       backgroundColor: Colors.black.withValues(
                        //         alpha: 0.35,
                        //       ),
                        //     ),
                        //     icon: Icon(
                        //       provider.isFlashEnabled
                        //           ? Icons.flash_on_rounded
                        //           : Icons.flash_off_rounded,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.75),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: 10.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.maybePop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: EdgeInsets.symmetric(vertical: 1.4.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      child: Text(
                        LanguageProvider.translate('buttons', 'cancel'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
          if (provider.stage == ScanStage.loadingInvitation)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x66000000),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          if (provider.stage == ScanStage.error)
            _ScanErrorSheet(
              message:
                  provider.errorMessage ??
                  LanguageProvider.translate('scan', 'invitation_load_failed'),
              onRetry: provider.scanAgain,
            ),
          if ((provider.stage == ScanStage.confirmation ||
                  provider.stage == ScanStage.creating) &&
              provider.invitation != null)
            const ScanConfirmationSheet(),
        ],
      ),
    );
  }
}

class _ScanErrorSheet extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ScanErrorSheet({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Color(0xffE23D3D),
                size: 38,
              ),
              SizedBox(height: 1.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyleClass.smallStyle(
                  color: const Color(0xff27313A),
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: Text(
                    LanguageProvider.translate('scan', 'scan_again'),
                    style: TextStyleClass.smallStyle(
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
