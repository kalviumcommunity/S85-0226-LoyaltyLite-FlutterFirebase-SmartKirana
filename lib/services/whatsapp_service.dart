import 'dart:convert';
import 'package:http/http.dart' as http;

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

  /// Send payment reminder (if applicable)
  static Future<bool> sendPaymentReminder({
    required String customerPhone,
    required String customerName,
    required double amount,
    required String shopName,
    required String dueDate,
  }) async {
    try {
      final message = '''
💳 Friendly Reminder, $customerName!

Outstanding balance: ₹${amount.toStringAsFixed(2)}
Due date: $dueDate

Please visit $shopName to clear your payment.

Thank you for your cooperation! 🙏
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending payment reminder: $e');
      return false;
    }
  }

  /// Send birthday/anniversary wishes
  static Future<bool> sendSpecialDayWishes({
    required String customerPhone,
    required String customerName,
    required String occasion, // 'Birthday' or 'Anniversary'
    required String shopName,
    required int bonusPoints,
  }) async {
    try {
      final emoji = occasion == 'Birthday' ? '🎂' : '💑';
      final message = '''
$emoji Happy $occasion, $customerName! $emoji

From all of us at $shopName, we wish you a wonderful day!

🎁 Special Gift: $bonusPoints bonus points added to your account!
🎉 Use them on your next visit!

Thank you for being a valued customer! 🛍️
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending special day wishes: $e');
      return false;
    }
  }

  /// Send low balance reminder
  static Future<bool> sendLowBalanceReminder({
    required String customerPhone,
    required String customerName,
    required int currentPoints,
    required int pointsNeeded,
    required String nextReward,
    required String shopName,
  }) async {
    try {
      final message = '''
🎯 You're so close, $customerName!

Current Points: $currentPoints
Points Needed: $pointsNeeded
Next Reward: $nextReward

Keep shopping at $shopName to unlock your reward! 🛍️
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending low balance reminder: $e');
      return false;
    }
  }

  /// Send shop closure notification
  static Future<bool> sendShopClosureNotification({
    required String customerPhone,
    required String customerName,
    required String shopName,
    required String closureReason,
    required String reopenDate,
  }) async {
    try {
      final message = '''
📢 Shop Update, $customerName!

$shopName will be closed temporarily.

Reason: $closureReason
Reopening: $reopenDate

We'll miss you! Visit us when we reopen! 🛍️

Team $shopName
      ''';

      return await _sendWhatsAppMessage(customerPhone, message);
    } catch (e) {
      print('Error sending shop closure notification: $e');
      return false;
    }
  }

  /// Internal method to send WhatsApp message via Twilio API
  static Future<bool> _sendWhatsAppMessage(String to, String message) async {
    try {
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$_accountSid:$_authToken'))}';
      
      final response = await http.post(
        Uri.parse('$_baseUrl/$_accountSid/Messages.json'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': 'whatsapp:$to',
          'From': _whatsappNumber,
          'Body': message,
        },
      );

      if (response.statusCode == 201) {
        print('WhatsApp message sent successfully to $to');
        return true;
      } else {
        print('Failed to send WhatsApp message: ${response.body}');
        return false;
      }
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

  /// Get message template based on type
  static String getMessageTemplate(String messageType) {
    switch (messageType) {
      case 'welcome':
        return '🎉 Welcome to {shopName}, {customerName}!';
      case 'points_earned':
        return '🌟 You earned {points} points!';
      case 'reward_unlocked':
        return '🎉 Congratulations! You unlocked {rewardName}!';
      case 'special_offer':
        return '🔥 Special Offer: {offerTitle}';
      case 'payment_reminder':
        return '💳 Payment Reminder: {amount} due';
      case 'birthday':
        return '🎂 Happy Birthday, {customerName}!';
      case 'low_balance':
        return '🎯 You are {points} points away from your next reward!';
      default:
        return '📢 Update from {shopName}';
    }
  }

  /// Schedule message (for future implementation)
  static Future<bool> scheduleMessage({
    required String customerPhone,
    required String message,
    required DateTime scheduledTime,
  }) async {
    // This would integrate with a cron job or task scheduler
    // For now, return true as placeholder
    print('Message scheduled for $scheduledTime');
    return true;
  }

  /// Get message delivery status
  static Future<Map<String, dynamic>> getMessageStatus(String messageId) async {
    try {
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$_accountSid:$_authToken'))}';
      
      final response = await http.get(
        Uri.parse('$_baseUrl/$_accountSid/Messages/$messageId.json'),
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get message status');
      }
    } catch (e) {
      print('Error getting message status: $e');
      return {};
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

  /// Get WhatsApp API usage statistics
  static Future<Map<String, dynamic>> getUsageStats() async {
    try {
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$_accountSid:$_authToken'))}';
      
      final response = await http.get(
        Uri.parse('$_baseUrl/$_accountSid/Usage.json'),
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get usage stats');
      }
    } catch (e) {
      print('Error getting usage stats: $e');
      return {};
    }
  }
}<arg_value>
<arg_key>EmptyFile</arg_key>
<arg_value>false
