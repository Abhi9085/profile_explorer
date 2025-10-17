import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;
  String? _selectedCountry;

  // --- Getters ---
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCountry => _selectedCountry;

  // --- Filtered users based on country ---
  List<UserModel> get filteredUsers {
    if (_selectedCountry == null) return _users;
    return _users.where((u) => u.country == _selectedCountry).toList();
  }

  // --- Unique available countries ---
  List<String> get availableCountries {
  // Create a unique sorted list of country names
    final countries = _users.map((u) => u.country).toSet().toList();
    countries.sort();
    return countries;
  }


  // --- Fetch users from API ---
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _service.fetchUsers();
      if (_selectedCountry != null &&
      !_users.any((u) => u.country == _selectedCountry)) {
        _selectedCountry = null;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Toggle like status ---
  void toggleLike(UserModel user) {
    user.isLiked = !user.isLiked;
    notifyListeners();
  }

  // --- Set selected country ---
  void setCountry(String? country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
