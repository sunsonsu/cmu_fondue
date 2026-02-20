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


### ListNotDoneProblems
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.listNotDoneProblems().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListNotDoneProblemsData, void>`
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

final result = await ConnectorConnector.instance.listNotDoneProblems();
ListNotDoneProblemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.listNotDoneProblems().ref();
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


### ProblemImageByProblemId
#### Required Arguments
```dart
String problemId = ...;
ConnectorConnector.instance.problemImageByProblemId(
  problemId: problemId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ProblemImageByProblemIdData, ProblemImageByProblemIdVariables>`
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

final result = await ConnectorConnector.instance.problemImageByProblemId(
  problemId: problemId,
);
ProblemImageByProblemIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String problemId = ...;

final ref = ConnectorConnector.instance.problemImageByProblemId(
  problemId: problemId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ProblemsByTag
#### Required Arguments
```dart
String TagId = ...;
ConnectorConnector.instance.problemsByTag(
  TagId: TagId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ProblemsByTagData, ProblemsByTagVariables>`
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

final result = await ConnectorConnector.instance.problemsByTag(
  TagId: TagId,
);
ProblemsByTagData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String TagId = ...;

final ref = ConnectorConnector.instance.problemsByTag(
  TagId: TagId,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateProblem
#### Required Arguments
```dart
String title = ...;
String detail = ...;
String locationName = ...;
double lat = ...;
double lng = ...;
String reporterId = ...;
String typeId = ...;
String tagId = ...;
ConnectorConnector.instance.createProblem(
  title: title,
  detail: detail,
  locationName: locationName,
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
  locationName: locationName,
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
String locationName = ...;
double lat = ...;
double lng = ...;
String reporterId = ...;
String typeId = ...;
String tagId = ...;

final ref = ConnectorConnector.instance.createProblem(
  title: title,
  detail: detail,
  locationName: locationName,
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
ConnectorConnector.instance.updateProblem(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateProblem, we created `UpdateProblemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateProblemVariablesBuilder {
  ...
   UpdateProblemVariablesBuilder title(String? t) {
   _title.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder detail(String? t) {
   _detail.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder locationName(String? t) {
   _locationName.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder lat(double? t) {
   _lat.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder lng(double? t) {
   _lng.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder typeId(String? t) {
   _typeId.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder tagId(String? t) {
   _tagId.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.updateProblem(
  id: id,
)
.title(title)
.detail(detail)
.locationName(locationName)
.lat(lat)
.lng(lng)
.typeId(typeId)
.tagId(tagId)
.execute();
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
);
UpdateProblemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.updateProblem(
  id: id,
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


### CreateProblemImage
#### Required Arguments
```dart
String problemId = ...;
String imageUrl = ...;
String fileName = ...;
String imageType = ...;
ConnectorConnector.instance.createProblemImage(
  problemId: problemId,
  imageUrl: imageUrl,
  fileName: fileName,
  imageType: imageType,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateProblemImageData, CreateProblemImageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createProblemImage(
  problemId: problemId,
  imageUrl: imageUrl,
  fileName: fileName,
  imageType: imageType,
);
CreateProblemImageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String problemId = ...;
String imageUrl = ...;
String fileName = ...;
String imageType = ...;

final ref = ConnectorConnector.instance.createProblemImage(
  problemId: problemId,
  imageUrl: imageUrl,
  fileName: fileName,
  imageType: imageType,
).ref();
ref.execute();
```


### UpdateProblemImage
#### Required Arguments
```dart
String problemImageId = ...;
String problemId = ...;
ConnectorConnector.instance.updateProblemImage(
  problemImageId: problemImageId,
  problemId: problemId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateProblemImage, we created `UpdateProblemImageBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateProblemImageVariablesBuilder {
  ...
   UpdateProblemImageVariablesBuilder imageUrl(String? t) {
   _imageUrl.value = t;
   return this;
  }
  UpdateProblemImageVariablesBuilder fileName(String? t) {
   _fileName.value = t;
   return this;
  }
  UpdateProblemImageVariablesBuilder imageType(String? t) {
   _imageType.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.updateProblemImage(
  problemImageId: problemImageId,
  problemId: problemId,
)
.imageUrl(imageUrl)
.fileName(fileName)
.imageType(imageType)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateProblemImageData, UpdateProblemImageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.updateProblemImage(
  problemImageId: problemImageId,
  problemId: problemId,
);
UpdateProblemImageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String problemImageId = ...;
String problemId = ...;

final ref = ConnectorConnector.instance.updateProblemImage(
  problemImageId: problemImageId,
  problemId: problemId,
).ref();
ref.execute();
```


### DeleteProblemImage
#### Required Arguments
```dart
String problemImageId = ...;
ConnectorConnector.instance.deleteProblemImage(
  problemImageId: problemImageId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteProblemImageData, DeleteProblemImageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.deleteProblemImage(
  problemImageId: problemImageId,
);
DeleteProblemImageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String problemImageId = ...;

final ref = ConnectorConnector.instance.deleteProblemImage(
  problemImageId: problemImageId,
).ref();
ref.execute();
```

