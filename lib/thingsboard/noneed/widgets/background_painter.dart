

import '../../commons.dart';

class Painter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    //top left
    //start point from 20% width to the left
    ovalPath.moveTo(width * .93, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .95, height * .1, width, height * .1);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);

    //top right
    ovalPath.moveTo(width * .05, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .05, height * .1, 0, height * .1);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);

    //bottom left
    /*ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);*/
    //bottom right
    ovalPath.moveTo(width * .25, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .23, height * .9, 0, height * .85);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class Painter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    //start point from 20% height to the left
    ovalPath.moveTo(0, height * .2);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * .15, height * .25, width * .21, height * .5);
    //paint a curve from current position to bottom left of screen at width*.1
    ovalPath.quadraticBezierTo(width * .28, height * .8, width * .1, height);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);

    //start point from 20% width to the left
    ovalPath.moveTo(width * .93, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .95, height * .15, width, height * .18);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class Painter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();

    //bottom left
    ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class Painter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey.shade200;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();

    //start point from 20% height to the left
    ovalPath.moveTo(0, height * .2);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * .05, height * .25, width * .1, height * .6);
    //paint a curve from current position to bottom left of screen at width*.1
    ovalPath.quadraticBezierTo(width * .12, height * .7, width * .05, height);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);

    //bottom right
    ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);
    //bottom left
    /*ovalPath.moveTo(width * .25, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .23, height * .9, 0, height * .85);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = const Color(0xFF305680);
    canvas.drawPath(ovalPath, paint);*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}