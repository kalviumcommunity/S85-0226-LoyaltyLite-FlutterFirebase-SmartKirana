# LoyalBazaar Database Schema

## Overview
Complete database schema for LoyalBazaar loyalty platform, designed for scalability and performance in Indian market conditions.

---

## 🏗️ Architecture Decisions

### Database Choice
- **Production**: PostgreSQL 14+ (ACID compliance, reliability)
- **Development**: Firebase Firestore (Rapid prototyping)
- **Local**: SQLite (Offline support, low resource usage)

### Design Principles
- **Normalization**: 3NF to reduce data redundancy
- **Indexing**: Optimized for Indian mobile network conditions
- **Partitioning**: Geographic data distribution
- **Backup**: Automated daily backups with point-in-time recovery

---

## 📊 Core Tables

### 1. Users (Shop Owners)

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    shop_name VARCHAR(255) NOT NULL,
    shop_address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    pincode VARCHAR(6),
    gst_number VARCHAR(15),
    business_type VARCHAR(50) DEFAULT 'kirana',
    profile_image_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    subscription_plan VARCHAR(50) DEFAULT 'freemium',
    subscription_expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_at TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_city ON users(city);
CREATE INDEX idx_users_business_type ON users(business_type);
CREATE INDEX idx_users_active ON users(is_active);
```

### 2. Customers

```sql
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(10),
    profile_image_url VARCHAR(500),
    total_points INTEGER DEFAULT 0,
    available_points INTEGER DEFAULT 0,
    tier_level INTEGER DEFAULT 1, -- 1=Bronze, 2=Silver, 3=Gold
    membership_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_visit_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_spent DECIMAL(12,2) DEFAULT 0.00,
    visit_count INTEGER DEFAULT 1,
    average_monthly_spend DECIMAL(12,2) DEFAULT 0.00,
    preferred_language VARCHAR(10) DEFAULT 'hi',
    referral_code VARCHAR(20),
    referred_by UUID REFERENCES customers(id)
);

-- Indexes for customer search performance
CREATE INDEX idx_customers_shop_id ON customers(shop_id);
CREATE INDEX idx_customers_phone ON customers(phone);
CREATE INDEX idx_customers_tier ON customers(tier_level);
CREATE INDEX idx_customers_active ON customers(is_active);
CREATE INDEX idx_customers_last_visit ON customers(last_visit_at);
```

### 3. Transactions

```sql
CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    shop_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(12,2) NOT NULL,
    points_earned INTEGER DEFAULT 0,
    points_redeemed INTEGER DEFAULT 0,
    transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('purchase', 'redemption', 'bonus', 'refund', 'adjustment')),
    payment_method VARCHAR(50),
    payment_reference VARCHAR(100),
    order_id VARCHAR(100),
    description TEXT,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    staff_id UUID REFERENCES users(id), -- Staff who processed transaction
    is_offline BOOLEAN DEFAULT FALSE -- For offline sync
);

-- Transaction types and their point calculations
-- purchase: points_earned = FLOOR(amount * points_per_rupee)
-- redemption: points_redeemed = points_used, amount = actual payment
-- bonus: points_earned = bonus_amount, amount = 0
-- refund: points_redeemed = -points_refunded, amount = 0

CREATE INDEX idx_transactions_customer ON transactions(customer_id);
CREATE INDEX idx_transactions_shop ON transactions(shop_id);
CREATE INDEX idx_transactions_date ON transactions(created_at);
CREATE INDEX idx_transactions_type ON transactions(transaction_type);
CREATE INDEX idx_transactions_offline ON transactions(is_offline);
```

### 4. Rewards Catalog

```sql
CREATE TABLE rewards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    points_required INTEGER NOT NULL,
    cash_value DECIMAL(12,2), -- Actual monetary value
    reward_type VARCHAR(20) NOT NULL CHECK (reward_type IN ('product', 'discount', 'free_item', 'cashback', 'service')),
    image_url VARCHAR(500),
    inventory_count INTEGER DEFAULT 0,
    max_quantity_per_customer INTEGER,
    validity_days INTEGER, -- Days from redemption
    is_active BOOLEAN DEFAULT TRUE,
    is_limited BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP
);

CREATE INDEX idx_rewards_shop ON rewards(shop_id);
CREATE INDEX idx_rewards_category ON rewards(category);
CREATE INDEX idx_rewards_active ON rewards(is_active);
CREATE INDEX idx_rewards_expires ON rewards(expires_at);
```

### 5. Customer Rewards (Redemptions)

```sql
CREATE TABLE customer_rewards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    reward_id UUID NOT NULL REFERENCES rewards(id) ON DELETE CASCADE,
    shop_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    points_used INTEGER NOT NULL,
    transaction_id UUID REFERENCES transactions(id),
    redemption_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'expired', 'used', 'cancelled')),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_customer_rewards_customer ON customer_rewards(customer_id);
CREATE INDEX idx_customer_rewards_reward ON customer_rewards(reward_id);
CREATE INDEX idx_customer_rewards_date ON customer_rewards(redemption_date);
```

### 6. Points Ledger

```sql
CREATE TABLE points_ledger (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    shop_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    transaction_id UUID REFERENCES transactions(id),
    points_change INTEGER NOT NULL, -- Positive for earning, negative for spending
    running_balance INTEGER NOT NULL,
    points_type VARCHAR(20) NOT NULL CHECK (points_type IN ('earned', 'redeemed', 'expired', 'adjusted')),
    reference_type VARCHAR(50), -- 'purchase', 'reward', 'bonus', etc.
    reference_id UUID, -- Can reference transactions, rewards, etc.
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_points_ledger_customer ON points_ledger(customer_id);
CREATE INDEX idx_points_ledger_balance ON points_ledger(running_balance);
CREATE INDEX idx_points_ledger_date ON points_ledger(created_at);
```

### 7. Notifications

```sql
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('shop_owner', 'customer')),
    user_id UUID NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('whatsapp', 'sms', 'push', 'email')),
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    recipient VARCHAR(20), -- For customer notifications
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'delivered', 'failed')),
    scheduled_at TIMESTAMP,
    sent_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_type ON notifications(type);
