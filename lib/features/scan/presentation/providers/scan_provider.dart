import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:visitor/core/helper_function/navigation.dart';
import 'package:visitor/features/scan/domain/entities/scan_entity.dart';
import 'package:visitor/features/scan/domain/usecases/scan_usecases.dart';
import 'package:visitor/features/scan/presentation/pages/scan_page.dart';
import 'package:visitor/features/scan/presentation/pages/scan_success_page.dart';
import 'package:visitor/features/language/presentation/provider/language_provider.dart';

import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/confirm_dialog.dart';
import '../../../../core/dialog/guest_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

enum ScanStage {
  scanning,
  loadingInvitation,
  confirmation,
  creating,
  success,
  error,
}

enum ScanTransactionType {
  checkIn('in'),
  checkOut('out');

  final String apiValue;

  const ScanTransactionType(this.apiValue);
}

class ScanProvider extends ChangeNotifier {
  final ScanUseCases scanUseCases;

  ScanProvider(this.scanUseCases);

  final MobileScannerController scannerController = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoZoom: true,
  );

  ScanStage stage = ScanStage.scanning;
  ScanTransactionType selectedTransaction = ScanTransactionType.checkIn;
  ScanEntity? invitation;
  String? detectedCode;
  String? errorMessage;
  DateTime? transactionDate;
  bool isFlashEnabled = false;

  void prepareScanner() {
    stage = ScanStage.scanning;
    selectedTransaction = ScanTransactionType.checkIn;
    detectedCode = null;
    invitation = null;
    errorMessage = null;
    transactionDate = null;
  }

  Future<void> onDetect(BarcodeCapture capture) async {
    if (stage != ScanStage.scanning || capture.barcodes.isEmpty) return;
    final rawValue = capture.barcodes.first.rawValue?.trim();
    if (rawValue == null || rawValue.isEmpty) return;

    detectedCode = _extractCardNumber(rawValue);
    stage = ScanStage.loadingInvitation;
    errorMessage = null;
    notifyListeners();
    await scannerController.stop();
    await _loadInvitation();
  }

  Future<void> _loadInvitation() async {
    final cardNumber = detectedCode;
    if (cardNumber == null) return;

    try {
      Map<String, dynamic> data = {};
      data['cardNumber'] = cardNumber;
      final result = await scanUseCases.getInvitationByCardNumber(data);
      result.fold(
        (error) {
          errorMessage =
              error.message ??
              LanguageProvider.translate('scan', 'invitation_not_found');
          stage = ScanStage.error;
        },
        (value) {
          invitation = value;
          selectedTransaction = value.transactionType == 'in'
              ? ScanTransactionType.checkOut
              : ScanTransactionType.checkIn;
          stage = ScanStage.confirmation;
        },
      );
    } catch (_) {
      errorMessage = LanguageProvider.translate(
        'scan',
        'invalid_invitation_data',
      );
      stage = ScanStage.error;
    }
    notifyListeners();
  }

  Future<void> confirmTransaction() async {
    final currentInvitation = invitation;
    final cardNumber = detectedCode;
    if (currentInvitation == null || cardNumber == null) return;
    if (currentInvitation.transactionType == 'out') return;

    if (currentInvitation.transactionType == 'in') {
      confirmDialog(
        LanguageProvider.translate('scan', 'confirm_check_out_message'),
        LanguageProvider.translate('buttons', 'yes'),
        _createTransaction,
        cancel: LanguageProvider.translate('buttons', 'no'),
      );
      return;
    }

    await _createTransaction();
  }

  Future<void> _createTransaction() async {
    final currentInvitation = invitation;
    final cardNumber = detectedCode;
    if (currentInvitation == null || cardNumber == null) return;

    stage = ScanStage.creating;
    errorMessage = null;
    notifyListeners();

    Map<String, dynamic> data = {};
    data['invitationId'] = currentInvitation.id;
    data['cardNumber'] = currentInvitation.cardNumber.isNotEmpty
        ? currentInvitation.cardNumber
        : cardNumber;
    data['transactionType'] = currentInvitation.transactionType == 'in'
        ? 'out'
        : 'in';
    data['createDate'] = DateTime.now().toUtc().toIso8601String();

    final result = await scanUseCases.createTransaction(data);

    result.fold(
      (error) {
        showToast(
          error.response?.data['error'] ??
              error.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (_) {
        transactionDate = DateTime.now();
        stage = ScanStage.success;
        notifyListeners();
        navPR(const ScanSuccessPage());
      },
    );
    if (stage != ScanStage.success) {
      notifyListeners();
    }
  }

  Future<void> toggleFlash() async {
    await scannerController.toggleTorch();
    isFlashEnabled = !isFlashEnabled;
    notifyListeners();
  }

  Future<void> scanAgain() async {
    prepareScanner();
    notifyListeners();
    await scannerController.start();
  }

  String _extractCardNumber(String rawValue) {
    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is Map) {
        final value =
            decoded['cardNumber'] ?? decoded['card_number'] ?? decoded['card'];
        if (value != null && value.toString().trim().isNotEmpty) {
          return value.toString().trim();
        }
      }
    } catch (_) {
      // Plain QR values are card numbers and need no decoding.
    }
    return rawValue;
  }

  void goToScanPage({VoidCallback? onReturn}) {
    if (AuthProvider.isGuestMode()) {
      showGuestDialog();
      return;
    }
    navP(const ScanPage(), then: (_) => onReturn?.call());
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }
}
