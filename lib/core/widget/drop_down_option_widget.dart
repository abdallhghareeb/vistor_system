import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/text_style.dart';
import '../constants/constants.dart';
import '../models/drop_down_class.dart';

class DropDownOptionWidget extends StatefulWidget {
  final DropDownClass dropDownClass;
  final dynamic data;
  final dynamic selected;
  final void Function() rebuild;
  const DropDownOptionWidget({
    required this.dropDownClass,
    Key? key,
    required this.data,
    required this.rebuild,
    this.selected,
  }) : super(key: key);
  @override
  State<DropDownOptionWidget> createState() =>
      _DropDownOptionWidgetState(dropDownClass, data);
}

class _DropDownOptionWidgetState extends State<DropDownOptionWidget> {
  _DropDownOptionWidgetState(this.dropDownClass, this.data);
  DropDownClass dropDownClass;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        child: InkWell(
          onTap: () async {
            // await dropDownClass.onTap(data);
            widget.rebuild();
            setState(() {});
          },
          child: Container(
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: ListTile(
              leading: Radio(
                value: data,
                groupValue: widget.selected,
                onChanged: (val) {
                  // dropDownClass.onTap(data);
                  widget.rebuild();
                  setState(() {});
                },
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              horizontalTitleGap: 1.w,
              visualDensity: VisualDensity.comfortable,
              title: Row(
                children: [
                  dropDownClass.displayedOptionWidget(data) ?? SizedBox(),
                  if (dropDownClass.displayedOptionWidget(data) != null)
                    SizedBox(width: 1.w),
                  Expanded(
                    child: Text(
                      dropDownClass.displayedOptionName(data),
                      style: TextStyleClass.smallStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
