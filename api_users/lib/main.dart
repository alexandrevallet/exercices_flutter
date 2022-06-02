import 'package:api_users/models/user.dart';
import 'package:api_users/services/user_service.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Liste des utilisateurs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<User>>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Chargement en cours..."));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snapshot.data![i].name),
                      subtitle: Text(snapshot.data![i].userName),
                      trailing: Text(snapshot.data![i].email),
                    );
                  });
            } else {
              return const Text("Une erreur est survenue.");
            }
          },
        ));
  }
}
