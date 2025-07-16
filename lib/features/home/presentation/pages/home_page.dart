import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import '../../domain/usecases/get_destinations_use_case.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(
        getDestinationsUseCase: context.read<GetDestinationsUseCase>(),
      )..loadDestinations(),
      child: const HomeView(),
    );
  }
}
