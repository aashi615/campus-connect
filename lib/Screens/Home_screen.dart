import 'package:campus_connect/Screens/Campus_chats.dart';
import 'package:campus_connect/Screens/Navbar.dart';
import 'package:campus_connect/Screens/Marketplace_screen.dart';
import 'package:campus_connect/Screens/Project_Buddy_Screen.dart';
import 'package:campus_connect/Screens/StudentCorner_screen.dart';
import 'package:campus_connect/Screens/ViewMyProfile_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class AutoFadingImages extends StatefulWidget{
  final List<String> images = [
    "assets/images/Hcampusmain.png",
    "assets/images/Hcommunities.png",
    "assets/images/Hmarketplace.png",
    // Add more image URLs as needed
  ];


  @override
  _AutoFadingImagesState createState() => _AutoFadingImagesState();
}

class _AutoFadingImagesState extends State<AutoFadingImages> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoFade();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAutoFade() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Image.asset(
          widget.images[_currentIndex],
          key: ValueKey<int>(_currentIndex),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Define currentIndex

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
}
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
       backgroundColor: Color(0xff0095FF),
        title: Text('Campus Connect',style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: SizedBox(
                height: 25,
                width: 30,
                child: Image.asset("assets/Icons/Home page/sidebar.png"),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
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
            },
          ),
          IconButton(
            icon: SizedBox(
                height:25,
                width:30,
                child: Image.asset("assets/Icons/Home page/messagebox.png")),
            onPressed: ()  async {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampusChatScreen(),
                  ),
                );
              } else {
                // Handle the case where the user is not signed in
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User is not signed in")),
                );
              }
            },
          ),
        ],

      ),
      body:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:8.0),
                height: 165,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Container(
                      width: 350,
                      child: AutoFadingImages(),
                    ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width:double.infinity,
                  height:110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1), // Color of the shadow
                        spreadRadius: 0, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset in x and y direction
                      ),
                    ],
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Campus Resources",style:TextStyle(
                            color: Color(0xFF0070A3),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                        ),
                          textAlign: TextAlign.left,
                        ),
                    ),
                   SizedBox(
                     height: 3,
                   ),
                     Row(
                       children: [
                     Expanded(
                     child: Column(
                     children: [
                         IconButton(
                         onPressed: () {
                           const url = "https://jcboseust.refread.com/#/home"; // Replace with your URL
                           launchUrl(
                               Uri.parse(url),
                               mode: LaunchMode.inAppWebView
                           );
                         },
                          icon: Image.asset(
                              "assets/Icons/Home page/library.png",
                         height: 42,
                         width: 42,
                         ),
                         ),
                       Text(
                       "Library",
                       textAlign: TextAlign.center,
                         style:TextStyle(
                           color:Color(0xFF0070A3),
                           fontWeight: FontWeight.bold,
                         ),
                      ),
                      ],
                      ),
                       ),
                         Expanded(
                           child: Column(
                             children: [
                               IconButton(
                                 onPressed: () async {
                                   const url = "https://jcboseustymca.co.in/"; // Replace with your URL
                                   launchUrl(
                                       Uri.parse(url),
                                       mode: LaunchMode.inAppWebView
                                   );
                                 },
                                 icon: Image.asset(
                                   "assets/Icons/Home page/erp_portal.png",
                                   height: 42,
                                   width: 42,
                                 ),
                               ),
                               Text(
                                 "Erp Portal",
                                 textAlign: TextAlign.center,
                                 style:TextStyle(
                                   color:Color(0xFF0070A3),
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Expanded(
                           child: Column(
                             children: [
                               IconButton(
                                 onPressed: () {},
                                 icon: Image.asset(
                                   "assets/Icons/Home page/dispensary.png",
                                   height: 42,
                                   width: 42,
                                 ),
                               ),
                               Text(
                                 "Dispensary",
                                 textAlign: TextAlign.center,
                                 style:TextStyle(
                                   color:Color(0xFF0070A3),
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Expanded(
                           child: Column(
                             children: [
                               IconButton(
                                 onPressed: () {},
                                 icon: Image.asset(
                                   "assets/Icons/Home page/campus map.png",
                                   height: 42,
                                   width: 42,
                                 ),
                               ),
                               Text(
                                 "Campus Map",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(color: Color(0xFF0070A3),
                                   fontWeight: FontWeight.bold,
                                 ),

                               ),
                             ],
                           ),
                         ),
    ]
                     )

                  ],
                )
              ),
             SizedBox(height: 15),
             Text("Explore Communities",
             style: TextStyle(
               color: Color(0xFF0070A3),
               fontWeight: FontWeight.bold,
               fontSize: 15,
             ),
             ),
             SizedBox(
               height: 10,
             ),
              Container(
                margin: EdgeInsets.only(left: 8),
                height: 74, // Provide a height constraint
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  itemCount: 4, // Number of containers you want to show
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height:65,
                      width: 74,
                      margin: EdgeInsets.only(right: 27), // Add spacing between containers
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 75,
                  width: 108,
                  decoration: BoxDecoration(
                    borderRadius:   BorderRadius.circular(6),
                    border: Border.all(
                      color:  Color(0xFF0D719F), // Color of the border
                      width: 1.5, // Width of the border
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentCorner()));
                    },
                    child: Column(
                     children: [
                       Image.asset("assets/Icons/Home page/student_corner.png",
                       height: 47,
                       width: 47,
                     ),
                       Text("Student Corner",
                         style: TextStyle(
                           color:Color(0xFF0070A3),
                           fontWeight: FontWeight.bold,
                         ),
                       )
                     ]
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:12),
                  height: 75,
                  width: 108,
                  decoration: BoxDecoration(
                    borderRadius:   BorderRadius.circular(6),
                    border: Border.all(
                      color:  Color(0xFF0D719F), // Color of the border
                      width: 1.5, // Width of the border
                    ),
                  ),
                  child: Column(
                      children: [
                        Image.asset("assets/Icons/Home page/pyq.png",
                          height: 47,
                          width: 47,
                        ),
                        Text("PYQ",
                          style: TextStyle(
                            color:Color(0xFF0070A3),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:12),
                  height: 75,
                  width: 108,
                  decoration: BoxDecoration(
                    borderRadius:   BorderRadius.circular(6),
                    border: Border.all(
                      color:  Color(0xFF0D719F), // Color of the border
                      width: 1.5, // Width of the border
                    ),
                  ),
                  child: Column(
                      children: [
                        Image.asset("assets/Icons/Home page/events.png",
                          height: 47,
                          width: 47,
                        ),
                        Text("Events",
                          style: TextStyle(
                            color:Color(0xFF0070A3),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(1), // Color of the shadow
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Offset in x and y direction
              ),
]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Notices",
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        color:Color(0xFF0070A3),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      ),

                    ],
                  ),
                ),

              ),
            )

            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2195F1), // Customize FAB color
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectBuddyScreen(),
            ),
          );
        },
        child: Icon(
          Icons.group_add,
          color: Colors.white,
        ),
        tooltip: "Project Buddy",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue, // Set your desired blue color here
        items: [
          BottomNavigationBarItem(
           icon: Image.asset("assets/Icons/Home page/Home.png",
           height: 25,
             alignment: Alignment.center,
             color: _currentIndex == 0 ? Colors.white : null,
           ),
            label: '',

          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/Icons/Home page/community.png",
              height: 25,
              alignment: Alignment.center,
              color: _currentIndex == 1 ? Colors.white : null,
            ),

            label: '',
          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/Icons/Home page/markeptplace.png",
              height: 25,
              alignment: Alignment.center,
              color: _currentIndex == 2 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/Icons/Home page/profile.png",
              height: 25,
              alignment: Alignment.center,
              color: _currentIndex == 3 ? Colors.white : null,
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            // Navigate to Marketplace page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MarketPlaceScreen(), // Replace with your Marketplace page widget
              ),
            );
          }

      if (index == 3) {
      // Navigate to Marketplace page
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
           ProfilePage(), // Replace with your Marketplace page widget
      ),
    );
  }
    },
      ),


    );

  }
  }

