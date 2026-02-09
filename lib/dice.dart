// Niina Miyagami
// Spring26, tac368
// week4 tue 

/*
Make an app that lets you press a button and roll a dice (die).  
If that is easy, you can put in 5 dice, roll all at once.  
And if you want more  to do, put a hold button each dice so that when you roll them,
the ones on hold do not change.
*/

import "package:flutter/material.dart";
import "dart:math";

void main()
{
  runApp(Dice());
}

class Dice extends StatelessWidget
{
  Dice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      title: "Dice",
      home: DiceHome(),
    );
  }
}

class DiceHome extends StatefulWidget
{
  @override
  State<DiceHome> createState() => DiceHomeState();
}

class DiceHomeState extends State<DiceHome>
{
  @override
  Widget build( BuildContext context)
  { return Scaffold
    (
      appBar: AppBar(title: const Text('Dice')),
      body: Row
        ( children: 
          [ Die(1), Die(2), Die(3), Die(4), Die(5), Die(6)],
        ),
    );
  } 
}

class Die extends StatefulWidget
{
  int face;
  Die(this.face);

  @override
  State<Die> createState() => DieState(face);
}

class DieState extends State<Die>
{
  int face=6;
  bool hold = false;
  DieState(this.face);
  Random randy = Random();

  Widget build( BuildContext context)
  { return Column
    ( children: 
      [ Container
    ( decoration: BoxDecoration
      ( border: Border.all( width: 1),
        color: hold? Colors.pink: Colors.white),
        height: 100, width: 100,
        child: Stack
          ( children: 
            [ ([1,3,5].contains(face)? Dot(40,40): Text("")), // center
              ([2,3,4,5,6].contains(face)? Dot(10,10): Text("")), // upper left 
              ([2,3,4,5,6].contains(face)? Dot(70,70): Text("")), // down right 
              ([4,5,6].contains(face)? Dot(10,70): Text("")), // upper right
              ([4,5,6].contains(face)? Dot(70,10): Text("")), // down left
              ([6].contains(face)? Dot(10,40): Text("") ), // center left
              ([6].contains(face)? Dot(70,40): Text("") ), // center right
            ],
          ),
      ),
      rollButton(),
      holdButton(),
      ],
    );
  }

  FloatingActionButton rollButton()
  { return FloatingActionButton
    ( onPressed: ()
      { setState
        (() 
          { if (!hold) { face = randy.nextInt(6)+1;}
          }
        );
      },
      child: Text("roll"),
    );
  }
  FloatingActionButton holdButton()
  { return FloatingActionButton
    (onPressed: () { setState(() { hold = !hold;
    });
   },
   child: Text("hold"),);
  }
}

class Dot extends Positioned
{
  final double x;
  final double y;

  Dot(this.x, this.y)
  : super 
  ( left: x, top: y, 
    child: Container
      ( height: 10, width: 10,
        decoration: BoxDecoration
          ( color: Colors.black,
            shape: BoxShape.circle,
          ),
      ),
    );
}