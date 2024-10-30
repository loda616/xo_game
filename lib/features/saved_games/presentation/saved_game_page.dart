import 'package:flutter/material.dart';
import 'saved_games_controller.dart';

class SavedGamesPage extends StatelessWidget {
  final SavedGamesController controller = SavedGamesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<String>>(
        future: controller.getSavedGames(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final game = snapshot.data![index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                color: Colors.black,
                child: ListTile(
                  title: Text(game, style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
