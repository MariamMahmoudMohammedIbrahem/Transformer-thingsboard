import '../../commons.dart';
part 'notification_widget_controller.dart';

class NotificationWidgetScreen extends StatefulWidget {
  final String title;
  final String body;
  const NotificationWidgetScreen({super.key, required this.title, required this.body});

  @override
  createState() => _NotificationWidgetScreen();
}

class _NotificationWidgetScreen extends NotificationWidgetController {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      left: 10.0,
      right: 10.0,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications, color: Colors.white),
                width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      height4,
                      Text(widget.body, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}