//
// import 'package:campus_connect/Screens/product_enquireScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductDetailsPage extends StatefulWidget {
//   final String documentId;
//
//   const ProductDetailsPage({Key? key, required this.documentId}) : super(key: key);
//
//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   late Map<String, dynamic> productDetails;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProductDetails();
//   }
//
//   Future<void> fetchProductDetails() async {
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//         .collection('Ads')
//         .doc(widget.documentId)
//         .get();
//
//     setState(() {
//       if (documentSnapshot.exists) {
//         productDetails = documentSnapshot.data() as Map<String, dynamic>;
//       } else {
//         productDetails = {}; // Or show an error message to the user
//       }
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Product Details',
//           style: TextStyle(color: Color(0xff006fa1), fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         actions: [
//           IconButton(icon: Icon(Icons.share), onPressed: () {}),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : productDetails.isEmpty
//           ? Center(child: Text("Product not found."))
//           : SingleChildScrollView( // Add this widget
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display the product image
//             Center(
//               child: Image.network(
//                 productDetails['images']['imageUrl'] ?? 'https://via.placeholder.com/150',
//                 height: 200,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Image.asset('assets/placeholder.png', height: 200);
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Title and Price Row
//             Padding(
//               padding: const EdgeInsets.only(left: 35.0, right: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     productDetails['images']['title'] ?? 'No Title',
//                     style: TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff006fa1)),
//                   ),
//                   Text(
//                     '₹ ${productDetails['images']['price'] ?? 'N/A'}',
//                     style: TextStyle(
//                         fontSize: 24, color: Color(0xff006fa1), fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//
//             // Used Frequency
//             Padding(
//               padding: const EdgeInsets.only(left: 42.0, right: 25),
//               child: Row(
//                 children: [
//                   Icon(Icons.watch_later_outlined, color: Colors.grey, size: 25),
//                   const SizedBox(width: 8),
//                   Text(
//                     productDetails['images']['used'] ?? 'New',
//                     style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Divider(color: Color(0xff006fa1)),
//             const SizedBox(height: 12),
//
//             // Description
//             Padding(
//               padding: const EdgeInsets.only(left: 35),
//               child: Text(
//                 productDetails['des'] ?? 'No description available.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//
//             const SizedBox(height: 36),
//
//             // Enquiry Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     String? ownerId = productDetails["images"]?["uid"];
//                     String? ownerImage = productDetails["images"]?["imageUrl"];
//                     String? productId = productDetails["id"];
//
//                     // Validate the existence of required details
//                     if (ownerId == null || ownerImage == null || productId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Some product details are missing. Please try again.")),
//                       );
//                       return;
//                     }
//
//                     // Fetch the owner's document from Firestore
//                     DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(ownerId)
//                         .get();
//
//                     // Check if the owner document exists
//                     if (ownerSnapshot.exists && ownerSnapshot.data() != null) {
//                       String ownerName = ownerSnapshot['chatIds']?['name'] ?? 'Owner';
//
//                       // Navigate to ChatScreen with owner details
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChatScreen(
//                             productOwnerId: ownerId,
//                             ownerName: ownerName,
//                             ownerImageUrl: ownerImage,
//                           ),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Owner information is not available.")),
//                       );
//                     }
//                   } catch (e) {
//                     // Log and display an error message
//                     print("Error: $e");
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("An error occurred. Please try again.")),
//                     );
//                   }
//                 },
//                 child: Text(
//                   'ENQUIRE NOW',
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff006fa1),
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   textStyle: TextStyle(fontSize: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
import 'package:campus_connect/Screens/product_enquireScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsPage extends StatefulWidget {
  final String documentId;

  const ProductDetailsPage({Key? key, required this.documentId}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Map<String, dynamic> productDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  /// Fetch product details from Firestore
  Future<void> fetchProductDetails() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Ads')
          .doc(widget.documentId)
          .get();

      setState(() {
        if (documentSnapshot.exists) {
          productDetails = documentSnapshot.data() as Map<String, dynamic>;
        } else {
          productDetails = {}; // Handle missing product details
        }
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors during fetching
      print("Error fetching product details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(color: Color(0xff006fa1), fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productDetails.isEmpty
          ? Center(child: Text("Product not found."))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Center(
              child: Image.network(
                productDetails['images']['imageUrl'] ?? 'https://via.placeholder.com/150',
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/placeholder.png', height: 200);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Title and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productDetails['images']['title'] ?? 'No Title',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff006fa1)),
                  ),
                  Text(
                    '₹ ${productDetails['images']['price'] ?? 'N/A'}',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff006fa1),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Usage frequency
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: Row(
                children: [
                  Icon(Icons.watch_later_outlined, color: Colors.grey, size: 25),
                  const SizedBox(width: 8),
                  Text(
                    productDetails['images']['used'] ?? 'New',
                    style: TextStyle(
                        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Color(0xff006fa1)),
            const SizedBox(height: 12),

            // Description
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                productDetails['des'] ?? 'No description available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 36),

            // Enquiry button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await handleEnquiry(context);
                },
                child: Text(
                  'ENQUIRE NOW',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff006fa1),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleEnquiry(BuildContext context) async {
    try {
      String? ownerId = productDetails["images"]?["uid"];
      if (ownerId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Owner ID is missing. Please try again.")),
        );
        return;
      }

      // Fetch owner details
      DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(ownerId)
          .get();

      if (ownerSnapshot.exists) {
        Map<String, dynamic> ownerData = ownerSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic>? chatIds = ownerData['chatIds'];

        String ownerName = chatIds?['name'] ?? 'Owner';
        String ownerImageUrl = chatIds?['profileImgUrl'] ?? 'https://via.placeholder.com/150';

        // Navigate to chat screen
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Owner information is not available.")),
        );
      }
    } catch (e) {
      print("Error in handleEnquiry: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }
}
