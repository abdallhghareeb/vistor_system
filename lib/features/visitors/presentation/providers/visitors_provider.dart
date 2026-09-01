import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:visitor/core/constants/constants.dart';

import '../../../../core/dialog/guest_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/models/pagination_class.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/visitor_entity.dart';
import '../../domain/usecases/visitors_usecases.dart';
import '../widgets/invitation_details_widget.dart';

enum VisitorStatus { checkedIn, checkedOut }

enum VisitorDatePreset { today, thisWeek, thisMonth }

class VisitorsProvider extends ChangeNotifier implements PaginationClass {
  VisitorsUseCases visitorsUseCases;

  VisitorsProvider(this.visitorsUseCases);

  final TextEditingController searchController = TextEditingController();

  List<VisitorTransactionEntity>? quickOverview;

  void setGuestQuickOverview() {
    final now = DateTime.now();
    quickOverview = [
      _guestTransaction(
        'Ahmed Hassan',
        'in',
        now.subtract(const Duration(minutes: 8)),
        'Reception A',
      ),
      _guestTransaction(
        'Sara Mohamed',
        'out',
        now.subtract(const Duration(minutes: 24)),
        'Main Lobby',
      ),
      _guestTransaction(
        'Omar Ali',
        'in',
        now.subtract(const Duration(minutes: 41)),
        'Meeting Room B',
      ),
      _guestTransaction(
        'Mariam Adel',
        'out',
        now.subtract(const Duration(hours: 1, minutes: 12)),
        'Reception B',
      ),
      _guestTransaction(
        'Youssef Ibrahim',
        'in',
        now.subtract(const Duration(hours: 2)),
        'Main Lobby',
      ),
    ];
    notifyListeners();
  }

  VisitorTransactionEntity _guestTransaction(
    String name,
    String transactionType,
    DateTime createdAt,
    String area,
  ) {
    return VisitorTransactionEntity(
      fullName: name,
      documentId: 'GUEST-DEMO',
      cardNumber: 'AV-${createdAt.minute.toString().padLeft(3, '0')}',
      visitorImage: null,
      documentImage: null,
      registrationDate: createdAt.subtract(const Duration(days: 1)),
      expiryDate: createdAt.add(const Duration(days: 1)),
      transactionType: transactionType,
      transactionCreatedUserId: 'guest-demo',
      createdUserName: 'Demo Operator',
      status: 1,
      areaName: area,
      createDate: createdAt,
      isSuccess: true,
      phoneNumber: null,
      companyName: 'AVMS Demo',
      unitName: area,
      statusValue: transactionType == 'in' ? 'Checked In' : 'Checked Out',
    );
  }

  Future<void> getQuickOverview() async {
    if (AuthProvider.isGuestMode()) {
      setGuestQuickOverview();
      return;
    }
    Map<String, dynamic> data = {};
    data['PageNumber'] = 1;
    data['PageSize'] = 5;

    Either<DioException, List<VisitorTransactionEntity>> result =
        await visitorsUseCases.getAllTransactions(data);
    result.fold(
      (l) {
        showToast(
          l.response?.data['error'] ??
              l.message ??
              LanguageProvider.translate('error', 'error'),
        );
      },
      (r) {
        quickOverview = [];
        quickOverview?.addAll(r);
        notifyListeners();
      },
    );
  }

  Future<void> refreshQuickOverview() async {
    quickOverview = null;
    notifyListeners();
    await getQuickOverview();
  }

  List<VisitorTransactionEntity>? visitors;
  Future<void> getVisitors() async {
    Map<String, dynamic> data = {};
    data['PageNumber'] = pageIndex;
    data['PageSize'] = 10;

    if (searchController.text.trim().isNotEmpty) {
      data['Search'] = searchController.text.trim();
    }

    if (filtersApplied) {
      _addDateFilter(data);
      if (appliedStatuses.length == 1) {
        data['TransactionType'] =
            appliedStatuses.first == VisitorStatus.checkedIn ? 'in' : 'out';
      }
    }
    Either<DioException, List<VisitorTransactionEntity>> result =
        await visitorsUseCases.getAllTransactions(data);
    result.fold(
      (l) {
        paginationStarted = false;
        showToast(
          l.message ?? LanguageProvider.translate('error', 'load_data_failed'),
        );
        notifyListeners();
      },
      (r) {
        pageIndex++;
        visitors ??= [];
        visitors?.addAll(r);
        if (r.isEmpty) {
          paginationFinished = true;
        }
        paginationStarted = false;
        notifyListeners();
      },
    );
  }

