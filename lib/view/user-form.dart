import 'package:bank/view/contact-list.dart';
import 'package:bank/view/home.dart';
import 'package:bank/view/initial.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'name': '',
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color buttonColor = Color(0xFFf9413f); // #F9413F
    double buttonWidth = screenWidth * 0.8; // Adjust as needed

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Indicações', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 16), // Adjust top padding as needed
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['name'] = value!;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu email';
                  }
                  // You can add more email validation logic if needed
                  return null;
                },
                onSaved: (value) {
                  _formData['email'] = value!;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite sua senha';
                  }
                  // You can add more password validation logic if needed
                  return null;
                },
                onSaved: (value) {
                  _formData['password'] = value!;
                },
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: buttonWidth * 0.3, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
               Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Initial();
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: buttonColor),
                  ),
                ),
                child: Text(
                  'Voltar',
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

 void _saveForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Dados a serem enviados para a API
    Map<String, dynamic> data = {
      'name': _formData['name'],
      'email': _formData['email'],
      'password': _formData['password'],
    };

    // URL da API para verificar se o email já existe
    String checkEmailUrl = 'http://172.174.204.171:5000/users?email=${_formData['email']}';

    try {
      // Faz a consulta para verificar se o email já existe
      http.Response emailCheckResponse = await http.get(Uri.parse(checkEmailUrl));

      if (emailCheckResponse.statusCode == 200) {
        // Se o email já existe, exibe um diálogo de erro
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro no cadastro'),
              content: Text('Já existe um usuário com esse email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (emailCheckResponse.statusCode == 404) {
        // Se o email não existe, continua com o envio dos dados
        String apiUrl = 'http://172.174.204.171:5000/users';

        // Envia uma requisição POST para a API
        http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        );

        // Verifica o código de status da resposta
        if (response.statusCode == 201) {
          // Sucesso - lógica de sucesso aqui
          print('Requisição bem-sucedida');
          print('Resposta da API: ${response.body}');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Home();
            }),
          );
        } else {
          // Se a resposta não for bem-sucedida, trata o erro aqui
          print('Erro na requisição: ${response.statusCode}');
          print('Resposta da API: ${response.body}');
          // Adicione lógica de tratamento de erro aqui
        }
      } else {
        // Trata outros códigos de status da resposta da verificação de email
        print('Erro na verificação de email: ${emailCheckResponse.statusCode}');
        print('Resposta da API: ${emailCheckResponse.body}');
        // Adicione lógica de tratamento de erro aqui
      }
    } catch (error) {
      // Trata erros de conexão ou outros erros durante a requisição
      print('Erro durante a requisição: $error');
      // Adicione lógica de tratamento de erro aqui
    }
  }
}
}