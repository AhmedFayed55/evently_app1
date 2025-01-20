import 'package:evently_app/auth/register_screen/register_screen.dart';
import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/tabs/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/assets_manager.dart';
import '../../utils/dialog_utils.dart';
import '../forget_password/forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: "ahmed@route.com");
  var passwordController = TextEditingController(text: "123456");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * .067,
              ),
              Image.asset(AssetsManager.logo),
              SizedBox(
                height: height * .032,
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "please enter an email"; //invalid
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return " Please enter  a valid email";
                  }
                  return null; //valid
                },
                hintStyle: AppStyles.medium16Grey,
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: const Icon(Icons.email),
              ),
              SizedBox(
                height: height * .0213,
              ),
              CustomTextField(
                keyboardType: TextInputType.phone,
                controller: passwordController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "please enter a password"; //invalid
                  }
                  if (text.length < 6) {
                    return "password should be at least 6 chars.";
                  }
                  return null; //valid
                },
                sufixIcon: const Icon(Icons.visibility_off),
                hintStyle: AppStyles.medium16Grey,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Icons.lock),
              ),
              SizedBox(
                height: height * .0213,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgetPassword.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: AppStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .0313,
              ),
              CustomElevatedButton(
                onTap: login,
                //     () {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       HomeScreen.routeName, (Route<dynamic> route) => false);
                // },
                text: AppLocalizations.of(context)!.login,
                textStyle: AppStyles.medium20White,
              ),
              SizedBox(
                height: height * .0313,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.dont_have_account,
                    style: AppStyles.medium16Black),
                TextSpan(
                  text: AppLocalizations.of(context)!.create_account,
                  style: AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                ),
              ])),
              SizedBox(
                height: height * .0333,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * .085),
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 2,
                      endIndent: 20,
                      color: AppColors.primaryLight,
                    )),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyles.medium16Primary,
                    ),
                    const Expanded(
                        child: Divider(
                            thickness: 2,
                            indent: 20,
                            color: AppColors.primaryLight)),
                  ],
                ),
              ),
              SizedBox(
                height: height * .0333,
              ),
              CustomElevatedButton(
                onTap: () {
                  /////
                },
                prefixIconButton: Image.asset(AssetsManager.googleLogo),
                text: AppLocalizations.of(context)!.login_with_google,
                textStyle: AppStyles.medium20Primary,
                backgroundColor: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      // ready to login
      //todo: show loading
      DialogUtils.showLoading(context: context, message: "Loading....");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: 'Login Successfully',
            title: "Success",
            posActionName: "Ok",
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print("login success");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message:
                  'The supplied auth credential is incorrect,, malformed or has expired.',
              posActionName: "Ok");
          print(
            'The supplied auth credential is incorrect,, malformed or has expired.',
          );
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: "Error",
            posActionName: "Ok");
        print(e.toString());
      }
    }
  }
}
