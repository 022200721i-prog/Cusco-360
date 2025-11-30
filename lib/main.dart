import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/festivities_screen.dart';
import 'sitios_arqueologicos/screens/sitios_screen.dart';

void main() {
  runApp(const Cusco360App());
}

class Cusco360App extends StatelessWidget {
  const Cusco360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cusco 360',
      home: const HomeScreen(),
      // Agrega estas rutas nombradas
      routes: {
        '/home': (context) => const HomeScreen(),
        '/festivities': (context) => const FestivitiesScreen(),
        '/sitios': (context) => const SitiosScreen(),
      },
    );
  }
}