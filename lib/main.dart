import 'package:flutter/material.dart';
import 'package:pontos_turisticos/page/filtro_page.dart';
import 'package:pontos_turisticos/page/tela_principal_page.dart';

void main() {
  runApp(const PontosTuristicos());
}

class PontosTuristicos extends StatelessWidget {
  const PontosTuristicos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pontos turísticos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TelaPrincipalPage(),
      routes: {
        FiltroPage.routeName: (BuildContext context) => FiltroPage()
      },
    );
  }

}
