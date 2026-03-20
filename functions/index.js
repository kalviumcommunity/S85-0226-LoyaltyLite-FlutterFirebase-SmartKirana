const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

// ==================== CALLABLE FUNCTIONS ====================

/**
 * Simple greeting function - callable from Flutter
 * Returns a personalized greeting message
 */
exports.sayHello = functions.https.onCall((data, context) => {
  const name = data.name || "User";
  const timestamp = new Date().toISOString();
  
  console.log(`sayHello called with name: ${name} at ${timestamp}`);
  
  return { 
    message: `Hello, ${name}!`,
    timestamp: timestamp,
    success: true
  };
});

/**
 * User profile function - callable from Flutter
 * Processes user data and returns formatted profile
 */
exports.getUserProfile = functions.https.onCall((data, context) => {
  const userId = data.userId;
  const name = data.name || "Anonymous User";
  const email = data.email || "no-email@example.com";
  
  console.log(`getUserProfile called for userId: ${userId}`);
  
  // Simulate processing user data
  const profile = {
    userId: userId,
    name: name,
    email: email,
    displayName: name.split(' ')[0],
    initials: name.split(' ').map(n => n[0]).join('').toUpperCase(),
    memberSince: new Date().toISOString().split('T')[0],
    status: "active",
    processedAt: new Date().toISOString()
  };
  
  return {
    profile: profile,
    message: "Profile processed successfully",
    success: true
  };
});

/**
 * Send notification function - callable from Flutter
 * Simulates sending a notification to a user
 */
exports.sendNotification = functions.https.onCall((data, context) => {
  const userId = data.userId;
  const title = data.title || "Notification";
  const body = data.body || "You have a new notification";
  
  console.log(`sendNotification called for userId: ${userId}, title: ${title}`);
  
  // Simulate notification processing
  const notification = {
    id: `notif_${Date.now()}`,
    userId: userId,
    title: title,
    body: body,
    type: "info",
    timestamp: new Date().toISOString(),
    read: false
  };
  
  // In a real app, you would send this via FCM or store in Firestore
  return {
    notification: notification,
    message: "Notification sent successfully",
    success: true
  };
});

// ==================== EVENT-BASED FUNCTIONS ====================

/**
 * Firestore Trigger: User Created
 * Automatically runs when a new document is created in the users collection
 */
exports.onUserCreated = functions.firestore
  .document("users/{userId}")
  .onCreate((snap, context) => {
    const userId = context.params.userId;
    const userData = snap.data();
    
    console.log(`New user created: ${userId}`);
    console.log("User data:", userData);
    
    // Auto-generate additional user fields
    const updates = {
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      lastLogin: admin.firestore.FieldValue.serverTimestamp(),
      status: "active",
      profileComplete: false,
      notificationsEnabled: true,
      preferences: {
        theme: "light",
        language: "en",
        emailNotifications: true
      }
    };
    
    // Update the user document with additional fields
    return snap.ref.update(updates).then(() => {
      console.log(`User ${userId} profile updated with default fields`);
      return null;
    }).catch((error) => {
      console.error(`Error updating user ${userId}:`, error);
      return null;
    });
  });

/**
 * Firestore Trigger: Message Created
 * Automatically runs when a new message is created
 */
exports.onMessageCreated = functions.firestore
  .document("messages/{messageId}")
  .onCreate((snap, context) => {
    const messageId = context.params.messageId;
    const messageData = snap.data();
    
    console.log(`New message created: ${messageId}`);
    console.log("Message data:", messageData);
    
    // Process message data
    const processedMessage = {
      ...messageData,
      processedAt: admin.firestore.FieldValue.serverTimestamp(),
      wordCount: messageData.text ? messageData.text.split(' ').length : 0,
      characterCount: messageData.text ? messageData.text.length : 0
    };
    
    // Update message with processed data
    return snap.ref.update(processedMessage).then(() => {
      console.log(`Message ${messageId} processed successfully`);
      
      // Update user's message count
      const userId = messageData.userId;
      if (userId) {
        return admin.firestore()
          .collection('users')
          .doc(userId)
          .update({
            lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
            messageCount: admin.firestore.FieldValue.increment(1)
          });
      }
      return null;
    }).catch((error) => {
      console.error(`Error processing message ${messageId}:`, error);
      return null;
    });
  });

/**
 * Firestore Trigger: Task Updated
 * Automatically runs when a task is updated
 */
exports.onTaskUpdated = functions.firestore
  .document("tasks/{taskId}")
  .onUpdate((change, context) => {
    const taskId = context.params.taskId;
    const beforeData = change.before.data();
    const afterData = change.after.data();
    
    console.log(`Task updated: ${taskId}`);
    console.log("Before:", beforeData);
    console.log("After:", afterData);
    
    // Check if task was completed
    const wasCompleted = beforeData.completed || false;
    const isCompleted = afterData.completed || false;
    
    if (!wasCompleted && isCompleted) {
      console.log(`Task ${taskId} was completed!`);
      
      // Update completion data
      return change.after.ref.update({
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        completionTime: new Date().toISOString()
      }).then(() => {
        // Update user's completed task count
        const userId = afterData.userId;
        if (userId) {
          return admin.firestore()
            .collection('users')
            .doc(userId)
            .update({
              completedTasksCount: admin.firestore.FieldValue.increment(1),
              lastCompletedTaskAt: admin.firestore.FieldValue.serverTimestamp()
            });
        }
        return null;
      });
    }
    
    return null;
  });

/**
 * Firestore Trigger: User Deleted
 * Automatically runs when a user document is deleted
 */
exports.onUserDeleted = functions.firestore
  .document("users/{userId}")
  .onDelete((snap, context) => {
    const userId = context.params.userId;
    const userData = snap.data();
    
    console.log(`User deleted: ${userId}`);
    console.log("Deleted user data:", userData);
    
    // Archive user data before deletion (optional)
    const archiveData = {
      originalUserId: userId,
      userData: userData,
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletionReason: "user_deletion"
    };
    
    // Store in archive collection
    return admin.firestore()
      .collection('userArchive')
      .add(archiveData)
      .then(() => {
        console.log(`User ${userId} archived successfully`);
        return null;
      })
      .catch((error) => {
        console.error(`Error archiving user ${userId}:`, error);
        return null;
      });
  });

// ==================== UTILITY FUNCTIONS ====================

/**
 * Health check function - callable from Flutter
 * Returns the status of the Cloud Functions service
 */
exports.healthCheck = functions.https.onCall((data, context) => {
  const timestamp = new Date().toISOString();
  const uptime = process.uptime();
  
  console.log(`Health check called at ${timestamp}`);
  
  return {
    status: "healthy",
    timestamp: timestamp,
    uptime: `${Math.floor(uptime)} seconds`,
    version: "1.0.0",
    environment: functions.config().firebase?.env || "development",
    success: true
  };
});

/**
 * Test function for debugging - callable from Flutter
 * Logs the received data and returns it back
 */
exports.echoTest = functions.https.onCall((data, context) => {
  const timestamp = new Date().toISOString();
  const auth = context.auth;
  
  console.log(`Echo test called at ${timestamp}`);
  console.log("Received data:", data);
  console.log("Auth context:", auth);
  
  return {
    echo: data,
    timestamp: timestamp,
    authenticated: auth !== null,
    authUid: auth?.uid || null,
    success: true
  };
});
