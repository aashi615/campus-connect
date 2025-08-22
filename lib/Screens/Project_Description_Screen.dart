import 'package:campus_connect/Screens/project_collaborate_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String projectId;

  ProjectDetailsScreen({required this.projectId});

  final TextStyle headerStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xff0070A3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0095FF),
        elevation: 0,
        title: const Text(
          'Project Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('projects')
            .doc(projectId)
            .get(),
        builder: (context, projectSnapshot) {
          if (projectSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!projectSnapshot.hasData || projectSnapshot.data!.data() == null) {
            return const Center(child: Text('Project not found'));
          }

          var projectData = projectSnapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            projectData['projectName']?.toString() ?? 'Unnamed Project',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0070A3),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            projectData['projectDescription']?.toString() ??
                                'No description provided.',
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 16),
                          Text('Skills Used:', style: headerStyle),
                          Text(
                            projectData['skillsUsed']?.toString() ?? 'Not specified',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text('Members Required:', style: headerStyle),
                          Text(
                            projectData['membersRequired']?.toString() ?? 'Not specified',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text('Project Type:', style: headerStyle),
                          Text(
                            projectData['projectType']?.toString() ?? 'Not specified',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Project Lead Section
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(projectData['uid']?.toString()) // Ensure uid is a String
                        .get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
                        return const Center(child: Text('User not found'));
                      }

                      var userData = userSnapshot.data!.data() as Map<String, dynamic>;
                      String? profileImageUrl = userData['chatIds']?['profileImgUrl'];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  profileImageUrl ?? 'https://via.placeholder.com/150',
                                ),
                                radius: 30,
                                onBackgroundImageError: (_, __) {
                                  profileImageUrl = 'https://via.placeholder.com/150';
                                },
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Project Lead',
                                    style: headerStyle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    userData['chatIds']?['name']?.toString() ?? 'No Name',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    userData['ads']?['branch']?.toString() ?? 'No Branch',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    userData['chatIds']?['course']?.toString() ?? 'No Course',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Contact Button
                  Align(
                    alignment: Alignment.center,
                    child:ElevatedButton.icon(
                      onPressed: () async {
                        var projectData = projectSnapshot.data!.data() as Map<String, dynamic>;

                        // Fetch user data (project owner) for owner details
                        var userSnapshot = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(projectData['uid']?.toString())
                            .get();

                        var userData = userSnapshot.data() as Map<String, dynamic>;
                        String ownerName = userData['chatIds']?['name'] ?? 'No Name';
                        String ownerImageUrl = userData['chatIds']?['profileImgUrl'] ?? 'https://via.placeholder.com/150';

                        // Navigate to the chat screen and pass the required fields
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              projectId: projectId, // Pass the projectId correctly
                              productOwnerId: projectData['uid']?.toString() ?? '', // Pass the productOwnerId
                              ownerName: ownerName, // Pass the owner's name
                              ownerImageUrl: ownerImageUrl, // Pass the owner's image URL
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people_alt_outlined, color: Colors.white),
                      label: const Text(
                        'Connect',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0095FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
