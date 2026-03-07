import 'dart:async';
import 'dart:convert';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {

  static final _instance = ChatWebService._internal();

  factory ChatWebService() => _instance;

  ChatWebService._internal();

  late WebSocket _socket;

  bool _isConnected = false;

  final _searchResultController =
      StreamController<Map<String, dynamic>>.broadcast();

  final _contentController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;

  Stream<Map<String, dynamic>> get contentStream =>
      _contentController.stream;

  void connect() {

    if (_isConnected) return;

    _socket = WebSocket(Uri.parse("ws://localhost:8000/ws/chat"));

    _isConnected = true;

    print("WebSocket connected");

    _socket.messages.listen((message) {

      final data = jsonDecode(message);

      if (data["type"] == 'search_results') {
        _searchResultController.add(data);
      }

      else if (data["type"] == 'content') {
        _contentController.add(data);
      }

      print(data["data"]);

    });

  }

  void clearResponse() {

    _contentController.add({
      "type": "clear",
      "data": ""
    });

  }

  void chat(String query) {

    if (!_isConnected) {
      print("WebSocket not connected");
      return;
    }

    print("sending query: $query");

    _socket.send(
      jsonEncode({
        "query": query
      }),
    );

  }

}