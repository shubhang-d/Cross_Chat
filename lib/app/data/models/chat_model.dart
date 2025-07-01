class Chat {
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isOnline;

  Chat({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}