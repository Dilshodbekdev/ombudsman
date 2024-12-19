import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_divider.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/faq_model.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late final bloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.faq();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).faq.replaceFirst('\n', ' '),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png'),
                  fit: BoxFit.cover,),
              ),
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ))
                  : state.faq?.isNotEmpty==true? ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.faq?.length,
                itemBuilder: (context, index){
                  return buildQuestionItem(state.faq?[index],appState.lang);
                }
              ):const SizedBox(),
          );
        },
      ),
    );
  },
);
  }

  Widget buildQuestionItem(FaqModel? model,String lang) {
    return getLang(LanguageModel.fromJson(jsonDecode(model?.content??'')), lang)!=''? Card(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedBackgroundColor: AppColors.mainColor,
        backgroundColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Colors.white,
        iconColor: Theme.of(context).colorScheme.tertiary,
        textColor: Theme.of(context).colorScheme.tertiary,
        collapsedTextColor: Colors.white,
        title: Text(
          getLang(LanguageModel.fromJson(jsonDecode(model?.title??'')), lang),
          style:  const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: <Widget>[
          const AppDivider(),
          ListTile(
            textColor: Theme.of(context).colorScheme.tertiary,
            title: Html(
              data: getLang(LanguageModel.fromJson(jsonDecode(model?.content??'')), lang),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }
}
