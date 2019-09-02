
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
    final int todoId = int.parse(request.path.variables['id']);
    final query = Query<Todo>(context)..where((t) => t.id).equalTo(todoId);
    return Response.ok(await query.fetch());
  }

  @Operation.post()
  Future<Response> addTodo(@Bind.body() Todo body) async {
    final query = Query<Todo>(context)..values = body;
    final insertedTodo = await query.insert();
    return Response.ok(insertedTodo);
  }

  @Operation.put('id')
  Future<Response> updateTodo(@Bind.path('id') int id, @Bind.body() Todo body) async {
    final query = Query<Todo>(context)
      ..values = body
      ..where((todo) => todo.id).equalTo(id);
    final updateTodo = await query.updateOne();
    if (updateTodo == null) {
      return Response.notFound(body: 'Task does not exist');
    }
    return Response.ok(updateTodo);
  }

  @Operation.delete('id')
  Future<Response> deleteTodo(@Bind.path('id') int id) async {
    final query = Query<Todo>(context)
      ..where((todo) => todo.id).equalTo(id);
    final deleteTodo = await query.delete();
    if (deleteTodo == 0) {
      return Response.notFound(body: 'Task does not exist');
    }
    return Response.ok(deleteTodo);
  }

  
}