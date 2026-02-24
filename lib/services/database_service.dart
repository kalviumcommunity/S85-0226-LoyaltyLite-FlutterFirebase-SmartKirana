import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  static const String baseUrl = 'https://your-api-domain.com/api'; // Replace with actual API URL
  static const String _tokenKey = 'auth_token';

  // Get stored auth token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Store auth token
  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Clear auth token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Generic API call with auth
  static Future<Map<String, dynamic>> _makeAuthenticatedRequest(
    String endpoint,
    String method,
    Map<String, dynamic>? body,
  ) async {
    final token = await getToken();
    if (token == null) {
      return {
        'success': false,
        'message': 'Not authenticated',
      };
    }

    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      late http.Response response;
      
      switch (method.toLowerCase()) {
        case 'get':
          response = await http.get(uri, headers: headers);
          break;
        case 'post':
          response = await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'put':
          response = await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'delete':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'API error: ${response.statusCode}',
          'error': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Shop Owner Operations
  static Future<Map<String, dynamic>> getShopOwnerProfile() async {
    return await _makeAuthenticatedRequest('/shop-owner/profile', 'GET');
  }

  static Future<Map<String, dynamic>> updateShopOwnerProfile(Map<String, dynamic> data) async {
    return await _makeAuthenticatedRequest('/shop-owner/profile', 'PUT', body: data);
  }

  // Customer Operations
  static Future<Map<String, dynamic>> addCustomer(Map<String, dynamic> customerData) async {
    return await _makeAuthenticatedRequest('/customers', 'POST', body: customerData);
  }

  static Future<Map<String, dynamic>> getCustomers({int page = 1, int limit = 20}) async {
    return await _makeAuthenticatedRequest('/customers?page=$page&limit=$limit', 'GET');
  }

  static Future<Map<String, dynamic>> getCustomerById(String customerId) async {
    return await _makeAuthenticatedRequest('/customers/$customerId', 'GET');
  }

  static Future<Map<String, dynamic>> updateCustomer(String customerId, Map<String, dynamic> data) async {
    return await _makeAuthenticatedRequest('/customers/$customerId', 'PUT', body: data);
  }

  static Future<Map<String, dynamic>> deleteCustomer(String customerId) async {
    return await _makeAuthenticatedRequest('/customers/$customerId', 'DELETE');
  }

  // Transaction Operations
  static Future<Map<String, dynamic>> addTransaction(Map<String, dynamic> transactionData) async {
    return await _makeAuthenticatedRequest('/transactions', 'POST', body: transactionData);
  }

  static Future<Map<String, dynamic>> getTransactions({String? customerId, int page = 1, int limit = 20}) async {
    String endpoint = '/transactions?page=$page&limit=$limit';
    if (customerId != null) {
      endpoint += '&customerId=$customerId';
    }
    return await _makeAuthenticatedRequest(endpoint, 'GET');
  }

  // Reward Operations
  static Future<Map<String, dynamic>> addReward(Map<String, dynamic> rewardData) async {
    return await _makeAuthenticatedRequest('/rewards', 'POST', body: rewardData);
  }

  static Future<Map<String, dynamic>> getRewards({String? shopId, int page = 1, int limit = 20}) async {
    String endpoint = '/rewards?page=$page&limit=$limit';
    if (shopId != null) {
      endpoint += '&shopId=$shopId';
    }
    return await _makeAuthenticatedRequest(endpoint, 'GET');
  }

  static Future<Map<String, dynamic>> updateReward(String rewardId, Map<String, dynamic> data) async {
    return await _makeAuthenticatedRequest('/rewards/$rewardId', 'PUT', body: data);
  }

  static Future<Map<String, dynamic>> deleteReward(String rewardId) async {
    return await _makeAuthenticatedRequest('/rewards/$rewardId', 'DELETE');
  }

  // Analytics Operations
  static Future<Map<String, dynamic>> getAnalytics(String period) async {
    return await _makeAuthenticatedRequest('/analytics?period=$period', 'GET');
  }

  static Future<Map<String, dynamic>> getDashboardData() async {
    return await _makeAuthenticatedRequest('/dashboard', 'GET');
  }

  // QR Code Operations
  static Future<Map<String, dynamic>> checkInCustomer(String qrData) async {
    return await _makeAuthenticatedRequest('/check-in', 'POST', body: {
      'qrData': qrData,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Report Generation
  static Future<Map<String, dynamic>> generateReport(String type, String period) async {
    return await _makeAuthenticatedRequest('/reports/generate?type=$type&period=$period', 'GET');
  }

  // WhatsApp/SMS Notification
  static Future<Map<String, dynamic>> sendNotification({
    required String customerId,
    required String message,
    required String type, // 'whatsapp', 'sms'
    String? phoneNumber,
  }) async {
    return await _makeAuthenticatedRequest('/notifications/send', 'POST', body: {
      'customerId': customerId,
      'message': message,
      'type': type,
      'phoneNumber': phoneNumber,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
