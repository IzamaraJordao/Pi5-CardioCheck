import 'package:bank/route/app_routes.dart';
import 'package:bank/view/contact-list.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  List<String> _moviePreferences = ["Ação", "Comédia", "Drama", "Ficção Científica"];
  List<String> _languages = ["Português", "Inglês", "Espanhol", "Outro"];
  List<String> _movieTypes = ["Clássicos", "Últimos Lançamentos"];
  List<String> _time = ["Sim", "Não"];


  String _selectedMoviePreference = "Ação";
  String _selectedLanguage = "Português";
  String _selectedMovieType = "Clássicos";
  String _selectedTime = "Sim";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Indicações'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildQuestion("Que tipo de filme mais te agrada?", _selectedMoviePreference, _moviePreferences, screenWidth),
              SizedBox(height: 20), // Espaço entre a primeira pergunta e o DropdownButton
              _buildQuestion("Você gosta de assistir em qual idioma?", _selectedLanguage, _languages, screenWidth),
              SizedBox(height: 20), // Espaço entre a segunda pergunta e o DropdownButton
              _buildQuestion("Os clássicos ou últimos lançamentos?", _selectedMovieType, _movieTypes, screenWidth),
              SizedBox(height: 20), // Espaço entre a terceira pergunta e o DropdownButton
               _buildQuestion("Esta com tempo para maratonar? (Mais de uma hora e meia)", _selectedTime, _time, screenWidth),
              SizedBox(height: 20), // Espaço entre a terceira pergunta e o DropdownButton
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ContactList();
                    }),
                  );
                  // _saveForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Indicar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, String selectedType, List<String> options, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(color: Colors.white)),
        SizedBox(height: 12), // Espaço entre a pergunta e o DropdownButton
        Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color.fromARGB(255, 153, 148, 148), width: 2),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedType,
            onChanged: (String? newValue) {
              setState(() {
                selectedType = newValue!;
              });
            },
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 30,
            isExpanded: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    );
  }

  void _saveForm() {
    print("Resposta 1: $_selectedMoviePreference");
    print("Resposta 2: $_selectedLanguage");
    print("Resposta 3: $_selectedMovieType");
    print("Resposta 4: $_selectedTime");
  
  }
}
