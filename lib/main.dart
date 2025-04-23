import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/utils/routes/app_router.dart';
import 'package:media_design_assingment_app/utils/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Setting the orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ToastificationWrapper(
        config: const ToastificationConfig(clipBehavior: Clip.antiAlias),
        child: MaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          //For context less navigation
          navigatorKey: AppRouter.key,
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.generateRoutes,
        ),
      ),
    );
  }
}
