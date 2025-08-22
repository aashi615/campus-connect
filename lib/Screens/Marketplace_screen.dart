import 'package:campus_connect/Screens/Campus_chats.dart';
import 'package:campus_connect/Screens/Home_screen.dart';
import 'package:campus_connect/Screens/MyAdds_Screen.dart';
import 'package:campus_connect/Screens/ViewMyProfile_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/Screens/AddItem_screen.dart';
import 'package:campus_connect/Screens/Product_Description.dart';

class MarketPlaceScreen extends StatefulWidget {
  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  bool _isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _fetchAds(); // Simulate fetching ads
  }

  void _fetchAds() async {
    // Simulate a delay to fetch data
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int _currentIndex = 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0095FF),
        title: Text(
          'Campus Market',
          style: TextStyle(
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
        actions: [
          IconButton(
            icon: SizedBox(
                height: 25,
                width: 30,
                child: Image.asset("assets/Icons/Home page/notifications.png")),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
          IconButton(
            icon: SizedBox(
                height: 25,
                width: 30,
                child: Image.asset("assets/Icons/Home page/messagebox.png")),
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampusChatScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User is not signed in")),
                );
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Products",
                        contentPadding: EdgeInsets.only(top: 0),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.black, size: 40),
                  onPressed: () {
                    // Handle My Ads action
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAdsScreen()),
                  );
                },
                child: Text(
                  'My Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Ads').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No products available'));
                }
                return GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: screenWidth / (screenHeight * 0.58),
                    crossAxisSpacing: 0.6,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data!.docs[index].data() as Map<String, dynamic>?;

                    if (product == null) return SizedBox.shrink();

                    String imageUrl = product['images']?['imageUrl'] ?? 'https://via.placeholder.com/150';
                    String title = product['images']?['title'] ?? 'No Title';
                    String price = product['images']?['price'] ?? '0';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(documentId: snapshot.data!.docs[index].id),
                          ),
                        );
                      },
                      child: ProductCard(
                        title: title,
                        imageUrl: imageUrl,
                        price: price,
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
            MaterialPageRoute(builder: (context) => AddItem()),
          );
        },
        backgroundColor: Color(0xff0094fd),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/Home.png",
              height: 25,
              color: _currentIndex == 0 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/community.png",
              height: 25,
              color: _currentIndex == 1 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/markeptplace.png",
              height: 25,
              color: _currentIndex == 2 ? Colors.white : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Icons/Home page/profile.png",
              height: 25,
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'HomePage'),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarketPlaceScreen(),
              ),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;

  ProductCard({required this.title, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double cardHeight = screenHeight * 0.18;
    double imageHeight = cardHeight;
    double imageWidth = screenWidth * 0.35;

    return Container(
      height: cardHeight,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            '₹ $price',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
