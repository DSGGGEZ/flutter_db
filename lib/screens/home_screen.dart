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
          title: const Text("What's your today diary?"),
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
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.calendar_month),
                            title: Text(data.title),
                            subtitle: Text(
                              data.date.toString() + " " + data.time.toString(),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              data.detail,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            subtitle: Text("\nWriter : " + data.writer),
                          ),
                          ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return FormEditScreen(data: data);
                                      }));
                                    }),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      var provider =
                                          Provider.of<TransactionProvider>(
                                              context,
                                              listen: false);
                                      provider.deleteTransaction(data);
                                    })
                              ]
                              // IconButton(
                              //     icon: const Icon(Icons.delete),
                              //     onPressed: () {
                              //       // call provider
                              //       var provider =
                              //           Provider.of<TransactionProvider>(context,
                              //               listen: false);
                              //       provider.deleteTransaction(data);
                              //     })
                              )
                        ],
                      ));
                },
              );
            }
          },
        ));
  }
}
