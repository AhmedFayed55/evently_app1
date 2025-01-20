import 'package:evently_app/auth/login_screen/login_screen.dart';
import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/custom_widgets/custom_text_field.dart';
import 'package:evently_app/tabs/home_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register_Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: "ahmed");
  var emailController = TextEditingController(text: "ahmed@route.com");
  var passwordController = TextEditingController(text: "123456");
  var rePasswordController = TextEditingController(text: "123456");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.asset(AssetsManager.logo),
              SizedBox(
                height: height * .032,
              ),
              CustomTextField(
                controller: nameController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "please enter a name"; //invalid
                  }
                  return null; //valid
                },
                hintStyle: AppStyles.medium16Grey,
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(
                height: height * .0213,
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
                prefixIcon: Icon(Icons.email),
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
                sufixIcon: Icon(Icons.visibility_off),
                hintStyle: AppStyles.medium16Grey,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(
                height: height * .0213,
              ),
              CustomTextField(
                controller: rePasswordController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "please enter a repassword"; //invalid
                  }
                  if (text.length < 6) {
                    return "password should be at least 6 chars.";
                  }
                  if (text != passwordController.text) {
                    return "re-password doesnot match password";
                  }
                  return null; //valid
                },
                sufixIcon: Icon(Icons.visibility_off),
                hintStyle: AppStyles.medium16Grey,
                hintText: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(
                height: height * .0213,
              ),
              CustomElevatedButton(
                  textStyle: AppStyles.medium20White,
                  text: AppLocalizations.of(context)!.create_account,
                  onTap: register),
              SizedBox(
                height: height * .0213,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.already_have_account,
                    style: AppStyles.medium16Black),
                TextSpan(
                  text: AppLocalizations.of(context)!.login,
                  style: AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      // ready to register
      //todo: show loading
      DialogUtils.showLoading(context: context, message: "Loading....");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: "Register Successfully",
            title: "Success",
            posActionName: "Ok",
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print("register sucess");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: "The password provided is too weak",
              title: "Error",
              posActionName: "Ok");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: "The account already exists for that email",
              title: "Error",
              posActionName: "Ok");
          print('The account already exists for that email.');
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
        print(e);
      }
    }
  }
}
