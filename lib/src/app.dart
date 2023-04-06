import 'package:flutter/material.dart';
import 'package:pokemon/src/providers/home_provider.dart';
import 'package:pokemon/src/routes/routes.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FindPokemon',
        initialRoute: '/',
        routes: getRoutes(),
      ),
    );
  }
}
