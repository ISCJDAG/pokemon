import 'package:pokemon/src/pages/home_paage.dart';
import 'package:pokemon/src/pages/splash_page.dart';

getRoutes() {
  return {
    '/': (context) => SplashPage(),
    '/home': (context) => HomePage(),
  };
}
