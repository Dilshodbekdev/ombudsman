import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_elevated_button.dart';
import 'package:ombudsman/src/config/components/text_field_components.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/reference/data/body/create_appeal_body.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/presentation/manager/appeal_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toastification/toastification.dart';

class CreateAppealPage extends StatefulWidget {
  const CreateAppealPage({super.key});

  @override
  State<CreateAppealPage> createState() => _CreateAppealPageState();
}

class _CreateAppealPageState extends State<CreateAppealPage> {
  late final bloc = context.read<AppealBloc>();

  final form = FormGroup({
    'citizenship': FormControl<int>(validators: [Validators.required]),
    'region': FormControl<int>(validators: [Validators.required]),
    'district': FormControl<int>(validators: [Validators.required]),
    'marital': FormControl<int>(validators: [Validators.required]),
    'appeal_type': FormControl<int>(validators: [Validators.required]),
    'appeal_direction': FormControl<int>(validators: [Validators.required]),
    'address': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [Validators.required]),
    'gender': FormControl<String>(validators: [Validators.required]),
    'juridical_name': FormControl<String>(),
    'text': FormControl<String>(validators: [Validators.required]),
    'is_juridical': FormControl<bool>(value: false),
  });

  FormControl<int> get citizenship => form.control('citizenship') as FormControl<int>;
  FormControl<int> get region => form.control('region') as FormControl<int>;
  FormControl<int> get district => form.control('district') as FormControl<int>;
  FormControl<int> get marital => form.control('marital') as FormControl<int>;
  FormControl<int> get appealType => form.control('appeal_type') as FormControl<int>;
  FormControl<int> get appealDirection => form.control('appeal_direction') as FormControl<int>;
  FormControl<String> get address => form.control('address') as FormControl<String>;
  FormControl<String> get email => form.control('email') as FormControl<String>;
  FormControl<String> get phone => form.control('phone') as FormControl<String>;
  FormControl<String> get gender => form.control('gender') as FormControl<String>;
  FormControl<String> get juridicalName => form.control('juridical_name') as FormControl<String>;
  FormControl<String> get text => form.control('text') as FormControl<String>;
  FormControl<bool> get isJuridical => form.control('is_juridical') as FormControl<bool>;

  File? file;
  int fileFormat=-1;
  List<RegionModel>? _districts = [];
  List<AppealTypeModel>? _appealTypes = [];

  @override
  void initState() {
    super.initState();
    bloc.regionList();
    bloc.appealTypes();
    bloc.maritalStatuses();
    bloc.citizenship();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).create_appeal,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AppealBloc, AppealState>(
        listener: (context, state) {
          if (state.isSendVerified) {
            if(state.createAppealModel?.message==null){
              toastification.show(
                  title: Text(
                    S.of(context).create_appeal,
                    style: const TextStyle(fontSize: 16),
                  ),
                  description: Text(
                    S.of(context).appeal_sended,
                    style: const TextStyle(fontSize: 14),
                  ),
                  type: ToastificationType.info,
                  alignment: Alignment.bottomCenter,
                  showProgressBar: false,
                  icon: const Icon(Icons.check_circle_outline),
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: 3.seconds,
                  primaryColor: AppColors.mainColor);
              context.pop();
            }else{
              toastification.show(
                  title: Text(
                    state.createAppealModel?.message??'--',
                    style: const TextStyle(fontSize: 16),
                  ),
                  description: Text(
                    S.of(context).appeal_sended,
                    style: const TextStyle(fontSize: 14),
                  ),
                  type: ToastificationType.info,
                  alignment: Alignment.bottomCenter,
                  showProgressBar: false,
                  icon: const Icon(Icons.check_circle_outline),
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: 3.seconds,
                  primaryColor: AppColors.mainColor);
            }
          }
        },
        builder: (context, state) {
          return ReactiveForm(
            formGroup: form,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png'),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                  S.of(context).required,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.red),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                  S.of(context).required1,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.red),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(S.of(context).citizenship,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(height: 6,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('citizenship') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:state.citizenship?.map((e){
                                return  DropdownMenuItem(
                                  value: e.value,
                                  child: Text(getLang(LanguageModel.fromJson(jsonDecode(e.label??'')),appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).citizenship_select,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {},
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).enter_address,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(height: 6,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('region') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:state.regions?.map((e){
                                return  DropdownMenuItem(
                                  value: e.id,
                                  child: Text(getRegionName(e, appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).regions,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {
                                setState(() {
                                  _districts=state.regionList?.where((test)=>test.parentId==val.value).toList();
                                });
                              },
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('district') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:_districts?.map((e){
                                return  DropdownMenuItem(
                                  value: e.id,
                                  child: Text(getRegionName(e, appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).district,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {},
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            ReactiveTextField(
                              formControl: form.control('address') as FormControl<String>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                errorText: null,
                                hintText: S.of(context).address,
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              cursorColor: Theme.of(context).colorScheme.tertiary,
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).add_info,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(height: 4,),
                            ReactiveTextField(
                              formControl: form.control('email') as FormControl<String>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                errorText: null,
                                hintText: 'E-mail',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              cursorColor: Theme.of(context).colorScheme.tertiary,
                              keyboardType:  TextInputType.emailAddress,
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            ReactiveTextField(
                              formControl: form.control('phone') as FormControl<String>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                errorText: null,
                                prefixText: "+998 ",
                                prefixStyle: const TextStyle(fontSize: 16),
                                hintText: S.of(context).phone,
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 9,
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('marital') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:state.maritalStatuses?.map((e){
                                return  DropdownMenuItem(
                                  value: e.value,
                                  child: Text(getLang(LanguageModel.fromJson(jsonDecode(e.label??'')),appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).marital_status,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {

                              },
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).juridic,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            ReactiveCheckboxListTile(
                              contentPadding: const EdgeInsets.all(0),
                              formControl: form.control('is_juridical') as FormControl<bool>,
                              title: Text(S.of(context).juridical_text,style: const TextStyle(fontSize: 12),),
                            ),
                            ReactiveValueListenableBuilder<bool>(
                              formControl: form.control('is_juridical') as FormControl<bool>,
                              builder: (context, value, child) {
                                return Visibility(
                                  visible: value.value==true,
                                    child: ReactiveTextField(
                                      formControl: form.control('juridical_name') as FormControl<String>,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle: const TextStyle(height: 0),
                                        errorText: null,
                                        hintText: S.of(context).juridical_name,
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        border: appTextFiledBorder(),
                                        enabledBorder: appTextFiledBorder(),
                                        disabledBorder: appTextFiledBorder(),
                                        focusedBorder: appTextFiledBorder(),
                                        errorBorder: appTextFiledErrorBorder(),
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.tertiary,
                                      validationMessages: {
                                        'required': (error) => '',
                                      },
                                    ),
                                );
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).gender,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            ReactiveValueListenableBuilder<String>(
                              formControl: form.control('gender') as FormControl<String>,
                              builder: (context, value, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: CheckboxListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        value: value.value=='m', onChanged: (val){
                                          gender.value='m';
                                      },title: Text(S.of(context).male),
                                      ),
                                    ),
                                    const SizedBox(width: 32,),
                                    Expanded(
                                      child: CheckboxListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        value: value.value=='f', onChanged: (val){
                                        gender.value='f';
                                      },title: Text(S.of(context).famale),),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).appeal_type,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(height: 6,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('appeal_direction') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:state.appealTypes?.map((e){
                                return  DropdownMenuItem(
                                  value: e.id,
                                  child: Text(getLang(LanguageModel.fromJson(jsonDecode(e.label??'')), appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).appeal_type,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {
                                setState(() {
                                  _appealTypes=state.appealTypeList?.where((test)=>test.parentId==val.value).toList();
                                });
                              },
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            ReactiveDropdownField<int>(
                              isExpanded: true,
                              formControl: form.control('appeal_type') as FormControl<int>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              borderRadius: BorderRadius.circular(6),
                              items:_appealTypes?.map((e){
                                return  DropdownMenuItem(
                                  value: e.id,
                                  child: Text(getLang(LanguageModel.fromJson(jsonDecode(e.label??'')), appState.lang)),
                                );
                              }).toList()??[],
                              hint: Text(S.of(context).appeal_type,style: const TextStyle(color: Colors.grey),),
                              onChanged: (val) {},
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).appeal,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(height: 6,),
                            ReactiveTextField(
                              formControl: form.control('text') as FormControl<String>,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0),
                                errorText: null,
                                hintText: S.of(context).appeal_text,
                                border: appTextFiledBorder(),
                                enabledBorder: appTextFiledBorder(),
                                disabledBorder: appTextFiledBorder(),
                                focusedBorder: appTextFiledBorder(),
                                errorBorder: appTextFiledErrorBorder(),
                              ),
                              cursorColor: Theme.of(context).colorScheme.tertiary,
                              keyboardType: TextInputType.text,
                              minLines: 5,
                              maxLines: null,
                              maxLength: 1000,
                              validationMessages: {
                                'required': (error) => '',
                              },
                            ),
                            const SizedBox(height: 10,),
                            Text(S.of(context).attachment,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),),
                            const SizedBox(height: 6,),
                            Row(
                              children: [
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: IconButton(
                                      onPressed: () async {
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf'],
                                        );
                                        if (result != null && result.files.single.path != null) {
                                          int bytes=await File(result.files.single.path!).length();
                                          if(bytes<=5242880){
                                            setState(() {
                                              file=File(result.files.single.path!);
                                            });
                                            fileFormat=1;
                                            String bytes = await getFileSize(File(result.files.single.path!).path, 1);
                                            debugPrint(bytes);
                                          }else{
                                            snackBar(S.of(context).file_required);
                                          }
                                        } else {
                                          /// User canceled the picker
                                        }
                                      },
                                      icon: SvgPicture.asset('assets/icons/ic_folder.svg',color: Colors.white,),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.buttonColorDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: IconButton(
                                      onPressed: () async {
                                        try {
                                          final image = await ImagePicker().pickImage(source: ImageSource.camera);
                                          if (image != null) {
                                            int bytes=await image.length();
                                            if(bytes<=5242880){
                                              setState(() {
                                                file=File(image.path);
                                              });
                                              fileFormat=2;
                                              String bytes = await getFileSize(image.path, 1);
                                              debugPrint(bytes);
                                            }else{
                                              snackBar(S.of(context).file_required);
                                            }
                                          }
                                        } on PlatformException catch (e) {
                                          debugPrint('Failed to pick image: $e');
                                        }
                                      },
                                      icon: SvgPicture.asset('assets/icons/ic_camera.svg',color: Colors.white,),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.buttonColorDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                                const SizedBox(width: 16,),
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: IconButton(
                                      onPressed: () async {
                                        try {
                                          final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if (image != null) {
                                            int bytes=await image.length();
                                            if(bytes<=5242880){
                                              setState(() {
                                                file=File(image.path);
                                              });
                                              fileFormat=2;
                                              String bytes = await getFileSize(image.path, 1);
                                              debugPrint(bytes);
                                            }else{
                                              snackBar(S.of(context).file_required);
                                            }
                                          }
                                        } on PlatformException catch (e) {
                                          debugPrint('Failed to pick image: $e');
                                        }
                                      },
                                      icon: SvgPicture.asset('assets/icons/ic_gallery.svg',color: Colors.white,),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.buttonColorDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],),
                            const SizedBox(height: 8,),
                            Align(
                              alignment: Alignment.center,
                                child: Text(S.of(context).file_required,style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    file!=null?
                    GestureDetector(
                      onTap: () {
                        OpenFile.open(file?.path);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(21),
                                  color: AppColors.mainColor,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_folder.svg',
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      file?.path.split('/').last??'--',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      file=null;
                                    });
                                  },
                                  icon: const Icon(Icons.delete,color: Colors.red,))
                            ],
                          ),
                        ),
                      ),
                    ):const SizedBox(),
                    const SizedBox(height: 12,),
                    state.isLoading?const CircularProgressIndicator(color: AppColors.mainColor,):
                    ReactiveFormConsumer(builder: (context,form,child){
                      return AppElevatedButton(
                          text: S.of(context).sending,
                          onClick: () {
                            if(form.valid){
                              debugPrint(jsonEncode(form.value));
                              bloc.createAppeal(CreateAppealBody(
                                email: email.value,
                                phone: "+998${phone.value}",
                                text: text.value,
                                gender: gender.value,
                                juridical_name: juridicalName.value,
                                is_juridical: isJuridical.value==true?'1':'0',
                                citizenship: citizenship.value,
                                marital_status: marital.value,
                                region_id: region.value,
                                district_id: district.value,
                                status: 1,
                                address: address.value,
                                appeal_type: appealType.value.toString(),
                                file: file
                              ));
                            }else{
                              form.markAllAsTouched();
                            }
                          });
                    }),
                    const SizedBox(height: 12,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  },
);
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
