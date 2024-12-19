import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/services/services.dart';
import 'package:ombudsman/src/core/util/app_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      //await Prefs.setString(AppConstants.kAccessToken, '9|RKzx95Z3uOQgd04cn0OVP7FMmatCHjGAM9Rd6I0Sed741391');
      final String token = await Prefs.getString(AppConstants.kAccessToken) ?? "";
      debugPrint(token);
      if (token.isNotEmpty) {
        context.goNamed(AppRoutes.main.name);
       // Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.REFERENCE_INFO, (route) => false);
      } else {
        context.goNamed(AppRoutes.language.name);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/${!state.isDark?'swatch':'swatch_auth'}.png'),
                fit: BoxFit.cover,
              ),
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SvgPicture.asset('assets/icons/ic_logo.svg',height: 100,fit: BoxFit.cover,),
              Image.asset('assets/images/img_logo.png',height: 160,fit: BoxFit.cover,),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  textAlign: TextAlign.center,
                  S.of(context).app_title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
  },
)
    );
  }
}
