
import '../../commons.dart';

class TelemetryTable extends StatelessWidget {
  const TelemetryTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];

    // Iterate through telemetryData to generate table rows
    telemetryData.forEach((key, values) {
      values.forEach((timestamp, value) {
        rows.add(DataRow(cells: [
          DataCell(Text(key)), // Telemetry Key
          DataCell(Text(value.toString())), // Telemetry Value
          DataCell(Text(DateTime.fromMillisecondsSinceEpoch(timestamp)
              .toString())), // Timestamp
        ]));
      });
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Telemetry Data Table'),
        ),
        body: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Telemetry Key')),
              DataColumn(label: Text('Value')),
              DataColumn(label: Text('Timestamp')),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}