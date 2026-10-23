import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/audio_player_widget.dart';
import 'core/auth/auth_provider.dart';
import 'core/bootstrap/bootstrap_provider.dart';
import 'core/catalog/catalog_provider.dart';
import 'core/content/chapters_provider.dart';
import 'core/favorites/favorites_provider.dart';
import 'core/network/api_client.dart';
import 'core/repositories/auth_repository.dart';
import 'core/repositories/catalog_repository.dart';
import 'core/repositories/content_repository.dart';
import 'core/repositories/favorites_repository.dart';
import 'core/storage/token_store.dart';
import 'core/team/team_provider.dart';
import 'routes/app_routes.dart';
import 'services/audio_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStore = TokenStore();
  final apiClient = ApiClient(tokenStore: tokenStore);
  final authRepository = AuthRepository(api: apiClient);
  final contentRepository = ContentRepository(api: apiClient);
  final catalogRepository = CatalogRepository(api: apiClient);
  final favoritesRepository = FavoritesRepository(api: apiClient);

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        Provider<AuthRepository>.value(value: authRepository),
        Provider<ContentRepository>.value(value: contentRepository),
        Provider<CatalogRepository>.value(value: catalogRepository),
        Provider<FavoritesRepository>.value(value: favoritesRepository),
        ChangeNotifierProvider<AudioService>(
          create: (_) => AudioService(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            auth: authRepository,
            tokenStore: tokenStore,
            api: apiClient,
          )..ensureInitialized(),
        ),
        ChangeNotifierProvider<BootstrapProvider>(
          create: (_) => BootstrapProvider(
            content: contentRepository,
            catalog: catalogRepository,
          )..ensureLoaded(),
        ),
        ChangeNotifierProvider<ChaptersProvider>(
          create: (_) => ChaptersProvider(content: contentRepository),
        ),
        ChangeNotifierProvider<CatalogProvider>(
          create: (_) => CatalogProvider(
            content: contentRepository,
            catalog: catalogRepository,
          ),
        ),
        ChangeNotifierProvider<TeamProvider>(
          create: (_) => TeamProvider(content: contentRepository),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(favorites: favoritesRepository),
        ),
      ],
      child: const SaiVaniApp(),
    ),
  );
}

class SaiVaniApp extends StatelessWidget {
  const SaiVaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget(
      child: MaterialApp(
        title: 'Sai Vani',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
