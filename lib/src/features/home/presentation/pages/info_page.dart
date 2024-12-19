import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/category_model.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';
import 'package:ombudsman/src/features/main/tabs/home/widgets/home_card1_widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late final bloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.category();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).about_ombudsman.replaceFirst('\n', ' '),
            ),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png'),
                    fit: BoxFit.cover,),
                ),
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ))
                    : state.category?.isNotEmpty==true? MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            itemCount: state.category?.length,
                            itemBuilder: (context, index) {
                              return buildNewsItem(context,
                                  state.category?[index], appState.lang);
                            }),
                      ):const SizedBox(),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildNewsItem(BuildContext context, CategoryModel? model, String lang) {
    return HomeCard1Widget(
        title: getLang(LanguageModel.fromJson(jsonDecode(model?.title ?? '')), lang),
        content: getLang(LanguageModel.fromJson(jsonDecode(model?.title ?? '')), lang),
        onClick: () {
          if(model?.id!=14){
            context.pushNamed(AppRoutes.leadership.name,
                pathParameters: {'id': model?.id.toString() ?? '0','title':getLang(LanguageModel.fromJson(jsonDecode(model?.title ?? '')), lang)});
          }else{
            context.pushNamed(AppRoutes.aboutOmbudsman.name,
                pathParameters: {'id': model?.id.toString() ?? '0','title':getLang(LanguageModel.fromJson(jsonDecode(model?.title ?? '')), lang)});
          }
        }).animate().move().fade().slideY(begin: 1, end: 0, duration: 300.ms);
  }
}
