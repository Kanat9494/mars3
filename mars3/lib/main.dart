import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_fade/image_fade.dart';
import 'package:mars3/chat_screen.dart';
import 'package:mars3/profile_page.dart';
import 'package:mars3/search_screen.dart';
import 'package:mars3/second.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as from_library;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //showPerformanceOverlay: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  double _bottomBarHeight = 60.0;
  late final ScrollListener _scrollListener;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _scrollListener = ScrollListener.initialize(_scrollController);

    _pages = [
      HomePage(scrollController: _scrollController),
      const SearchPage(),
      const EmptyPage(title: "Добавить"),
      const ChatScreen(),
      const ProfileBaseScreen()
    ];
  }

  @override
  void dispose() {
    _scrollListener.removeListener(() {});
    _scrollController.dispose();

    super.dispose();
  }

  void showBottomBar() {
    setState(() {
      _bottomBarHeight = 60;
    });
  }

  void hideBottomBar() {
    setState(() {
      _bottomBarHeight = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    super.build(context);
//Setting SysemUIOverlay
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
        extendBody: true,
        backgroundColor: const Color.fromARGB(235, 236, 235, 235),
        body: PageStorage(
            bucket: _bucket,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            )),
        //  floatingActionButton:  Container(
        //       width: double.infinity, // Растягиваем на всю ширину
        //       padding: EdgeInsets.symmetric(horizontal: 16.0), // Произвольные отступы по бокам
        //       child: FloatingActionButton(
        //         onPressed: () {
        //           // Handle button press
        //         },
        //         backgroundColor: const Color.fromARGB(255, 22, 9, 206),
        //         tooltip: 'Increment',
        //         child: const Text('В корзину', style: TextStyle(color: Colors.white, fontSize: 18)),
        //       ),),
        //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: AnimatedBuilder(
          animation: _scrollListener,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _scrollListener._isVisible ? _bottomBarHeight : 0,
              child: child,
            );
          },
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            selectedItemColor: const Color.fromARGB(
                255, 0, 0, 158), // Синий цвет для активной вкладки
            unselectedItemColor: Colors.black,

            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Главная'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: 'Поиск'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add, size: 45), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message_outlined,
                  ),
                  label: 'Чаты'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                  ),
                  label: 'Профиль'),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class MarketplaceItemCard extends StatelessWidget {
  final Item item;

  // const MarketplaceItemCard({Key? key, required this.item}) : super(key: key);
  const MarketplaceItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      height: 370,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  width: double.infinity,
                  memCacheHeight: 225,
                  height: 225,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                // child: CachedNetworkImage(
                //   imageUrl: item.imageUrl,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: 225.0,
                //   memCacheHeight: 225,
                //   //memCacheWidth: double.infinity,
                // ),
                // child: ImageFade(
                //   width: double.infinity,
                //   height: 225,
                //   image: NetworkImage(item.imageUrl),
                //   duration: const Duration(milliseconds: 900),
                //   fit: BoxFit.cover,
                //   placeholder: Container(
                //     color: const Color(0xFFCFCDCA),
                //     alignment: Alignment.center,
                //     child: const Icon(Icons.photo,
                //         color: Colors.white30, size: 128.0),
                //   ),
                //   loadingBuilder: (context, progress, chunkEvent) =>
                //       Center(child: CircularProgressIndicator(value: progress)),
                // ),
                // child: FadeInImage(
                //   width: double.infinity,
                //   height: 225,
                //   fit: BoxFit.cover,
                //   placeholder: NetworkImage('https://placehold.co/30x30'),
                //   image: NetworkImage(item.imageUrl),
                //   imageErrorBuilder: (context, error, stackTrace) => const Icon(
                //     Icons.error,
                //     color: Colors.red,
                //   ),
                // ),

                // child: SizedBox(
                //   height: 225,
                //   child: FadeInImage(
                //     width: double.infinity,
                //     height: 225,
                //     //fadeInDuration: const Duration(mi),
                //     fit: BoxFit.cover,
                //     placeholder:
                //         MemoryImage(Uint8List(0)), // Пустой placeholder
                //     image: NetworkImage(item.imageUrl),
                //     placeholderErrorBuilder: (context, error, stackTrace) =>
                //         Center(
                //       child:
                //           CircularProgressIndicator(), // Индикатор загрузки вместо контейнера
                //     ),
                //     imageErrorBuilder: (context, error, stackTrace) =>
                //         const Icon(
                //       Icons.error,
                //       color: Colors.grey,
                //     ),
                //   ),
                // )
              ),
              const SizedBox(height: 8.0),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item.category ?? "Нет",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item.additionalInfo ?? "Нет",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Отображаем снэкбар
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Товар добавлен в корзину'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 0, 0, 158), // Цвет кнопки
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Закругление
                        ),
                      ),
                      child: const Text(
                        'В корзину',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor:
                    const Color.fromARGB(85, 0, 0, 0), // Цвет волны при нажатии
                highlightColor: const Color.fromARGB(0, 0, 0, 0),
                splashFactory: InkRipple.splashFactory,
                radius: 220.0,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const SliverPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //key: PageStorageKey('sliverAppBarKey'),
      expandedHeight: 100.0,
      toolbarHeight: 100.0,
      floating: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 158),
      // backgroundColor: const Color.fromARGB(255, 22, 9, 206), // старый фон
      // backgroundColor:
      //     const Color.fromARGB(255, 22, 9, 206), // Розовый фон
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0), // Нижний левый угол
          bottomRight: Radius.circular(20.0), // Нижний правый угол
        ),
      ),
      title: SizedBox(
        height: 110.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Текст по середине',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 55.0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0), // Добавляем отступы по горизонтали
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Поиск',
                    hintStyle: TextStyle(fontSize: 22.0),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, size: 30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularGoodsTitle extends StatelessWidget {
  const PopularGoodsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 60.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        padding: const EdgeInsets.all(16.0),
        child: const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Популярные товары",
            style: TextStyle(
              fontSize: 20.0, // Увеличение размера шрифта на 20
              fontWeight: FontWeight.bold,
              color: Colors.black, // Изменение цвета текста на черный
            ),
          ),
        ),
      ),
    );
  }
}

