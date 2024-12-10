import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendDb extends StatefulWidget {
  const SendDb({super.key});

  @override
  State<SendDb> createState() => _SendDbState();
}

class _SendDbState extends State<SendDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('images')
                      .doc('aaa')
                      .set({'url': 'bbb'});
                },
                child: Text('send to DB'))
          ],
        ),
      ),
    );
  }
}
