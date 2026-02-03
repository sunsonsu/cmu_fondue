1. download data connect vscode extension https://open-vsx.org/vscode/item?itemName=googlecloudtools.firebase-dataconnect-vscode
2. Write your query in .gql file in dataconnect/connector folder
3. Run command "Data Connect: Generate Dart SDK" in vscode (the output is in /lib/domain/dataconnect_generated/)
4. Example usage
```dart
ConnectorConnector.instance.ProblemTypesQuery().execute();

```

<span style="color: red;">The emulator must running for local development</span>