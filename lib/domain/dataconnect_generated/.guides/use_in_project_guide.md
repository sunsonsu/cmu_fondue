1. make sure you have configure the firebase project with
```bash
flutterfire configure
```
when prompt answer n to generate the new firebase_option.dart

2. download data connect vscode extension 
![alt text](image.png)

3. Write your query in .gql file in dataconnect/connector folder
4. Run command "Data Connect: Generate Dart SDK" in vscode (the output is in /lib/domain/dataconnect_generated/)
5. Example usage
```dart
ConnectorConnector.instance.ProblemTypesQuery().execute();
```

<span style="color: red;">The emulator must running for local development</span>