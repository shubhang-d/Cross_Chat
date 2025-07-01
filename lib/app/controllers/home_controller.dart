import 'package:get/get.dart';
import '../data/models/chat_model.dart';

class HomeController extends GetxController {
  // Observables for state management
  final selectedNavIndex = 0.obs;
  final selectedChatIndex = 0.obs;
  final RxList<Chat> chats = <Chat>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load some dummy data to showcase the UI
    fetchChats();
  }

  void selectNavItem(int index) {
    selectedNavIndex.value = index;
  }

  void selectChat(int index) {
    selectedChatIndex.value = index;
  }

  void fetchChats() {
    // In a real app, this would be an API call
    final dummyChats = [
      Chat(
        name: 'Jane Doe',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        lastMessage: 'Hey, how is the Flutter app coming?',
        timestamp: '15:32',
        unreadCount: 3,
        isOnline: true,
      ),
      Chat(
        name: 'Project Team',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        lastMessage: 'Alex: Don\'t forget the meeting at 4 PM.',
        timestamp: '15:28',
        unreadCount: 1,
      ),
      Chat(
        name: 'Sarah Smith',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        lastMessage: 'Sounds good! See you then.',
        timestamp: '14:55',
        isOnline: true,
      ),
      Chat(
        name: 'Mike Johnson',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        lastMessage: 'Can you review my latest PR?',
        timestamp: '11:10',
      ),
      Chat(
        name: 'Flutter Devs',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        lastMessage: 'Someone just published a new package!',
        timestamp: 'Yesterday',
      ),
       Chat(
        name: 'Lisa Ray',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
        lastMessage: 'The new design looks amazing! 😍',
        timestamp: 'Yesterday',
        isOnline: true
      ),
       Chat(
        name: 'Markus',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        lastMessage: 'I\'m running a bit late.',
        timestamp: '2 days ago',
      ),
    ];

    chats.assignAll(dummyChats);
  }
}