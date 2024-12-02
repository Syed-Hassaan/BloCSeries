import 'package:blocseries/bloc/counter_bloc.dart';
import 'package:blocseries/bloc/counter_event.dart';
import 'package:blocseries/bloc/counter_state.dart';
import 'package:blocseries/visibility_bloc/visiblity_bloc.dart';
import 'package:blocseries/visibility_bloc/visiblity_event.dart';
import 'package:blocseries/visibility_bloc/visiblity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BloC Series',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [

        BlocProvider(create: (context)=>CounterBloc()),
        BlocProvider(create: (context)=>VisiblityBloc()),
          ],
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
                buildWhen: (previous, current) {
              debugPrint("Previous Count ${previous.count}");
              debugPrint("Current Count ${current.count}");
              return current.count >= 2;
            },
                // bloc: counterBloc,
                builder: (context, state) {
              return Text(
                state.count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            BlocBuilder<VisiblityBloc, VisibilityState>(
              
                builder: (context, state) {
                  return Visibility(
                      visible: state.show,
                      child: Container(
                        color: Colors.purple,
                        height: 200,
                        width: 200,
                      ));
                })
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CoutnerDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisiblityBloc>().add(VisiblityShowEvent());
            },
            child: const Text("Show"),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisiblityBloc>().add(VisiblityHideEvent());

            },
            child: const Text("Hide"),
          ),
        ],
      ),
    );
  }
}
