import 'dart:async';


import 'package:Game/bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  double barrierXone = 1.8;
  double barrierXtwo = 1.8 + 1.5;
  double barrierXthree = 1.8 + 3;
  bool gameStarted = false;
  int score = 0;
  int highscore = 0;

  @override
  void initState() {
    setState(() {

      birdYaxis = 0;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.8;
      barrierXtwo = 1.8 + 1.5;
      barrierXthree = 1.8 + 3;
      gameStarted = false;
      score = 0;
    });
  }


  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool checkLose() {
    if (barrierXone < 0.2 && barrierXone > -0.2) {
      if (birdYaxis < -0.3 || birdYaxis > 0.7) {
        return true;
      }
    }
    if (barrierXtwo < 0.2 && barrierXtwo > -0.2) {
      if (birdYaxis < -0.8 || birdYaxis > 0.4) {
        return true;
      }
    }
    if (barrierXthree < 0.2 && barrierXthree > -0.2) {
      if (birdYaxis < -0.4 || birdYaxis > 0.7) {
        return true;
      }
    }
    return false;
  }

  void startGame() {

    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;


      setState(() {



        birdYaxis = initialHeight - height;
        if (barrierXone < -2) {
          score++;
          barrierXone += 4.5;
        } else {
          barrierXone -= 0.04;
        }
        if (barrierXtwo < -2) {
          score++;

          barrierXtwo += 4.5;
        } else {
          barrierXtwo -= 0.04;
        }
        if (barrierXthree < -2) {
          score++;

          barrierXthree += 4.5;
        } else {
          barrierXthree -= 0.04;
        }
      });
      if (birdYaxis > 1.3 || checkLose()) {
        timer.cancel();
        _showDialog();

      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              "???????????? ???????????????",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "?????????: " + score.toString(),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              FlatButton(
                color:Colors.black,
                child: Text(
                  "???????????? ????????????",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (score > highscore) {
                    highscore = score;
                  }
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                  
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      child: MyBird(),
                      decoration: BoxDecoration(
               image: new DecorationImage(
               image: new AssetImage('lib/images/nile.jpg'),
               fit: BoxFit.fill,
             ),
                    ),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(" ")
                          : Text("??????????????? ????????????",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black,fontWeight:FontWeight.bold)),
                    ),
                    AnimatedContainer(
                  alignment: Alignment(barrierXone, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 150.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXthree, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 100.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 150.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 100.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXthree, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("?????????",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(score.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("?????????",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(highscore.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ],
                    ),
                  ],

                    ),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("lib/images/p1.jpg"),
                    fit: BoxFit.fill,
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
