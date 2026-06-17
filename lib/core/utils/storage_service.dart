import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:super_system/core/network/dio_factory.dart';

class StorageService {
  static StorageService? _instance;
  late final FlutterSecureStorage _secureStorage;
  late final SharedPreferences _preferences;

  // Private constructor
  StorageService._internal();

  // Factory constructor
  factory StorageService() {
    _instance ??= StorageService._internal();
    return _instance!;
  }

  // Initialize method to be called at app startup
  static Future<void> initialize() async {
    final instance = StorageService();
    instance._secureStorage = const FlutterSecureStorage();
    instance._preferences = await SharedPreferences.getInstance();
  }

  // Secure Storage - for sensitive data
  Future<void> saveSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecure(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearSecure() async {
    await _secureStorage.deleteAll();
  }

  // Shared Preferences - for non-sensitive data
  Future<void> save(String key, dynamic value) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    }
  }

  dynamic get(String key, {dynamic defaultValue}) {
    return _preferences.get(key) ?? defaultValue;
  }

  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    return _preferences.getStringList(key) ?? defaultValue;
  }

  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  Future<void> clear() async {
    await _preferences.clear();
  }

  // Add this key with the others

  // Favorites: Save full list
  Future<void> saveFavoriteProducts(List<String> productIds) async {
    await _preferences.setStringList(keyFavoriteProducts, productIds);
  }

  // Favorites: Get full list
  List<String> getFavoriteProducts() {
    return _preferences.getStringList(keyFavoriteProducts) ?? [];
  }

  // Favorites: Add or remove a product ID
  Future<void> toggleFavoriteProduct(String productId) async {
    final current = getFavoriteProducts();
    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    await saveFavoriteProducts(current);
  }

  // Favorites: Check if a product is favorite
  bool isFavorite(String productId) {
    return getFavoriteProducts().contains(productId);
  }

  // Favorites: Clear all favorites
  Future<void> clearFavoriteProducts() async {
    await _preferences.remove(keyFavoriteProducts);
  }

  Future<void> saveCustomerInfo({
    required String name,
    required String phone,
    required String area,
    required String governorate,
    required String address,
  }) async {
    await _preferences.setString(keyCustomerName, name);
    await _preferences.setString(keyCustomerPhone, phone);
    await _preferences.setString(keyCustomerArea, area);
    await _preferences.setString(keyCustomerGovernorate, governorate);
    await _preferences.setString(keyCustomerAddress, address);
  }

  Map<String, String> getCustomerInfo() {
    return {
      'name': _preferences.getString(keyCustomerName) ?? '',
      'firstPhoneNumber': _preferences.getString(keyCustomerPhone) ?? '',
      'area': _preferences.getString(keyCustomerArea) ?? '',
      'governorate': _preferences.getString(keyCustomerGovernorate) ?? '',
      'address': _preferences.getString(keyCustomerAddress) ?? '',
    };
  }

  Future<void> clearCustomerInfo() async {
    await _preferences.remove(keyCustomerName);
    await _preferences.remove(keyCustomerPhone);
    await _preferences.remove(keyCustomerArea);
    await _preferences.remove(keyCustomerGovernorate);
    await _preferences.remove(keyCustomerAddress);
  }

  // Storage keys
  static const String keyFavoriteProducts = 'favorite_products';
  static const String keyToken = 'token';
  static const String keyUser = 'user';
  static const String keyOnboarding = 'onboarding_completed';
  static const String keyLanguage = 'language';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyStudentName = 'student_name';
  static const String keyStudentCode = 'student_code';
  static const String keyGroupName = 'group_name';
  static const String keyParentPhone = 'parent_phone';

  // User info keys
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserPhone = 'user_phone';
  static const String keyUserToken = 'user_token';
  static const String keyUserLoggedIn = 'user_logged_in';
  static const String keyStoreName = 'store_name';
  static const String dateOfBirth = 'date_of_birth';

  // Customer info keys
  static const String keyCustomerName = 'customer_name';
  static const String keyCustomerPhone = 'customer_phone';
  static const String keyCustomerArea = 'customer_area';
  static const String keyCustomerGovernorate = 'customer_governorate';
  static const String keyCustomerAddress = 'customer_address';

  static const String keyUserGender = 'user_gender';

  static const String secondPhone = 'second_phone';

  static const String keyIsFirstTime = 'is_first_time';
  static const String keyAcademicYear = 'academic_year';
  static const String keySavedAccounts = 'saved_accounts';

  // Get all saved accounts
  List<Map<String, dynamic>> getSavedAccounts() {
    final String jsonStr = getString(keySavedAccounts, defaultValue: '[]');
    try {
      final list = json.decode(jsonStr) as List;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } catch (_) {
      return [];
    }
  }

  // Save the current active account info into the saved list
  Future<void> saveCurrentAccountToList() async {
    final currentCode = getString(keyStudentCode);
    if (currentCode.isEmpty) return;

    final name = getString(keyStudentName);
    final phone = getString(keyParentPhone);
    final group = getString(keyGroupName);
    final academic = getString(keyAcademicYear);
    final token = await getSecure(keyUserToken) ?? '';
    final refresh = await getSecure(keyRefreshToken) ?? '';

    final accounts = getSavedAccounts();
    accounts.removeWhere((element) => element['studentCode'] == currentCode);
    accounts.insert(0, {
      'studentName': name,
      'studentCode': currentCode,
      'parentPhone': phone,
      'groupName': group,
      'academicYear': academic,
      'userToken': token,
      'refreshToken': refresh,
    });

    await save(keySavedAccounts, json.encode(accounts));
  }

  // Switch to another account by studentCode
  Future<void> switchAccount(String studentCode) async {
    // First, save current state of active account
    await saveCurrentAccountToList();

    final accounts = getSavedAccounts();
    final targetAccount = accounts.firstWhere(
      (element) => element['studentCode'] == studentCode,
      orElse: () => {},
    );

    if (targetAccount.isEmpty) return;

    // Set target account as active
    await save(keyStudentName, targetAccount['studentName'] ?? '');
    await save(keyStudentCode, targetAccount['studentCode'] ?? '');
    await save(keyParentPhone, targetAccount['parentPhone'] ?? '');
    await save(keyGroupName, targetAccount['groupName'] ?? '');
    await save(keyAcademicYear, targetAccount['academicYear'] ?? '');
    await saveSecure(keyUserToken, targetAccount['userToken'] ?? '');
    await saveSecure(keyRefreshToken, targetAccount['refreshToken'] ?? '');

    // Set Dio token
    DioFactory.setTokenIntoHeaderAfterLogin(targetAccount['userToken'] ?? '');
  }
}
