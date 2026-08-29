part of '../task.dart';

class CategoryIconOption {
  final String key;
  final IconData icon;

  const CategoryIconOption({required this.key, required this.icon});
}

const List<CategoryIconOption> categoryIconOptions = [
  CategoryIconOption(key: 'book', icon: LucideIcons.book_open),
  CategoryIconOption(key: 'fitness', icon: LucideIcons.dumbbell),
  CategoryIconOption(key: 'work', icon: LucideIcons.briefcase),
  CategoryIconOption(
    key: 'mindfulness',
    icon: LucideIcons.face_slightly_smiling,
  ),
  CategoryIconOption(key: 'school', icon: LucideIcons.graduation_cap),
  CategoryIconOption(key: 'gaming', icon: LucideIcons.gamepad_2),
  CategoryIconOption(key: 'heart', icon: LucideIcons.heart),
  CategoryIconOption(key: 'flame', icon: LucideIcons.flame),
];
