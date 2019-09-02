


import './controller/todo.controller.dart';
import './utils//utils.dart';
import 'todo_apis.dart';


class TodoConfiguration extends Configuration {
  TodoConfiguration(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class TodoApisChannel extends ApplicationChannel {
  ManagedContext context;
  
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config = TodoConfiguration(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName);
    context = ManagedContext(dataModel, psc);
  }

  
  
  Future willOpen() async {
    final config = TodoConfiguration(options.configurationFilePath);
    await createDatabaseSchema(context, config.database.isTemporary);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/example")
      .linkFunction((request) async {
        print(request);
        return Response.ok({"key": "value"});
      });

    router
      .route('/todos')
      .link(() => TodoController());
    
    router
      .route('/addtodo')
      .link(() => TodoController());

    router
      .route('/todo/[:id]')
      .link(() => TodoController());
    

    return router;
  }
}