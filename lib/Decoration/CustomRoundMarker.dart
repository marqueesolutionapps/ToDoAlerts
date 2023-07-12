// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CustomRoundMarkerForCalendar(Color borderColor, Color backgroundColor, double size) {
  return Container(
    height: size,
    width: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: borderColor,
    ),
    child: Container(
      height: size / 2,
      width: size / 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
    ),
  );
}

Widget CustomRoundMarker(Color backgroundColor, double size) {
  return  CustomPaint(
    size: Size(size, size),
    painter: CirclePainter(color: backgroundColor, strokeSize: size),
  );
}

class CirclePainter extends CustomPainter {

  final Color? color;
  final double? strokeSize;
  const CirclePainter({Key? key, required this.color, required this.strokeSize});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = color!..strokeWidth = strokeSize! / 3..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}