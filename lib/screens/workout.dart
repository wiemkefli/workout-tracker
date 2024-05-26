import 'package:flutter/material.dart';
import 'package:workoutamw/screens/active_workout.dart';
import 'package:workoutamw/screens/history.dart';
import 'package:workoutamw/screens/home_screen.dart'; // Import the HomeScreen

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  static String id = 'workout_page';

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeScreen.id);
            },
          ),
        ],
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // This replaces the "WORKOUT" text space
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ActiveWorkoutPage.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'START WORKOUT',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.pushReplacementNamed(context, HistoryPage.id);
          }
        },
      ),
    );
  }
}
