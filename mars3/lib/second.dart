import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart' as from_library;

class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: true,
          // systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
          // systemNavigationBarDividerColor: Color.fromARGB(0, 0, 0, 0),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromARGB(120, 0, 0, 0),
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 217, 217),
        body: CustomScrollView(
            shrinkWrap: false,
            //cacheExtent: 3200,
            slivers: <Widget>[
              const SliverAppBar(
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(title: Text('Animated AppBar')),
              ),
              SliverToBoxAdapter(
                child: _buildProductImages(context),
              ),
              SliverToBoxAdapter(
                  child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "Товарный название",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )),
              SliverToBoxAdapter(
                  child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "Описание товара здесь. Это может быть длинное описание, описывающее товар и его характеристики",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
              )),
              SliverToBoxAdapter(child: _buildButtons()),
              SliverFixedExtentList(
                itemExtent: 90,
                delegate: SliverChildBuilderDelegate(
                    (BuildContext contexxt, int index) {
                  return _buildProductParameters('Состав', 'Хлопок 100%');
                }, childCount: 50),
              ),
              SliverFixedExtentList(
                itemExtent: 90,
                delegate: SliverChildBuilderDelegate(
                    (BuildContext contexxt, int index) {
                  return _buildProductParameters(
                      productParameters[index]['parameter'] ?? '',
                      productParameters[index]['value'] ?? '');
                }, childCount: productParameters.length),
              )
            ]));
  }
}

Widget _buildButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment
        .spaceEvenly, // Распределить пространство равномерно между кнопками
    children: <Widget>[
      ElevatedButton(
        onPressed: () {
          // Действие при нажатии на кнопку 1
        },
        child: const Text('Кнопка 1'),
      ),
      ElevatedButton(
        onPressed: () {
          // Действие при нажатии на кнопку 2
        },
        child: const Text('Кнопка 2'),
      ),
      ElevatedButton(
        onPressed: () {
          // Действие при нажатии на кнопку 3
        },
        child: const Text('Кнопка 3'),
      ),
      ElevatedButton(
        onPressed: () {
          // Действие при нажатии на кнопку 4
        },
        child: const Text('Кнопка 4'),
      ),
    ],
  );
}

Widget _buildProductImages(BuildContext context) {
  List<String> imageUrls = [
    "12.jpg",
    "12.jpg",
    "12.jpg",
    "12.jpg",
    "12.jpg",
  ];

  return from_library.CarouselSlider(
    options: from_library.CarouselOptions(
      height: 400.0, // Высота карусели
      enableInfiniteScroll: true, // Зацикливание карусели
      //enlargeCenterPage: true, // Увеличение текущей страницы
      autoPlay: true, // Автоматическое воспроизведение
      viewportFraction: 1.0, // Один слайдер виден целиком
      aspectRatio: 16 / 9, // Соотношение сторон изображений (примерно 16:9)
    ),
    items: imageUrls.map((imageUrl) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              image: DecorationImage(
                //image: NetworkImage(imageUrl),
                image: AssetImage('assets/images/$imageUrl'),
                //image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

Widget _buildProductParameters(
  String title,
  String subtitle, {
  double titleFontSize = 20,
  double subtitleFontSize = 18,
}) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.all(10.0), // Отступы внутри контейнера

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: subtitleFontSize,
            ),
          ),
        ],
      ),
    ),
  );
}

List<Map<String, String>> productParameters = List.generate(
  500, // количество элементов в списке
  (index) => {
    "parameter": "Текст 1 для виджета ${index + 1}",
    "value": "Текст 2 для виджета ${index + 1}"
  },
);
