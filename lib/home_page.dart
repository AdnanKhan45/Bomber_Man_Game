import 'dart:async';

import 'package:bomber_man_game/button.dart';
import 'package:bomber_man_game/pixels.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 130;
  int playerPosition = 0;
  int bombPosition = -1;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
    111,
    113,
    115,
    117,
    118,
  ];

  List<int> boxes = [
    12,
    14,
    16,
    19,
    28,
    39,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    116,
    119,
    99,
    79,
    59,
    103,
    83,
    63,
    43,
    107,
    96,
    65,
    3,
    6,
    8,
    30,
    50,
    70,
    100,
    121,
    123,
    127,
    45,
    36,
    47,
    85
  ];

  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerPosition + 10 <= 129 &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  List<int> fire = [-1];

  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition + 10);
          fire.add(bombPosition - 10);
        });
        clearFire();
      });
    });
  }

  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          destroyBoxes();
          bombPosition = -1;
        });
      });
    });
  }

  void destroyBoxes() {
    for (int i = 0; i < fire.length; i++) {
      if (boxes.contains(fire[i])) {
        boxes.remove(fire[i]);
      }
    }
    fire.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[800],
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    if (fire.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.red,
                        outerColor: Colors.red[800],
                      );
                    } else if (bombPosition == index) {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("lib/assets/pokeball.png"),
                        ),
                      );
                    } else if (playerPosition == index) {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset("lib/assets/bomberman.png"),
                        ),
                      );
                    } else if (barriers.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                      );
                    } else if (boxes.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.brown,
                        outerColor: Colors.brown[800],
                      );
                    } else {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                      );
                    }
                  }),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[800],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveUp,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 30,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        function: moveLeft,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_left,
                          size: 30,
                        ),
                      ),
                      MyButton(
                        function: placeBomb,
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "lib/assets/pokeball.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MyButton(
                        function: moveRight,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveDown,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
