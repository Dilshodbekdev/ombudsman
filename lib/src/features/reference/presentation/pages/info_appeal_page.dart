import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_divider.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/reference/data/model/answer_files_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/presentation/manager/appeal_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

class InfoAppealPage extends StatefulWidget {
  final String arg;
  const InfoAppealPage({super.key, required this.arg});

  @override
  State<InfoAppealPage> createState() => _InfoAppealPageState();
}

class _InfoAppealPageState extends State<InfoAppealPage> {
  late final bloc = context.read<AppealBloc>();
  AppealModel? appealModel;
  List<AnswerFile>? answerFiles;
  String? type;

  @override
  void initState() {
    super.initState();
    bloc.appealTypes();
    setState(() {
      appealModel=AppealModel.fromJson(jsonDecode(widget.arg));
     if(appealModel?.answerFile!=null){
       answerFiles=(jsonDecode(appealModel?.answerFile??'') as List)
           .map((data) => AnswerFile.fromJson(data))
           .toList();
     }
    });
    debugPrint(jsonEncode(appealModel));
    debugPrint(jsonEncode(answerFiles));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).my_appeals,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AppealBloc, AppealState>(
        listener: (context,state){
          if(state.hasError){
            toastification.show(
                title: Text(S.of(context).my_appeals,style: const TextStyle(fontSize: 16),),
                description: Text(state.errorMessage,style: const TextStyle(fontSize: 14),),
                type: ToastificationType.error,
                alignment: Alignment.bottomCenter,
                showProgressBar: false,
                style: ToastificationStyle.fillColored,
                autoCloseDuration: 3.seconds,
            );
          }
          if(state.isGetNewMessageVerified){
            state.appealTypeList?.forEach((action){
              if(action.id==int.parse(appealModel?.appealType??'')){
                setState(() {
                  type=getLang(LanguageModel.fromJson(jsonDecode(action.label??'')), appState.lang);
                });
              }
            });
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png'),
                  fit: BoxFit.cover),
            ),
            child:state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Card(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: DefaultTabController(
                length: appealModel?.answerFile!=null?3:2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TabBar(
                        indicatorColor: AppColors.mainColor,
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: AppColors.mainColor,
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        tabs: appealModel?.answerFile!=null? [
                          Tab(text: S.of(context).appeal),
                          Tab(text: S.of(context).info),
                          Tab(text: S.of(context).answer),
                        ]:[
                          Tab(text: S.of(context).appeal),
                          Tab(text: S.of(context).info),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: appealModel?.answerFile==null?
                        [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).appeal_type,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    type??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12,),
                                  Text(
                                    S.of(context).attachment_files,
                                    style: const TextStyle(
                                        color:
                                        AppColors.secondaryTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 4),
                                  appealModel?.file!=null?
                                  GestureDetector(
                                    onTap: () {
                                      snackBar(S.of(context).file_loading);
                                      openFile1(fileName: appealModel?.file?.split('/').last??'');
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
                                            const SizedBox(height: 8,),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    appealModel?.file?.split('/').last??'--',
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ):const SizedBox(),
                                  const SizedBox(height: 14,),
                                  const AppDivider(),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).appeal_text,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.text??'--',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 12,),
                                ],
                              ),
                            ),
                          ),
                          // info
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).status_appeal,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: textColor(appealModel?.status??0).withOpacity(0.1),
                                    ),
                                    child: Text(
                                      getStatusText(appealModel?.status??0, appState.lang),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textColor(appealModel?.status??0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16,),
                                  Text(
                                    S.of(context).appeal_type,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    type??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).create_appeal_date,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.createdAt??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).process_appeal_date,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.updatedAt??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).appeal_code,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.requestCode??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // response
                        ]:[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).appeal_type,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    type??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12,),
                                  Text(
                                    S.of(context).attachment_files,
                                    style: const TextStyle(
                                        color:
                                        AppColors.secondaryTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 4,),
                                  appealModel?.file!=null?
                                  GestureDetector(
                                    onTap: () {
                                      snackBar(S.of(context).file_loading);
                                      openFile1(fileName: appealModel?.file?.split('/').last??'');
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
                                            const SizedBox(height: 8,),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    appealModel?.file?.split('/').last??'--',
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ):const SizedBox(),
                                  const SizedBox(height: 12,),
                                  const AppDivider(),
                                  const SizedBox(height: 12,),
                                  Text(
                                    S.of(context).appeal_text,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2,),
                                  Text(
                                    appealModel?.text??'--',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 14,),
                                ],
                              ),
                            ),
                          ),
                          // info
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).status_appeal,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: textColor(appealModel?.status??0).withOpacity(0.1),
                                    ),
                                    child: Text(
                                      getStatusText(appealModel?.status??0, appState.lang),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textColor(appealModel?.status??0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16,),
                                  Text(
                                    S.of(context).appeal_type,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    type??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).create_appeal_date,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.createdAt??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).process_appeal_date,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.updatedAt??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).appeal_code,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    appealModel?.requestCode??'--',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12,),
                                  Text(
                                    S.of(context).answer,
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    S.of(context).answer_text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 14,),
                                  const AppDivider(),
                                  const SizedBox(height: 14,),
                                  Text(
                                    S.of(context).attachment_files,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 4,),
                                  Column(
                                    children: List.generate(answerFiles?.length??0, (index){
                                      return GestureDetector(
                                        onTap: () {
                                          snackBar(S.of(context).file_loading);
                                          downloadFile(answerFiles?[index].id??'',answerFiles?[index].name??'--').then((file){
                                            OpenFile.open(file?.path);
                                          });
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
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
                                                const SizedBox(height: 8,),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        answerFiles?[index].name??'--',
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String getType(List<AppealTypeModel> types,int status,String lang){
    String type1='erfg';

    for (var type in types) {
      if(type.value==status){
        type1=getLang(LanguageModel.fromJson(jsonDecode(type.label??'')), lang);
        debugPrint(type1);
        break;
      }
    }
    return type1;
  }

  Future<File?> downloadFile(String id, String name) async {
    final iosStorage = await getApplicationDocumentsDirectory();
    final androidStorage = await getDownloadsDirectory();
    final file = Platform.isIOS?File('${iosStorage.path}/$name'):File('${androidStorage?.path}/$name');
    final response = await Dio().get("https://edo.ijro.uz/api/integration/file/download/$id",
        options: Options(
        responseType: ResponseType.bytes,
            followRedirects: false,
          headers: {
          'Authorization':'Basic SU5URUdSQVRJT05fQVBJX1VTRVI6ZXlKQVNGRDQzMjEzNHBaQ0k2SWoxMjM0VkFTREZtT1RkNDM1NmtaRGZkc1ZsTXpTQURGSTM0NTY3TlRRek1ENDU2N0F3TVRVNDU2N3daV1J0cmU0M2haaTU2N1NBRElzSW1SaVgyNTQ2N2xrSWo1NjdvaU42NTdXQVNERlk1TjJSak5ERTQ1NjQ1NkFTREZ6TWpjNDY0NjFBU0RGTjQ1NkRNQVNERndNREE0NTZ4TlRC'
          }
        ));
    debugPrint("response status message${response.statusCode}");
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  }

  Future<File?> downloadFile1(String name) async {
    final iosStorage = await getApplicationDocumentsDirectory();
    final androidStorage = await getDownloadsDirectory();
    final file = Platform.isIOS?File('${iosStorage.path}/$name'):File('${androidStorage?.path}/$name');
    final response = await Dio().get("https://omd2.technocorp.uz/files/$name",
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
        ));
    debugPrint("response status message${response.statusCode}");
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }

  Future openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    debugPrint('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future openFile1({required String fileName}) async {
    final file = await downloadFile1(fileName);
    if (file == null) return;
    debugPrint('Path: ${file.path}');
    OpenFile.open(file.path);
  }
}
