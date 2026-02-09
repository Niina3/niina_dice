// Niina Miyagami
// Spring26 tac368
// w4 thu
// lab07 CounterBloc

// remake the default flutter app, counter 
// using BlocProvider 

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:niina_dice/main.dart";

void main(){runApp( const MyApp());}

class CounterCubit extends Cubit<int>
{
  CounterCubit() : super(0);
  void increment() => emit(state+1);
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build( BuildContext context )
  {return MaterialApp(
      title: 'CounterBloc',
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const MyHomePage(title: 'CounterBloc'),
      ),
    );
  }
}

class MyAppHome extends StatelessWidget
{ const MyAppHome({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context)
  { return Scaffold
    ( appBar: AppBar( title: const Text("CounterBloc")),
      body: Center(
      child: Column
        ( children: 
            [ const Text('You have pushed the button this many times:'),
              BlocBuilder<CounterCubit, int>
                ( builder: (context, counter)
                  { return Text
                    ( '$counter',
                      style: const TextStyle(fontSize:30),
                    );
                  },
                ),
            ],
          ),  
      ),
      floatingActionButton: 
      FloatingActionButton
        ( //onPressed: () => context.read<CounterCubit>().increment(),
          onPressed: () => BlocProvider.of<CounterCubit>(context),
          tooltip: 'Increment',
          child: const Icon(Icons.add),),         
    );
  }
}   
   
