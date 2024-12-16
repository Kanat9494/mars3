import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_fade/image_fade.dart';
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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _bottomBarHeight = 60.0;
  late final ScrollListener _scrollListener;

  @override
  void initState() {
    super.initState();

    _scrollListener = ScrollListener.initialize(_scrollController);
  }

//   @override
//   void initState(){
//     super.initState();

//     _scrollController.addListener(() {
// if (_scrollController.position.userScrollDirection ==
//         ScrollDirection.reverse) {
//           hideBottomBar();
//         }
//         else {
//           showBottomBar();
//         }
//     });
//   }

  @override
  void dispose() { 
    _scrollListener.removeListener(() { });
    _scrollController.dispose();

   super.dispose(); 
  }

  void showBottomBar(){
    setState(() {
      _bottomBarHeight = 60;
    });
  }

  void hideBottomBar(){
    setState(() {
      _bottomBarHeight = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
//Setting SysemUIOverlay
SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    // systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    // systemNavigationBarDividerColor: Color.fromARGB(0, 0, 0, 0),
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Color.fromARGB(120, 0, 0, 0),
    statusBarIconBrightness: Brightness.light),
);

    
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 236, 235, 235),

      body: CustomScrollView(
        
        // cacheExtent: 1200.0,
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            toolbarHeight: 100.0,
            floating: true,
            backgroundColor:  const Color.fromARGB(255, 22, 9, 206),
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
  padding: const EdgeInsets.symmetric(horizontal: 10.0), // Добавляем отступы по горизонтали
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
            // flexibleSpace: FlexibleSpaceBar(
            //   titlePadding: const EdgeInsets.only(left: 0, right: 0),
            //  centerTitle: true,
            //   title: Container(
            //     decoration: const BoxDecoration(
            //   color:  Color.fromARGB(255, 22, 9, 206),
            //   borderRadius: BorderRadius.only(
            //     bottomLeft:
            //         Radius.circular(20), // Закругление левого нижнего угла
            //     bottomRight:
            //         Radius.circular(20), // Закругление правого нижнего угла
            //   ),
            // ),

               
            //     child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       const SizedBox(
            //         height: 70.0,
            //       ),
            //       const Text(
            //         'Текст по середине',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 16.0,
            //         ),
            //       ),
            //       const SizedBox(height: 8.0),
            //       Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 6.0),
            //         height: 35.0,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //         child: const TextField(
            //           decoration: InputDecoration(
            //             hintText: 'Поиск',
            //             hintStyle: TextStyle(fontSize: 14.0),
            //             border: InputBorder.none,
            //             icon: Icon(Icons.search),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   )
            // ),
          ),

          SliverToBoxAdapter(
  child: Container(
    height: 60.0,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)
        )
      ),
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
),

DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)
              )
            ),
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
        final item = popularItems[index % popularItems.length];
        return PopularItemCard(item: item);
                    }
                  ),
                );
              },
              childCount: 1,
            ),

),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 10.0,),
          ),

          SliverToBoxAdapter(
  child: Container(
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
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/$imagePath'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    ),
),

const SliverToBoxAdapter(
            child: SizedBox(height: 10.0,),
          ),

          SliverToBoxAdapter(
  child: Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)
        )
      ),
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
),

DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)
              )
            ),
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
        final item = popularItems[index % popularItems.length];
        return PopularItemCard(item: item);
                    }
                  ),
                );
              },
              childCount: 1,
            ),

),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 10.0),
          ),

          SliverToBoxAdapter(
  child: Container(
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
)
),

const SliverToBoxAdapter(
  child: SizedBox(height: 10.0,),
),


DecoratedSliver(
  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
  sliver: SliverPadding(
  padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),

  sliver: SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.8,
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final item = popularItems[index % popularItems.length];
        return Container(
          height: 90.0,
  decoration: BoxDecoration(
    color: (index == 0 || index == 9) ? Colors.orange[300] : Colors.purple[100 * (index % 9)],
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: Row(
    children: [
      const SizedBox(
        
        width: 90, 
        height: 70,
        child: Padding(
            padding: EdgeInsets.only(left: 5.0), // Отступы сверху и снизу
            child: Text(
              'Название товара, которое может быть довольно длинным и должно переноситься на следующую строку при необходимости',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
      ),
      const SizedBox(width: 15), // Пространство между изображением и текстом

      SizedBox(
        width: 63,
        height: 92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      
    ],
  ),
);

        },
    childCount: 10,

    ),
  )
),
),

const SliverToBoxAdapter(child: SizedBox(height: 10.0),),


SliverToBoxAdapter(
  child: Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)
        )
      ),
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
),

DecoratedSliver(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)
            )),
            sliver: SliverPadding(
  padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 20.0),
 sliver: SliverGrid.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 370,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 5.0,
      ), 
      itemBuilder: (BuildContext context, int index) {
        return MarketplaceItemCard(item: allItems3[index]);
      },
      itemCount: 1000,)
// sliver: SliverMasonryGrid.count(
//   crossAxisCount: 2,
//   mainAxisSpacing: 5.0,
//   childCount: 1000,
//   itemBuilder: (context, index) {
//     return MarketplaceItemCard(item: allItems3[index]);
//   }
// )
      )
          ),

          

          

          

          


          

          

          

          

          





          


          
          
        ],
      ),
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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 35), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined, size: 35), label: '')

          ],
        ),
        )
    );
  }
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
  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0)),
  child: Stack(
    children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                // child: CachedNetworkImage(
                //   imageUrl: item.imageUrl,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: 225.0,
                //   memCacheHeight: 225,
                // ),
                child: ImageFade(
                  width: double.infinity,
                  height: 225,
                  image: NetworkImage(item.imageUrl),
                  duration: const Duration(milliseconds: 900),
                  fit: BoxFit.cover,
                  placeholder: Container(
    color: const Color(0xFFCFCDCA),
    alignment: Alignment.center,
    child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
  ),
  loadingBuilder: (context, progress, chunkEvent) =>
    Center(child: CircularProgressIndicator(value: progress)),
                )
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
           Expanded(
              child: Padding(padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: MaterialButton(
  onPressed: () {},
  color: const Color.fromARGB(255, 22, 9, 206),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Указываете радиус закругления
  ),
  child: const Text('В корзину', style: TextStyle(color: Colors.white)),
),
)
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

class Item {
  final String imageUrl;
  final String name;
  final String? category; // Made 'category' parameter optional with '?'
  final String? additionalInfo; // Made 'additionalInfo' parameter optional with '?'
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
      margin: const EdgeInsets.only(left: 16.0, right: 0.0, bottom: 16.0, top: 0.0),
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
          onTapDown: (details){},
        onTap: (){},
        // borderRadius: BorderRadius.circular(10.0),
        
        child: Column(
          spacing: 16.0,
        children: <Widget>[
            Ink.image(
              image: const AssetImage('assets/images/12.jpg'),


            
            height: 120,
              width: 120,
              fit: BoxFit.cover,
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

      )
    );
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

  ScrollListener.initialize(ScrollController scrollController, [double height = 60]) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
          _isVisible = false;
        }
        else {
          _isVisible = true;
        }
      notifyListeners();
    });
  }

}