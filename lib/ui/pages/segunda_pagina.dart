import 'package:flutter/material.dart';
import 'package:flutter_first_app/core/models/persona.dart';

class SegundaPaginaArgumentos {
  final Persona? usuario;
  final bool esNuevo;
  SegundaPaginaArgumentos({this.usuario, this.esNuevo = false});
}

class SegundaPagina extends StatefulWidget {
  final Persona? usuario;
  final bool esNuevo;
  const SegundaPagina({super.key, this.usuario, this.esNuevo = false});

  @override
  State<SegundaPagina> createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  @override
  Widget build(BuildContext context) {
    SegundaPaginaArgumentos argumentos;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argumentos =
          ModalRoute.of(context)?.settings.arguments as SegundaPaginaArgumentos;
    } else {
      argumentos = SegundaPaginaArgumentos();
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Segunda pagina'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })),
      //onPressed: () => Navigator.of(context).pop(context))), otra forma de hacerlo
      body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/cachorros.jpg'),
                )),
              ),
              //Text(widget.usuario?.nombre ?? 'Sin nombre', style: const TextStyle(fontSize: 20)),
              Text(argumentos.usuario?.nombre ?? 'Sin nombre',
                  style: const TextStyle(fontSize: 20)),
              //Text(widget.usuario?.edad.toString() ?? 'Sin edad', style: const TextStyle(fontSize: 20)),
              Text(argumentos.usuario?.edad.toString() ?? 'Sin edad',
                  style: const TextStyle(fontSize: 20)),
              SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.network(
                      'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcQOO0X7mMnoYz-e9Zdc6Pe6Wz7Ow1DcvhEiaex5aSv6QJDoCtcooqA7UUbjrphvjlIc'))
              //Image.asset('assets/gatito-cesped_0.jpg')),
            ],
          )),
    );
  }
}
