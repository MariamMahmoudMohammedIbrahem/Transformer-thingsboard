import '../../commons.dart';
import 'package:http/http.dart' as http;
part 'historical_graph_controller.dart';

class HistoricalGraphScreen extends StatefulWidget {
  const HistoricalGraphScreen({super.key});

  @override
  createState() => _HistoricalGraphScreen();
}

class _HistoricalGraphScreen extends HistoricalGraphController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                historical();
              },
              child: const Text(
                'hey',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
