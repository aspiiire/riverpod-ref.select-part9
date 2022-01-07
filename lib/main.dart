import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class Car {
  final String name;
  final String model;
  final Color color;

  Car({
    required this.name,
    required this.model,
    this.color = Colors.grey,
  });
}

final carProvider = StateProvider<Car>(
  (ref) => Car(
    name: 'bmw',
    model: 'QTb',
  ),
);

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color carColor = ref.watch(carProvider.select((car) => car.color));

    ref.listen(carProvider.select((car) => car.model), (prevModel, newModel) {
      print('Our prev model was $prevModel and the new one is $newModel');
    });

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            color: carColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Some text'),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final carProviderController = ref.read(carProvider.notifier);

            carProviderController.state = Car(
              name: carProviderController.state.name,
              model: 'i93223',
              color: Colors.blue,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
