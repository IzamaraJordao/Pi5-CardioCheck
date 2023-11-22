import 'package:bank/view/contact-form.dart';
import 'package:bank/view/contact-list.dart';
import 'package:bank/main.dart';
import 'package:bank/view/home.dart';
import 'package:flutter/material.dart';

class Negative extends StatelessWidget {
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
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'O seu teste resultou em:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black, // Alterado para preto conforme solicitado
                  fontSize: 18,
                ),
              ),
    SizedBox(height: 20),
              Text(
                'Positivo para potencial doenças no coração!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
      Padding(
                padding: EdgeInsets.only(top: 2),
                child: Image.asset(
                  'assets/images/img_com_doenca.png',
                  width: 200,
                  height: 200,
                ),
              ),

              SizedBox(height: 10),
              Text(
                'É aconselhável que você procure um médico especialista em doenças do coração para realizar check-up e verificar os possíveis problemas cardíacos. Cuidar da saúde do coração é fundamental para promover uma vida longa e saudável!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              // Removi o botão "Entrar"
Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Home();
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
                    'Retornar a tela inicial',
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
}


