import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wil_flutter_application/routes/route_manager.dart';
import 'package:wil_flutter_application/services/auth_services.dart';
import 'package:wil_flutter_application/services/firestore_services.dart';
import 'package:wil_flutter_application/services/storage_service.dart';
import 'package:wil_flutter_application/themes/app_themes.dart';
import 'package:wil_flutter_application/viewmodels/auth_viewmodel.dart';
import 'package:wil_flutter_application/viewmodels/employee_viewmodel.dart';
import 'package:wil_flutter_application/viewmodels/qualification_viewmodel.dart';
import 'package:wil_flutter_application/viewmodels/skills_viewmodel.dart';
import 'package:wil_flutter_application/viewmodels/training_viewmodel.dart';
import 'package:wil_flutter_application/views/auth/login_screen.dart';
import 'package:wil_flutter_application/views/auth/signup_screen.dart';
import 'package:wil_flutter_application/views/employee/employee_dashboard.dart';
import 'package:wil_flutter_application/views/employee/employee_form.dart';
import 'package:wil_flutter_application/views/employee/employee_profile.dart';
import 'package:wil_flutter_application/views/qualifications/qualifications_list_screen.dart';
import 'package:wil_flutter_application/views/skills/skills_list_screen.dart';
import 'package:wil_flutter_application/views/trainings/trainings_list_screen.dart';
import 'package:wil_flutter_application/views/aichat/screens/ai_chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBNvrr3B87ZYIS0ALCP6OO9guAHfwN1Um4",
        authDomain: "codets-6e4e2.firebaseapp.com",
        databaseURL: "https://codets-6e4e2-default-rtdb.firebaseio.com",
        projectId: "codets-6e4e2",
        storageBucket: "codets-6e4e2.firebasestorage.app",
        messagingSenderId: "928800433651",
        appId: "1:928800433651:web:9974ff6f71182c019c1e86",
        measurementId: "G-L7E7HH9GVM",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        Provider<StorageService>(create: (_) => StorageService()),
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<EmployeeViewModel>(
          create: (_) => EmployeeViewModel(),
        ),
        ChangeNotifierProvider<SkillsViewModel>(
          create: (_) => SkillsViewModel(),
        ),
        ChangeNotifierProvider<QualificationViewModel>(
          create: (_) => QualificationViewModel(),
        ),
        ChangeNotifierProvider<TrainingViewModel>(
          create: (_) => TrainingViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Employee Management',
        theme: AppTheme.lightTheme, // NEW: Using our enhanced theme
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.login,
        routes: {
          RouteManager.login: (context) => LoginScreen(),
          RouteManager.signup: (context) => SignupScreen(),
          RouteManager.employeeForm: (context) => EmployeeFormScreen(),
          RouteManager.employeeDashboard: (context) =>
              EmployeeDashboardScreen(),
          RouteManager.employeeProfile: (context) => EmployeeProfileScreen(),
          RouteManager.skills: (context) => SkillsListScreen(),
          RouteManager.qualifications: (context) => QualificationsListScreen(),
          RouteManager.trainings: (context) => TrainingsListScreen(),
          RouteManager.chatBoard: (context) => const AIChatScreen(),
        },
      ),
    );
  }
}
