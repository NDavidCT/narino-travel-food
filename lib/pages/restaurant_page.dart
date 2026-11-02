// Pantalla de detalle para restaurantes típicos
// Muestra información, menú, favoritos y reseñas del restaurante
import '../services/translation_service.dart';
import 'package:narino_travel_food/services/content_translations_qu.dart';
import 'package:narino_travel_food/services/name_translations.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:narino_travel_food/models/restaurant.dart';
import 'package:narino_travel_food/services/favorites_service.dart';
import 'package:narino_travel_food/widgets/reviews_section.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class RestaurantPage extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantPage({super.key, this.restaurant});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  String? _translatedDescription;
  Locale? _lastLocale;
  final FavoritesService _favoritesService = FavoritesService();
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
          parent: _heartAnimationController, curve: Curves.elasticOut),
    );
    _favoritesService.initialize();
    // Configurar locale español para timeago
    timeago.setLocaleMessages('es', timeago.EsMessages());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleLocaleChange();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleLocaleChange();
  }

  Future<void> _handleLocaleChange() async {
    final locale = Localizations.localeOf(context);
    if (_lastLocale == locale) return;
    _lastLocale = locale;
    final target = TranslationService.googleCode(locale.languageCode);
    final isEnglish = target != null;
    if (locale.languageCode == 'qu' && widget.restaurant != null) {
      setState(() {
        _translatedDescription =
            kichwaTexts[widget.restaurant!.description ?? ''];
      });
    } else if (isEnglish && widget.restaurant != null) {
      final descTr = await TranslationService.translateText(
          widget.restaurant!.description ?? '', 'es', target);
      if (!mounted) return;
      setState(() {
        _translatedDescription = descTr.isEmpty ? null : descTr;
      });
    } else {
      setState(() {
        _translatedDescription = null;
      });
    }
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    if (widget.restaurant == null) return;

    bool wasAdded =
        await _favoritesService.toggleRestaurantFavorite(widget.restaurant!);

    if (wasAdded) {
      _heartAnimationController.forward().then((_) {
        _heartAnimationController.reverse();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${widget.restaurant!.name} ${AppLocalizations.of(context)!.addedToFavorites} ❤️'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${widget.restaurant!.name} ${AppLocalizations.of(context)!.removedFromFavorites}'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.undo,
            onPressed: () {
              _favoritesService.addRestaurantToFavorites(widget.restaurant!);
            },
          ),
        ),
      );
    }
  }

  void _shareRestaurant() {
    if (widget.restaurant == null) return;

    final shareText = '''
🍽️ ${widget.restaurant!.name} - Nariño, Colombia

📍 ${widget.restaurant!.address ?? 'Restaurante en Nariño'}

${widget.restaurant!.description ?? 'Deliciosa gastronomía nariñense'}

⭐ Calificación: ${widget.restaurant!.rating ?? 0}/5

📱 Descarga Nariño Travel & Food y descubre más restaurantes increíbles en Nariño 🇨🇴
    ''';

    Share.share(shareText,
        subject: '${widget.restaurant!.name} - Nariño Travel & Food');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant?.name != null
            ? localizedName(context, widget.restaurant!.name)
            : AppLocalizations.of(context)!.restaurantDetails),
        // --- BOTONES DE FAVORITOS Y COMPARTIR ---
        actions: <Widget>[
          // Botón de favoritos con animación
          AnimatedBuilder(
            animation: _favoritesService,
            builder: (context, child) {
              bool isFavorite = widget.restaurant != null
                  ? _favoritesService
                      .isRestaurantFavorite(widget.restaurant!.name ?? '')
                  : false;
              return ScaleTransition(
                scale: _heartAnimation,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: _toggleFavorite,
                  tooltip: isFavorite
                      ? 'Quitar de favoritos'
                      : 'Agregar a favoritos',
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareRestaurant,
            tooltip: AppLocalizations.of(context)!.shareRestaurant,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Contenedor principal con la imagen de fondo
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.restaurant?.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Botón de regreso (ya estaba aquí y lo dejamos)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.restaurant?.name != null
                        ? localizedName(context, widget.restaurant!.name)
                        : AppLocalizations.of(context)!.nameUnavailable,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.restaurant?.address ??
                        AppLocalizations.of(context)!.addressUnavailable,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.aboutRestaurant,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _translatedDescription ??
                        widget.restaurant?.description ??
                        AppLocalizations.of(context)!.descriptionUnavailable,
                    style: const TextStyle(fontSize: 16),
                  ),

                  // SECCIÓN DE RESEÑAS
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!.reviewsAndOpinions,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReviewsSection(
                    placeId: widget.restaurant?.name ?? '',
                    placeName: widget.restaurant?.name ?? 'Restaurante',
                  ),

                  // Espacio extra al final
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
