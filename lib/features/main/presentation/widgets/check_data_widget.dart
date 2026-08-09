import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import 'check_data_item_widget.dart';

class CheckDataWidget extends StatelessWidget {
  const CheckDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final completeDataProvider = context.watch<CompleteDataProvider>();

    return SizedBox(
      height: 9.h,
      child: Builder(
        builder: (context) {
          if (completeDataProvider.checkData == null) {
            return const Center(child: LoadingWidget());
          } else if (completeDataProvider.checkData!.isEmpty) {
            return Center(
              child: FittedBox(
                child: EmptyAnimation(
                  title: '',
                  gif: LottiePaths.noSearch,
                  width: 20.w,
                  height: 5.h,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w),
            scrollDirection: Axis.horizontal,
            itemCount: completeDataProvider.checkData!.length,
            separatorBuilder: (context, index) => SizedBox(width: 2.w),
            itemBuilder: (context, index) {
              return CheckDataItemWidget(
                item: completeDataProvider.checkData![index],
              );
            },
          );
        },
      ),
    );
  }
}
