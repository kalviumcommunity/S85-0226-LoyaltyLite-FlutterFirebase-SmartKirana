import 'package:shared_preferences/shared_preferences.dart';

enum UserRole {
  shopOwner,
  customer,
  admin,
  staff,
}

class RoleService {
  static const String _roleKey = 'user_role';
  static const String _userIdKey = 'user_id';
  static const String _shopIdKey = 'shop_id';
  static const String _permissionsKey = 'user_permissions';

  /// Get current user role
  static Future<UserRole?> getCurrentRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleString = prefs.getString(_roleKey);
      
      if (roleString != null) {
        return UserRole.values.firstWhere(
          (role) => role.toString() == roleString,
          orElse: () => UserRole.customer,
        );
      }
      return null;
    } catch (e) {
      print('Error getting user role: $e');
      return null;
    }
  }

  /// Set user role
  static Future<bool> setUserRole(UserRole role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_roleKey, role.toString());
    } catch (e) {
      print('Error setting user role: $e');
      return false;
    }
  }

  /// Check if user has specific permission
  static Future<bool> hasPermission(String permission) async {
    try {
      final role = await getCurrentRole();
      final permissions = await getUserPermissions();
      
      return permissions.contains(permission) || _roleHasPermission(role!, permission);
    } catch (e) {
      print('Error checking permission: $e');
      return false;
    }
  }

  /// Get user permissions based on role
  static Future<List<String>> getUserPermissions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final permissions = prefs.getStringList(_permissionsKey);
      
      if (permissions != null) {
        return permissions;
      }
      
      // Return default permissions based on role
      final role = await getCurrentRole();
      return _getDefaultPermissions(role ?? UserRole.customer);
    } catch (e) {
      print('Error getting user permissions: $e');
      return [];
    }
  }

  /// Set user permissions
  static Future<bool> setUserPermissions(List<String> permissions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setStringList(_permissionsKey, permissions);
    } catch (e) {
      print('Error setting user permissions: $e');
      return false;
    }
  }

  /// Get current user ID
  static Future<String?> getCurrentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userIdKey);
    } catch (e) {
      print('Error getting user ID: $e');
      return null;
    }
  }

  /// Set current user ID
  static Future<bool> setCurrentUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_userIdKey, userId);
    } catch (e) {
      print('Error setting user ID: $e');
      return false;
    }
  }

  /// Get current shop ID (for shop owners)
  static Future<String?> getCurrentShopId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_shopIdKey);
    } catch (e) {
      print('Error getting shop ID: $e');
      return null;
    }
  }

  /// Set current shop ID
  static Future<bool> setCurrentShopId(String shopId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_shopIdKey, shopId);
    } catch (e) {
      print('Error setting shop ID: $e');
      return false;
    }
  }

  /// Check if user is shop owner
  static Future<bool> isShopOwner() async {
    final role = await getCurrentRole();
    return role == UserRole.shopOwner;
  }

  /// Check if user is customer
  static Future<bool> isCustomer() async {
    final role = await getCurrentRole();
    return role == UserRole.customer;
  }

  /// Check if user is admin
  static Future<bool> isAdmin() async {
    final role = await getCurrentRole();
    return role == UserRole.admin;
  }

  /// Check if user is staff
  static Future<bool> isStaff() async {
    final role = await getCurrentRole();
    return role == UserRole.staff;
  }

  /// Get default permissions for role
  static List<String> _getDefaultPermissions(UserRole role) {
    switch (role) {
      case UserRole.shopOwner:
        return [
          'customer.add',
          'customer.edit',
          'customer.delete',
          'customer.view',
          'transaction.add',
          'transaction.edit',
          'transaction.view',
          'reward.create',
          'reward.edit',
          'reward.delete',
          'reward.view',
          'analytics.view',
          'shop.edit',
          'shop.view',
          'notification.send',
          'qr.generate',
        ];
      
      case UserRole.customer:
        return [
          'points.view',
          'reward.view',
          'reward.redeem',
          'transaction.view',
          'profile.edit',
          'profile.view',
          'qr.scan',
        ];
      
      case UserRole.admin:
        return [
          'shop.add',
          'shop.edit',
          'shop.delete',
          'shop.view',
          'user.add',
          'user.edit',
          'user.delete',
          'user.view',
          'analytics.view',
          'system.config',
          'notification.send',
        ];
      
      case UserRole.staff:
        return [
          'customer.add',
          'customer.view',
          'transaction.add',
          'transaction.view',
          'reward.view',
          'analytics.view',
          'notification.send',
        ];
      
      default:
        return [];
    }
  }

  /// Check if role has specific permission
  static bool _roleHasPermission(UserRole role, String permission) {
    final defaultPermissions = _getDefaultPermissions(role);
    return defaultPermissions.contains(permission);
  }

  /// Clear all role-related data
  static Future<bool> clearRoleData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_roleKey);
      await prefs.remove(_userIdKey);
      await prefs.remove(_shopIdKey);
      await prefs.remove(_permissionsKey);
      return true;
    } catch (e) {
      print('Error clearing role data: $e');
      return false;
    }
  }

  /// Get role display name
  static String getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.shopOwner:
        return 'Shop Owner';
      case UserRole.customer:
        return 'Customer';
      case UserRole.admin:
        return 'Admin';
      case UserRole.staff:
        return 'Staff';
      default:
        return 'Unknown';
    }
  }

  /// Get role icon
  static String getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.shopOwner:
        return 'storefront';
      case UserRole.customer:
        return 'person';
      case UserRole.admin:
        return 'admin_panel_settings';
      case UserRole.staff:
        return 'badge';
      default:
        return 'help';
    }
  }

  /// Check if user can access specific screen
  static Future<bool> canAccessScreen(String screenName) async {
    final role = await getCurrentRole();
    
    switch (screenName) {
      case 'dashboard':
        return true; // All roles can access dashboard
      
      case 'customer_management':
        return role == UserRole.shopOwner || role == UserRole.admin || role == UserRole.staff;
      
      case 'reward_management':
        return role == UserRole.shopOwner || role == UserRole.admin;
      
      case 'analytics':
        return role == UserRole.shopOwner || role == UserRole.admin || role == UserRole.staff;
      
      case 'shop_settings':
        return role == UserRole.shopOwner || role == UserRole.admin;
      
      case 'user_management':
        return role == UserRole.admin;
      
      case 'rewards':
        return role == UserRole.customer;
      
      case 'qr_scanner':
        return role == UserRole.customer;
      
      default:
        return false;
    }
  }

  /// Get navigation items based on role
  static Future<List<Map<String, dynamic>>> getNavigationItems() async {
    final role = await getCurrentRole();
    
    switch (role) {
      case UserRole.shopOwner:
        return [
          {'title': 'Dashboard', 'icon': 'dashboard', 'route': '/shop/dashboard'},
          {'title': 'Customers', 'icon': 'people', 'route': '/shop/customers'},
          {'title': 'Rewards', 'icon': 'card_giftcard', 'route': '/shop/rewards'},
          {'title': 'Analytics', 'icon': 'analytics', 'route': '/shop/analytics'},
          {'title': 'Settings', 'icon': 'settings', 'route': '/shop/settings'},
        ];
      
      case UserRole.customer:
        return [
          {'title': 'My Points', 'icon': 'stars', 'route': '/customer/dashboard'},
          {'title': 'Rewards', 'icon': 'card_giftcard', 'route': '/customer/rewards'},
          {'title': 'History', 'icon': 'history', 'route': '/customer/history'},
          {'title': 'QR Scanner', 'icon': 'qr_code_scanner', 'route': '/customer/qr-scanner'},
          {'title': 'Profile', 'icon': 'person', 'route': '/customer/profile'},
        ];
      
      case UserRole.admin:
        return [
          {'title': 'Dashboard', 'icon': 'dashboard', 'route': '/admin/dashboard'},
          {'title': 'Shops', 'icon': 'store', 'route': '/admin/shops'},
          {'title': 'Users', 'icon': 'people', 'route': '/admin/users'},
          {'title': 'Analytics', 'icon': 'analytics', 'route': '/admin/analytics'},
          {'title': 'Settings', 'icon': 'settings', 'route': '/admin/settings'},
        ];
      
      case UserRole.staff:
        return [
          {'title': 'Dashboard', 'icon': 'dashboard', 'route': '/staff/dashboard'},
          {'title': 'Customers', 'icon': 'people', 'route': '/staff/customers'},
          {'title': 'Transactions', 'icon': 'receipt', 'route': '/staff/transactions'},
          {'title': 'Analytics', 'icon': 'analytics', 'route': '/staff/analytics'},
        ];
      
      default:
        return [];
    }
  }

  /// Validate user session
  static Future<bool> validateSession() async {
    try {
      final userId = await getCurrentUserId();
      final role = await getCurrentRole();
      
      return userId != null && role != null;
    } catch (e) {
      print('Error validating session: $e');
      return false;
    }
  }

  /// Get user session info
  static Future<Map<String, dynamic>?> getSessionInfo() async {
    try {
      final userId = await getCurrentUserId();
      final role = await getCurrentRole();
      final shopId = await getCurrentShopId();
      final permissions = await getUserPermissions();
      
      if (userId != null && role != null) {
        return {
          'userId': userId,
          'role': role.toString(),
          'roleDisplayName': getRoleDisplayName(role),
          'shopId': shopId,
          'permissions': permissions,
          'canAccess': await getNavigationItems(),
        };
      }
      return null;
    } catch (e) {
      print('Error getting session info: $e');
      return null;
    }
  }

  /// Check if feature is enabled for role
  static bool isFeatureEnabled(UserRole role, String feature) {
    switch (feature) {
      case 'whatsapp_notifications':
        return role == UserRole.shopOwner || role == UserRole.admin;
      
      case 'analytics':
        return role == UserRole.shopOwner || role == UserRole.admin || role == UserRole.staff;
      
      case 'multi_store':
        return role == UserRole.admin;
      
      case 'referral_program':
        return role == UserRole.shopOwner || role == UserRole.admin;
      
      case 'bulk_operations':
        return role == UserRole.shopOwner || role == UserRole.admin;
      
      default:
        return true;
    }
  }

  /// Get role-based color theme
  static Map<String, String> getRoleTheme(UserRole role) {
    switch (role) {
      case UserRole.shopOwner:
        return {
          'primary': 'orange',
          'secondary': 'deepOrange',
          'accent': 'amber',
        };
      
      case UserRole.customer:
        return {
          'primary': 'blue',
          'secondary': 'indigo',
          'accent': 'purple',
        };
      
      case UserRole.admin:
        return {
          'primary': 'red',
          'secondary': 'pink',
          'accent': 'rose',
        };
      
      case UserRole.staff:
        return {
          'primary': 'green',
          'secondary': 'teal',
          'accent': 'cyan',
        };
      
      default:
        return {
          'primary': 'grey',
          'secondary': 'blueGrey',
          'accent': 'grey',
        };
    }
  }
}
