import '../commons.dart';

part 'drag_drop_controller.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  createState() => _DragDropScreen();
}

class _DragDropScreen extends DragDropController {
  final Map<Key, Widget> cards = {
    const ValueKey('card1'): const Card(
      child: ListTile(
        title: Text('Card 1'),
        leading: Icon(Icons.drag_handle),
      ),
    ),
    const ValueKey('card2'): const Card(
      child: ListTile(
        title: Text('Card 2'),
        leading: Icon(Icons.drag_handle),
      ),
    ),
    const ValueKey('card3'): const Card(
      child: ListTile(
        title: Text('Card 3'),
        leading: Icon(Icons.drag_handle),
      ),
    ),
    const ValueKey('card4'): const Card(
      child: ListTile(
        title: Text('Card 4'),
        leading: Icon(Icons.drag_handle),
      ),
    ),
    const ValueKey('card5'): const Card(
      child: ListTile(
        title: Text('Card 5'),
        leading: Icon(Icons.drag_handle),
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop Cards'),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final keys = cards.keys.toList();
            final key = keys.removeAt(oldIndex);
            keys.insert(newIndex, key);

            final updatedCards = <Key, Widget>{};
            for (final key in keys) {
              updatedCards[key] = cards[key]!;
            }
            cards
              ..clear()
              ..addAll(updatedCards);
          });
        },
        children: [
          for (final key in cards.keys)
            Container(
              key: key,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: cards[key],
            ),
        ],
      ),
    );
  }

}