class PopularGoodsList extends StatelessWidget {
  const PopularGoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      sliver: SliverFixedExtentList(
        itemExtent: 255,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SizedBox(
              height: 225,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int innerIndex) {
                    // print('First row $innerIndex');
                    final item = Item(
                        imageUrl:
                            'https://picsum.photos/id/$innerIndex/200/300',
                        name: 'Item $innerIndex',
                        price: 'Price $innerIndex');
                    return PopularItemCard(item: item);
                  }),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }
}

class TenPadding extends StatelessWidget {
  const TenPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 10.0,
      ),
    );
  }
}

class AdCarousels extends StatelessWidget {
  const AdCarousels({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: from_library.CarouselSlider(
          options: from_library.CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            // autoPlay: true,
          ),
          items: [
            '1.jpg',
            '2.jpg',
            '3.jpg',
            '4.jpg',
            '5.jpg',
            '6.jpg',
          ].map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    width: double
                        .infinity, // или укажи конкретную ширину, например 200
                    height: 200, // Укажи одинаковую высоту для всех картинок
                    child: Image.asset(
                      'assets/images/$imagePath',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PopularShopsTitle extends StatelessWidget {
  const PopularShopsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        padding: const EdgeInsets.all(16.0),
        child: const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Популярные магазины",
            style: TextStyle(
              fontSize: 20.0, // Увеличение размера шрифта на 20
              fontWeight: FontWeight.bold,
              color: Colors.black, // Изменение цвета текста на черный
            ),
          ),
        ),
      ),
    );
  }
}

class PopularShopsList extends StatelessWidget {
  const PopularShopsList({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      sliver: SliverFixedExtentList(
        itemExtent: 255,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return RepaintBoundary(
              child: SizedBox(
                height: 225,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      // print('First row $innerIndex');
                      final item = Item(
                          imageUrl:
                              'https://picsum.photos/id/$innerIndex/200/300',
                          name: 'Item $innerIndex',
                          price: 'Price $innerIndex');
                      return PopularItemCard(item: item);
                    }),
              ),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          'assets/images/12.jpg',
          height: 220.0,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
            right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1.8,
          ),
          itemCount: 10,
          addAutomaticKeepAlives: true, // Ограничиваем количество элементов
          itemBuilder: (BuildContext context, int index) {
            final item = popularItems[index % popularItems.length];

            return SizedBox(
              height: 91,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: (index == 0 || index == 9)
                      ? Colors.orange[300]
                      : Colors.purple[100 * ((index % 9) + 1)], // Исправлено
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 90,
                      height: 70,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Название товара, которое может быть довольно длинным и должно переноситься на следующую строку при необходимости',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 15), // Отступ между текстом и картинкой
                    SizedBox(
                      width: 63,
                      height: 92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                          placeholder: NetworkImage(
                              'https://placehold.co/30x30'), // Используй заглушку
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                          placeholderErrorBuilder:
                              (context, error, stackTrace) => const Center(
                                  child:
                                      CircularProgressIndicator()), // Индикатор загрузки
                          imageErrorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AllGoodsTitle extends StatelessWidget {
  const AllGoodsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        padding: const EdgeInsets.all(16.0),
        child: const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Все товары",
            style: TextStyle(
              fontSize: 20.0, // Увеличение размера шрифта на 20
              fontWeight: FontWeight.bold,
              color: Colors.black, // Изменение цвета текста на черный
            ),
          ),
        ),
      ),
    );
  }
}

class AllGoodsGrid extends StatelessWidget {
  const AllGoodsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        sliver: SliverPadding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 20.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 370,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return RepaintBoundary(
                    child: MarketplaceItemCard(item: allItems3[index]),
                  );
                },
                childCount: 1000, // Ограничиваем количество элементов
              ),
            )
