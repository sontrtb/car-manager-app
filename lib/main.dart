import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/models/user.dart';
import 'package:car_manager_app/screens/auth/login.dart';
import 'package:car_manager_app/screens/auth/register.dart';
import 'package:car_manager_app/screens/auth/update_infor_user.dart';
import 'package:car_manager_app/screens/bottom_tab/bottom_tab.dart';
import 'package:car_manager_app/screens/car/car_detail.dart';
import 'package:car_manager_app/screens/car/map_all_car.dart';
import 'package:car_manager_app/user/user_detail.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    primary: const Color.fromRGBO(121, 122, 236, 1),
    seedColor: const Color.fromRGBO(121, 122, 236, 1),
  ),
);

void main() {
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
        '/all_car': (context) => const MapAllCar(),
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
        if (settings.name == UserDetail.routeName) {
          final args = settings.arguments as UserDetailArguments;

          return MaterialPageRoute(
            builder: (context) {
              return UserDetail(user: args.user);
            },
          );
        }
        return null;
      },
    );
  }
}
