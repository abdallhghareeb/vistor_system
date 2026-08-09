import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/visitors_provider.dart';
import '../widgets/visitors_filter_sheet.dart';
import '../widgets/visitors_list_widget.dart';
import '../widgets/visitors_search_widget.dart';

class VisitorsPage extends StatelessWidget {
  const VisitorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VisitorsProvider>();
    provider.pagination();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(LanguageProvider.translate('home', 'visitors'),),),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 2.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: VisitorsSearchWidget(
                controller: provider.searchController,
                onChanged: provider.searchVisitors,
                onFilterTap: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const VisitorsFilterSheet(),
                ),
              ),
            ),
            SizedBox(height: 1.5.h),
            const Expanded(child: VisitorsListWidget()),
          ],
        ),
      ),
    );
  }
}
