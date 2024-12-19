import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_elevated_button.dart';
import 'package:ombudsman/src/config/theme/app_colors.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';

class SliderPage extends StatefulWidget {
  final int args;
  const SliderPage({super.key, required this.args});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  var _index = 0;

  PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.args == 2
          ? AppBar(
              title: Text(
                S.of(context).user_manual,
              ),
            )
          : null,
      body: BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${!state.isDark?'swatch':'swatch_auth'}.png'),
              fit: BoxFit.cover,
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 380,
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                children: [
                  _itemSlider(
                      'assets/icons/ic_intro_1.svg',
                      S.of(context).slider_title_1,
                      S.of(context).slider_desc_1,
                  ),
                  _itemSlider(
                      'assets/icons/ic_intro_2.svg',
                      S.of(context).slider_title_2,
                      S.of(context).slider_desc_2,
                  ),
                  _itemSlider(
                      'assets/icons/ic_intro_3.svg',
                      S.of(context).slider_title_3,
                      S.of(context).slider_desc_3,
                  ),
                  _itemSlider(
                      'assets/icons/ic_intro_4.svg',
                      S.of(context).slider_title_4,
                      S.of(context).slider_desc_4,
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 32, top: 24),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(36),
                        topLeft: Radius.circular(36))),
                child: Column(
                  children: [
                    DotsIndicator(
                      decorator: DotsDecorator(
                        activeColor: AppColors.bottomNavActiveIconColor,
                        color: AppColors.bottomNavNoActiveIconColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      dotsCount: 4,
                      position: _index,
                    ),
                    const SizedBox(height: 24,),
                    AppElevatedButton(
                        text: S.of(context).next,
                        onClick: () {
                          if (_index != 3) {
                            setState(() {
                              _index++;
                              controller.animateToPage(_index,
                                  duration: const Duration(milliseconds: 2),
                                  curve: Curves.linear);
                            });
                          } else {
                           widget.args == 1
                                ? context.pushReplacementNamed(AppRoutes.oneId.name) : context.pop();
                          }
                        }),
                  ],
                ))
          ],
        ),
      );
  },
),
    );
  }

  Widget _itemSlider(String img, String title, String desc) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: AppColors.sliderImageColorDark,
              borderRadius: BorderRadius.circular(16)),
          child: SvgPicture.asset(
            img,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ).animate().fadeIn(duration: const Duration(seconds: 1)).shader(),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            desc,
            style: const TextStyle( fontSize: 14),
            textAlign: TextAlign.center,
          ).animate().moveY(duration: const Duration(seconds: 2)),
        )
      ],
    );
  }
}
