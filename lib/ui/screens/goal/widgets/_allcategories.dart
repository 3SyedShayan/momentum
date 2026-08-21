part of '../goal.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

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
                icon: Icon(Icons.add),
              ),
              ...categories.map(
                (c) => Padding(
                  padding: Space.r.t12,
                  child: GestureDetector(
                    onTap: () => AddCategoryModal.show(context, category: c),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(c.color),
                          radius: 5,
                        ),
                        Space.x.t04,
                        Text(c.name, style: AppText.b2.cl(AppTheme.c.subText)),
                      ],
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
