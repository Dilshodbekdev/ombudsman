import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/data/models/language_model.dart';
import 'package:ombudsman/src/features/home/data/models/news_model.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final bloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.news();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).news,
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
                  fit: BoxFit.cover),
            ),
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor,))
                : state.news.isEmpty
                ? Center(
              child: Text(
                S.of(context).data_no,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : LazyLoadScrollView(
              isLoading: state.isPagingNews,
              scrollOffset: 300,
              onEndOfPage: () => bloc.pagingNews(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.news.length + (state.isPagingNews ? 1 : 0),
                itemBuilder: (context, index) => index == state.news.length
                    ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : buildNewsItem(context,state.news[index],appState.lang),
                separatorBuilder: (context, index) => const SizedBox(),
              ),
            )
          );
        },
      ),
    );
  },
);
  }

  Widget buildNewsItem(BuildContext context,NewModel? model,String lang) {
    return getLang(LanguageModel.fromJson(jsonDecode(model?.title??'')), lang)!=''? Card(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/img_placeholder.jpg'),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/img_placeholder.jpg', fit: BoxFit.cover);
                  },
                  image: NetworkImage(getImg(model?.anonsImage??'')),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ExpansionTile(
              title: Text(
              getLang(LanguageModel.fromJson(jsonDecode(model?.title??'')), lang),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
              ),
            ),
              children: [
                model?.content!=null?
                Html(
                  data: getLang(LanguageModel.fromJson(jsonDecode(model?.content??'')), lang),
                  shrinkWrap: false,
                ):const SizedBox(),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  model?.date??'--',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.secondaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ):const SizedBox();
  }
}
