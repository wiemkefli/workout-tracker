import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workoutamw/screens/workout.dart';
import 'package:workoutamw/screens/workout_detail.dart'; // Import the new detailed view page

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static String id = 'history_page';

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Workout History'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, WorkoutPage.id);
            },
          ),
        ),
        body: const Center(
          child: Text('Please log in to view your workout history.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, WorkoutPage.id);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('workouts')
            .orderBy('start_time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final workouts = snapshot.data!.docs;

          if (workouts.isEmpty) {
            return const Center(
              child: Text('No workouts found.'),
            );
          }

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              final startTime = (workout['start_time'] as Timestamp).toDate();
              final endTime = workout.data().containsKey('end_time') 
                ? (workout['end_time'] as Timestamp).toDate() 
                : null;
              final duration = workout.data().containsKey('duration') 
                ? Duration(seconds: workout['duration']) 
                : null;

              return ListTile(
                title: Text('Workout on ${startTime.toLocal()}'),
                subtitle: endTime != null && duration != null
                    ? Text('Duration: ${duration.inMinutes} mins ${duration.inSeconds % 60} secs')
                    : const Text('In progress...'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutDetailPage(workoutId: workout.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
