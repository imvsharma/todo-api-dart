import '../todo_apis.dart';

/* ManagedObject<T> handles the translation of database rows to application objects and vice-versa. */
class Todo extends ManagedObject<_Todo> implements _Todo {}

class _Todo {
  //@Column(primaryKey: true, unique: true, indexed: true)
  @primaryKey
  int id;

  String title;
  String description;
}