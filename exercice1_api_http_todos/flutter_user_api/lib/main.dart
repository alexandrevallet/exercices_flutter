import 'package:flutter/material.dart';
import 'models/todo.dart';
import 'package:flutter_user_api/services/user_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({Key? key}) : super(key: key);

  @override
  State<DataFromAPI> createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: FutureBuilder<List<Todo>>(
            future: getAllTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Chargement en cours..."));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return CheckboxListTile(
                          title: Text(snapshot.data![i].title),
                          value: snapshot.data![i].completed,
                          onChanged: (bool? value) {});
                    });
              } else {
                //Error
                return const Text("Une erreur est survenue");
              }
            }));
  }
}
