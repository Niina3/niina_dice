// box_state knows the location of the robot and 
// any boxes.  It gets this from gs which is read
// out of a file ... a puzzle starting position.
// The puzzle has r for robot and b for box, but also
// s for robot sitting on a goal and c for box sitting
// on a goal.  We only record the robot and box here.

import "package:flutter_bloc/flutter_bloc.dart";

class BoxState
{ // same size rectangular grid as board.  raster coordinates.
  // This one has just 'b' for box and 'r' for 
  // robot.  This state changes as you play.
  List<List<String>> boxes = []; // starts empty 

  // takes the game state letter list-grid and extracts just
  // the box and robot info.
  BoxState.first( List<List<String>> gs )
  { boxes = [];
    int sizeX = gs.length;
    int sizeY = gs[0].length;

    for ( int i=0; i<sizeX; i++ )
    { List<String> c = [];
      for ( int j=0; j<sizeY; j++ )
      { String glet = gs[i][j];
        String letter = " ";
        if      (glet=="r" || glet=="s") { letter = "r"; }
        else if (glet=="b" || glet=="c") { letter = "b"; }
        else                             { letter = " "; }
        c.add(letter);
      }
      boxes.add(c);
    }
  }

  // This constructor is for playing the game.  We give it 
  // a new position grid, just install it.
  BoxState.update( this.boxes );
}

class BoxCubit extends Cubit<BoxState>
{
  BoxCubit( List<List<String>> gs ) : super( BoxState.first( gs) );

  void update(List<List<String>> bs ) 
  { emit( BoxState.update(bs) ); }
}