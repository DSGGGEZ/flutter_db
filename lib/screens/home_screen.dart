import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db/screens/form_edit_screen.dart';
import 'package:provider/provider.dart';

import '../models/transactions.dart';
import '../providers/transaction_provider.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense App"),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                }),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider providers, Widget? child) {
            var count = providers.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text(
                  "No Item Data.",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: providers.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = providers.transactions[index];
                  return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                          enabled: true,
                          leading: CircleAvatar(
                              radius: 30,
                              child: FittedBox(
                                child: Text(data.amount.toString()),
                              )),
                          title: Text(data.title),
                          subtitle: Text(data.date),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormEditScreen(data: data);
                            }));
                          },
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // call provider
                                var provider = Provider.of<TransactionProvider>(
                                    context,
                                    listen: false);
                                provider.deleteTransaction(data);
                              })));
                },
              );
            }
          },
        ));
  }
}
