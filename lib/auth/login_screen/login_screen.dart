import 'package:evently_app/auth/register_screen/register_screen.dart';
import 'package:evently_app/custom_widgets/custom_elevated_button.dart';
import 'package:evently_app/tabs/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/assets_manager.dart';
import '../forget_password/forget_password.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
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
              hintStyle: AppStyles.medium16Grey,
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: const Icon(Icons.email),
            ),
            SizedBox(
              height: height * .0213,
            ),
            CustomTextField(
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
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, (Route<dynamic> route) => false);
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
    );
  }
}
