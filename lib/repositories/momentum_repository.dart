import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
import '../models/task_model.dart';
import '../models/goal_model.dart';
import '../models/user_profile_model.dart';
import '../service/firebase/collections.dart';

class MomentumRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Profile Operations ---
  Future<UserProfileModel> getUserProfile(String uid) async {
    final doc = await _firestore.collection(usersCollection).doc(uid).get();
    if (!doc.exists) {
      // Initialize default profile
      final newProfile = UserProfileModel(
        uid: uid,
        displayName: 'Shayan',
        email: 'shayan@momentum.app',
        streakCount: 12,
        totalHoursPlanned: 248,
        totalHoursCompleted: 189,
        notificationsEnabled: true,
        defaultReminderMinutes: 15,
        themeMode: 'light',
      );
      await _firestore
          .collection(usersCollection)
          .doc(uid)
          .set(newProfile.toMap());

      // Seed default categories
      await seedDefaultCategories(uid);

      return newProfile;
    }
    return UserProfileModel.fromMap(doc.data()!, uid);
  }

  Future<void> updateUserProfile(UserProfileModel profile) async {
    await _firestore
        .collection(usersCollection)
        .doc(profile.uid)
        .set(profile.toMap());
  }

  // --- Category Operations ---
  Stream<List<CategoryModel>> getCategories(String uid) {
    return _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> addCategory(String uid, CategoryModel category) async {
    final docRef = await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection)
        .add(category.toMap());
    return docRef.id;
  }

  Future<void> deleteCategory(String uid, String categoryId) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection)
        .doc(categoryId)
        .delete();
  }

  // --- Task Operations ---
  Stream<List<TaskModel>> getTasks(String uid) {
    return _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(tasksCollection)
        .orderBy('startTime')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> addTask(String uid, TaskModel task) async {
    final docRef = await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(tasksCollection)
        .add(task.toMap());
    return docRef.id;
  }

  Future<void> updateTask(String uid, TaskModel task) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(tasksCollection)
        .doc(task.id)
        .set(task.toMap());
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(tasksCollection)
        .doc(taskId)
        .delete();
  }

  // --- Goal Operations ---
  Stream<List<GoalModel>> getGoals(String uid) {
    return _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => GoalModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> addGoal(String uid, GoalModel goal) async {
    final docRef = await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .add(goal.toMap());
    return docRef.id;
  }

  Future<void> updateGoal(String uid, GoalModel goal) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .doc(goal.id)
        .set(goal.toMap());
  }

  Future<void> deleteGoal(String uid, String goalId) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .doc(goalId)
        .delete();
  }

  // --- Seeding Default Data ---
  Future<void> seedDefaultCategories(String uid) async {
    final categoriesRef = _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection);
    final tasksRef = _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(tasksCollection);
    final goalsRef = _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection);

    // Create Category documents and get their IDs
    final workRef = await categoriesRef.add(
      CategoryModel(id: '', name: 'Work', colorHex: '#1A56DB').toMap(),
    );
    final healthRef = await categoriesRef.add(
      CategoryModel(id: '', name: 'Health', colorHex: '#10B981').toMap(),
    );
    final learningRef = await categoriesRef.add(
      CategoryModel(id: '', name: 'Learning', colorHex: '#F59E0B').toMap(),
    );
    final restRef = await categoriesRef.add(
      CategoryModel(id: '', name: 'Rest', colorHex: '#8B5CF6').toMap(),
    );

    final workId = workRef.id;
    final healthId = healthRef.id;
    final learningId = learningRef.id;
    final restId = restRef.id;

    final today = DateTime.now();

    // Default Tasks
    final defaultTasks = [
      TaskModel(
        id: '',
        title: 'Morning Coffee',
        categoryId: restId,
        startTime: DateTime(today.year, today.month, today.day, 8, 0),
        endTime: DateTime(today.year, today.month, today.day, 8, 30),
        isCompleted: true,
        durationPlanned: 30,
        durationCompleted: 30,
      ),
      TaskModel(
        id: '',
        title: 'Flutter Development',
        categoryId: workId,
        startTime: DateTime(today.year, today.month, today.day, 9, 0),
        endTime: DateTime(today.year, today.month, today.day, 12, 0),
        isCompleted: true,
        durationPlanned: 180,
        durationCompleted: 180,
      ),
      TaskModel(
        id: '',
        title: 'Deep Work Session',
        categoryId: workId,
        startTime: DateTime(today.year, today.month, today.day, 13, 0),
        endTime: DateTime(today.year, today.month, today.day, 15, 0),
        isCompleted: false,
        durationPlanned: 120,
        durationCompleted: 0,
      ),
      TaskModel(
        id: '',
        title: 'Lunch Break',
        categoryId: restId,
        startTime: DateTime(today.year, today.month, today.day, 12, 0),
        endTime: DateTime(today.year, today.month, today.day, 13, 0),
        isCompleted: false,
        durationPlanned: 60,
        durationCompleted: 0,
      ),
      TaskModel(
        id: '',
        title: 'Client Work Review',
        categoryId: workId,
        startTime: DateTime(today.year, today.month, today.day, 15, 30),
        endTime: DateTime(today.year, today.month, today.day, 17, 0),
        isCompleted: false,
        durationPlanned: 90,
        durationCompleted: 0,
      ),
      TaskModel(
        id: '',
        title: 'Gym Session',
        categoryId: healthId,
        startTime: DateTime(today.year, today.month, today.day, 17, 30),
        endTime: DateTime(today.year, today.month, today.day, 18, 30),
        isCompleted: false,
        durationPlanned: 60,
        durationCompleted: 0,
      ),
    ];

    for (final task in defaultTasks) {
      await tasksRef.add(task.toMap());
    }

    // Default Goals
    final defaultGoals = [
      GoalModel(
        id: '',
        title: 'Finish Flutter Feature',
        categoryId: workId,
        totalSessions: 5,
        completedSessions: 3,
        type: 'weekly',
      ),
      GoalModel(
        id: '',
        title: 'Exercise 5 Times',
        categoryId: healthId,
        totalSessions: 5,
        completedSessions: 3,
        type: 'weekly',
      ),
      GoalModel(
        id: '',
        title: 'Read 3 Chapters',
        categoryId: learningId,
        totalSessions: 3,
        completedSessions: 2,
        type: 'weekly',
      ),
      GoalModel(
        id: '',
        title: 'Finish Mobile App',
        categoryId: workId,
        totalSessions: 100,
        completedSessions: 68,
        type: 'monthly',
      ),
      GoalModel(
        id: '',
        title: 'Read One Book',
        categoryId: learningId,
        totalSessions: 12,
        completedSessions: 7,
        type: 'monthly',
      ),
      GoalModel(
        id: '',
        title: 'Launch MVP',
        categoryId: workId,
        totalSessions: 2,
        completedSessions: 1,
        type: 'monthly',
      ),
    ];

    for (final goal in defaultGoals) {
      await goalsRef.add(goal.toMap());
    }
  }
}
