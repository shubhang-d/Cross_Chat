class Message {
  final String text;
  final String timestamp;
  final String senderId;
  final bool isSentByMe;

  // This is used for styling grouped message bubbles
  final bool isLastInGroup;

  Message({
    required this.text,
    required this.timestamp,
    required this.senderId,
    required this.isSentByMe,
    this.isLastInGroup = true,
  });

  // A factory method for easy updates
  Message copyWith({
    bool? isLastInGroup,
  }) {
    return Message(
      text: this.text,
      timestamp: this.timestamp,
      senderId: this.senderId,
      isSentByMe: this.isSentByMe,
      isLastInGroup: isLastInGroup ?? this.isLastInGroup,
    );
  }
}