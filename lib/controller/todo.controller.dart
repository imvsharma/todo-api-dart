
import '../model/todo.dart';

import '../todo_apis.dart';

class TodoController extends ResourceController {
  TodoController(this.context);
  ManagedContext context;
  @Operation.get()
  Future<Response> getAllBooks() async {
    final query = Query<Todo>(context);
    return Response.ok(await query.fetch());
  }

  @Operation.get('id')
  Future<Response> getBookById() async {
    return Response.ok(['Create UI Screen']);
  }

  @Operation.post()
  Future<Response> addTodo() async {
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Todo>(context)
      ..values.title = body['title'] as String
      ..values.description = body['description'] as String;
    
    final insertedTodo = await query.insert();

    return Response.ok(insertedTodo);
  }

  @Operation.put('id')
  Future<Response> updateTodo() async {
    return Response.ok('Task updated');
  }

  @Operation.delete('id')
  Future<Response> deleteTodo() async {
    return Response.ok('Task deleted');
  }

  
}