import 'package:bank/view/approved.dart';
import 'package:bank/view/home.dart';
import 'package:bank/view/negative.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardioForm extends StatefulWidget {
  @override
  _CardioFormState createState() => _CardioFormState();
}

class _CardioFormState extends State<CardioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'idade': '',
    'sexo': 1, // 1 = masculino; 0 = feminino
    'tipoDorPeito': 0,
    'pressaoRepouso': '',
    'colesterolSeric': '',
    'acucarJejum': '',
    'resultadosEletro': 0,
    'freqCardiacaMax': '',
    'anginaInduzida': 1, // 1 = sim; 0 = não
    'picoAntigo': '',
    'inclinaPicoST': 0,
    'numVasosColoridos': 0,
    'tal': 0,
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
        title: Text('Realizando a verificação', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(16, 20, 16, 16), // Adjust top padding as needed
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Qual a sua idade?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua idade';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['idade'] = value!;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['sexo'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Feminino'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['sexo'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Qual o sexo?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['tipoDorPeito'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Dor no peito típica (Angina)'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Dor no peito atípica (outro tipo)'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Dor no peito não relacionada ao coração'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Sem sintomas de dor no peito'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['tipoDorPeito'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Qual tipo de dor no peito?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Qual a pressão arterial em repouso',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a pressão arterial em repouso';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['pressaoRepouso'] = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Qual o colesterol sérico? (em mg/dl)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o colesterol sérico';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['colesterolSeric'] = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Qual o valor do açúcar em jejum? (120 mg/dl)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o valor de açúcar no sangue em jejum';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['acucarJejum'] = value!;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['resultadosEletro'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text(
                          'Não há anormalidades significativas'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(
                          'Existe presença leves'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(
                          'Existe presença de anormalidades '),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['resultadosEletro'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Qual o resultado do eletrocardiográficos em repouso?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Qual a frequência cardíaca máxima alcançada?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a frequência cardíaca máxima alcançada';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['freqCardiacaMax'] = value!;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['anginaInduzida'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Sim'),
                    ),
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Não'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['anginaInduzida'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Na prática de atividade física, você sente dor no peito?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        'Ponto mais alto que o coração diminuiu o ritmo no exercício?(0.0 - 6.5)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o valor para o pico antigo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['picoAntigo'] = value!;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['inclinaPicoST'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Inclinação descendente'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Inclinação plana'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Inclinação ascendente'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['inclinaPicoST'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Na prática de atividade física, há aceleração dos batimentos cardíacos?',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['numVasosColoridos'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('0'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('1'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('2'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('3'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['numVasosColoridos'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Qual o número de vasos principais coloridos por fluorosopia? (0-3)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _formData['tal'],
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Não possuo'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Sim'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Defeito reversível'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _formData['tal'] = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Possui condição pré-existente? ',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: buttonWidth * 0.3, vertical: 16),
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
                      Navigator.pop(context);
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
      ),
    );
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Dados a serem enviados para a API
      Map<String, dynamic> data = {
        'age': _formData['idade'],
        'sex': _formData['sexo'],
        'cp': _formData['tipoDorPeito'],
        'trestbps': _formData['pressaoRepouso'],
        'chol': _formData['colesterolSeric'],
        'fbs': _formData['acucarJejum'],
        'restecg': _formData['resultadosEletro'],
        'thalach': _formData['freqCardiacaMax'],
        'exang': _formData['anginaInduzida'],
        'oldpeak': _formData['picoAntigo'],
        'slope': _formData['inclinaPicoST'],
        'ca': _formData['numVasosColoridos'],
        'thal': _formData['tal'],
      };
      print(data);

      // URL da API para enviar os dados
      String apiUrl = 'http://172.174.204.171:5000/patients';

      try {
        // Envia uma requisição POST para a API
        http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        );
        print(response.statusCode);
        // Verifica o código de status da resposta
        if (response.statusCode == 200) {
          // Sucesso - lógica de sucesso
          print('Requisição bem-sucedida');
          print('Resposta da API: ${response.body}');
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          var messageValue = responseBody['message'];
          if ( messageValue == 1 ) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Negative();
            }),
          );
            
          } else {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Approved();
            }),
          );
           
          }
        } else {
          // Se a resposta não for bem-sucedida, trata o erro aqui
          print('Erro na requisição: ${response.statusCode}');
          print('Resposta da API: ${response.body}');
          // Adicione lógica de tratamento de erro aqui

           showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Erro'),
                  content: Text('Erro ao gerar. Tente novamente.'),
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
        }
      } catch (error) {
        // Se a requisição não for bem-sucedida, trata o erro aqui
        print('Erro na requisição: $error');
        showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Erro'),
                  content: Text('Erro ao gerar. Tente novamente.'),
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
        // Adicione lógica de tratamento de erro aqui
      }
    }
  }
}
