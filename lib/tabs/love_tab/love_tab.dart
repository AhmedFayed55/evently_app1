import 'package:evently_app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../model/event.dart';
import '../../providers/event_list_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/assets_manager.dart';
import '../home_tab/event_item_widget.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final eventListProvider =
          context.read<EventListProvider>(); // get data dont rebuild
      final favoriteProvider =
          context.read<FavoriteProvider>(); // get data dont rebuild
      // todo: loop through events and update
      favoriteProvider.updateFavorites(eventListProvider.eventsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
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
              child: favoriteProvider.favoriteEvents.isEmpty
                  ? Center(child: Lottie.asset("assets/lotties/event.json"))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          onIconPressed: () => onIconPressed(
                              favoriteProvider.favoriteEvents[index]),
                          event: favoriteProvider.favoriteEvents[index],
                        );
                      },
                      itemCount: favoriteProvider.favoriteEvents.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  onIconPressed(Event event) {
    event.isFavorite = !event.isFavorite;

    var eventListProvider = context.read<EventListProvider>();
    var favoriteProvider = context.read<FavoriteProvider>();
    // todo: update fav
    favoriteProvider.updateFavorites(eventListProvider.eventsList);

    setState(() {});
  }
}
