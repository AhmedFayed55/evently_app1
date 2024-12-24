import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/custom_widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "Register_Screen";

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
        child: Column(
          children: [
            Image.asset(AssetsManager.logo),
            SizedBox(
              height: height * .032,
            ),
            CustomTextField(
              hintStyle: AppStyles.medium16Grey,
              hintText: AppLocalizations.of(context)!.name,
              prefixIcon: Icon(Icons.person),
            ),
            SizedBox(
              height: height * .0213,
            ),
            CustomTextField(
              hintStyle: AppStyles.medium16Grey,
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(
              height: height * .0213,
            ),
            CustomTextField(
              sufixIcon: Icon(Icons.visibility_off),
              hintStyle: AppStyles.medium16Grey,
              hintText: AppLocalizations.of(context)!.password,
              prefixIcon: Icon(Icons.lock),
            ),
            SizedBox(
              height: height * .0213,
            ),
            CustomTextField(
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
                onTap: () {}),
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
    );
  }
}
