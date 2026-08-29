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
              IconButton(
                onPressed: () => AddCategoryModal.show(context),
                icon: const Icon(Icons.add),
              ),
              ...categories.map(
                (c) => Padding(
                  padding: Space.r.t12,
                  child: GestureDetector(
                    onTap: () => AddCategoryModal.show(context, category: c),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SpaceToken.t12,
                        vertical: SpaceToken.t08,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.c.subBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(c.color),
                            radius: 5,
                          ),
                          Space.x.t08,
                          Text(
                            c.name,
                            style: AppText.b2.cl(AppTheme.c.subText),
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
