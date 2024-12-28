import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              ///change language
              languageProvider.changeLanguage("en");
              Navigator.pop(context);
            },
            child: languageProvider.appLanguage == "en"
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.english),
          ),
          SizedBox(
            height: height * .012,
          ),
          InkWell(
              onTap: () {
                ///change language
                languageProvider.changeLanguage("ar");
                Navigator.pop(context);
              },
              child: languageProvider.appLanguage == "ar"
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary),
        Icon(
          Icons.check,
          color: AppColors.primaryLight,
          size: 30,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(text, style: AppStyles.bold20Black);
  }
}
