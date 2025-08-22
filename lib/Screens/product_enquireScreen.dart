
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String productOwnerId;
  final String ownerName;
  final String ownerImageUrl;

  ChatScreen({
    required this.productOwnerId,
    required this.ownerName,
    required this.ownerImageUrl,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? chatId;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    String userId = _auth.currentUser!.uid;
    chatId = _generateChatId(userId, widget.productOwnerId);

    try {
      // Check if a chat already exists
      DocumentSnapshot chatSnapshot = await _firestore.collection('Chats').doc(chatId).get();

      if (!chatSnapshot.exists) {
        // Create a new chat if it does not exist
        await _firestore.collection('Chats').doc(chatId).set({
          'participants': [userId, widget.productOwnerId],
          'createdAt': FieldValue.serverTimestamp(),
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error initializing chat: $e");
    }
  }

  String _generateChatId(String userId, String ownerId) {
    List<String> ids = [userId, ownerId];
    ids.sort();  // Sort to ensure the same order
    return ids.join('_');  // Create a unique chat ID
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty && chatId != null) {
      String messageContent = _messageController.text.trim();
      String senderId = _auth.currentUser!.uid;

      try {
        // Send the message to Firestore
        await _firestore.collection('Chats').doc(chatId).collection('Messages').add({
          'senderId': senderId,
          'messageContent': messageContent,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Update last message in the chat document
        await _firestore.collection('Chats').doc(chatId).update({
          'lastMessage': messageContent,
          'lastMessageTime': FieldValue.serverTimestamp(),
        });

        _messageController.clear();
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat('HH:mm').format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.ownerImageUrl),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                widget.ownerName,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatId == null
                ? Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('Chats')
                  .doc(chatId)
                  .collection('Messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isCurrentUser = message['senderId'] == _auth.currentUser!.uid;

                    // Extract the timestamp of the current message
                    Timestamp currentTimestamp = message['timestamp'];
                    DateTime currentDate = currentTimestamp.toDate();

                    // Check if a new date separator is needed
                    bool isNewDate = false;
                    if (index == 0) {
                      isNewDate = true; // Always show the date header for the first message
                    } else {
                      Timestamp previousTimestamp = messages[index - 1]['timestamp'];
                      DateTime previousDate = previousTimestamp.toDate();
                      isNewDate = currentDate.day != previousDate.day ||
                          currentDate.month != previousDate.month ||
                          currentDate.year != previousDate.year;
                    }

                    // Format the date for the header
                    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(currentDate);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (isNewDate)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: isCurrentUser ? Colors.grey[300] : Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message['messageContent'],
                                  style: TextStyle(color: isCurrentUser ? Colors.black : Colors.white),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  (message['timestamp'] != null)
                                      ? _formatTimestamp(message['timestamp'])
                                      : 'Sending...',
                                  style: TextStyle(
                                      color: isCurrentUser ? Colors.black54 : Colors.white70,
                                      fontSize: 8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
