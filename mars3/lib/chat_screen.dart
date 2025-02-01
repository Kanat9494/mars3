import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'Чаты',
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 179), fontWeight: FontWeight.bold), // Текст белый
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: const Color.fromARGB(255, 0, 0, 0), // Иконка поиска белая
            ),
            onPressed: () {
              // Действие при нажатии на иконку поиска
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: const Color.fromARGB(255, 0, 0, 0), // Иконка настроек белая
            ),
            onPressed: () {
              // Действие при нажатии на иконку настроек
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Белый фон для всего тела
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ChatTile(chat: chat);
          },
        ),
      ),
    );
  }
}

final List<Chat> chats = List.generate(200, (index) {
    return Chat(
      name: 'User ${index + 1}',
      lastMessage: 'Last message from User ${index + 1}...',
      lastLogin: '$index hours ago', // случайное время
      isDelivered: true, // случайное значение для delivered
      avatarUrl: 'https://picsum.photos/id/$index/200/300', // случайные URL
    );
  });

class Chat {
  final String name;
  final String lastMessage;
  final String lastLogin;
  final bool isDelivered;
  final String avatarUrl;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.lastLogin,
    required this.isDelivered,
    required this.avatarUrl,
  });
}

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chat.avatarUrl),
        radius: 30,
      ),
      title: Text(
        chat.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          SizedBox(width: 10),
          Text(
            chat.lastLogin,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      trailing: Icon(
        chat.isDelivered ? Icons.check_circle : Icons.access_time,
        color: chat.isDelivered ? Colors.green : Colors.orange,
      ),
      onTap: () {
        // Можно добавить переход в экран чата
      },
    );
  }
}
