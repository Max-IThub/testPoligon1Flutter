import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_poligon1/bloc/main_bloc.dart';
import 'package:test_poligon1/bloc/main_events.dart';
import 'package:test_poligon1/bloc/main_states.dart';

void main() {
  getIt.registerSingleton<MainBloc>(MainBloc());
  runApp(const MyApp());
}

GetIt getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Тестовый полигон'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getIt<MainBloc>().add(
      LoadingEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: BlocConsumer<MainBloc, MainState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return ListView.builder(
              itemCount: state.listOfProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    getIt<MainBloc>().add(NavigateToScreenEvent(index: 0));
                  },
                  child: Center(
                    child: Text(
                      state.listOfProducts[index],
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                );
              },
            );
          }
          if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ));
          }

          return Container();
        },
        listener: (context, state) {
          if (state is NavigateToScreenState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(appBar: AppBar(),
                      body: Center(child: Text(state.product)),
                    )));
          }
        },
        bloc: getIt<MainBloc>(),
      ),
    );
  }
}
