import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_qu.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('qu'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Narino Travel Food'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get writeReview;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @kichwa.
  ///
  /// In en, this message translates to:
  /// **'Kichwa'**
  String get kichwa;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet.'**
  String get noReviews;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Add your review'**
  String get addReview;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @verifyingAuth.
  ///
  /// In en, this message translates to:
  /// **'Verifying authentication...'**
  String get verifyingAuth;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get authError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @mainScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get mainScreenTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @destinations.
  ///
  /// In en, this message translates to:
  /// **'Destinations'**
  String get destinations;

  /// No description provided for @aboutDestination.
  ///
  /// In en, this message translates to:
  /// **'About the Destination'**
  String get aboutDestination;

  /// No description provided for @historyAndInfo.
  ///
  /// In en, this message translates to:
  /// **'History and Relevant Information'**
  String get historyAndInfo;

  /// No description provided for @featuredActivities.
  ///
  /// In en, this message translates to:
  /// **'Featured Activities'**
  String get featuredActivities;

  /// No description provided for @reviewsAndOpinions.
  ///
  /// In en, this message translates to:
  /// **'Reviews and Opinions'**
  String get reviewsAndOpinions;

  /// No description provided for @reviewsAndRatings.
  ///
  /// In en, this message translates to:
  /// **'Reviews and Ratings'**
  String get reviewsAndRatings;

  /// No description provided for @yourReview.
  ///
  /// In en, this message translates to:
  /// **'Your review'**
  String get yourReview;

  /// No description provided for @writeReviewShort.
  ///
  /// In en, this message translates to:
  /// **'Write Review'**
  String get writeReviewShort;

  /// No description provided for @editReview.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReview;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @shareExperience.
  ///
  /// In en, this message translates to:
  /// **'Be the first to share your experience!'**
  String get shareExperience;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @loginToReview.
  ///
  /// In en, this message translates to:
  /// **'Log in to write a review'**
  String get loginToReview;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get greeting;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @otherVisitorsReviews.
  ///
  /// In en, this message translates to:
  /// **'Other visitors\' reviews'**
  String get otherVisitorsReviews;

  /// No description provided for @showAllReviews.
  ///
  /// In en, this message translates to:
  /// **'Show all reviews'**
  String get showAllReviews;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @popularDestinations.
  ///
  /// In en, this message translates to:
  /// **'Popular Destinations'**
  String get popularDestinations;

  /// No description provided for @featuredRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Featured Restaurants'**
  String get featuredRestaurants;

  /// No description provided for @narinoTouristDestinations.
  ///
  /// In en, this message translates to:
  /// **'Nariño Tourist Destinations'**
  String get narinoTouristDestinations;

  /// No description provided for @narinoGastronomy.
  ///
  /// In en, this message translates to:
  /// **'Nariño Gastronomy'**
  String get narinoGastronomy;

  /// No description provided for @whatAreYouLookingFor.
  ///
  /// In en, this message translates to:
  /// **'What would you like to find?'**
  String get whatAreYouLookingFor;

  /// No description provided for @searchNarino.
  ///
  /// In en, this message translates to:
  /// **'Search for destinations, restaurants and more in Nariño'**
  String get searchNarino;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @dateAdded.
  ///
  /// In en, this message translates to:
  /// **'Date added'**
  String get dateAdded;

  /// No description provided for @ascendingOrder.
  ///
  /// In en, this message translates to:
  /// **'Ascending order'**
  String get ascendingOrder;

  /// No description provided for @clearFavorites.
  ///
  /// In en, this message translates to:
  /// **'Clear favorites'**
  String get clearFavorites;

  /// No description provided for @confirmClearFavorites.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all your favorites?'**
  String get confirmClearFavorites;

  /// No description provided for @myFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get myFavorites;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @shareFavorites.
  ///
  /// In en, this message translates to:
  /// **'Share favorites'**
  String get shareFavorites;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'You have no favorites yet'**
  String get noFavorites;

  /// No description provided for @exploreAndSave.
  ///
  /// In en, this message translates to:
  /// **'Explore amazing destinations and restaurants\nand save your favorites!'**
  String get exploreAndSave;

  /// No description provided for @explorePlaces.
  ///
  /// In en, this message translates to:
  /// **'Explore places'**
  String get explorePlaces;

  /// No description provided for @noResultsFoundDestinations.
  ///
  /// In en, this message translates to:
  /// **'No destinations found'**
  String get noResultsFoundDestinations;

  /// No description provided for @noResultsFoundRestaurants.
  ///
  /// In en, this message translates to:
  /// **'No restaurants found'**
  String get noResultsFoundRestaurants;

  /// No description provided for @tryOtherSearchTerms.
  ///
  /// In en, this message translates to:
  /// **'Try other search terms'**
  String get tryOtherSearchTerms;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'removed from favorites'**
  String get removedFromFavorites;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @restaurantNoName.
  ///
  /// In en, this message translates to:
  /// **'Restaurant without name'**
  String get restaurantNoName;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Discover destinations, restaurants and unique experiences'**
  String get tagline;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @noAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountQuestion;

  /// No description provided for @registerHere.
  ///
  /// In en, this message translates to:
  /// **'Sign up here'**
  String get registerHere;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with that email.'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get wrongPassword;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Sign-in error'**
  String get loginError;

  /// No description provided for @googleSignInError.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In error'**
  String get googleSignInError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @registerAccount.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// No description provided for @haveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountQuestion;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInLink;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDontMatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get passwordTooShort;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get weakPassword;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailInUse;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Format error: the email address is not valid.'**
  String get invalidEmail;

  /// No description provided for @registerError.
  ///
  /// In en, this message translates to:
  /// **'Registration error'**
  String get registerError;

  /// No description provided for @aboutRestaurant.
  ///
  /// In en, this message translates to:
  /// **'About the Restaurant'**
  String get aboutRestaurant;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get viewOnMap;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @shareDestination.
  ///
  /// In en, this message translates to:
  /// **'Share destination'**
  String get shareDestination;

  /// No description provided for @shareRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Share restaurant'**
  String get shareRestaurant;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'added to favorites'**
  String get addedToFavorites;

  /// No description provided for @couldNotOpenMap.
  ///
  /// In en, this message translates to:
  /// **'Could not open the map'**
  String get couldNotOpenMap;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search destinations, restaurants...'**
  String get searchHint;

  /// No description provided for @searchFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Search in favorites...'**
  String get searchFavoritesHint;

  /// No description provided for @favoritesCleared.
  ///
  /// In en, this message translates to:
  /// **'Favorites removed'**
  String get favoritesCleared;

  /// No description provided for @mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Nariño Map'**
  String get mapTitle;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get myLocation;

  /// No description provided for @viewDestination.
  ///
  /// In en, this message translates to:
  /// **'View destination'**
  String get viewDestination;

  /// No description provided for @calculatingDistance.
  ///
  /// In en, this message translates to:
  /// **'Calculating distance...'**
  String get calculatingDistance;

  /// No description provided for @nearbyDestinations.
  ///
  /// In en, this message translates to:
  /// **'Nearby Destinations'**
  String get nearbyDestinations;

  /// No description provided for @noNearbyDestinations.
  ///
  /// In en, this message translates to:
  /// **'No nearby destinations found'**
  String get noNearbyDestinations;

  /// No description provided for @loadingMap.
  ///
  /// In en, this message translates to:
  /// **'Loading map...'**
  String get loadingMap;

  /// No description provided for @perPerson.
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get perPerson;

  /// No description provided for @restaurantDetails.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Details'**
  String get restaurantDetails;

  /// No description provided for @descriptionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Description not available.'**
  String get descriptionUnavailable;

  /// No description provided for @addressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Address not available'**
  String get addressUnavailable;

  /// No description provided for @nameUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Name not available'**
  String get nameUnavailable;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get viewAll;

  /// No description provided for @allDestinationsTitle.
  ///
  /// In en, this message translates to:
  /// **'All Nariño Destinations'**
  String get allDestinationsTitle;

  /// No description provided for @searchInNarino.
  ///
  /// In en, this message translates to:
  /// **'Search in Nariño'**
  String get searchInNarino;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @tryOtherKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try other keywords'**
  String get tryOtherKeywords;

  /// No description provided for @activitiesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 activity} other{{count} activities}}'**
  String activitiesCount(int count);

  /// No description provided for @destinationsCount.
  ///
  /// In en, this message translates to:
  /// **'Destinations ({count})'**
  String destinationsCount(int count);

  /// No description provided for @restaurantsCount.
  ///
  /// In en, this message translates to:
  /// **'Restaurants ({count})'**
  String restaurantsCount(int count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'pt', 'qu', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'pt': return AppLocalizationsPt();
    case 'qu': return AppLocalizationsQu();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
