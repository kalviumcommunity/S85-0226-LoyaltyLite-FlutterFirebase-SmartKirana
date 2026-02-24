# 💳 LocalLoyal – Modern Loyalty System for Small Businesses

## 📌 Problem Statement

Small businesses in Tier-2 and Tier-3 towns struggle to build customer loyalty because they lack simple, affordable tools to track repeat customers or maintain reward programs.

Most existing loyalty systems:

❌ Are expensive

❌ Require complicated hardware

❌ Are not built for small shop owners

❌ Need technical knowledge

## 💡 Solution

LocalLoyal is a simple, mobile-friendly digital loyalty platform that allows small shop owners to:

- Track repeat customers
- Reward customers with points
- Create simple reward programs
- Send WhatsApp/SMS updates
- View basic analytics

Customers only need their mobile number — no app download required.

## 🚀 Features

### 👨‍💼 For Shop Owners

- Register & Login
- Add customer via phone number
- Add purchase entry
- Auto-assign loyalty points
- Create reward rules (e.g., 100 points = ₹50 discount)
- View customer history
- Dashboard analytics

### 👤 For Customers

- Earn points automatically
- Get reward eligibility notification
- View loyalty status (via link)

## 🏗️ Tech Stack

### Frontend

- Flutter
- Material Design 3
- Google Fonts
- Responsive UI

### Backend

- Node.js
- Express.js
- MongoDB
- JWT Authentication

### Optional

- Twilio / WhatsApp API (for notifications)
- Razorpay (if integrating payments)

## 🧠 How It Works

1. Shop owner logs in
2. Adds customer mobile number
3. Adds purchase amount
4. System calculates loyalty points (e.g., ₹10 = 1 point)
5. When customer reaches threshold → reward unlocked
6. Owner can redeem reward

## 🗂️ Project Structure

```
local-loyal/
├── lib/
│   ├── models/
│   │   ├── shop_owner.dart
│   │   ├── customer.dart
│   │   ├── transaction.dart
│   │   └── reward.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── database_service.dart
│   │   └── whatsapp_service.dart
│   ├── screens/
│   │   ├── auth/
│   │   ├── shop_owner/
│   │   └── customer/
│   └── main.dart
├── backend/
│   ├── models/
│   ├── routes/
│   ├── controllers/
│   └── middleware/
└── README.md
```

## 📊 Database Models

### User (Shop Owner)

```dart
class ShopOwner {
  String name;
  String phone;
  String password;
  String shopName;
  String location;
  String email;
}
```

### Customer

```dart
class Customer {
  String phone;
  int totalPoints;
  double totalSpent;
  String shopId;
  String name;
  DateTime lastVisit;
}
```

### Transaction

```dart
class Transaction {
  String customerId;
  double amount;
  int pointsEarned;
  DateTime date;
  String shopId;
  String type; // purchase or redemption
}
```

### Reward

```dart
class Reward {
  String name;
  String description;
  int pointsRequired;
  String type; // discount, free_item, cashback
  bool isActive;
  String shopId;
}
```

## 🌍 Target Audience

- Kirana stores
- Salons
- Medical shops
- Small restaurants
- Clothing shops

## 📱 Mobile-First UI Features

- **Responsive Design**: Works on all screen sizes
- **Touch-Friendly**: Large buttons and easy navigation
- **Offline Support**: Works with poor internet connectivity
- **Bilingual**: Hindi + English support
- **Simple Forms**: Easy data entry for non-technical users

## 🔐 Role-Based Access

### Shop Owner Role
- Full dashboard access
- Customer management
- Reward creation
- Analytics viewing
- QR code generation

### Customer Role
- View points balance
- Browse available rewards
- QR code scanning
- Transaction history

## 📲 WhatsApp Notification Integration

### Setup
```dart
// WhatsApp Service
class WhatsAppService {
  static Future<void> sendRewardNotification({
    required String customerPhone,
    required String rewardName,
    required int pointsEarned,
  }) async {
    // Twilio WhatsApp API integration
    final message = '''
    🎉 Congratulations! You've earned $pointsEarned points!
    🎁 Reward: $rewardName
    📱 Download LocalLoyal to claim: [link]
    ''';
    
    // Send via Twilio API
    await _sendWhatsAppMessage(customerPhone, message);
  }
}
```

### Notification Types
- **Welcome Message**: New customer registration
- **Points Earned**: After each purchase
- **Reward Unlocked**: When threshold reached
- **Special Offers**: Promotional campaigns

## 🚀 Deployment Steps

### Frontend (Flutter Web) on Vercel

1. **Build for Web**
```bash
flutter build web --release
```

2. **Deploy to Vercel**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel --prod
```

3. **vercel.json Configuration**
```json
{
  "version": 2,
  "builds": [
    {
      "src": "build/web/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/build/web/$1"
    }
  ]
}
```

### Backend (Node.js) on Render

1. **Prepare Backend**
```bash
# Create render.yaml
runtime: node
buildCommand: "npm install"
startCommand: "npm start"
```

2. **Environment Variables**
```bash
NODE_ENV=production
MONGODB_URI=mongodb://...
JWT_SECRET=your-secret
TWILIO_ACCOUNT_SID=your-sid
TWILIO_AUTH_TOKEN=your-token
```

3. **Deploy to Render**
```bash
# Connect GitHub repo to Render
# Auto-deploy on push to main branch
```

## 🔧 Environment Configuration

### .env.example
```env
# Database
MONGODB_URI=mongodb://localhost:27017/localloyal
MONGODB_TEST_URI=mongodb://localhost:27017/localloyal_test

# JWT
JWT_SECRET=your-super-secret-jwt-key
JWT_EXPIRES_IN=7d

# WhatsApp/Twilio
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_WHATSAPP_NUMBER=whatsapp:+14155238886

# App Configuration
APP_NAME=LocalLoyal
APP_URL=https://your-app.vercel.app
APP_PORT=3000

# Firebase (if using)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY=-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com

# Razorpay (if using payments)
RAZORPAY_KEY_ID=rzp_test_xxxxxxxxx
RAZORPAY_KEY_SECRET=your_secret_key
```

## 📈 Future Improvements

- QR-based loyalty system
- Referral rewards
- AI-based customer retention insights
- Multi-store support
- Offline-first mode

## 🎯 Impact

- Helps local businesses compete with big brands
- Encourages repeat customers
- Affordable SaaS model
- Increases revenue for small shops

## 📱 Installation & Setup

### Prerequisites
- Flutter SDK
- Node.js
- MongoDB
- Twilio Account (for WhatsApp)

### Quick Start

1. **Clone Repository**
```bash
git clone https://github.com/your-username/local-loyal.git
cd local-loyal
```

2. **Setup Frontend**
```bash
cd frontend
flutter pub get
flutter run
```

3. **Setup Backend**
```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your credentials
npm run dev
```

4. **Run Tests**
```bash
# Frontend
flutter test

# Backend
npm test
```

## 📞 Support & Contact

- **Documentation**: [Link to docs]
- **Issues**: [GitHub Issues]
- **Email**: support@localloyal.com
- **WhatsApp**: +91 98765 43210

## 👨‍💻 Built By

**Aman Rohilla**
(Full-Stack Developer)

- GitHub: [@amanrohilla](https://github.com/amanrohilla)
- LinkedIn: [Aman Rohilla](https://linkedin.com/in/amanrohilla)
- Portfolio: [amanrohilla.dev](https://amanrohilla.dev)

---

## 📄 License

MIT License - feel free to use this project for your own loyalty system needs!

---

**🚀 LocalLoyal - Empowering Small Businesses with Digital Loyalty!**
