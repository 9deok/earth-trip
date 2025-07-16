import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import '../widgets/destination_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('추천 여행지')),
      body: ListView.builder(
        itemCount: controller.destinations.length,
        itemBuilder: (context, index) {
          final d = controller.destinations[index];
          return DestinationCard(title: d.title, imageUrl: d.imageUrl);
        },
      ),
    );
  }
}