  void refresh() {
    clear();
    getVisitors();
  }

  void clear() {
    visitors = null;
    paginationStarted = false;
    paginationFinished = false;
    pageIndex = 1;
    notifyListeners();
  }

  @override
  int pageIndex = 1;

  @override
  bool paginationFinished = false;

  @override
  bool paginationStarted = false;

  final ScrollController controller = ScrollController();
  bool _paginationInitialized = false;

  @override
  void pagination() {
    if (_paginationInitialized) return;
    _paginationInitialized = true;
    controller.addListener(() async {
      if (controller.position.atEdge && controller.position.pixels > 50) {
        if (!paginationFinished &&
            !paginationStarted &&
            visitors != null &&
            visitors!.isNotEmpty) {
          paginationStarted = true;
          notifyListeners();
          await getVisitors();
        }
      }
    });
  }

  DateTime? dateFrom;
  DateTime? dateTo;
  VisitorDatePreset? selectedDatePreset;
  final Set<VisitorStatus> selectedStatuses = {VisitorStatus.checkedIn};
  Set<VisitorStatus> appliedStatuses = {};
  bool filtersApplied = false;

  bool get hasSelectedDateFilter =>
      dateFrom != null || dateTo != null || selectedDatePreset != null;

  int get selectedFilterCount =>
      (hasSelectedDateFilter ? 1 : 0) + selectedStatuses.length;

  void searchVisitors(String _) {
    refresh();
  }

  void selectDatePreset(VisitorDatePreset preset) {
    if (selectedDatePreset == preset) {
      clearDateFilter();
      return;
    }
    dateFrom = null;
    dateTo = null;
    selectedDatePreset = preset;
    notifyListeners();
  }

  void toggleStatus(VisitorStatus status) {
    if (selectedStatuses.contains(status)) {
      selectedStatuses.remove(status);
    } else {
      selectedStatuses.add(status);
    }
    notifyListeners();
  }

  void selectDateFrom(DateTime date) {
    dateFrom = date;
    if (dateTo != null && dateTo!.isBefore(date)) {
      dateTo = null;
    }
    selectedDatePreset = null;
    notifyListeners();
  }

  void selectDateTo(DateTime date) {
    dateTo = date;
    selectedDatePreset = null;
    notifyListeners();
  }

  void clearDateFilter() {
    dateFrom = null;
    dateTo = null;
    selectedDatePreset = null;
    notifyListeners();
  }

  void resetFilters() {
    dateFrom = null;
    dateTo = null;
    selectedDatePreset = null;
    selectedStatuses.clear();
    appliedStatuses = {};
    filtersApplied = false;
    notifyListeners();
  }

  void applyFilters() {
    appliedStatuses = Set<VisitorStatus>.from(selectedStatuses);
    filtersApplied = true;
    refresh();
  }

  void _addDateFilter(Map<String, dynamic> data) {
    DateTime? startDate;
    DateTime? endDate;

    switch (selectedDatePreset) {
      case VisitorDatePreset.today:
        startDate = DateTime.now();
        endDate = DateTime.now();
      case VisitorDatePreset.thisWeek:
        startDate = DateTime.now().subtract(
          Duration(days: DateTime.now().weekday - 1),
        );
        endDate = startDate.add(const Duration(days: 6));
      case VisitorDatePreset.thisMonth:
        startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
        endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
      case null:
        startDate = dateFrom;
        endDate = dateTo;
    }

    if (startDate != null) {
      data['CreateDateFrom'] = '${convertDateToStringYMD(startDate)}T00:00:00';
    }
    if (endDate != null) {
      data['CreateDateTo'] = '${convertDateToStringYMD(endDate)}T23:59:59';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  void showVisitWidget(VisitorTransactionEntity transaction) {
    if (AuthProvider.isGuestMode()) {
      showGuestDialog();
      return;
    }
    showModalBottomSheet(
      context: Constants.globalContext(),
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return InvitationDetailsWidget(transaction: transaction);
      },
    );
  }
}