// sliver: SliverMasonryGrid.count(
//   crossAxisCount: 2,
//   mainAxisSpacing: 5.0,
//   childCount: 1000,
//   itemBuilder: (context, index) {
//     return MarketplaceItemCard(item: allItems3[index]);
//   }
// )
            ));
  }
}

class HomePage extends StatelessWidget {
  final ScrollController scrollController;

  const HomePage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //key: PageStorageKey("mainPageKey"),
      // cacheExtent: 1200.0,
      controller: scrollController,
      cacheExtent: 1200,
      slivers: [
        const CustomAppBar(),
        const PopularGoodsTitle(),
        const PopularGoodsList(),
        const TenPadding(),
        const AdCarousels(),
        const TenPadding(),
        const PopularShopsTitle(),
        const PopularShopsList(),
        const TenPadding(),
        const AdBanner(),
        const TenPadding(),
        const CategoriesGrid(),
        const TenPadding(),
        const AllGoodsTitle(),
        const AllGoodsGrid(),
      ],
    );
  }
}

class Item {
  final String imageUrl;
  final String name;
  final String? category; // Made 'category' parameter optional with '?'
  final String?
      additionalInfo; // Made 'additionalInfo' parameter optional with '?'
  final String price;

  Item({
    required this.imageUrl,
    required this.name,
    this.category, // Updated to make it optional
    this.additionalInfo, // Updated to make it optional
    required this.price,
  });
}

final List<Item> allItems3 = List.generate(
  1000,
  (index) => Item(
    imageUrl: 'https://picsum.photos/id/$index/200/300',
    name: 'Item $index',
    category: 'Category $index',
    additionalInfo: 'Info $index',
    price: '\$${index + 1}',
  ),
);

class PopularItemCard extends StatelessWidget {
  final Item item;

  const PopularItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
            left: 16.0, right: 0.0, bottom: 16.0, top: 0.0),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.transparent,
          child: InkResponse(
            splashFactory: InkRipple.splashFactory,
            containedInkWell: true,
            onTapDown: (details) {},
            onTap: () {},
            // borderRadius: BorderRadius.circular(10.0),

            child: Column(
              spacing: 16.0,
              children: <Widget>[
                // FadeInImage(
                //   //placeholder: const NetworkImage('https://placehold.co/30x30'),
                //   placeholder: NetworkImage('https://placehold.co/30x30'),
                //   image: NetworkImage(item.imageUrl),
                //   height: 120,
                //   width: 120,
                //   fit: BoxFit.cover,
                //   imageErrorBuilder: (context, error, stackTrace) => Container(
                //     height: 120,
                //     width: 120,
                //     color: Colors.grey, // Фон ошибки
                //     child: const Icon(Icons.error, color: Colors.red),
                //   ),
                // ),
                FadeInImage(
                  placeholder: NetworkImage(
                      'https://placehold.co/30x30'), // Используй заглушку
                  image: NetworkImage(item.imageUrl),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholderErrorBuilder: (context, error, stackTrace) =>
                      const Center(
                          child:
                              CircularProgressIndicator()), // Индикатор загрузки
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Изменение цвета текста на белый
                  ),
                ),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white, // Изменение цвета текста на белый
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// final images = List.generate(
//   10,
//   (index) => Hero(
//     tag: 'image-$index',
//     child: CachedNetworkImage(imageUrl: 'https://picsum.photos/seed/${index * 7}/350/250',
//     fit: BoxFit.cover,
//     fadeInDuration: Duration.zero,),
//   )
// );

class EmptyPage extends StatelessWidget {
  final String title;
  const EmptyPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title, style: const TextStyle(fontSize: 24))),
    );
  }
}

final List<Widget> images = [
  Hero(
    tag: 'image-1',
    child: Image.asset(
      'assets/images/1.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Hero(
    tag: 'image-2',
    child: Image.asset(
      'assets/images/2.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Hero(
    tag: 'image-3',
    child: Image.asset(
      'assets/images/3.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Hero(
    tag: 'image-4',
    child: Image.asset(
      'assets/images/4.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Hero(
    tag: 'image-5',
    child: Image.asset(
      'assets/images/5.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Hero(
    tag: 'image-6',
    child: Image.asset(
      'assets/images/6.jpg',
      fit: BoxFit.cover,
    ),
  ),
];

final List<Item> popularItems = [
  Item(
    imageUrl: 'https://picsum.photos/id/1/200/300',
    name: 'Item 1',
    price: '\$10',
  ),
  Item(
    imageUrl: 'https://picsum.photos/id/2/200/300',
    name: 'Item 2',
    price: '\$15',
  ),
  Item(
    imageUrl: 'https://picsum.photos/id/3/200/300',
    name: 'Item 3',
    price: '\$20',
  ),
];

class ScrollListener extends ChangeNotifier {
  bool _isVisible = true;

  ScrollListener.initialize(ScrollController scrollController,
      [double height = 60]) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isVisible = false;
      } else {
        _isVisible = true;
      }
      notifyListeners();
    });
  }
}
