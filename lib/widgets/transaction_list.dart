import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty ? Column(children: [
        SizedBox(height: 10,),
        Text(
          'No Transactions Added Yet!',
          style: TextStyle(fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20,),
        Image.asset('assets/images/waiting.png',height: 400,fit: BoxFit.cover,),
      ],) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme
                            .of(context)
                            .primaryColorDark, width: 2),
                  ),
                  child: Text(
                    '₹ ${transactions[index].amount..toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme
                            .of(context)
                            .primaryColorDark),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat.MMMMEEEEd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
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
