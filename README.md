# flutter_streams

É um projeto flutter para demonstrar como atualizar um único item numa lista usando Streams.

Foi utilizado a API: https://jsonplaceholder.typicode.com/todos

Foi pego essas informações de Todos e alternando em um único item a tarefa completada como true ou false.

Como ficou a Stream:

Todo todo = snapshot.data[index];

StreamBuilder<Todo>(
    initialData: todo,
    stream: stream.where((todoStream) => todoStream.id == todo.id),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
    },
);