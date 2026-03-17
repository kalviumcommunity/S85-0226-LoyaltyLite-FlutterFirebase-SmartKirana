import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  static Future<Map<String, dynamic>> loginShopOwner({
    required String phone,
    required String password,
  }) async {
    if (phone.length < 10 || password.length < 6) {
      return {
        'success': false,
        'message': 'Invalid credentials format',
      };
    }
    return {
      'success': true,
      'message': 'Login successful',
      'token': 'demo_token_shop_owner',
    };
  }

  static Future<Map<String, dynamic>> registerShopOwner({
    required String name,
    required String phone,
    required String email,
    required String shopName,
    required String location,
    required String password,
  }) async {
    if (name.isEmpty || phone.length < 10 || !email.contains('@') || shopName.isEmpty || location.isEmpty || password.length < 6) {
      return {
        'success': false,
        'message': 'Please provide valid registration details',
      };
    }
    return {
      'success': true,
      'message': 'Registration successful',
      'token': 'demo_token_registered_shop_owner',
    };
  }
}
