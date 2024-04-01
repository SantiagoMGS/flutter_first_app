import 'package:flutter/material.dart';
import 'package:flutter_first_app/ui/pages/primera_pagina.dart';
import 'package:flutter_first_app/ui/pages/segunda_pagina.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        //useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'primera_pagina': (context) => const FormularioPagina(),
        'segunda_pagina': (context) => const SegundaPagina(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario"),
        ),
        body: const Center(
          child: FormularioPagina(),
        ),
      ),
    );
  }
}
