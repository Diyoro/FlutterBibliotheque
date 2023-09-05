import 'package:flutter/material.dart';


class PageLecture extends StatefulWidget {
  late final Map<String, dynamic> livre;

  PageLecture({required this.livre});

  @override
  State<PageLecture> createState() => _PageLectureState();
}

class _PageLectureState extends State<PageLecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livre['nom']),
      ),
      body: Center(
        child: Text(
          widget.livre['document'],
          style: TextStyle(fontSize: 18),
        ),
      )
    );
  }
}

