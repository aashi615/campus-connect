import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid; // Current user's UID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Listed Products',
          style: TextStyle(
            color: Colors.blue, // Blue text color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Ads')
            .where('images.uid', isEqualTo: currentUserId) // Filter by current user's UID
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products listed'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
              String productId = doc.id;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: productData['images'] != null &&
                              productData['images']['imageUrl'] != null
                              ? Image.network(
                            productData['images']['imageUrl'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                              : Icon(Icons.image, size: 60, color: Colors.grey),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            productData['images'] != null
                                ? productData['images']['title'] ?? 'No Title'
                                : 'No Title',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => showEditDialog(context, productId, productData),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            side: BorderSide(color: Colors.blue),
                          ),
                          child: Text('Edit'),
                        ),
                        SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => deleteProduct(productId),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red),
                          ),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void showEditDialog(BuildContext context, String productId, Map<String, dynamic> productData) {
    showDialog(
      context: context,
      builder: (context) => EditProductDialog(
        productId: productId,
        productData: productData,
      ),
    );
  }

  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('Ads').doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product deleted successfully')),
    );
  }
}

class EditProductDialog extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;

  EditProductDialog({required this.productId, required this.productData});

  @override
  _EditProductDialogState createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController usedDurationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.productData['images']['title'] ?? '';
    descriptionController.text = widget.productData['des'] ?? '';
    usedDurationController.text = widget.productData['images']['used'] ?? '';
    priceController.text = widget.productData['images']['price'] ?? '';
  }

  Future<void> updateProduct() async {
    await FirebaseFirestore.instance.collection('Ads').doc(widget.productId).update({
      'images.title': titleController.text,
      'des': descriptionController.text,
      'images.used': usedDurationController.text,
      'images.price': priceController.text,
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: usedDurationController,
              decoration: InputDecoration(labelText: 'Used Duration'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: updateProduct,
          child: Text('UPDATE', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
