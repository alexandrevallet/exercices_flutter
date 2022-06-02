import 'package:flutter/material.dart';
import 'models/genderize.dart';
import 'package:flutter_user_api/services/genderize_service.dart';

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
  TextEditingController myController = TextEditingController();
  String firstname = "";
  bool isElevated = true;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Masculin ou féminin ?'),
        ),
        body: Column(
          children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Entrez un prénom',
              ),
            ),           
            ElevatedButton(
              onPressed: () {
                setState(() {
                  firstname = myController.text;
                });
              },
              child: const Text('Rechercher'),
            ),
            Card(
              child: FutureBuilder<Gender>(
                  future: getAllTodos(firstname),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Text("Chargement en cours..."));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.data!.name == "Error") {
                        return Container();
                      }
                      return ListTile(
                        title: Text(snapshot.data!.name),
                        subtitle: Text(snapshot.data!.gender),
                        trailing: Text(snapshot.data!.probability.toString()),
                      );
                    } else {
                      //Error
                      return const Text("Une erreur est survenue");
                    }
                  }),
            ),
          ],
        ));
  }
}
