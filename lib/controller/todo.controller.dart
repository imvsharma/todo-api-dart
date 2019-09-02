import '../todo_apis.dart';

class TodoController extends ResourceController {

  @Operation.get()
  Future<Response> getAllBooks() async {
    return Response.ok(['Create UI Screen', 'Add the logic', 'Add angular functionality']);
  }

  @Operation.get('id')
  Future<Response> getBookById() async {
    return Response.ok(['Create UI Screen']);
  }

  @Operation.post()
  Future<Response> addTodo() async {
    return Response.ok('Task added');
  }

  
}