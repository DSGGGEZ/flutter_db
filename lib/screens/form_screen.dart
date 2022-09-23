// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final writerController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Today Diary'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Title"),
                      autofocus: true,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Title.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Detail"),
                      controller: detailController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Detail.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Writer Name"),
                      controller: writerController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Writer Name.";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var detail = detailController.text;
                            var writer = writerController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                                title: title,
                                detail: detail,
                                writer: writer,
                                date: DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()));
                            provider.addTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("บันทึกไดอารี"))
                  ]),
            )));
  }
}
