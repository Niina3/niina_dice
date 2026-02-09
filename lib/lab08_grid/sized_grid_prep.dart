// sized_grid_prep.dart
// Barrett Koster  2025 
// lab
// let user enter 2D grid size, make grid that size

// modified by Niina Miyagami
// spring26, tac368
// week4 thu
// lab08

/*
starting size of the grid is 4 wide 3 high
use BLoC state to change size of the grid 
have buttons to increment the width and height 
or have text fields to type in new sizes
*/


import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main()
{ runApp(SG()); }

// added by Niina
class GridSizeState
{
  final int width;
  final int height;
  GridSizeState( this.width, this.height);
}

class GridSizeCubit extends Cubit<GridSizeState>
{
  GridSizeCubit() : super( GridSizeState( 4, 3));

  void incWidth() => emit(GridSizeState(state.width+1, state.height));
  void incHeight() => emit(GridSizeState(state.width, state.height+1));

  void decWidth() => emit(GridSizeState(state.width>1? state.width-1 : 1, state.height));
  void decHeight() => emit(GridSizeState(state.width, state.height>1? state.height-1 : 1));
}

class SG extends StatelessWidget
{
  SG({super.key});

  Widget build( BuildContext context )
  {
    return BlocProvider<GridSizeCubit>
    ( create: (context) => GridSizeCubit(),
      child: MaterialApp
      ( title: "Sized Grid",
        home: SG1()),);
  }
}

class SG1 extends StatelessWidget
{
  SG1({super.key});

  Widget build( BuildContext context )
  { return Scaffold
    ( appBar: AppBar( title: Text("sized grid") ),
      body: BlocBuilder<GridSizeCubit, GridSizeState>
      ( builder: (context, gridSizeState)
        {
          // originalGrid
          Row originalGrid = Row(children: [],);
          for (int i=0; i<4; i++)
          {
            Column col = Column(children: []);
            for (int j=0; j<3; j++)
            {
              col.children.add( Boxy(40,40));
            }
            originalGrid.children.add(col);
          }

          // theGrid
          Row theGrid = Row(children: []);
          for ( int i=0; i<gridSizeState.width; i++)
          {
            Column col = Column(children: []);
            for ( int j=0; j<gridSizeState.height; j++)
            { col.children.add( Boxy(40, 40));}
            theGrid.children.add(col);
          }
          return Column
            ( children: [
              const SizedBox(height :10),
              Row
              (children: 
              [ FloatingActionButton
                (onPressed: () => BlocProvider.of<GridSizeCubit>(context).incWidth(),
                 child: const Text("W+", style: TextStyle(fontSize: 30),),),
                FloatingActionButton
                (onPressed: () => BlocProvider.of<GridSizeCubit>(context).decWidth(),
                 child: const Text("W-", style: TextStyle(fontSize: 30),)),
                FloatingActionButton
                (onPressed: () => BlocProvider.of<GridSizeCubit>(context).incHeight(),
                 child: const Text("H+", style: TextStyle(fontSize: 30),)),
                FloatingActionButton
                (onPressed: () => BlocProvider.of<GridSizeCubit>(context).decHeight(),
                 child: const Text("H-", style: TextStyle(fontSize: 30),)),
              ],
              ),
          const SizedBox(height: 10),
          const Text("before the grid: width=4, height=3"),
          const SizedBox(height: 6),
          originalGrid,
          const SizedBox(height: 6),
          Text("after the grid: width=${gridSizeState.width}, height=${gridSizeState.height}"),
          theGrid,
          ],
          );
        },
      ),
    );
  }
}

class Boxy extends Padding
{
  final double width;
  final double height;
  Boxy( this.width,this.height ) 
  : super
    ( padding: EdgeInsets.all(4.0),
      child: Container
      ( width: width, height: height,
        decoration: BoxDecoration
        ( border: Border.all(), ),
        child: Text("x"),
      ),
    );
}
