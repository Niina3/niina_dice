// Niina Miyagami
// Spring26, tac368
// hw3 lights out game

/*
instructions: 
Start with 9 lights, with increase and decrease buttons (for more and fewer lights)
lights are randomly on/off to start
clicking on a light flips that one AND its 2 neighbors (but not past the end)
goal: get all of the lights to go out
*/

/*
what I need:
default 9 boxes for lights with incrase and decrease buttons - Row 
random to fill the lights' colors - yellow - on, brown - off
clicking on light changes color - row of buttons under light boxes 
clicking changes its 2 neighbors 
*/

/*
structure:
- title
- light bulb boxes
- row of light on/off buttons
- number of bulb boxes 
- increase/decrease buttons 
*/

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'dart:math';

void main()
{ runApp(LO());}

class LightState 
{
  final List<bool> lights; // on/off

  LightState(this.lights);
}

class LightCubit extends Cubit<LightState>
{
  static final randy = Random();

  LightCubit() : super(LightState(_random(9))); // starts with 9 lights 

  static List<bool> _random(int n) // randomly assign on/off
  {
    List<bool> lights = [];

    for (int i=0; i<n; i++) 
    { lights.add(randy.nextBool());}
    return lights; 
  }

  // button methods 
  void increase() => emit(LightState(_random(state.lights.length+1)));

  void decrease() 
  {
    if (state.lights.length>1) { emit(LightState(_random(state.lights.length-1)));}
    else { emit(LightState(_random(1)));}
  }

  void change(int i)
  {
    List<bool> newLights = []; // to store the changes 

    for (int j=0; j<state.lights.length; j++) // first copy lights to newLights 
    { newLights.add(state.lights[j]);}

    newLights[i] = !newLights[i]; // change the light 

    // change the left one if not on the edge
    if (i-1 >=0)
    { newLights[i-1] = !newLights[i-1];}

    // change the right one if not on the edge
    if (i+1< newLights.length)
    { newLights[i+1] = !newLights[i+1];}

    emit(LightState(newLights));
  }
}

class LO extends StatelessWidget
{
  LO({super.key});

  @override
  Widget build(BuildContext context) 
  { return BlocProvider<LightCubit>
    (create: (context) => LightCubit(),
    child: MaterialApp
      ( title: 'Lights Out Game',
        home: LOHome(),
      ),
    );
  }
}

class LOHome extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  { return Scaffold
    ( appBar: AppBar(title: const Text('Lights Out Game')),
      body: BlocBuilder<LightCubit, LightState>
      ( builder: (context, lightState)
        { 
          // row of light boxes 
          Row lightRow = Row
          ( mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          );
          for (int i=0; i<lightState.lights.length; i++)
          { lightRow.children.add(LightBox(lightState.lights[i]));} //LightBox
          
          // light on/off buttons
          Row buttonRow = Row
          ( mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          );
          for (int i=0; i<lightState.lights.length; i++)
          { buttonRow.children.add
            ( FloatingActionButton
              ( onPressed: () {BlocProvider.of<LightCubit>(context).change(i);},
                child: const Text(""),
              ),
            ); //LightButton 
          }

          return Column
          ( children: [
            // structure
            const SizedBox(height: 10,),
            lightRow, // light boxes
            buttonRow, // on/off buttons 
            // number of light boxes
            const SizedBox(height: 10,),
            Text("${lightState.lights.length} lights", style: const TextStyle(fontSize: 20),),
            // increase/decrease buttons 
            const SizedBox(height: 10,),
            Row
            ( mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [ FloatingActionButton
                ( 
                  onPressed: () => BlocProvider.of<LightCubit>(context).decrease(),
                  tooltip: "decrease",
                  child: const Text("-"),
                ),
                FloatingActionButton
                (
                  onPressed: () => BlocProvider.of<LightCubit>(context).increase(),
                  tooltip: "increase",
                  child: const Text("+"),
                ),
              ]
            ),
            const SizedBox(height: 10,),
          ]
          );
        }
      ),
    );
  }
}

class LightBox extends StatelessWidget
{
  final bool isOn;
  LightBox(this.isOn);

  @override
  Widget build(BuildContext context) 
  { return Container
    ( height: 55, width: 55,
      decoration: BoxDecoration
      ( border: Border.all( width: 2),
        color: (isOn? Colors.yellow : Color(0xff6b4b3e)),
      ),
    );
  }
}

class LightButton extends StatelessWidget
{
  final int index;
  LightButton(this.index);

  @override
  Widget build(BuildContext context) 
  { return Listener
    ( onPointerDown: (_) {BlocProvider.of<LightCubit>(context).change(index);} ,
      child: Container
      ( height: 50, width: 50,
        decoration: BoxDecoration
        ( color: const Color(0xffe6ddff),),
      ),
    );
  }
}
