import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timelines/timelines.dart';

const completeColor = Color(0xff5ec792);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class ProcessTimelinePage extends StatefulWidget {
  @override
  _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
}

class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
  int _processIndex = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Process Timeline')),
      body: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
          MediaQuery.of(context).size.width / _processes.length,
          oppositeContentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.asset(
                'assets/images/status${index + 1}.png',
                width: 50.0,
                color: getColor(index),
              ),
            );
          },
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    _processes[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: getColor(index),
                    ),
                  ),
                  Text(
                    "12:00 AM",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: getColor(index),
                    ),
                  ),
                  Text(
                    "17/08/2002",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: getColor(index),
                    ),
                  ),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            var color;
            var child;
            if (index == _processIndex) {
              color = inProgressColor;
              // child = Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CircularProgressIndicator(
              //     strokeWidth: 3.0,
              //     valueColor: AlwaysStoppedAnimation(Colors.white),
              //   ),
              // );
            } else if (index < _processIndex) {
              color = completeColor;
              // child = Icon(
              //   Icons.check,
              //   color: Colors.white,
              //   size: 15.0,
              // );
            } else {
              color = todoColor;
            }
            return Stack(
              children: [
                OutlinedDotIndicator(
                  borderWidth: 4.0,
                  color: color,
                ),
              ],
            );
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == _processIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(index),
                );
              }
            } else {
              return null;
            }
          },
          itemCount: _processes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.chevronRight),
        onPressed: () {
          setState(() {
            _processIndex = (_processIndex + 1) % _processes.length;
          });
        },
        backgroundColor: inProgressColor,
      ),
    );
  }
}

final _processes = [
  "Created",
  "Accepted",
  "Delivering",
  "Succeed",
];