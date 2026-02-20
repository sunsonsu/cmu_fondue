# Basic Usage

```dart
ConnectorConnector.instance.CreateProblem(createProblemVariables).execute();
ConnectorConnector.instance.UpdateProblem(updateProblemVariables).execute();
ConnectorConnector.instance.DeleteProblem(deleteProblemVariables).execute();
ConnectorConnector.instance.insertProblemType(insertProblemTypeVariables).execute();
ConnectorConnector.instance.insertUser(insertUserVariables).execute();
ConnectorConnector.instance.CreateProblemImage(createProblemImageVariables).execute();
ConnectorConnector.instance.UpdateProblemImage(updateProblemImageVariables).execute();
ConnectorConnector.instance.DeleteProblemImage(deleteProblemImageVariables).execute();
ConnectorConnector.instance.ListProblems().execute();
ConnectorConnector.instance.ListNotDoneProblems().execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ConnectorConnector.instance.UpdateProblemImage({ ... })
.imageUrl(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

