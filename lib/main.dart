import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdp2/bindings/general_bindings.dart';
import 'package:sdp2/data/repositories/seller/seller_repository.dart';
import 'package:sdp2/routes/app_routes.dart';
import 'package:sdp2/utils/themes/theme.dart';

import 'common/widgets/multi_language/locall_string.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'common/splash_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
  await GetStorage.init();

  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'sdp2-bf09c',
  ).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  //cloudinary
  
  Get.put(SellerRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: const Locale('en', 'US'),
      title: 'SDP 2',
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      // darkTheme: MyAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const SplashView(),
    );
  }
}
