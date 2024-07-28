import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:chat_app/views/sign_up.dart';
import 'package:chat_app/widgets/sign_button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatelessWidget {
  SignInView({
    super.key,
  });
  static String id = 'signIn';
  bool isLoading = false;

  String? email;

  String? passWord;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoaded) {
          isLoading = true;
        } else if (state is SignInsuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        }else if (state is SignInFailure){
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      kLogo,
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'pacifico',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        onChanged: (data) {
                          email = data;
                        },
                        text: 'Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        obscureText: true,
                        onChanged: (data) {
                          passWord = data;
                        },
                        text: 'password'),
                    const SizedBox(
                      height: 20,
                    ),
                    SignButton(
                        text: 'Sign In',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                          }
                          BlocProvider.of<SignInCubit>(context)
                              .signInUser(email: email!, passWord: passWord!);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, SignUpView.id),
                          child: const Text(
                            " Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),);
      }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /*Future<void> signInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: passWord!);
  }
*/
