part of '../goal.dart';

class _AllCategories extends StatelessWidget {
  const _AllCategories({super.key});

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
              Padding(
                padding: Space.r.t08,
                child: GestureDetector(
                  onTap: () => AddCategoryModal.show(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SpaceToken.t12,
                      vertical: SpaceToken.t08,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.c.subBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.c.border,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.plus,
                          size: 14,
                          color: AppTheme.c.primary,
                        ),
                        Space.x.t04,
                        Text(
                          'New',
                          style: AppText.b2b.cl(AppTheme.c.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...categories.map(
                (c) => Padding(
                  padding: Space.r.t08,
                  child: GestureDetector(
                    onTap: () => AddCategoryModal.show(context, category: c),
                    onLongPress: () =>
                        AddCategoryModal.confirmDelete(context, c),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SpaceToken.t12,
                        vertical: SpaceToken.t08,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.c.subBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.c.border,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(c.color),
                            radius: 4,
                          ),
                          Space.x.t08,
                          Text(
                            c.name,
                            style: AppText.b2.cl(AppTheme.c.text),
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
