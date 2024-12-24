import 'package:evently_app/auth/register/register_screen.dart';
import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/tabs/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../custom_widgets/custom_text_field.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/assets_manager.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!.forget_password,
                  style: AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .0313,
            ),
            CustomElevatedButton(
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
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
                  Expanded(
                      child: Divider(
                    thickness: 2,
                    endIndent: 20,
                    color: AppColors.primaryLight,
                  )),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: AppStyles.medium16Primary,
                  ),
                  Expanded(
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
              prefixIconButton: Image.asset(AssetsManager.gooleLogo),
              text: AppLocalizations.of(context)!.login_with_google,
              textStyle: AppStyles.medium20Primary,
              backgroundColor: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
