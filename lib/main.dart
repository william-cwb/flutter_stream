import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_streams/service.dart';
import 'package:flutter_streams/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamController<Todo> _controller = new StreamController<Todo>.broadcast();
  Stream<Todo> get stream => _controller.stream;
  Sink get sink => _controller.sink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Streams'),
        ),
        body: FutureBuilder<List<Todo>>(
          initialData: null,
          future: Service.getTasks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Todo todo = snapshot.data[index];
                  return StreamBuilder<Todo>(
                      initialData: todo,
                      stream: stream.where((todoStream) => todoStream.id == todo.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        print(snapshot.data.toJson());
                        return ListTile(
                          title: Text(todo.title),
                          trailing: Switch(
                            onChanged: (bool value) {
                              snapshot.data.completed = value;
                              sink.add(snapshot.data);
                            },
                            value: todo.completed,
                          ),
                        );
                      },);
                },
              );
            }
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}
