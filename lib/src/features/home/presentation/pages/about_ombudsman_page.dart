import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_divider.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/home/data/models/leadership_model.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';

class AboutOmbudsmanPage extends StatefulWidget {
  final int id;
  final String title;
  const AboutOmbudsmanPage({super.key, required this.id, required this.title});

  @override
  State<AboutOmbudsmanPage> createState() => _AboutOmbudsmanPageState();
}

class _AboutOmbudsmanPageState extends State<AboutOmbudsmanPage> {
  late final bloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.leadership();
    bloc.management(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png',),
            fit: BoxFit.cover,
          ),
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
          child: DefaultTabController(
            length: 3,
            child:state.management==null && state.leaderships==null?
            const Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: state.management?.isNotEmpty==true?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.management?[0].title!=null?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].title ?? '')), appState.lang),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  ):const SizedBox(),
                  state.management?[0].biography!=null?
                  Html(
                    data:getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].biography ?? '')), appState.lang),
                    shrinkWrap: true,
                  ):const SizedBox(),
                  state.management?[0].leader!=null?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].leader ?? '')), appState.lang),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  ):const SizedBox(),
                  state.management?[0].address!=null?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].address ?? '')), appState.lang),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
                  ):const SizedBox(),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  leader(state.leaderships?[0].anonsImage??'', state.leaderships?[0].title??'', state.leaderships?[0].description??'', appState.lang)
                      :const SizedBox(),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  leader(state.leaderships?[1].anonsImage??'', state.leaderships?[1].title??'', state.leaderships?[1].description??'', appState.lang)
                      :const SizedBox(),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  leader(state.leaderships?[2].anonsImage??'', state.leaderships?[2].title??'', state.leaderships?[2].description??'', appState.lang)
                      :const SizedBox(),
                  state.management?[0].content!=null?
                  Html(
                    data:getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].content ?? '')), appState.lang),
                    shrinkWrap: false,
                  ):const SizedBox(),
                  const AppDivider(),
                  const SizedBox(height: 16,),
                  Text(
                      S.of(context).about_text_1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),textAlign: TextAlign.center,
                  ),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  part1(state.leaderships??[],appState.lang):const SizedBox(),
                  const AppDivider(),
                  const SizedBox(height: 16,),
                  Text(
                    S.of(context).about_text_2.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),textAlign: TextAlign.center,
                  ),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  part2(state.leaderships??[], appState.lang):const SizedBox(),
                  const AppDivider(),
                  const SizedBox(height: 16,),
                  Text(
                    S.of(context).about_text_3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),textAlign: TextAlign.center,
                  ),
                  state.management?[0].activity!=null?
                  Html(
                    data:getLang(LanguageModel.fromJson(jsonDecode(state.management?[0].activity ?? '')), appState.lang),
                    shrinkWrap: false,
                  ):const SizedBox(),
                  const AppDivider(),
                  const SizedBox(height: 16,),
                  Text(
                    S.of(context).about_text_4,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),textAlign: TextAlign.center,
                  ),
                  state.leaderships!=null&&state.leaderships?.isNotEmpty==true?
                  part3(state.leaderships??[], appState.lang):const SizedBox()
                ],
              ):const SizedBox(),
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

  Widget part1(List<LeadershipModel> leaderships,String lang){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: icon1(leaderships[3].anonsImage??'', leaderships[3].title??'',lang)),
            Expanded(child: icon1(leaderships[4].anonsImage??'', leaderships[4].title??'',lang)),
          ],
        ),
        Row(
          children: [
            Expanded(child: icon1(leaderships[5].anonsImage??'', leaderships[5].title??'',lang)),
            Expanded(child: icon1(leaderships[6].anonsImage??'', leaderships[6].title??'',lang)),
          ],
        ),
        Row(
          children: [
            Expanded(child: icon1(leaderships[7].anonsImage??'', leaderships[7].title??'',lang)),
            Expanded(child: icon1(leaderships[8].anonsImage??'', leaderships[8].title??'',lang)),
          ],
        ),
      ],
    );
  }

  Widget part2(List<LeadershipModel> leaderships,String lang){
    return Column(
      children: [
        icon2(leaderships[9].anonsImage??'', leaderships[9].title??'',lang),
        icon2(leaderships[10].anonsImage??'', leaderships[10].title??'',lang),
        icon2(leaderships[11].anonsImage??'', leaderships[11].title??'',lang),
        icon2(leaderships[12].anonsImage??'', leaderships[12].title??'',lang),
        icon2(leaderships[13].anonsImage??'', leaderships[13].title??'',lang),
        icon2(leaderships[14].anonsImage??'', leaderships[14].title??'',lang),
      ],
    );
  }

  Widget part3(List<LeadershipModel> leaderships,String lang){
    return Column(
      children: [
        icon2(leaderships[15].anonsImage??'', leaderships[15].title??'',lang),
        icon2(leaderships[16].anonsImage??'', leaderships[16].title??'',lang),
      ],
    );
  }

  Widget icon1(String image,String title,String lang){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FadeInImage(
            placeholder: const AssetImage('assets/images/img_placeholder.jpg'),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/img_placeholder.jpg', fit: BoxFit.cover);
            },
            image: NetworkImage(getImg(image)),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10,),
          Text(getLang(LanguageModel.fromJson(jsonDecode(title)), lang),style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget icon2(String image,String title,String lang){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 100,
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/img_placeholder.jpg'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/img_placeholder.jpg', fit: BoxFit.cover);
              },
              image: NetworkImage(getImg(image)),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10,),
          Text(getLang(LanguageModel.fromJson(jsonDecode(title)), lang),style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget leader(String image,String title,String desc,String lang){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/img_placeholder.jpg'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/img_placeholder.jpg', fit: BoxFit.cover);
                },
                image: NetworkImage(getImg(image)),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            getLang(LanguageModel.fromJson(jsonDecode(title)), lang),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8,),
          Text(
            getLang(LanguageModel.fromJson(jsonDecode(desc)), lang),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
