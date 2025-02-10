import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: MySearchAppBar(),
      body: GridView.builder(
        key: PageStorageKey('searchScreenRootKey'),
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 столбца
          crossAxisSpacing: 10, // расстояние между столбцами
          mainAxisSpacing: 10, // расстояние между строками
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryTile(category: category);
        },
      ),
    );
  }
}

final List<Category> categories = List.generate(100, (index) {
  return Category(
    name: 'Category ${index + 1}',
    imageUrl:
        'https://picsum.photos/id/$index/200/300', // случайное изображение
  );
});

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class CategoryTile extends StatelessWidget {
  final Category category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(category.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Align(
            alignment: Alignment.bottomCenter, // Это выравнивает текст по низу
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(140, 0, 0, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}

class MySearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  MySearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: Padding(
        padding: const EdgeInsets.only(left: 0, right: 4),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor:
                const Color.fromARGB(255, 247, 245, 245), // Легкий серый фон
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Закругленные края
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: TextStyle(color: Colors.black),
          onSubmitted: (value) {
            // Здесь можно обработать поиск, например, сделать запрос
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            'Отмена',
            style: TextStyle(
                color:
                    const Color.fromARGB(255, 0, 0, 179), // Синий цвет текста
                fontWeight: FontWeight.bold, // Жирный шрифт
                fontSize: 16),
          ),
        )
      ],
      scrolledUnderElevation: 0.0,
    );
  }
}
