import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/resources/color_constants.dart';
import 'package:portfolio/view_model/widget/pie_chart_widget.dart';
import 'package:portfolio/model/pie_chart_data_model.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key, required this.size, required this.dataList, this.isLabelVisible = false, this.stroke = 2,
    this.textDistance = 50, this.textGap = 15, this.textCenterAdjustmentOffset = const Offset(0, 0)});
  final Size size;
  final List<PieChartDataModel> dataList;
  final bool isLabelVisible;
  final double stroke;
  final double textDistance;
  final double textGap;
  final Offset textCenterAdjustmentOffset;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with SingleTickerProviderStateMixin {

  late Canvas canvas;
  // late Paint paint;
  late double adjustmentFactor;

  double _fraction = 0.0;
  late Animation<double> _animation;
  late AnimationController _controller;


  final List<PieData> _pieData = [];

  @override
  void initState() {
    canvas = Canvas(PictureRecorder());
    adjustmentFactor = 0;

    for(int i = 0; i< widget.dataList.length; i++) {
      _pieData.add(PieData(startAngle: adjustmentFactor, sweepAngle: (2 * pi * widget.dataList[i].percentage/100)));
      adjustmentFactor += (2 * pi * widget.dataList[i].percentage/100);
    }


    _controller =
        AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _animation=
    Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _animation.addListener(() {
      // print(_animation.value);
      setState(() {
        _fraction = _animation.value;
      });
    });


    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [...List.generate(_pieData.length, (index) {
        // if(index < widget.dataList.length){
        // if(index > 0){
        //   adjustmentFactor += 2 * pi * widget.dataList[index -1].percentage/100;
        //   // adjustmentFactor += _degreesToRadians(10).toDouble();
        // }
        return CustomPaint( //                       <-- CustomPaint widget
          size: Size(widget.size.width, widget.size.height),
          painter: MyPainter(
              startAngle: _pieData[index].startAngle,
              sweepAngle: _pieData[index].sweepAngle,
              color: widget.dataList[index].color.withAlpha(190),
            stroke: 1/widget.stroke,
            fraction: _fraction,
            text: widget.isLabelVisible ? widget.dataList[index].title
            : "${widget.dataList[index].percentage}%",
            textDistance: widget.textDistance,
            textGap: widget.textGap,
            textCenterAdjustmentOffset: widget.textCenterAdjustmentOffset
          ),
        );
      }

      )
      ]
    );
  }
}

class MyPainter extends CustomPainter {

  MyPainter({required this.startAngle, required this.sweepAngle, required this.color, required this.fraction, this.text = '',
    required this.stroke, required this.textDistance, required this.textGap, required this.textCenterAdjustmentOffset});
  double startAngle;
  double sweepAngle;
  Color color;
  final double fraction;
  final String text;
  final double stroke;
  final double textDistance;
  final double textGap;
  final Offset textCenterAdjustmentOffset;


  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    //                                             <-- Insert your painting code here.
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/4/stroke;


    // canvas.drawArc(Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: size.width/2), startAngle * fraction, sweepAngle * fraction, true, paint);


    // Hollow Circle
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Path path = Path()..arcTo(rect,startAngle * fraction, sweepAngle * fraction, true);
    canvas.drawPath(
        path,
        paint);


    paint..strokeWidth = 1.0
      ..color= ColorConstants.white
      ..style = PaintingStyle.stroke;

    // Hollow Inner Stroke
    canvas.drawArc(
        Rect.fromCenter(center: Offset(size.width/2, size.height/2), height: (size.width - size.width/4/stroke), width: (size.width - size.width/4/stroke)),
        startAngle * fraction, sweepAngle * fraction,
        false,
        paint);

    // Hollow Outer Stroke
    canvas.drawArc(
        Rect.fromCenter(center: Offset(size.width/2, size.height/2), height: (size.width + size.width/4/stroke), width: (size.width + size.width/4/stroke)),
        startAngle * fraction, sweepAngle * fraction,
        false,
        paint);

