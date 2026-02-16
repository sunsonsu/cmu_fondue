# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListProblems
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listProblems().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListProblemsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listProblems();
ListProblemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listProblems().ref();
ref.execute();

ref.subscribe(...);
```


### ListProblemTypes
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listProblemTypes().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListProblemTypesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listProblemTypes();
ListProblemTypesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listProblemTypes().ref();
ref.execute();

ref.subscribe(...);
```


### ListProblemTags
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listProblemTags().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListProblemTagsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.listProblemTags();
ListProblemTagsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listProblemTags().ref();
ref.execute();

ref.subscribe(...);
```


### ProblemTypesQuery
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.problemTypesQuery().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ProblemTypesQueryData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.problemTypesQuery();
ProblemTypesQueryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.problemTypesQuery().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### insertProblemType
#### Required Arguments
```dart
String name = ...;
String description = ...;
ConnectorConnector.instance.insertProblemType(
  name: name,
  description: description,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<insertProblemTypeData, insertProblemTypeVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.insertProblemType(
  name: name,
  description: description,
);
insertProblemTypeData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String description = ...;

final ref = ConnectorConnector.instance.insertProblemType(
  name: name,
  description: description,
).ref();
ref.execute();
```


### insertUser
#### Required Arguments
```dart
String email = ...;
bool isAdmin = ...;
ConnectorConnector.instance.insertUser(
  email: email,
  isAdmin: isAdmin,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<insertUserData, insertUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.insertUser(
  email: email,
  isAdmin: isAdmin,
);
insertUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;
bool isAdmin = ...;

final ref = ConnectorConnector.instance.insertUser(
  email: email,
  isAdmin: isAdmin,
).ref();
ref.execute();
```


### CreateProblem
#### Required Arguments
```dart
String title = ...;
String detail = ...;
double lat = ...;
double lng = ...;
String reporterId = ...;
String typeId = ...;
String tagId = ...;
ConnectorConnector.instance.createProblem(
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  reporterId: reporterId,
  typeId: typeId,
  tagId: tagId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateProblemData, CreateProblemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createProblem(
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  reporterId: reporterId,
  typeId: typeId,
  tagId: tagId,
);
CreateProblemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String title = ...;
String detail = ...;
double lat = ...;
double lng = ...;
String reporterId = ...;
String typeId = ...;
String tagId = ...;

final ref = ConnectorConnector.instance.createProblem(
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  reporterId: reporterId,
  typeId: typeId,
  tagId: tagId,
).ref();
ref.execute();
```


### UpdateProblem
#### Required Arguments
```dart
String id = ...;
String title = ...;
String detail = ...;
double lat = ...;
double lng = ...;
String typeId = ...;
String tagId = ...;
ConnectorConnector.instance.updateProblem(
  id: id,
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  typeId: typeId,
  tagId: tagId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateProblemData, UpdateProblemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.updateProblem(
  id: id,
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  typeId: typeId,
  tagId: tagId,
);
UpdateProblemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String title = ...;
String detail = ...;
double lat = ...;
double lng = ...;
String typeId = ...;
String tagId = ...;

final ref = ConnectorConnector.instance.updateProblem(
  id: id,
  title: title,
  detail: detail,
  lat: lat,
  lng: lng,
  typeId: typeId,
  tagId: tagId,
).ref();
ref.execute();
```


### DeleteProblem
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.deleteProblem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteProblemData, DeleteProblemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.deleteProblem(
  id: id,
);
DeleteProblemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.deleteProblem(
  id: id,
).ref();
ref.execute();
```

