import 'package:flutter/material.dart';

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

  @override
  initState() {
    _controller = TextEditingController(text: '');
    _controller2 = TextEditingController(text: '');
    seleccionado = false;
    carrera = '';
    pais = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50),
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
                    print("Esta es mi edad: $valor");
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
                        print("Formulario validado");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Formulario validado"),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        print("Formulario no validado");
                      }
                    }),
                const SizedBox(width: 8),
                OutlinedButton(child: const Text("Segundo"), onPressed: () {}),
                // const SizedBox(width: 8),
                // ElevatedButton(child: const Text("Tercero"), onPressed: () {}),
                const SizedBox(width: 8),
                GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text("Cuarto")),
                    onTap: () {
                      print("Presionado simple");
                    },
                    onDoubleTap: () {
                      print("Presionado doble");
                    },
                    onLongPress: () {
                      print("Presionado largo");
                    })
              ])
            ])));
  }
}
