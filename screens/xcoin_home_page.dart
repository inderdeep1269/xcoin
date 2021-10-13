import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:xcoin/services/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var increasingRate = 0.30;

  late RuntimeArtboard _riveArtBoard;
  late RiveAnimationController _controller;

  bool isClicked = false;
  var currentTime;
  late DateTime clickTime;
  late DateTime closeTime;

  void initArt() async {
    rootBundle.load('assets/Animation/mining.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(_controller = OneShotAnimation('Idle_Mode'));
      _riveArtBoard = artboard as RuntimeArtboard;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime _tempTime = DateTime.now();
      if (_tempTime.second == closeTime.second) {
        isClicked = false;
        _riveArtBoard.removeController(_controller);
        _riveArtBoard
            .addController(_controller = OneShotAnimation('Idle_Mode'));
      }
      //  Update Condition with hours.
      setState(() {});
    });
    initArt();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context);
    final isXCoinDark = (_theme.getTheme() == ThemeData.dark());

    final _height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
            // color: Colors.greenAccent.withOpacity(0.2),
            // color: const Color(0xFF212126),
            ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Animations.....................
              Flexible(
                  child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Rive(artboard: _riveArtBoard))),

              SizedBox(height: _height * 0.03),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: isClicked
                    ? Text('$increasingRate X/hr',
                        style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: isXCoinDark ? Colors.white : Colors.black))
                    : RaisedButton(
                        onPressed: () {
                          setState(() {
                            isClicked = true;
                            clickTime = DateTime.now();
                            closeTime =
                                clickTime.add(const Duration(seconds: 10));
                            // Add Hours...........................................

                            _riveArtBoard.addController(
                                _controller = OneShotAnimation('Mining_Mode'));
                          });
                        },
                        child: const Text('Start Mining')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
