import 'package:flutter/material.dart';

class DetailsTransaction extends StatefulWidget {
  static const String idScreen = "DetailsTransaction";
  const DetailsTransaction({super.key});

  @override
  State<DetailsTransaction> createState() => _DetailsTransactionState();
}

class _DetailsTransactionState extends State<DetailsTransaction> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Details transaction'),
      ),
      body: Center(),
    );
  }
}
