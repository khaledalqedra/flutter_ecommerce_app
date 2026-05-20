# Flutter E-Commerce App

## Project Overview
A Flutter e-commerce application with Firebase backend and BLoC/Cubit state management.

## Tech Stack
- **Flutter** 3.36 (Channel beta), Dart SDK ^3.5.4
- **State Management:** flutter_bloc ^9.1.1 (Cubit pattern)
- **Backend:** Firebase (Auth, Cloud Firestore)
- **Auth:** firebase_auth ^6.1.4, google_sign_in ^6.2.1, flutter_facebook_auth ^7.1.6
- **UI:** cached_network_image, flutter_carousel_widget, main_persistent_bottom_nav_bar_v2
- **Splash:** flutter_native_splash (deep purple `#673AB7`)

## Project Structure
```
lib/
├── main.dart                        # App entry, Firebase init, auth gate
├── firebase_options.dart            # FlutterFire generated config
├── models/                          # Pure data classes with toMap/fromMap
├── services/
│   ├── auth_services.dart           # AuthServices abstract + AuthServicesImpl
│   └── firestore_services.dart      # FirestoreServices singleton (CRUD + streams)
├── view_models/
│   ├── auth_cubit/                  # AuthCubit + AuthState
│   ├── home_cubit/                  # HomeCubit + HomeState
│   ├── product_details_cubit/
│   ├── cart_cubit/
│   ├── checkout_cubit/
│   ├── choose_location_cubit/
│   └── add_new_card/                # PaymentMethodsCubit
├── views/
│   ├── pages/                       # Full screens
│   └── widgets/                     # Reusable components
└── utils/
    ├── app_colors.dart              # AppColors constants
    ├── app_routes.dart              # Route name constants
    └── api.paths.dart               # ApiPaths static methods (Firestore paths)
```

## Architecture Conventions

### State Management
- One Cubit per feature; states defined in a `part` file (`*_state.dart`) alongside the cubit.
- States use `sealed class` with `final class` subtypes.
- Cubits depend on services via direct instantiation (not injected).

### Services
- `AuthServices` is an abstract class; `AuthServicesImpl` is the concrete implementation.
- `FirestoreServices` is a singleton accessed via `FirestoreServices.instance`.
- All `AuthServices` methods that return a result must return `Future<bool>` (not `Future<void>`).

### Firestore Paths
All Firestore document/collection paths are defined as static methods in `ApiPaths`:
```dart
ApiPaths.users(userId)           // users/{userId}
ApiPaths.cartItems(userId)       // users/{userId}/cart/
ApiPaths.cartItem(userId, id)    // users/{userId}/cart/{id}
ApiPaths.locations(userId)       // users/{userId}/locations/
ApiPaths.paymentCards(userId)    // users/{userId}/paymentCards/
ApiPaths.favoriteProducts(userId)// users/{userId}/favorites/
ApiPaths.products()              // products/
```

### Navigation
- Named routes defined in `AppRoutes` constants.
- `AppRouter.onGenerateRoute` handles all route creation with Cubit provisioning.
- Bottom nav shell: `CustomBottomNavbar` (home, cart, favorites, profile tabs).
- Auth gate in `main.dart`: redirects to `homeRoute` if `AuthDone`, else `loginRoute`.

### UI
- Primary color: `Colors.deepPurple` (`AppColors.primary`)
- Material 3 theme via `ColorScheme.fromSeed`
- Reusable widgets: `MainBotton`, `LabelWithTextField`, `SocialMediaButton`

## Android Build Notes
- `android/app/build.gradle` uses `flutter.minSdkVersion` (not `localProperties`)
- AGP version: 8.6.0, Kotlin: 2.1.0
- Google Services plugin: 4.3.15

## Known Limitations
- Home data (`HomeCubit`) uses dummy/hardcoded data — not yet wired to Firestore.
- Facebook login button exists in UI but `onTap` is not implemented.
- Forgot Password button exists in UI but is not implemented.
- Splash screen image may fail to decode on Android emulator (non-fatal, software renderer limitation).
