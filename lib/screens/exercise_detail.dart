import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String exerciseName;
  final String workoutId;

  const ExerciseDetailPage({super.key, required this.exerciseName, required this.workoutId});

  static String id = 'exercise_detail_page';

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Future<void> _addSet() async {
    int reps = int.tryParse(_repsController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    await _firestore.collection('workouts/${widget.workoutId}/exercises/${widget.exerciseName}/sets').add({
      'reps': reps,
      'weight': weight,
    });

    _repsController.clear();
    _weightController.clear();
    setState(() {});
  }

  Future<void> _removeSet(String setId) async {
    await _firestore.doc('workouts/${widget.workoutId}/exercises/${widget.exerciseName}/sets/$setId').delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('SET', style: TextStyle(fontSize: 16, color: Colors.green)),
                Text('REP', style: TextStyle(fontSize: 16, color: Colors.green)),
                Text('WEIGHT (KGS)', style: TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('workouts/${widget.workoutId}/exercises/${widget.exerciseName}/sets').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final sets = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: sets.length,
                    itemBuilder: (context, index) {
                      final set = sets[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text((index + 1).toString(), style: const TextStyle(fontSize: 16, color: Colors.green)),
                          Text(set['reps'].toString(), style: const TextStyle(fontSize: 16, color: Colors.green)),
                          Text(set['weight'].toString(), style: const TextStyle(fontSize: 16, color: Colors.green)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeSet(set.id),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _repsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Reps'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Weight (kgs)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addSet,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('ADD SET', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
