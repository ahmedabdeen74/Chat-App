import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/cubits/signUp_cubit/sign_up_cubit.dart';
import 'package:chat_app/views/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:chat_app/views/sign_in.dart';
import 'package:chat_app/views/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
         BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          SignInView.id: (context) => SignInView(),
          SignUpView.id: (context) => SignUpView(),
          ChatPage.id:(context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: SignInView.id,
      ),
    );
  }
}
