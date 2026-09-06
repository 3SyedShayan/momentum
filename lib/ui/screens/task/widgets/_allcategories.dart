part of '../task.dart';

class _AllCategories extends StatelessWidget {
  const _AllCategories();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryX>>(
      stream: CategoryRepo.ins.watchAllCategories(),
      builder: (context, snapshot) {
        final categories = snapshot.data ?? [];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => AddCategoryModal.show(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.c.subBackground.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppTheme.c.border.withValues(alpha: 0.7),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.plus,
                        size: 14,
                        color: AppTheme.c.subText,
                      ),
                      Space.x.t04,
                      Text(
                        'Category',
                        style: AppText.b2.cl(AppTheme.c.subText).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Space.x.t08,
              ...categories.map(
                (c) => Padding(
                  padding: Space.r.t08,
                  child: GestureDetector(
                    onTap: () => AddCategoryModal.show(context, category: c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.c.subBackground.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.c.border.withValues(alpha: 0.7),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(c.color),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Space.x.t08,
                          Text(
                            c.name,
                            style: AppText.b2.cl(AppTheme.c.subText).copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
