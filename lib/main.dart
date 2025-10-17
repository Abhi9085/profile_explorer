// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'presentation/providers/user_provider.dart';
// import 'presentation/screens/home/home_screen.dart';

// void main() {
//   runApp(const ProfileExplorerApp());
// }

// class ProfileExplorerApp extends StatelessWidget {
//   const ProfileExplorerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Profile Explorer',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorSchemeSeed: Colors.indigo,
//         ),
//         home: const HomeScreen(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/connectivity_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/widgets/offline_screen.dart';

void main() {
  runApp(const ProfileExplorerApp());
}

class ProfileExplorerApp extends StatelessWidget {
  const ProfileExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Updated UserProvider to use dependency injection
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Added the new ConnectivityProvider
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Profile Explorer',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        // The home is now a wrapper that checks for connectivity
        home: const AppWrapper(),
      ),
    );
  }
}

// This new widget will listen to the connectivity status and build the UI accordingly.
class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes in the connectivity provider
    final connectivityProvider = context.watch<ConnectivityProvider>();

    // If the device is online, show the HomeScreen.
    // Otherwise, show the OfflineScreen.
    if (connectivityProvider.isOnline) {
      return const HomeScreen();
    } else {
      return const OfflineScreen();
    }
  }
}
