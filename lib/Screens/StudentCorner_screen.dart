import 'package:campus_connect/Screens/Contacts_Screen.dart';
import 'package:campus_connect/Screens/Placement_Page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class StudentCorner extends StatefulWidget{
  @override
  State<StudentCorner> createState() => _StudentCornerState();
}

class _StudentCornerState extends State<StudentCorner> {
  Color borderColor =Color(0xff0095FF); // Initial border color

  void changeBorderColor() {
    setState(() {
      borderColor = Color(0xFF0070A3); // Change border color on tap
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff0095FF),
          title: Text('Student Corner',style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,
          ),
          leading:  IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              size:25,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: SizedBox(
                  height:25,
                  width:30,
                  child: Image.asset("assets/Icons/Home page/notifications.png")),
              onPressed: () {
                // Add your onPressed logic here
              },),],
        ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 85,left: 28,right: 28),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 38.0, // Adjust as needed
          crossAxisSpacing: 38.0, // Adjust as needed
          childAspectRatio: 90 / 85, // Adjust to maintain the aspect ratio

          children: [
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    const link="https://ymcamob.com/";
                    launchUrl(
                        Uri.parse(link),
                        mode: LaunchMode.inAppWebView
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/Alumni.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'College Alumni',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    const link="https://www.jcboseust.ac.in/tpo/downloads";
                    launchUrl(
                        Uri.parse(link),
                        mode: LaunchMode.inAppWebView
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/PlacementRules.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'Placement Rules',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>ContactsPage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/collegecontacts.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'College Contacts',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {

                    const link="https://www.jcboseust.ac.in/student-window";
                    launchUrl(
                        Uri.parse(link),
                        mode: LaunchMode.inAppWebView
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/scholarships.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'Scholarships',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    const link="https://www.jcboseust.ac.in/Holidays-List-2022";
                    launchUrl(
                        Uri.parse(link),
                        mode: LaunchMode.inAppWebView
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/img.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'Holidays List',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 127,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF0D719F), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    const link="https://www.jcboseust.ac.in/content/scheme_syllabus";
                    launchUrl(
                        Uri.parse(link),
                        mode: LaunchMode.inAppWebView
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Icons/Student Corner/syllabus.png', width: 68, height: 68),
                      SizedBox(height: 12),
                      Text(
                        'Syllabus',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D719F),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}