CREATE INDEX idx_notifications_status ON notifications(status);
```

### 8. Analytics Events

```sql
CREATE TABLE analytics_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID REFERENCES users(id) ON DELETE CASCADE,
    event_type VARCHAR(50) NOT NULL,
    event_data JSONB, -- Flexible event data storage
    customer_id UUID REFERENCES customers(id), -- Null for shop-wide events
    session_id VARCHAR(255), -- For tracking user sessions
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Partitioned by month for performance
CREATE INDEX idx_analytics_shop_date ON analytics_events(shop_id, created_at);
CREATE INDEX idx_analytics_type_date ON analytics_events(event_type, created_at);
```

### 9. Settings & Configuration

```sql
CREATE TABLE app_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('shop_owner', 'customer')),
    user_id UUID NOT NULL,
    setting_key VARCHAR(100) NOT NULL,
    setting_value TEXT,
    is_public BOOLEAN DEFAULT FALSE, -- Can be shared with customers
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_settings_unique ON app_settings(user_type, user_id, setting_key);
```

---

## 🔄 Data Sync Strategy

### Offline-First Architecture
```sql
-- Local SQLite schema for offline operation
CREATE TABLE offline_queue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    operation_type VARCHAR(20) NOT NULL, -- 'create', 'update', 'delete'
    table_name VARCHAR(50) NOT NULL,
    record_id UUID, -- ID of the record to sync
    data JSONB, -- Complete record data
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    synced_at TIMESTAMP, -- NULL when not synced
    sync_status VARCHAR(20) DEFAULT 'pending' -- 'pending', 'synced', 'failed'
);

-- Sync status tracking
CREATE TRIGGER update_offline_queue AFTER INSERT ON offline_queue
BEGIN
    UPDATE offline_queue SET created_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;
```

---

## 📈 Performance Optimizations

### Indexing Strategy
1. **Composite Indexes**: For common query patterns
2. **Partial Indexes**: For specific column searches
3. **Covering Indexes**: For range queries
4. **Functional Indexes**: For JSONB data

### Query Optimization
```sql
-- Optimized customer search with partial matching
CREATE OR REPLACE FUNCTION customer_search(search_text TEXT) 
RETURNS TABLE(id UUID, name TEXT, phone TEXT, rank INTEGER) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        c.id,
        c.name,
        c.phone,
        ts_rank(c.name, search_text) as rank
    FROM customers c
    WHERE 
        c.phone ILIKE '%' || search_text || '%' OR
        c.name ILIKE '%' || search_text || '%'
    ORDER BY rank
    LIMIT 20;
END;
$$ LANGUAGE plpgsql;
```

---

## 🔒 Security Considerations

### Data Protection
1. **Encryption**: All sensitive data encrypted at rest
2. **Access Control**: Role-based permissions
3. **Audit Trail**: Complete change logging
4. **Data Retention**: GDPR-like policies for Indian context
5. **Backup Strategy**: Daily encrypted backups

### Compliance
1. **GST Compliance**: Proper tax invoice generation
2. **RBI Guidelines**: Digital payment regulations
3. **Data Localization**: Indian data center requirements
4. **Consumer Protection**: Indian Consumer Protection Act

---

## 📊 Migration Strategy

### Version Control
```sql
-- Migration tracking table
CREATE TABLE schema_migrations (
    id SERIAL PRIMARY KEY,
    version VARCHAR(20) NOT NULL,
    description TEXT,
    sql_up TEXT NOT NULL,
    sql_down TEXT,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rollback_sql TEXT
);
```

### Data Archival
```sql
-- Archive old transactions (older than 2 years)
CREATE TABLE transactions_archive AS 
SELECT * FROM transactions 
WHERE created_at < CURRENT_DATE - INTERVAL '2 years';

-- Partition by year for large datasets
CREATE TABLE transactions_2024 PARTITION OF transactions
FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');
```

---

## 📱 Mobile Database Considerations

### SQLite Optimizations
```sql
-- Optimized for mobile storage and query performance
CREATE TABLE customers_mobile (
    id TEXT PRIMARY KEY, -- UUID as text for compatibility
    shop_id TEXT,
    name TEXT NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    total_points INTEGER DEFAULT 0,
    available_points INTEGER DEFAULT 0,
    created_at INTEGER DEFAULT (strftime('%s', 'now')),
    last_sync_at INTEGER DEFAULT (strftime('%s', 'now'))
);

-- FTS for fast customer search
CREATE VIRTUAL TABLE customers_fts USING fts5(name, phone);
```

---

## 🚀 Scaling Strategy

### Horizontal Scaling
- **Read Replicas**: Multiple read-only database copies
- **Connection Pooling**: Efficient connection management
- **Query Caching**: Redis for frequent queries
- **Load Balancing**: Database read/write distribution

### Vertical Scaling
- **Data Partitioning**: Geographic distribution
- **Table Partitioning**: Time-based data separation
- **Archive Strategy**: Cold data movement to cheaper storage
- **Index Maintenance**: Automated rebuild and optimization

---

*Database schema designed for Indian market conditions and scalability requirements*
