import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart'; // Import GetX for Rx types

// --- Enums for State Management ---
enum DatabaseType { none, firebase, supabase }
enum ConnectionStatus { disconnected, connecting, connected, error }

abstract class DatabaseService {
  Future<void> initialize();
  
  // The UI will listen to this directly from the service via the controller.
  // It is now an Rx variable, not a stream.
  Rx<ConnectionStatus> get connectionStatus;
  
  DatabaseType get currentDb;
  RxString get connectionError;

  Future<bool> connect(DatabaseType type, Map<String, String> credentials);
  Future<void> disconnect();
}

// --- MOCK IMPLEMENTATION ---
class MockDatabaseService implements DatabaseService {
  final _storage = const FlutterSecureStorage();
  
  // The service now owns its state. No more Get.find here!
  @override
  final Rx<ConnectionStatus> connectionStatus = ConnectionStatus.disconnected.obs;
  @override
  final RxString connectionError = ''.obs;

  DatabaseType _currentDb = DatabaseType.none;
  @override
  DatabaseType get currentDb => _currentDb;
  
  @override
  Future<void> initialize() async {
    // Set to connecting briefly to show loading on app start if needed
    connectionStatus.value = ConnectionStatus.connecting;
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate async check

    final type = await _storage.read(key: 'db_type');
    if (type == 'firebase') {
      _currentDb = DatabaseType.firebase;
      connectionStatus.value = ConnectionStatus.connected;
    } else if (type == 'supabase') {
      _currentDb = DatabaseType.supabase;
      connectionStatus.value = ConnectionStatus.connected;
    } else {
      connectionStatus.value = ConnectionStatus.disconnected;
    }
  }
  
  @override
  Future<bool> connect(DatabaseType type, Map<String, String> credentials) async {
    connectionStatus.value = ConnectionStatus.connecting;
    connectionError.value = ''; // Clear previous errors
    await Future.delayed(const Duration(seconds: 2));

    if (credentials.values.any((v) => v.toLowerCase() == 'fail')) {
      connectionError.value = "Invalid credentials provided.";
      connectionStatus.value = ConnectionStatus.error;
      return false;
    }

    await _storage.write(key: 'db_type', value: type.name);
    for (var entry in credentials.entries) {
      await _storage.write(key: 'db_${entry.key}', value: entry.value);
    }

    _currentDb = type;
    connectionStatus.value = ConnectionStatus.connected;
    return true;
  }

  @override
  Future<void> disconnect() async {
    await _storage.deleteAll();
    _currentDb = DatabaseType.none;
    connectionStatus.value = ConnectionStatus.disconnected;
  }
}