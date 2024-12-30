import 'package:evently_app/custom_widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.043),
        child: Column(
          children: [
            CustomTextField(
              style: AppStyles.bold14Primary,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Image.asset(AssetsManager.search),
              hintText: AppLocalizations.of(context)!.search_for_event,
              borderColor: AppColors.primaryLight,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox();
                  //EventItemWidget();
                },
                itemCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
