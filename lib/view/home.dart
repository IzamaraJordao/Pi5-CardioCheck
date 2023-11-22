import 'package:bank/view/approved.dart';
import 'package:bank/view/contact-form.dart';
import 'package:bank/view/contact-list.dart';
import 'package:bank/main.dart';
import 'package:bank/view/negative.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xFFf9413f); // Cor #F9413F

    double buttonWidth = MediaQuery.of(context).size.width * 0.8; // Largura do botão "Entrar"

    return Scaffold(
      backgroundColor: Colors.white, // Alterado para branco conforme solicitado
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Realize o teste para verificar a possível presença de doença cardíaca.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black, // Alterado para preto conforme solicitado
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      // return Negative();
                      return CardioForm();
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: EdgeInsets.symmetric(horizontal: buttonWidth * 0.3, vertical: 16), // Ajuste o tamanho horizontal do botão conforme necessário
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Iniciar Teste',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'O que é o CardioCheck?',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Cuidar da saúde do coração é essencial para promover uma vida longa e saudável. O propósito do CardioCheck é auxiliá-lo na verificação potencial de doenças cardíacas. Respondendo algumas perguntas, você logo tem acesso ao resultado. Nosso compromisso é facilitar o monitoramento do seu bem-estar cardíaco, tornando a jornada de cuidados com o coração mais simples e acessível :)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              // Removi o botão "Entrar"
            ],
          ),
        ),
      ),
    );
  }
}


