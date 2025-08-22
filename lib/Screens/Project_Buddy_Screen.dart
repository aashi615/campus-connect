
import 'package:campus_connect/Screens/Add_project_Screen.dart';
import 'package:campus_connect/Screens/Project_Description_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectBuddyScreen extends StatefulWidget {
  @override
  _ProjectBuddyScreenState createState() => _ProjectBuddyScreenState();
}

class _ProjectBuddyScreenState extends State<ProjectBuddyScreen> {
  String userName = '';
  String profileImageUrl = '';


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['chatIds']['name'] ?? 'User';
            profileImageUrl = userDoc['chatIds']['profileImgUrl'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0095FF),
        elevation: 0,
        title: const Text(
          'Project Buddy Finder',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffe9f2fb), Color(0xffc9dff4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Automatically adjusts to content
                    children: [
                      Row(
                        children: [
                          // Profile Image
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: profileImageUrl.isNotEmpty
                                  ? NetworkImage(profileImageUrl)
                                  : null,
                              backgroundColor: const Color(0xffdbe9f4),
                              child: profileImageUrl.isEmpty
                                  ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xff4a4a4a),
                              )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Welcome Text
                          Expanded(
                            child: Text(
                              'Welcome, $userName',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4a4a4a),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Subtitle
                      const Text(
                        'Collaborate on Projects and Connect with your Perfect Project Partner.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6a6a6a),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Section Title
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Projects',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                Text(
                  'My Projects',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),

          // Projects List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('projects').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching projects."));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No projects found.",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                final projects = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index].data() as Map<String, dynamic>;
                    String projectId = projects[index].id; // Get project ID

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xff0095FF), width: 1.5),
                      ),
                      elevation: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffffffff), Color(0xffffffff)], // White gradient
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Flexible Column for Project Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Project Title
                                    Text(
                                      project['projectName'] ?? 'Unnamed Project',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xff0070A3),
                                      ),
                                      overflow: TextOverflow.ellipsis, // Prevent overflow
                                    ),
                                    const SizedBox(height: 10),
                                    // Members Required
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Members Required: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: project['membersRequired']?.toString() ?? 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Tech Stack
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Tech Stack: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: project['skillsUsed'] ?? 'Not specified',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Icon Button for Navigation
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xff0070A3),
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    // Navigate to ProjectDetailsScreen and pass projectId
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProjectDetailsScreen(
                                          projectId: project['projectId'], // Pass the projectId from the project map
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectScreen()),
          );
        },
        backgroundColor: const Color(0xff0094fd),
        child: const Icon(Icons.add),
      ),
    );
  }
}

