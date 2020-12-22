// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

final yellow = Color(0xFFFFFF00);

final textStyle = GoogleFonts.libreFranklin(
  textStyle: TextStyle(
    color: yellow,
    fontSize: 48,
  ),
  fontWeight: FontWeight.w700,
);

final crawlString1 = '''
Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.
''';
final crawlString2 = """
\nFast Development
\nPaint your app to life in milliseconds with Stateful Hot Reload. Use a rich set of fully-customizable widgets to build native interfaces in minutes.
\n\nExpressive and Flexible UI
\nQuickly ship features with a focus on native end-user experiences. Layered architecture allows for full customization, which results in incredibly fast rendering and expressive and flexible designs.
\n\nNative Performance
\nFlutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts, and your Flutter code is compiled to native ARM machine code using Dart's native compilers.
""";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.black,
      builder: (context, _) => CrawlPage(),
    );
  }
}

class CrawlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Column(children: [
        Flexible(
          flex: 5,
          child: Perspective(child: Crawler()),
        ),
        Flexible(
          flex: 1,
          child: Column(),
        ),
      ]),
    );
  }
}

class Crawler extends StatefulWidget {
  final crawlDuration = const Duration(seconds: 30);

  @override
  _CrawlerState createState() => _CrawlerState();
}

class _CrawlerState extends State<Crawler> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: widget.crawlDuration,
            curve: Curves.linear));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SuperSize(
      height: 1279,
      child: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: height),
          Text(
            crawlString1,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          FlutterLogo(size: width / 1.5),
          Text(
            crawlString2,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
        ],
      ),
    );
  }
}

class SuperSize extends StatelessWidget {
  SuperSize({this.child, this.height = 1000});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: height,
      maxHeight: height,
      child: child,
    );
  }
}

class Perspective extends StatelessWidget {
  Perspective({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-3.14 / 3.5),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
