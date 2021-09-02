import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {   // Ubah ke stateful karena agar bisa menyimpan nilai amound dan title 
  final Function addTx;


  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController
        .text; // Jangan lupa kalau controller tambah .text agar menampilkan isinya
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }

    widget.addTx(    // widget. Ini fungsi spesial dari flutter
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop(); // Agar ketika user sudah memasukkan judul dan nilai formnya lansung close
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Tittle'),
              //onChanged: (value){
              //  titleInput = value;
              //},
              controller:
                  titleController, // Pakai controller untuk menyimpan value agar lebih singkat
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (value) {
              //  amountInput = value;
              //},
              controller: amountController,
              keyboardType: TextInputType.number, //Mengubah kenis keyboard
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add to Transaction'),
              textColor: Colors.purple,
              onPressed: () => submitData(),
            ),
          ],
        ),
      ),
    );
  }
}
