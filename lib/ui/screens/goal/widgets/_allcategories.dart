part of '../goal.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Categories',
          style: AppText.h3b,
        ),
        Space.y.t08,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: allCategories
                .map(
                  (c) => Padding(
                    padding: Space.r.t12,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(c.color),
                          radius: 5,
                        ),
                        Space.x.t04,
                        Text(
                          c.name,
                          style: AppText.b2.cl(AppTheme.c.subText),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
