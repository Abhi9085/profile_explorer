import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider extends ChangeNotifier {
  late StreamSubscription<InternetConnectionStatus> _subscription;
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _subscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      final hasConnection = (status == InternetConnectionStatus.connected);
      if (_isOnline != hasConnection) {
        _isOnline = hasConnection;
        notifyListeners();
      }
    });
  }

  // It's important to cancel the subscription when the provider is disposed
  // to prevent memory leaks.
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
