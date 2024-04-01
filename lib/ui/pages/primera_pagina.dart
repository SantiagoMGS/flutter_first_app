import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/core/controllers/persona_controller.dart';
import 'package:flutter_first_app/core/models/persona.dart';
import 'package:flutter_first_app/ui/pages/segunda_pagina.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FormularioPagina extends StatefulWidget {
  const FormularioPagina({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioPaginaState();
  }
}

class FormularioPaginaState extends State<FormularioPagina> {
  final _formKey = GlobalKey<FormState>();

  List<String> paises = ['Colombia', 'Peru', 'Argentina', 'Bolivia'];
  //textField
  late TextEditingController _controller;
  late TextEditingController _controller2;

  late bool seleccionado;
  late String carrera;
  late String? pais;
  late String respuesta;

  final Persona persona = Persona(nombre: 'Santiago Martinez', edad: 27);

  final hiveStore = Hive.box('hiveStore');
  late final SharedPreferences preferencesStore;

  void initSharedPreferences() async {
    preferencesStore = await SharedPreferences.getInstance();
    var carreraPrefs = preferencesStore.getString('carrera') ?? '';
    setState(() {
      carrera = carreraPrefs;
    });
  }

  @override
  initState() {
    initSharedPreferences();
    _controller =
        TextEditingController(text: hiveStore.get('nombre', defaultValue: ''));
    _controller2 =
        TextEditingController(text: hiveStore.get('edad', defaultValue: ''));
    seleccionado = false;
    carrera = '';
    pais = null;
    respuesta = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ej. Santiago Martinez',
                    label: Text('Nombre Completo')),
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _controller2,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ej. 25',
                      label: Text('Edad')),
                  onChanged: (valor) {
                    if (kDebugMode) {
                      print("Esta es mi edad: $valor");
                    }
                  },
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Por favor ingrese su edad';
                    }
                    return null;
                  }),
              ListTile(
                  title: const Text("Eres nuevo programador"),
                  subtitle: const Text("Selecciona si eres nuevon"),
                  leading: Checkbox(
                      value: seleccionado,
                      onChanged: (value) {
                        //Actualizar estado de Widget
                        setState(() {
                          if (value != null) {
                            seleccionado = value;
                          }
                        });
                      })),
              const Text("Selecciona tu carreara"),
              ListTile(
                  title: const Text("Informatica"),
                  trailing: Radio(
                      groupValue: carrera,
                      value: 'Informatica',
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            carrera = value;
                          }
                        });
                      })),
              ListTile(
                  title: const Text("Electronica"),
                  trailing: Radio(
                      groupValue: carrera,
                      value: 'Electronica',
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            carrera = value;
                          }
                        });
                      })),
              const Text("Selecciona tu país"),
              DropdownButton<String>(
                  value: pais,
                  items: paises.map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        pais = value;
                      }
                    });
                  }),
              Row(children: [
                TextButton(
                    child: const Text("Validar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (carrera.isEmpty || pais == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Por favor selecciona carrera y pais"),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }
                        hiveStore.put('nombre', _controller.value.text);
                        hiveStore.put('edad', _controller2.value.text);
                        //hiveStore.put('carrera', carrera);
                        preferencesStore.setString('carrera', carrera);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Datos almacenados correctamente"),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        print("Formulario no validado");
                      }
                    }),
                const SizedBox(width: 8),
                OutlinedButton(
                    child: const Text("Segundo"),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SegundaPagina(
                      //               usuario: persona,
                      //               esNuevo: true,
                      //             ))); // Navegacion con parametros usando MaterialPageRoute
                      final controlador = PersonaController(persona);
                      controlador.cambiarNombre('Poderosisimo jesus');
                      Navigator.pushNamed(context, 'segunda_pagina',
                          arguments: SegundaPaginaArgumentos(
                              usuario: persona, esNuevo: true));
                    }),
                const SizedBox(width: 8),
                ElevatedButton(child: const Text("Tercero"), onPressed: () {}),
                const SizedBox(width: 8),
                GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text("Cuarto")),
                    onTap: () async {
                      var url = Uri.parse(
                          'https://jsonplaceholder.typicode.com/todos/1');
                      var response = await http.get(url);
                      var json = jsonDecode(response.body);
                      setState(() {
                        respuesta = json['title'];
                      });
                      print(response.body);
                    },
                    onDoubleTap: () {
                      print("Presionado doble");
                    },
                    onLongPress: () {
                      print("Presionado largo");
                    }),
              ]),
              Text(respuesta),
            ])));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    hiveStore.close();
    super.dispose();
  }
}
