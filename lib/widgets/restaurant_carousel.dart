import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
import 'package:narino_travel_food/models/restaurant.dart';
import 'package:narino_travel_food/pages/restaurant_page.dart';
import 'package:narino_travel_food/services/translation_service.dart';
import 'animated_favorite_button.dart';

class RestaurantCarousel extends StatefulWidget {
  const RestaurantCarousel({super.key});

  @override
  State<RestaurantCarousel> createState() => _RestaurantCarouselState();
}

class _RestaurantCarouselState extends State<RestaurantCarousel> {
  List<String?> _translatedNames = List.filled(restaurants.length, null);
  Locale? _lastLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleLocaleChange();
  }

  Future<void> _handleLocaleChange() async {
    final locale = Localizations.localeOf(context);
    if (_lastLocale == locale) return;
    _lastLocale = locale;
    final isEnglish = locale.languageCode == 'en';
    if (isEnglish) {
      for (int i = 0; i < restaurants.length; i++) {
        final name = restaurants[i].name ?? '';
        final nameTr = await TranslationService.translateText(name, 'es', 'en');
        setState(() {
          _translatedNames[i] = nameTr;
        });
      }
    } else {
      setState(() {
        _translatedNames = List.filled(restaurants.length, null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.narinoGastronomy,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('Ver todos'),
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (BuildContext context, int index) {
              Restaurant restaurant = restaurants[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantPage(
                      restaurant: restaurant,
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  width: 200.0,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          children: [
                            Image(
                              height: 140.0,
                              width: 200.0,
                              image: AssetImage(restaurant.imageUrl ?? ''),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: RestaurantFavoriteButton(
                                restaurant: restaurant,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 60.0,
                          maxHeight: 90.0,
                          minWidth: 200.0,
                          maxWidth: 200.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _translatedNames[index] ??
                                    restaurant.name ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Flexible(
                                child: Text(
                                  restaurant.address ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
