part of '../goal.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Add Category"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Name"),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Color"),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => ''.pop(context),
                      child: const Text("Cancel"),
                    ),
                    // TextButton(
                    //   // onPressed: () => allCategories.add(
                    //   //   Category(
                    //   //     id: "",
                    //   //     name: "",
                    //   //     color: 0,
                    //   //     icon: 0,
                    //   //   ),
                    //   // ),
                    //   child: const Text("Add"),
                    // ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
          ...allCategories
              .map(
                (c) => Padding(
                  padding: Space.r.t12,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(backgroundColor: Color(c.color), radius: 5),
                      Space.x.t04,
                      Text(c.name, style: AppText.b2.cl(AppTheme.c.subText)),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
