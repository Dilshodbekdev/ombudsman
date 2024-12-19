import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/presentation/manager/appeal_bloc.dart';

class ReferencesPage extends StatefulWidget {
  const ReferencesPage({super.key});

  @override
  State<ReferencesPage> createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
  late final bloc = context.read<AppealBloc>();

  List<AppealModel> allTickets = [];
  List<AppealModel> news = [];
  List<AppealModel> registered = [];
  List<AppealModel> review = [];
  List<AppealModel> answered = [];

  @override
  void initState() {
    super.initState();
    bloc.appealList();
    /*bloc.statuses();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppealBloc, AppealState>(
        listener: (context, state) {
          if (state.isGetMessageVerified) {
            allTickets = state.appealList ?? [];
            news = state.appealList
                    ?.where((element) => element.status == 1)
                    .toList() ??
                [];
            registered = state.appealList
                    ?.where((element) => element.status == 2)
                    .toList() ??
                [];
            review = state.appealList
                    ?.where((element) => element.status == 3)
                    .toList() ??
                [];
            answered = state.appealList
                    ?.where((element) => element.status == 4)
                    .toList() ??
                [];
          }
        },
        builder: (context, state) {
          return BlocBuilder<AppCubit, AppState>(
            builder: (context, appState) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/${!appState.isDark?'swatch':'swatch_auth'}.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).appeals,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                context.pushNamed(AppRoutes.requirements.name);
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/ic_create_reference.svg',
                              ),
                              label: Text(
                                S.of(context).new_appeal,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.tertiary
                                ),
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .move()
                            .fade()
                            .slideY(begin: 1, end: 0, duration: 50.ms),
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 5,
                          child: Column(
                            children: [
                              Card(
                                color: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: TabBar(
                                  indicatorColor: AppColors.mainColor,
                                  unselectedLabelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  labelColor: AppColors.mainColor,
                                  isScrollable: true,
                                  labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  tabAlignment: TabAlignment.start,
                                  tabs: [
                                    Tab(text: S.of(context).all),
                                    Tab(text: S.of(context).new1),
                                    Tab(text: S.of(context).registered),
                                    Tab(text: S.of(context).review),
                                    Tab(text: S.of(context).answered),
                                  ],
                                ),
                              )
                                  .animate()
                                  .move()
                                  .fade()
                                  .slideY(begin: 1, end: 0, duration: 100.ms),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                   allTickets.isNotEmpty? MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          itemCount: allTickets.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoutes.infoAppeal.name,
                                                      pathParameters: {
                                                        'arg': jsonEncode(allTickets[index])
                                                      });
                                                },
                                                child: Ink(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          allTickets[index].text ?? '--',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: textColor(allTickets[index].status ?? 0).withOpacity(0.1),
                                                              ),
                                                              child: Text(
                                                                getStatusText(allTickets[index].status ?? 0, appState.lang),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: textColor(allTickets[index].status ?? 0),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              allTickets[index].createdAt ?? '--',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors.secondaryTextColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ).animate().move().fade().slideY(
                                                begin: 1,
                                                end: 0,
                                                duration: 100.ms);
                                          }),
                                    ): Center(
                                     child: Text(S.of(context).data_no,
                                       style: const TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500,
                                       ),
                                     ),
                                   ),
                                    news.isNotEmpty? MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          itemCount: news.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoutes.infoAppeal.name,
                                                      pathParameters: {
                                                        'arg': jsonEncode(
                                                            news[index])
                                                      });
                                                },
                                                child: Ink(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          news[index].text ?? '--',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: textColor(news[index].status ?? 0).withOpacity(0.1),
                                                              ),
                                                              child: Text(
                                                                getStatusText(news[index].status ?? 0, appState.lang),
                                                                style: TextStyle(
                                                                      fontSize: 12,
                                                                  color: textColor(news[index].status ?? 0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              news[index].createdAt ?? '--',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors.secondaryTextColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ):
                                    Center(
                                      child: Text(S.of(context).data_no,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),),
                                    registered.isNotEmpty? MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          itemCount: registered.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoutes.infoAppeal.name,
                                                      pathParameters: {
                                                        'arg': jsonEncode(
                                                            registered[index])
                                                      });
                                                },
                                                child: Ink(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          registered[index].text ?? '--',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: textColor(registered[index].status ?? 0).withOpacity(0.1),
                                                              ),
                                                              child: Text(
                                                                getStatusText(registered[index].status ?? 0, appState.lang),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: textColor(registered[index].status ?? 0),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              registered[index].createdAt ?? '--',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors.secondaryTextColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ):
              Center(
              child: Text(S.of(context).data_no,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),),
                                    review.isNotEmpty? MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          itemCount: review.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoutes.infoAppeal.name,
                                                      pathParameters: {
                                                        'arg': jsonEncode(
                                                            review[index])
                                                      });
                                                },
                                                child: Ink(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          review[index].text ?? '--',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: textColor(review[index].status ?? 0).withOpacity(0.1),
                                                              ),
                                                              child: Text(
                                                                getStatusText(review[index].status ?? 0, appState.lang),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: textColor(review[index].status ?? 0),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              review[index].createdAt ?? '--',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors.secondaryTextColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ):
                                    Center(
                                      child: Text(S.of(context).data_no,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),),
                                  answered.isNotEmpty?  MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          itemCount: answered.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoutes.infoAppeal.name,
                                                      pathParameters: {
                                                        'arg': jsonEncode(
                                                            answered[index])
                                                      });
                                                },
                                                child: Ink(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          answered[index].text ?? '--',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: textColor(answered[index].status ?? 0).withOpacity(0.1),
                                                              ),
                                                              child: Text(
                                                                getStatusText(answered[index].status ?? 0,
                                                                    appState.lang),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: textColor(answered[index].status ?? 0),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              answered[index].createdAt ?? '--',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors.secondaryTextColor,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ):Center(
                                    child: Text(S.of(context).data_no,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