    // Hollow Separator Lines
    canvas.drawLine(Offset(size.width/2 + (size.width/2 - size.width/8/stroke) * cos((startAngle * fraction)),  size.width/2 + (size.width/2 - size.width/8/stroke) * sin((startAngle * fraction))),
        Offset(size.width/2 + (size.width/2 + size.width/8/stroke) * cos((startAngle * fraction)),  size.width/2 + (size.width/2 + size.width/8/stroke) * sin((startAngle * fraction))),
        paint);

//     canvas.drawArc(
//         Rect.fromCenter(center: Offset(
//             (size.width/2 + (size.width/2 - size.width/8/stroke) * cos((startAngle * fraction)) + size.width/2 + (size.width/2 + size.width/8/stroke) * cos((startAngle * fraction)))/2,
//             (size.width/2 + (size.width/2 - size.width/8/stroke) * sin((startAngle * fraction)) + size.width/2 + (size.width/2 + size.width/8/stroke) * sin((startAngle * fraction)))/2),
//             height: ((size.width/2 + (size.width/2 + size.width/8/stroke)) - (size.width/2 + (size.width/2 - size.width/8/stroke) * cos((startAngle * 0))))/2
//
//             // (size.width + size.width/4/stroke),
//                 ,
//             // width: (size.width + size.width/4/stroke)),
//             width: ((size.width/2 + (size.width/2 + size.width/8/stroke)) - (size.width/2 + (size.width/2 - size.width/8/stroke) * cos((startAngle * 0))))/2
// ,),
//             startAngle * fraction, 90,
//         false,
//         paint);

    paint..strokeWidth = 0.5
      ..color= ColorConstants.glassWhite.withOpacity(fraction);

    // Outer Arrow Lines
    canvas.drawLine(Offset(size.width/2 + (size.width/2 + size.width/16/stroke) * cos((startAngle * fraction + sweepAngle * fraction/2)),  size.width/2 + (size.width/2 + size.width/16/stroke) * sin((startAngle * fraction + sweepAngle * fraction/2))),
        Offset(size.width/2 + (size.width/2 + size.width/8/stroke + textDistance) * cos((startAngle * fraction + sweepAngle * fraction/2)),  size.width/2 + (size.width/2 + size.width/8/stroke + textDistance) * sin((startAngle * fraction + sweepAngle * fraction/2))),
        paint);

    // paint..style = PaintingStyle.stroke
    // ..strokeWidth = 1
    // ..color = ColorConstants.white;
    // canvas.drawArc(Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: size.width/2), startAngle * fraction, sweepAngle * fraction, false, paint);

    // paint..style = PaintingStyle.fill
    // ..color = ColorConstants.white;

    // canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/4, paint);
    // canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/4.5, paint);
    // canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/7, paint);


    canvas.save();

    canvas.translate(size.width/2 + (size.width/2 + size.width/8/stroke + textDistance + textGap) * cos((startAngle * fraction + sweepAngle * fraction /2)),  size.width/2 + (size.width/2 + size.width/8/stroke + textDistance + textGap) * sin((startAngle * fraction + sweepAngle * fraction /2)));
    // canvas.translate(size.width/2 + size.width/1.3 * cos((startAngle + sweepAngle/2)),  size.width/2 + size.width/1.3 * sin((startAngle + sweepAngle/2)));

    // TextSpan span = TextSpan(
    // style: TextStyle(color: Colors.brown, fontSize: 24.0,
    // fontFamily: 'Roboto'), text: textList[i]);
    // TextPainter tp = new TextPainter(
    // text: span, textDirection: TextDirection.ltr);
    // tp.layout();
    TextSpan span = TextSpan(text: text, style: TextStyle(color: ColorConstants.white.withOpacity(fraction)));
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();


    tp.paint(canvas, textCenterAdjustmentOffset);

    canvas.restore();

  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

num _degreesToRadians(num deg) => deg * (pi / 180);

class PieData {
  final double startAngle;
  final double sweepAngle;

  PieData({required this.startAngle, required this.sweepAngle});
}
