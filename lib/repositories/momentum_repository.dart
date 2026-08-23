import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/models/category/category.dart';
import '../core/models/goal/goal.dart';
import '../models/task_model.dart';
import '../models/user_profile_model.dart';
import '../services/firebase/collections.dart';

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

  // --- CategoryX Operations ---
  Stream<List<CategoryX>> getCategories(String uid) {
    return _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryX.fromJson({'id': doc.id, ...doc.data()}))
              .toList(),
        );
  }

  Future<String> addCategory(String uid, CategoryX category) async {
    final docRef = await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(categoriesCollection)
        .add(category.toJson());
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
  Stream<List<GoalX>> getGoals(String uid) {
    return _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = Map<String, dynamic>.from(doc.data());
            data['id'] = int.tryParse(doc.id) ?? doc.id.hashCode;
            return GoalX.fromJson(data);
          }).toList(),
        );
  }

  Future<String> addGoal(String uid, GoalX goal) async {
    final docRef = await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .add(goal.toJson());
    return docRef.id;
  }

  Future<void> updateGoal(String uid, GoalX goal) async {
    await _firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(goalsCollection)
        .doc(goal.id.toString())
        .set(goal.toJson());
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

    // Create CategoryX documents and get their IDs
    final workCat = const CategoryX(
      id: '',
      name: 'Work',
      icon: 'work',
      color: 0xFF1A56DB,
    );
    final healthCat = const CategoryX(
      id: '',
      name: 'Health',
      icon: 'fitness_center',
      color: 0xFF10B981,
    );
    final learningCat = const CategoryX(
      id: '',
      name: 'Learning',
      icon: 'school',
      color: 0xFFF59E0B,
    );
    final restCat = const CategoryX(
      id: '',
      name: 'Rest',
      icon: 'self_improvement',
      color: 0xFF8B5CF6,
    );

    final workRef = await categoriesRef.add(workCat.toJson());
    final healthRef = await categoriesRef.add(healthCat.toJson());
    final learningRef = await categoriesRef.add(learningCat.toJson());
    final restRef = await categoriesRef.add(restCat.toJson());

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
    final workCategoryObj = workCat.copyWith(id: workId);
    final healthCategoryObj = healthCat.copyWith(id: healthId);
    final learningCategoryObj = learningCat.copyWith(id: learningId);

    final defaultGoals = [
      GoalX(
        id: 1,
        title: 'Finish Flutter Feature',
        category: workCategoryObj,
        percentageCompleted: 0.6,
        type: GoalType.weekly,
        createdAt: today,
      ),
      GoalX(
        id: 2,
        title: 'Exercise 5 Times',
        category: healthCategoryObj,
        percentageCompleted: 0.6,
        type: GoalType.weekly,
        createdAt: today,
      ),
      GoalX(
        id: 3,
        title: 'Read 3 Chapters',
        category: learningCategoryObj,
        percentageCompleted: 0.66,
        type: GoalType.weekly,
        createdAt: today,
      ),
      GoalX(
        id: 4,
        title: 'Finish Mobile App',
        category: workCategoryObj,
        percentageCompleted: 0.68,
        type: GoalType.monthly,
        createdAt: today,
      ),
      GoalX(
        id: 5,
        title: 'Read One Book',
        category: learningCategoryObj,
        percentageCompleted: 0.58,
        type: GoalType.monthly,
        createdAt: today,
      ),
      GoalX(
        id: 6,
        title: 'Launch MVP',
        category: workCategoryObj,
        percentageCompleted: 0.5,
        type: GoalType.monthly,
        createdAt: today,
      ),
    ];

    for (final goal in defaultGoals) {
      await goalsRef.add(goal.toJson());
    }
  }
}
