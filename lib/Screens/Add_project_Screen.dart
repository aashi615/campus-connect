import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectDescriptionController = TextEditingController();
  final TextEditingController skillsUsedController = TextEditingController();
  final TextEditingController membersRequiredController = TextEditingController();

  String? projectType; // For storing the selected project type
  bool isLoading = false;
  Future<void> _submitProject() async {
    // Showing loading indicator
    setState(() {
      isLoading = true;
    });

    // Validating input fields
    if (projectNameController.text.trim().isEmpty ||
        projectDescriptionController.text.trim().isEmpty ||
        skillsUsedController.text.trim().isEmpty ||
        membersRequiredController.text.trim().isEmpty ||
        projectType == null) {
      // Showing error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields!"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;

        CollectionReference projectsRef = FirebaseFirestore.instance.collection("projects");

        // Generate projectId when the document is created
        DocumentReference projectDocRef = await projectsRef.add({
          "uid": uid, // Store the user ID of the project owner
          "projectName": projectNameController.text.trim(),
          "projectDescription": projectDescriptionController.text.trim(),
          "skillsUsed": skillsUsedController.text.trim(),
          "membersRequired": int.tryParse(membersRequiredController.text.trim()) ?? 0,
          "projectType": projectType ?? "Not specified",
          "createdAt": Timestamp.now(), // Timestamp for creation time
        });

        String projectId = projectDocRef.id;  // Get the document ID

        // Now, update the document with the projectId (if necessary)
        await projectDocRef.update({
          "projectId": projectId, // Store projectId in the document
        });

        // Clear input fields
        projectNameController.clear();
        projectDescriptionController.clear();
        skillsUsedController.clear();
        membersRequiredController.clear();
        projectType = null;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Project added successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffffff), Color(0xffffff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        "Add Your Project Details",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0070A3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    _buildTextField("Project Name", projectNameController),
                    const SizedBox(height: 20),
                    _buildTextField("Project Description", projectDescriptionController, isMultiline: true),
                    const SizedBox(height: 20),
                    _buildTextField("Skills Used", skillsUsedController),
                    const SizedBox(height: 20),
                    _buildTextField("Members Required", membersRequiredController, isNumeric: true),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: projectType,
                      onChanged: (value) {
                        setState(() {
                          projectType = value;
                        });
                      },
                      decoration: _inputDecoration("Project Type"),
                      items: const [
                        DropdownMenuItem(
                          value: "Beginner",
                          child: Text("Beginner"),
                        ),
                        DropdownMenuItem(
                          value: "Intermediate",
                          child: Text("Intermediate"),
                        ),
                        DropdownMenuItem(
                          value: "Advanced",
                          child: Text("Advanced"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitProject,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0095FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        ),
                        child: const Text(
                          "Submit Project",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0095FF),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isMultiline = false, bool isNumeric = false}) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(label),
      maxLines: isMultiline ? null : 1,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xff4a4a4a)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
