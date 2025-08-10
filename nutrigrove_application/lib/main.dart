import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/tutorial/tutorial_screen.dart';
import 'services/mock_data_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const NutriGroveApp());
}

class NutriGroveApp extends StatelessWidget {
  const NutriGroveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MockDataService()),
      ],
      child: MaterialApp(
        title: 'NutriGrove',
        theme: AppTheme.lightTheme,
        home: const TutorialScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
