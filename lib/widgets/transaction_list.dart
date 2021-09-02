import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          400, // Height diperlukan untuk bisa scroll sehingga column dibawah di refactor dengan container
      child: transactions.isEmpty
          ? Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'No transactoins added !!!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    //Sizebox() gunanya agar membuat box baru bisa kosong atau tanpa isi
                    height: 40,
                  ),
                  Container(
                    //Direfactor dengan container karena butuh height agar bisa boxfit gambar
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (contex, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        )),
                        child: Text(
                          //tx.amount.toString(),     // toString() karena Text hanya bisa string
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}', // Ini alternatif cara penulisan . toStingAsFixed(2) maksudnya hanya mengambil 2 angka dibelakang koma
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].tittle,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMMMd().add_jm().format(transactions[
                                    index]
                                .date), // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
