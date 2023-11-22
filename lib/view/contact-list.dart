import 'package:bank/data/contact-mock.dart';
import 'package:bank/data/image-mock.dart';
import 'package:bank/models/contact.dart';
import 'package:bank/models/filme.dart';
import 'package:bank/view/contact-form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  final List<Film> _contact = [spider, venom];
  @override
  State<StatefulWidget> createState() {
    return ContactListState();
  }
}

class ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Indicações de Filmes', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff000000),
      ),
      body: ListView.builder(
        itemCount: widget._contact.length,
        itemBuilder: (context, i) {
          print(widget._contact[i]);
          final contact = widget._contact[i];
          return ListTile(
            leading: Image.network(contact.image),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.name.toUpperCase(), style: TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Color.fromARGB(255, 213, 217, 7)),
                          Text(" ${contact.pontuaction}", style: TextStyle(color: Color.fromARGB(255, 211, 231, 31))),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.category, color: Colors.white),
                          Text(" ${contact.genero}", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          Text(" ${contact.year}", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.white),
                          Text(" ${contact.time} minutos", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget._contact.remove(contact);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
