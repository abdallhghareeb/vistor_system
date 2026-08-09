import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_animation_widget.dart';
import '../providers/visitors_provider.dart';
import 'quick_overview_card_widget.dart';

class QuickOverviewWidget extends StatelessWidget {
  const QuickOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visitorsProvider = context.watch<VisitorsProvider>();

    return Builder(
      builder: (context) {
        if (visitorsProvider.quickOverview == null) {
          return Center(
            child: LoadingAnimationWidget(
              gif: LottiePaths.loading,
              width: 20.w,
              height: 5.h,
              topPadding: 1.h,
            ),
          );
        } else if (visitorsProvider.quickOverview!.isEmpty) {
          return Center(
            child: EmptyAnimation(
              title: '',
              gif: LottiePaths.noSearch,
              width: 35.w,
              height: 12.h,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
          child: Wrap(
            runSpacing: 1.h,
            children: List.generate(
              visitorsProvider.quickOverview!.length,
              (index) => SizedBox(
                width: double.infinity,
                child: QuickOverviewCardWidget(
                  transaction: visitorsProvider.quickOverview![index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
