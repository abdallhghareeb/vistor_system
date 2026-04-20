import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/drop_down_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/excuse_entity.dart';
import '../../domain/usecases/excuse_usecases.dart';
import '../widgets/add_excuse_dialog_widget.dart';
import '../widgets/apply_excuse_widget.dart';
import 'excuse_types_provider.dart';

class AddExcuseProvider extends ChangeNotifier {
  List<TextFieldModel> addExcuseFields=[];
  final ExcuseUsecases excuseUsecases;
  AddExcuseProvider(this.excuseUsecases);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void showApplyExcuseDialog(){
    showModalBottomSheet(
        context: Constants.globalContext(),
        backgroundColor: AppColor.backgroundColor,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36),),),
        builder: (context) {
          return ApplyExcuseWidget();
        }
    );
  }


  void showAddExcuseDialog(){
    addExcuseFields=[
      TextFieldModel(controller: TextEditingController(),
          readOnlyOnly: true,onTap: (){
        ExcuseTypesProvider excuseTypesProvider = Provider.of<ExcuseTypesProvider>(Constants.globalContext(),listen: false);
        showDropDownDialog(excuseTypesProvider).then((value){});
        },suffix: Icon(Icons.keyboard_arrow_down_sharp,color: AppColor.defaultColor,size: 4.w,)
          ,key: "ExcuseType",label: "exception_type"),
      TextFieldModel(controller: TextEditingController(),key: "Date",label: "date",
        onTap: (){
        showDatePicker(context: Constants.globalContext(), firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 30)),).
        then((value) {
          if(value!=null){
            addExcuseFields.firstWhere((element) => element.key=="Date",).controller.text = convertDateToStringYMD(value);
          }
        },);
        },
        readOnlyOnly: true,),
      TextFieldModel(controller: TextEditingController(),key: "Reason",label: "reason_for_excuse",max: 4),
    ];
    showModalBottomSheet(
        context: Constants.globalContext(),
        backgroundColor: Colors.white,
        constraints: BoxConstraints(maxHeight: 100.h,minHeight: 100.h),
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12),),),
        builder: (context) {
          return AddExcuseDialogWidget();
        }
    );
  }


  List<dynamic> files = [];

  void addFiles(List file){
    files.addAll(file);
    notifyListeners();
  }

  void removeFiles(int index){
    files.removeAt(index);
    notifyListeners();
  }

  String getFileName(int index){
      return files[index].path.split('/').last;
  }

  Future createExcuse() async{
    Map<String, dynamic> data = {};
    List<dynamic> attachments= [];
    for(int i=0;i<files.length;i++){
      attachments.add(await MultipartFile.fromFile(files[i].path));
    }
    for (var element in addExcuseFields) {
      data[element.key??""] = element.controller.text;
    }
    data["attachments"] = attachments;
    AuthProvider authProvider = Provider.of<AuthProvider>(Constants.globalContext(),listen: false);
    data["employeeId"] = authProvider.userEntity?.user?.employeeId??"";
    loading();
    Either<DioException, ExcuseEntity> login = await excuseUsecases.createExcuse(data);
    navPop();
    login.fold((l)  {
      showToast(l.response?.data['error']??l.message ??"Something went wrong");
    }, (r) async {
      successDialog(then: (){
        navPop();
      });
    });

  }


}
