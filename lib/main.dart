import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/screens/auth/login.dart';
import 'package:car_manager_app/screens/auth/register.dart';
import 'package:car_manager_app/screens/auth/update_infor_user.dart';
import 'package:car_manager_app/screens/bottom_tab/bottom_tab.dart';
import 'package:car_manager_app/screens/car/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final theme = ThemeData(
  // useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 136, 249, 174),
  ),
);

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: '/bottom_tab',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        'update_infor_user': (context) => const UpdateInforUser(),
        '/bottom_tab': (context) => const BottomTab(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CarDetail.routeName) {
          final args = settings.arguments as CarDetailArguments;

          return MaterialPageRoute(
            builder: (context) {
              return CarDetail(initCar: args.car);
            },
          );
        }
        return null;
      },
    );
  }
}
