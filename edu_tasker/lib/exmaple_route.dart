// TODO1 import library
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//TODO2
// The route config

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state){
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          // name: 'goToDetails',
          path: 'details',
          builder:(BuildContext context, GoRouterState state){
            return const DetailsScreen();
          },
        )
      ],
    ),
  ]
);

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Go Router',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to the Details screen'),
          onPressed: ()=> context.go('/details'),
          // onPressed: ()=> context.goNamed('/details'),
          ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){context.pop();},
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to the Home Page'),
          onPressed: () => context.go('/'),
        )
      ),
    );
  }
}