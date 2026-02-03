import 'package:cmu_fondue/dataconnect_generated/generated.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';

class DataConnectTestQueryPage extends StatelessWidget {
  const DataConnectTestQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Problem Types Query Test')),
      body: FutureBuilder<QueryResult<ProblemTypesQueryData, void>>(
        future: ConnectorConnector.instance.problemTypesQuery().execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final problemTypes = snapshot.data!.data.problemTypess;

          if (problemTypes.isEmpty) {
            return const Center(child: Text('No problem types found'));
          }

          return ListView.separated(
            itemCount: problemTypes.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final type = problemTypes[index];
              return ListTile(
                title: Text(type.typeName),
                subtitle: Text(type.typeThaiName),
                leading: CircleAvatar(child: Text('${index + 1}')),
              );
            },
          );
        },
      ),
    );
  }
}
