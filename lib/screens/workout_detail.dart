import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutDetailPage extends StatelessWidget {
  final String workoutId;

  const WorkoutDetailPage({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Details'),
        ),
        body: const Center(
          child: Text('Please log in to view workout details.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('workouts')
            .doc(workoutId)
            .collection('exercises')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final exercises = snapshot.data!.docs;

          if (exercises.isEmpty) {
            return const Center(
              child: Text('No exercises found for this workout.'),
            );
          }

          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExpansionTile(
                title: Text(exercise.id),
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('workouts')
                        .doc(workoutId)
                        .collection('exercises')
                        .doc(exercise.id)
                        .collection('sets')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final sets = snapshot.data!.docs;

                      if (sets.isEmpty) {
                        return const Center(
                          child: Text('No sets found for this exercise.'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: sets.length,
                        itemBuilder: (context, index) {
                          final set = sets[index];
                          return ListTile(
                            title: Text('Set ${index + 1}'),
                            subtitle: Text(
                                'Reps: ${set['reps']}, Weight: ${set['weight']} kg'),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
