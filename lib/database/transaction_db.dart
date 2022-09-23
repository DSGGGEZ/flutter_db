import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/transactions.dart';

class TransactionDB {
  //DB Services
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    var appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");

    //json
    var keyID = store.add(db, {
      "id": statement.id,
      "title": statement.title,
      "detail": statement.detail,
      "writer": statement.writer,
      "date": statement.date
    });
    db.close();
    return keyID;
  }

  Future<List<Transactions>> loadAllData() async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactionList = [];
    for (var record in snapshot) {
      int id = record.key;
      String title = record['title'].toString();
      String detail = record['detail'].toString();
      String writer = record['writer'].toString();
      String date = record['date'].toString();
      transactionList.add(Transactions(
          id: id, title: title, detail: detail, writer: writer, date: date));
    }
    db.close();
    return transactionList;
  }

  //my CRUD update code
  Future updateData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");

    //filter from 'title' and 'date'
    final finder = Finder(
        filter: Filter.and(<Filter>[
      Filter.equals('title', statement.title),
      Filter.equals('detail', statement.title),
      Filter.equals('writer', statement.title),
      Filter.equals('date', statement.date)
    ]));
    var updateResult =
        await store.update(db, statement.toMap(), finder: finder);
    print("Delete data with id $updateResult");
    db.close();
  }

  //my CRUD update code
  Future deleteData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    print("Statement id is ${statement.id}");

    final finder = Finder(
        filter: Filter.and(<Filter>[
      Filter.equals('title', statement.title),
      Filter.equals('detail', statement.title),
      Filter.equals('writer', statement.title),
      Filter.equals('date', statement.date)
    ]));
    var deleteResult = await store.delete(db, finder: finder);
    print("Delete data with id $deleteResult");
    db.close();
  }

  Future<Transactions?> loadSingleRow(int id) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    var snapshot =
        await store.find(db, finder: Finder(filter: Filter.byKey(id)));
    Transactions? transaction;
    for (var record in snapshot) {
      int id = int.parse(record['id'].toString());
      String title = record['title'].toString();
      String detail = record['detail'].toString();
      String writer = record['writer'].toString();
      String date = record['date'].toString();
      // print(record['title']);
      transaction = Transactions(
          id: id, title: title, detail: detail, writer: writer, date: date);
    }
    db.close();
    return transaction;
  }
}
