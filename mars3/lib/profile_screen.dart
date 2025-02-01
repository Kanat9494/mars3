import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileBaseScreenState();
}
class _ProfileBaseScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);  // Инициализация TabController с 3 вкладками
  }

  @override
  void dispose() {
    _tabController.dispose();  // Не забываем освободить ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,  // Высота AppBar при расширении
            pinned: true,            // Закрепляем AppBar при прокрутке
            floating: false,         // Скрываем/показываем AppBar при прокрутке
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: profileHeaderWidget(),
            ),
             bottom: TabBar(
              controller: _tabController,  // Привязываем TabController
              tabs: [
                    Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.favorite_border)),
                  Tab(icon: Icon(Icons.bookmark_border)),
                  ],
            ),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              // TabBarView будет заменен на TabBar внутри SliverList
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Первая вкладка - Фотографии
                    GridView.builder(
                      shrinkWrap: true,  // Обрезаем GridView до минимального размера
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return buildImage(index);
                      },
                    ),

                    // Вторая вкладка - Лайкнутые фотографии
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: 200,
                      itemBuilder: (context, index) {
                        return buildImage(index);
                      },
                    ),

                    // Третья вкладка - Забронированные фотографии
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: 300,
                      itemBuilder: (context, index) {
                        return buildImage(index);
                      },
                    ),
                  ],
                ),
              ),
            ]),)
          
        ],
      ),
    );
  }
}

Widget buildImage(int index) {
    return Image.network('https://picsum.photos/id/$index/200/300', fit: BoxFit.cover);
  }


Widget profileHeaderWidget() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xff74EDED),
                backgroundImage:
                    NetworkImage("https://placeimg.com/640/480/people"),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "23",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.4,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "1.5M",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "234",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "John Doe",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Lorem Ipsum",
            style: TextStyle(
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          actions(),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 85,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 1000,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('https://picsum.photos/id/$index/200/300'),
                              radius: 28,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Ke dkfm okdf ',
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    ),
  );
}

Widget actions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 30),
              side: BorderSide(
                color: const Color.fromARGB(255, 184, 183, 183),
              )),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text("Edit Profile", style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    ],
  );
}


