import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/text_style.dart';
import '../constants/constants.dart';
import '../dialog/drop_down_dialog.dart';
import '../models/drop_down_class.dart';


class DropDownWidget extends StatefulWidget {
  final DropDownClass dropDownClass;
  final double? width,borderRadius;
  final Color? borderColor;
  final double? padding;
  final void Function()? onTap;
  const DropDownWidget({required this.dropDownClass,this.width,Key? key, this.onTap, this.borderRadius, this.borderColor, this.padding}) : super(key: key);
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState(dropDownClass);
}

class _DropDownWidgetState extends State<DropDownWidget> {
  DropDownClass dropDownClass;
  _DropDownWidgetState(this.dropDownClass);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
            if(widget.onTap==null){
              showDropDownDialog(dropDownClass).then((value) => setState((){}));
            }else{
              widget.onTap!();
            }
          },
          child: Container(
            width: widget.width??100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius??10),
              color: Colors.white,
              border:  Border.all(color:widget.borderColor ?? Colors.grey),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: widget.padding ?? 0.7.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dropDownClass.displayedWidget()??const SizedBox(),
                  if(dropDownClass.displayedWidget()!=null)SizedBox(width: 3.w,),
                  Expanded(
                    child: Text(dropDownClass.displayedName(),maxLines: 1,
                      style: TextStyleClass.smallStyle(color: Colors.grey),),
                  ),
                  const Spacer(),
                  Icon(Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey,size: Constants.isTablet?60:30,),
                ],
              ),
            ),
          ),
        ),
        if(dropDownClass.selected() is DropDownClass && dropDownClass.selected().list().isNotEmpty)
          ...[
            SizedBox(height: 0.5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(dropDownClass.selected().titleName()??"",style: TextStyleClass.smallStyle(),),
                SizedBox(width: 2.w,),
                if(dropDownClass.selected().require())
                  Icon(Icons.star,size: 2.w,color: Colors.red,),
              ],
            ),
            SizedBox(height: 0.5.h,),
            DropDownWidget(dropDownClass: dropDownClass.selected()),
          ],
      ],
    );
  }
}
