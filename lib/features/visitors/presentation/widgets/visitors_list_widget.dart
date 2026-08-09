import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_animation_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../providers/visitors_provider.dart';
import 'visitor_card_widget.dart';

class VisitorsListWidget extends StatelessWidget {
  const VisitorsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visitorsProvider = context.watch<VisitorsProvider>();

    return RefreshIndicator(
      onRefresh: () async {
        visitorsProvider.refresh();
      },
      child: SingleChildScrollView(
        controller: visitorsProvider.controller,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Builder(
          builder: (context) {
            if (visitorsProvider.visitors == null) {
              return Center(
                child: LoadingAnimationWidget(
                  gif: LottiePaths.loading,
                  width: 20.w,
                  height: 5.h,
                ),
              );
            } else if (visitorsProvider.visitors!.isEmpty) {
              return Center(
                child: EmptyAnimation(title: '', gif: LottiePaths.noSearch),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    runSpacing: 1.h,
                    children: List.generate(
                      visitorsProvider.visitors!.length,
                      (index) => SizedBox(
                        width: double.infinity,
                        child: VisitorCardWidget(
                          visitor: visitorsProvider.visitors![index],
                        ),
                      ),
                    ),
                  ),
                  if (visitorsProvider.paginationStarted) const LoadingWidget(),
                  SizedBox(height:5.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
