import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_elevated_button.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/home/data/models/management_model.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';

class LeadershipPage extends StatefulWidget {
  final int id;
  final String title;
  const LeadershipPage({super.key, required this.id, required this.title});

  @override
  State<LeadershipPage> createState() => _LeadershipPageState();
}

class _LeadershipPageState extends State<LeadershipPage> {
  late final bloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
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
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        itemCount: state.management?.length,
                        itemBuilder: (context, index) {
                          return buildNewsItem(context, state.management?[index],appState.lang);
                        }),
                  ),
          );
        },
      ),
    );
  },
);
  }

  Widget buildNewsItem(BuildContext context, ManagementModel? model,String lang) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  image: NetworkImage(getImg(model?.image??'')),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              getLang(LanguageModel.fromJson(jsonDecode(model?.leader ?? '')), lang),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10,),
            Text(
              getLang(LanguageModel.fromJson(jsonDecode(model?.title ?? '')), lang),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/call.svg',
                      height: 16,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                     S.of(context).phone,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryTextColor),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Text(
              model?.phone ?? '--',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      height: 16,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      S.of(context).reception_days,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryTextColor),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8,),
            model?.reception!=null?
            Text(
              getLang(LanguageModel.fromJson(jsonDecode(model?.reception ?? '')), lang),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ):const SizedBox(),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: AppElevatedButton(text: S.of(context).biography, onClick: model?.biography!=null ?(){
                  context.pushNamed(AppRoutes.biography.name, pathParameters: {"text": getLang(LanguageModel.fromJson(jsonDecode(model?.biography ?? '')), lang)});
                }:null)),
                const SizedBox(width: 12,),
                Expanded(child: AppElevatedButton(text: S.of(context).functions, onClick: model?.content!=null ?(){
                  context.pushNamed(AppRoutes.functions.name, pathParameters: {"text": getLang(LanguageModel.fromJson(jsonDecode(model?.content ?? '')), lang)});
                }:null)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
