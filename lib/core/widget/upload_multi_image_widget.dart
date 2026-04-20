import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../helper_function/image.dart';

class UploadMultiImageWidget extends StatelessWidget {
  const UploadMultiImageWidget({super.key, required this.images,
    required this.count, required this.deleteImage, required this.imagesList});
  final List images;
  final int count;
  final void Function(int i) deleteImage;
  final void Function(List<XFile> images) imagesList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
    border: Border.all(color:Colors.grey.shade300),
    //     boxShadow: [
    //    BoxShadow(
    //   color: const Color(0xff323131).withOpacity(0.05),
    //   spreadRadius: 3,
    //   blurRadius: 7,
    //   offset: const Offset(1, 2), // changes position of shadow
    // )
    //     ],
    //     color:  const Color(0xffFBF8F8).withOpacity(0.8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
      child: InkWell(
        onTap: ()async{
          List<XFile>? pickedImages = await chooseImageMulti(context);
          if(pickedImages!=null){
            imagesList(pickedImages);
          }
        },
        child: Column(
          children: [
            SizedBox(height: 1.h,),
            if(images.isNotEmpty)
              SizedBox(
              width: 94.w,
              height: 10.h,
              child: Row(
                children: [
                  Container(
                    width: 18.w,
                    height: 18.w,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: Colors.black,
                        border: Border.all(color: Colors.red,width: 2)
                    ),
                    child: Icon(Icons.add,size: 8.w,color: Colors.white,),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx,i){
                        return InkWell(
                          onTap: (){
                            deleteImage(i);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: (images[i] is XFile)?DecorationImage(
                                  image: FileImage(File(images[i].path)),
                                  fit: BoxFit.cover,
                                ):DecorationImage(
                                  image: CachedNetworkImageProvider(images[i].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if(images.isEmpty)
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  color: Colors.black,
                  border: Border.all(color: Colors.red,width: 2)
                ),
                child: Text(LanguageProvider.translate("buttons", "add_image"),style: TextStyleClass.smallStyle(color: Colors.white),),
              ),
            if(images.isEmpty)
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LanguageProvider.translate('upload', 'upload_image').replaceAll('*input*', count.toString()),style: TextStyleClass.smallStyle(
                  color: Colors.black,
                ),),
                // const Spacer(),
                // Icon(Icons.arrow_forward_ios,color: Colors.grey,size: Constants.isTablet?40:20,),
              ],
            ),

            Row(
              children: [
                if(images.isNotEmpty)Text(LanguageProvider.translate('upload', 'delete_image'),style: TextStyleClass.smallStyle(
                  color: Colors.black,
                ),),
                const Spacer(),
                Text('${images.length}/$count',style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
