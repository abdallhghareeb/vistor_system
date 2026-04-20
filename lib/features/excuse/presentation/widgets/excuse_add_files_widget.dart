import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/add_excuse_provider.dart';
import 'package:file_picker/file_picker.dart';

class ExcuseAddFilesWidget extends StatelessWidget {
  const ExcuseAddFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AddExcuseProvider addExcuseProvider = Provider.of(context);

    return InkWell(
      onTap: ()async{
        FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result != null) {
          List<File> files = result.paths.map((path) => File(path!)).toList();
          addExcuseProvider.addFiles(files);
        }
      },
      child: SizedBox(width: 100.w,
        child: Stack(clipBehavior: Clip.none,
          children: [
            Container(width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffC3C3C3),width: 1),
                  borderRadius: BorderRadius.circular(4)
              ),
              child:addExcuseProvider.files.isEmpty? DottedBorder(
                options: RectDottedBorderOptions(
                  color: AppColor.smallWhite,
                  dashPattern: [12, 6],
                  strokeWidth: 2,
                ),
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 2.5.h),
                    child: Text(LanguageProvider.translate("home", "browse_files"),
                      style: TextStyle(color: Color(0xff6B7280)),
                    ),
                  ),
                ),
              ) :
              Wrap(children: List.generate(addExcuseProvider.files.length, (index) {
                return Container(
                    padding:  EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                    margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(width: 6.w,height: 6.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(Images.pdfUploaded))
                            ),
                          ),
                          Text(addExcuseProvider.getFileName(index),style: TextStyleClass.captionStyle(),),
                        ]),
                        InkWell(
                            onTap: (){
                              addExcuseProvider.removeFiles(index);
                            },
                            child: Icon(Icons.close,size: 6.w,))
                      ],
                    )
                );
              }),
              ),),
            PositionedDirectional(
                top: -1.h,start: 2.w,
                child: Container(color: AppColor.backgroundColor,
                  padding:  EdgeInsets.symmetric(horizontal: 1.w),
                  child: Row(
                    children: [
                      Text(LanguageProvider.translate('inputs', "attachment"),
                          style:TextStyleClass.captionStyle(color: AppColor.labelTextColor).copyWith(fontWeight: FontWeight.w500))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
