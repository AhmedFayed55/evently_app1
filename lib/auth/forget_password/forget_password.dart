import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../utils/app_styles.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = "forget_password";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.forget_password,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Column(
          children: [
            Image.asset(AssetsManager.forgetPassword),
            SizedBox(
              height: height * .0285,
            ),
            CustomTextField(
              hintStyle: AppStyles.medium16Grey,
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(
              height: height * .0285,
            ),
            CustomElevatedButton(
                textStyle: AppStyles.medium20White,
                text: AppLocalizations.of(context)!.reset_password,
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
