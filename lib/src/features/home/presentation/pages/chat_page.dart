
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombudsman/generated/l10n.dart';
import 'package:ombudsman/src/config/components/app_elevated_button.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/util/funs.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
              S.of(context).online_chat.replaceFirst('\n', ' '),
            ),
          ),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${!appState.isDark ? 'swatch' : 'swatch_auth'}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                                height:60,child: Image.asset('assets/images/logo_advice.png')),
                          )),
                      const SizedBox(height: 16,),
                      Card(
                        color: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(S.of(context).chat_text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),textAlign: TextAlign.justify,)
                        ),
                      ),
                      const SizedBox(height: 16,),
                      AppElevatedButton(text: "www.advice.uz", onClick: (){const url = 'https://advice.uz/uz/page/about';
                      launchInBrowser(Uri.parse(url));})
                    ],
                  ),
                )
              );
            },
          ),
        );
      },
    );
  }
}
