class ChatMessage {
  final String role; // "user" or "assistant"
  String content;

  ChatMessage({required this.role, required this.content});
}