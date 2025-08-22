import 'package:campus_connect/Screens/product_enquireScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CampusChatScreen extends StatefulWidget {
  @override
  _CampusChatScreenState createState() => _CampusChatScreenState();
}

class _CampusChatScreenState extends State<CampusChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Get the current user's UID
    String? currentUserId = _auth.currentUser?.uid;

    // Check if UID is available
    if (currentUserId == null || currentUserId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
           backgroundColor: Color(0xff0095FF),
          title: Text('Campus Chats',style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Text("User ID not found. Please log in."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0095FF),
        title: Text('Campus Chats',style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Chats')
            .where('participants', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error loading chats: ${snapshot.error}"));
          }

          var chatDocuments = snapshot.data?.docs ?? [];

          if (chatDocuments.isEmpty) {
            return Center(child: Text("No chats available"));
          }

          return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (context, index) {
              var chatData = chatDocuments[index];
              var lastMessage = chatData['lastMessage'] ?? '';
              var lastMessageTime = chatData['lastMessageTime'] ?? FieldValue.serverTimestamp();
              var participants = chatData['participants'] as List;

              // Find the ownerId by excluding the current user
              var ownerId = participants.firstWhere((id) => id != currentUserId, orElse: () => '');

              // Skip the tile if no valid ownerId is found
              if (ownerId.isEmpty) {
                return SizedBox.shrink(); // Use SizedBox to avoid taking up space
              }

              return FutureBuilder<DocumentSnapshot>(
                future: _firestore.collection('users').doc(ownerId).get(),
                builder: (context, ownerSnapshot) {
                  if (!ownerSnapshot.hasData || !ownerSnapshot.data!.exists) {
                    return SizedBox.shrink(); // Avoid showing invalid users
                  }

                  var ownerData = ownerSnapshot.data!;
                  var chatIds = (ownerData.data() as Map<String, dynamic>)['chatIds'] ?? {};

                  var ownerName = chatIds['name'] ?? 'Unknown';
                  var ownerImageUrl = chatIds['profileImgUrl'] ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(ownerImageUrl),
                    ),
                    title: Text(ownerName),
                    subtitle: Text(lastMessage),
                    trailing: Text(_formatTimestamp(lastMessageTime)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            productOwnerId: ownerId,
                            ownerName: ownerName,
                            ownerImageUrl: ownerImageUrl,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat('HH:mm').format(timestamp.toDate());
  }
}
