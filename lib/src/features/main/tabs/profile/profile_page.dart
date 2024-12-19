import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_divider.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/app_state/localization.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/services/services.dart';
import 'package:ombudsman/src/core/util/app_constants.dart';
import 'package:ombudsman/src/features/auth/data/models/one_id_model.dart';
import 'package:ombudsman/src/features/main/tabs/profile/widgets/profile_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final cubit = context.read<AppCubit>();
  User? userData;

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Text(
            S.of(context).exit_text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mainColor),
              child: Text(
                S.of(context).no,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mainColor),
              child: Text(
                S.of(context).yes,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Prefs.setString(AppConstants.kAccessToken, '');
                Prefs.setString(AppConstants.kRefreshToken, '');
                Prefs.setString(AppConstants.kUser, '');
                Prefs.setBool(AppConstants.kExit, true);
                context.goNamed(AppRoutes.oneId.name);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _userInfo(User? user) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Text(
            S.of(context).personal_data,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsOverflowAlignment: OverflowBarAlignment.start,
          actions: <Widget>[
            Text(S.of(context).full_name,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.secondaryTextColor),),
            const SizedBox(height: 2,),
            Text(user?.fullName??'--',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            /*Text(S.of(context).phone,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.secondaryTextColor),),
            const SizedBox(height: 2,),
            Text(user?.phoneNumber??'--',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            Text(S.of(context).birth_date,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.secondaryTextColor),),
            const SizedBox(height: 2,),
            Text(user?.birthDate??'--',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            Text(S.of(context).address,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.secondaryTextColor),),
            const SizedBox(height: 2,),
            Text(user?.address??'--',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),*/
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${!state.isDark?'swatch':'swatch_auth'}.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      S.of(context).profile,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ).animate().move().fade().slideY(begin: 1,end: 0,duration: 200.ms),
                  )
                ),
                FutureBuilder(
                  future: Prefs.getString(AppConstants.kUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      debugPrint(snapshot.data);
                      userData = User.fromJson(jsonDecode(snapshot.data!));
                    }
                    return Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData?.fullName??'',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        userData?.phoneNumber??'',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  _userInfo(userData);
                                }, icon: const Icon(Icons.arrow_forward_ios))
                              ],
                            ),
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 220.ms),
                          const AppDivider(),
                          ProfileButtonWidget(
                            icon: "assets/icons/ic_clipboard.svg",
                            text: S.of(context).user_manual,
                            onClick: () {
                              context.pushNamed(AppRoutes.slider.name,pathParameters: {'args':'2'});
                            },
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 240.ms),
                          ExpansionTile(
                            leading: SvgPicture.asset(
                              'assets/icons/ic_translate.svg',
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            title: Text(
                              S.of(context).app_language,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            iconColor: Theme.of(context).colorScheme.tertiary,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.changeLocale(Localization.uz, 'uz');
                                },
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SvgPicture.asset('assets/icons/uz.svg',height: 30,)),
                                title: const Text(
                                  "O'zbek",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    value: state.lang=='uz',
                                    onChanged: (v){
                                      cubit.changeLocale(Localization.uz, 'uz');
                                    }),
                              ).animate().move().fade().slideY(duration: 200.ms),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.changeLocale(Localization.uk, 'uk');
                                },
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SvgPicture.asset('assets/icons/uz.svg',height: 30,)),
                                title: const Text(
                                  "Ўзбек",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: state.lang=='uk',
                                    onChanged: (v){
                                      cubit.changeLocale(Localization.uk, 'uk');
                                    }),
                              ).animate().move().fade().slideY(duration: 250.ms),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.changeLocale(Localization.en, 'en');
                                },
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SvgPicture.asset('assets/icons/sh.svg',height: 30,)),
                                title: const Text(
                                  "English",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: state.lang=='en',
                                    onChanged: (v){
                                      cubit.changeLocale(Localization.en, 'en');
                                    }),
                              ).animate().move().fade().slideY(duration: 300.ms),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.changeLocale(Localization.ru, 'ru');
                                },
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SvgPicture.asset('assets/icons/ru.svg',height: 30,)),
                                title: const Text(
                                  "Русский",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: state.lang=='ru',
                                    onChanged: (v){
                                      cubit.changeLocale(Localization.ru, 'ru');
                                    }),
                              ).animate().move().fade().slideY(duration: 300.ms),
                            ],
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 260.ms),
                          const AppDivider(),
                          ExpansionTile(
                            leading: SvgPicture.asset(
                              'assets/icons/ic_light.svg',
                              color:Theme.of(context).colorScheme.tertiary,
                            ),
                            iconColor: Theme.of(context).colorScheme.tertiary,
                            title: Text(
                              S.of(context).app_theme,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.toLight();
                                },
                                leading: SvgPicture.asset('assets/icons/ic_light.svg',color: Theme.of(context).colorScheme.tertiary,),
                                title: Text(
                                  S.of(context).light,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: state.isDark==false,
                                    onChanged: (v){
                                      cubit.toLight();
                                    }),
                              ).animate().move().fade().slideY(duration: 280.ms),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: AppDivider(),
                              ),
                              ListTile(
                                onTap: () {
                                  cubit.toDark();
                                },
                                leading: SvgPicture.asset('assets/icons/ic_dark.svg',color: Theme.of(context).colorScheme.tertiary,),
                                title: Text(
                                  S.of(context).dark,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: state.isDark==true,
                                    onChanged: (v){
                                      cubit.toDark();
                                    }),
                              ).animate().move().fade().slideY(duration: 300.ms),
                            ],
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 320.ms),
                          const AppDivider(),
                          ProfileButtonWidget(
                            icon: 'assets/icons/ic_call.svg',
                            text: S.of(context).by_phone,
                            onClick: () {
                              _makePhoneCall("(71) 200-10-96");
                            },
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 340.ms),
                          const AppDivider(),
                          ProfileButtonWidget(
                            icon: 'assets/icons/ic_share.svg',
                            text: S.of(context).share,
                            onClick: () {
                              Share.share('https://play.google.com/store/apps/details?id=com.technocorp.ombudsman', subject: S.of(context).app_name);
                            },
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 360.ms),
                          ProfileButtonWidget(
                            icon:'assets/icons/ic_info.svg',
                            text: S.of(context).about_app,
                            onClick: () {
                              context.pushNamed(AppRoutes.aboutApp.name);
                            },
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 380.ms),
                          ListTile(
                            onTap: () {
                              _showMyDialog();
                            },
                            leading: SvgPicture.asset(
                              'assets/icons/ic_logout.svg',
                              color: Colors.red,
                            ),
                            title: Text(
                              S.of(context).exit,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ).animate().move().fade().slideY(begin: 1,end: 0,duration: 400.ms),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
