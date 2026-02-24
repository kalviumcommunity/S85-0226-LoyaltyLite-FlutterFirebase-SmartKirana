import 'dart:convert';

class WhatsAppService {
  static const String _baseUrl = 'https://api.twilio.com/2010-04-01/Accounts';
  
  // Twilio credentials (should be loaded from environment variables)
  static const String _accountSid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  static const String _authToken = 'your_auth_token';
  static const String _whatsappNumber = 'whatsapp:+14155238886';

  /// Send welcome message to new customer
  static Future<bool> sendWelcomeMessage({
    required String customerPhone,
    required String shopName,
    required String customerName,
  }) async {
    try {
      final message = '''
🎉 Welcome to $shopName, $customerName!

Thank you for joining our loyalty program! 🎁

📱 Start earning points with every purchase
🎁 Unlock exciting rewards
📊 Track your loyalty status

Questions? Call us at our shop!

Team $shopName
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending welcome message: $e');
      return false;
    }
  }

  /// Send points earned notification
  static Future<bool> sendPointsEarnedNotification({
    required String customerPhone,
    required String customerName,
    required int pointsEarned,
    required int totalPoints,
    required String shopName,
    required double purchaseAmount,
  }) async {
    try {
      final message = '''
🌟 Great news, $customerName!

You've earned $pointsEarned points on your purchase of ₹${purchaseAmount.toStringAsFixed(2)}!

📊 Current Balance: $totalPoints points
🎁 Keep shopping to unlock amazing rewards!

Thank you for choosing $shopName! 🛍️
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending points notification: $e');
      return false;
    }
  }

  /// Send reward unlocked notification
  static Future<bool> sendRewardUnlockedNotification({
    required String customerPhone,
    required String customerName,
    required String rewardName,
    required String rewardDescription,
    required String shopName,
  }) async {
    try {
      final message = '''
🎉 CONGRATULATIONS, $customerName! 🎉

You've unlocked an amazing reward! 🎁

🌟 Reward: $rewardName
📝 Details: $rewardDescription

Visit $shopName to claim your reward!

Show this message to redeem 📱
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending reward notification: $e');
      return false;
    }
  }

  /// Send special offer/promotional message
  static Future<bool> sendSpecialOffer({
    required String customerPhone,
    required String customerName,
    required String offerTitle,
    required String offerDescription,
    required String shopName,
    required String validUntil,
  }) async {
    try {
      final message = '''
🔥 SPECIAL OFFER for $customerName! 🔥

$offerTitle

$offerDescription

⏰ Valid until: $validUntil
📍 Visit: $shopName

Don't miss out on this amazing deal! 🛍️
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending special offer: $e');
      return false;
    }
  }

  /// Send bulk messages (for promotional campaigns)
  static Future<Map<String, int>> sendBulkMessages({
    required List<String> phoneNumbers,
    required String message,
  }) async {
    int successCount = 0;
    int failureCount = 0;

    for (String phone in phoneNumbers) {
      bool success = await _sendWhatsAppMessage(phone, message);
      if (success) {
        successCount++;
      } else {
        failureCount++;
      }
      
      // Add delay to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return {
      'success': successCount,
      'failure': failureCount,
      'total': phoneNumbers.length,
    };
  }

  /// Internal method to send WhatsApp message via Twilio API
  static Future<bool> _sendWhatsAppMessage(String to, String message) async {
    try {
      // Simulate API call - in real implementation, use http package
      print('Sending WhatsApp to $to: $message');
      
      // Simulate success
      await Future.delayed(const Duration(milliseconds: 500));
      print('WhatsApp message sent successfully to $to');
      return true;
    } catch (e) {
      print('Error sending WhatsApp message: $e');
      return false;
    }
  }

  /// Format phone number to international format
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    String cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Add +91 prefix for Indian numbers if not present
    if (cleaned.length == 10) {
      return '+91$cleaned';
    } else if (cleaned.startsWith('91') && cleaned.length == 12) {
      return '+$cleaned';
    } else if (cleaned.startsWith('+')) {
      return cleaned;
    }
    
    return cleaned;
  }

  /// Validate phone number format
  static bool isValidPhoneNumber(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    
    // Check for Indian numbers (10 digits or +91 followed by 10 digits)
    if (cleaned.length == 10) {
      return true;
    } else if (cleaned.startsWith('+91') && cleaned.length == 13) {
      return true;
    } else if (cleaned.startsWith('91') && cleaned.length == 12) {
      return true;
    }
    
    return false;
  }
}
