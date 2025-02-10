import 'package:flutter/material.dart';

class ProfileBaseScreen extends StatefulWidget {
  const ProfileBaseScreen({super.key});

  @override
  State<ProfileBaseScreen> createState() => _ProfileBaseScreenState();
}

class _ProfileBaseScreenState extends State<ProfileBaseScreen> {
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: Text(
              "john.doe",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: Colors.black, size: 30),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      profileHeaderWidget(),
                    ],
                  ),
                ),
              ];
            },
            body: PageStorage(
              bucket: _bucket,
              child: Column(
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[400],
                      indicatorWeight: 1,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(
                            icon: Icon(
                          Icons.grid_on,
                          size: 30.0,
                        )),
                        Tab(icon: Icon(Icons.favorite_border, size: 30.0)),
                        Tab(icon: Icon(Icons.bookmark_border, size: 30.0)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Первая вкладка - Фотографии
                        GridView.builder(
                          key: PageStorageKey('photosTab'),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                          key: PageStorageKey('liked'),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                          key: PageStorageKey('saved'),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                ],
              ),
            )),
      ),
    );
  }
}

Widget buildImage(int index) {
  return Image.network('https://picsum.photos/id/$index/200/300',
      fit: BoxFit.cover);
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
                    NetworkImage("https://picsum.photos/id/127/200/300"),
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
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/id/$index/200/300'),
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
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 50),
              backgroundColor: const Color.fromARGB(255, 0, 0, 179)),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text("Edit Profile",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          ),
        ),
      ),
    ],
  );
}
