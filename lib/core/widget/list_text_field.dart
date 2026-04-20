import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/images.dart';
import '../models/text_field_model.dart';
import 'svg_widget.dart';
import 'text_field.dart';

class ListTextFieldWidget extends StatelessWidget {
  const ListTextFieldWidget({super.key, required this.inputs, this.style, this.color,this.labelColor,this.required,
    this.readOnlyOnly,
    this.borderColor, this.isGradient, this.borderRadius, this.hintColor, this.rebuild});
  final List<TextFieldModel> inputs;
  final TextStyle? style;
  final void Function()? rebuild;
  final bool? isGradient,required,readOnlyOnly;
  final Color? color,hintColor,borderColor,labelColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    List telInputs = ['mobileNumber','whats'];
    return Column(
      children: List.generate(
        inputs.length,
        (index) {
          TextFieldWidget textFieldWidget = TextFieldWidget(
            borderRadius: borderRadius,
            label: inputs[index].label,
            color: color,hintColor: hintColor,
            required: required,
            borderColor: borderColor,
            isLabel: inputs[index].isLabel ?? false,
            readOnlyOnly: inputs[index].readOnlyOnly?? false,
            // maxLength: telInputs.contains(inputs[index].key)?9:null,
            controller: inputs[index].controller,
            keyboardType: inputs[index].textInputType,
            next: inputs.length - 1 != index,
            hintText: inputs[index].hint,
            onTextTap: inputs[index].onTap,
            minLines: inputs[index].min,
            maxLines: inputs[index].max,
            validator: inputs[index].validator,
            labelColor: labelColor,
            obscureText: inputs[index].obscureText,
            suffix: telInputs.contains(inputs[index].key) ?SizedBox(): inputs[index].key!.contains('password') ||
                inputs[index].key!.contains('Password')? InkWell(
              onTap: (){
                if(inputs[index].onShownTap !=null){
                  inputs[index].onShownTap!();
                }
              },
              child: SvgWidget(svg: inputs[index].obscureText?
              Images.passwordShown : Images.passwordHidden,width: 4.w,),
            ): inputs[index].suffix,
            prefix: inputs[index].prefix,
            readOnly: inputs[index].readOnly,
            width: inputs[index].width,
            contentPadding: inputs[index].contentPadding,
          );
          return textFieldWidget;
        },
      ),
    );
  }
}
// Row(mainAxisSize: MainAxisSize.min,
//   children: [
//     Container(height:6.5.h,color: AppColor.smallWhite,width: 0.2.w,margin: EdgeInsets.symmetric(horizontal: 1.w),),
//     CountryCodePicker(showFlag: true,showDropDownButton: false,flagWidth: 6.w,
//       onChanged: (val){
//       },favorite: ["eg"],initialSelection: "eg",
//       margin: EdgeInsets.zero, hideMainText: true,padding: EdgeInsets.zero,),
//     Padding(
//         padding: EdgeInsets.symmetric(horizontal: 1.w),
//         child: Icon(Icons.keyboard_arrow_down_sharp,size: 4.w,color:Color(0xff2D3036),)),
//   ],
// )
