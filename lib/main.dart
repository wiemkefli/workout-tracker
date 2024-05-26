import 'package:flutter/material.dart';
import 'package:workoutamw/screens/home_screen.dart';
import 'package:workoutamw/screens/login_screen.dart';
import 'package:workoutamw/screens/signup_screen.dart';
import 'package:workoutamw/screens/workout.dart';
import 'package:workoutamw/screens/history.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workoutamw/screens/active_workout.dart';
import 'package:workoutamw/screens/muscle_group_selection.dart';
import 'package:workoutamw/screens/arm_workout.dart';
import 'package:workoutamw/screens/exercise_detail.dart';
import 'package:workoutamw/screens/chest_workout.dart';
import 'package:workoutamw/screens/leg_workout.dart';
import 'package:workoutamw/screens/abs_workout.dart';
import 'package:workoutamw/screens/home_after_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        HomeScreen.id: (context) => const HomeScreen(), // Add this line
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        WorkoutPage.id: (context) => const WorkoutPage(),
        HistoryPage.id: (context) => const HistoryPage(),
        ActiveWorkoutPage.id: (context) => const ActiveWorkoutPage(),
        HomeAfterLoginPage.id: (context) => const HomeAfterLoginPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == MuscleGroupSelectionPage.id) {
          final Function(String) onSelectExercise = settings.arguments as Function(String);
          return MaterialPageRoute(
            builder: (context) {
              return MuscleGroupSelectionPage(onSelectExercise: onSelectExercise);
            },
          );
        } else if (settings.name == ArmWorkoutPage.id) {
          final Function(String) onSelectExercise = settings.arguments as Function(String);
          return MaterialPageRoute(
            builder: (context) {
              return ArmWorkoutPage(onSelectExercise: onSelectExercise);
            },
          );
        } else if (settings.name == ChestWorkoutPage.id) {
          final Function(String) onSelectExercise = settings.arguments as Function(String);
          return MaterialPageRoute(
            builder: (context) {
              return ChestWorkoutPage(onSelectExercise: onSelectExercise);
            },
          );
        } else if (settings.name == LegWorkoutPage.id) {
          final Function(String) onSelectExercise = settings.arguments as Function(String);
          return MaterialPageRoute(
            builder: (context) {
              return LegWorkoutPage(onSelectExercise: onSelectExercise);
            },
          );
        } else if (settings.name == AbsWorkoutPage.id) {
          final Function(String) onSelectExercise = settings.arguments as Function(String);
          return MaterialPageRoute(
            builder: (context) {
              return AbsWorkoutPage(onSelectExercise: onSelectExercise);
            },
          );
        } else if (settings.name == ExerciseDetailPage.id) {
          final Map<String, String> args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) {
              return ExerciseDetailPage(
                exerciseName: args['exerciseName']!,
                workoutId: args['workoutId']!,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
