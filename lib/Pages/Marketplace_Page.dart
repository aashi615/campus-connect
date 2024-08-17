import 'package:campus_connect/Pages/AddItem_Page.dart';
import 'package:campus_connect/Pages/Product_Description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
class MarketPlacePage extends StatefulWidget {
  @override
  State<MarketPlacePage> createState() => _MarketPlacePageState();
}

class _MarketPlacePageState extends State<MarketPlacePage> {
  // Arrays to store item data
  List<String> itemNames = [
    'Calculator',
    'Bag',
    'Frame',
    'Batteries',
    'Arduino',
    'Atomic Habits', 'Solder Iron',
    'PCB'

    // Add more item names as needed
  ];

  List<String> prices = [
    '200',
    '500',
    '120', '150','400','120','800','900'
    // Add more prices as needed
  ];

  List<String> imagePaths = [
    'assets/Icons/MarketPlace/Calculator.png',
    'assets/Icons/MarketPlace/img_2.png',
    'assets/Icons/MarketPlace/img_1.png',
    'assets/Icons/MarketPlace/img_3.png',
    'assets/Icons/MarketPlace/img_4.png',
    'assets/Icons/MarketPlace/img_5.png',
    'assets/Icons/MarketPlace/img_6.png',
    'assets/Icons/MarketPlace/img_7.png',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       backgroundColor: Color(0xff0095FF),
       title: Text('Campus Market',style: TextStyle(
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
           },
         ),

       ],

     ),
     body:
     Column(
       children: [
         Row(
           children: [
             Container(
             margin:EdgeInsets.only(top:12,left: 25),
             width:292,
             height:39,
               decoration: BoxDecoration(
                 border: Border.all(
                   width:2,
                   color:Colors.grey,
                 ),
                     borderRadius: BorderRadius.circular(50),
               ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Search Products",style: TextStyle(color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  )),
                ),
                Icon(Icons.search,
                 size: 22,
                   color: Colors.grey,
                 )
              ],
            )
           ),
             Padding(
               padding: const EdgeInsets.only(top:12.0),
               child: IconButton(onPressed:(){},
                   icon: Image.asset("assets/Icons/MarketPlace/Favourites.png",
                   height: 41,
                   ),
               ),
             )
             ]
         ),
         Expanded(
           child: Container(
             padding: EdgeInsets.all(12),
             child: GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 mainAxisSpacing: 15,
                 crossAxisSpacing: 15,
               ),
               itemCount: 8,
               itemBuilder:(context,index){
                 return InkWell(
                   onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder:(context)=> ProductDescription()));
                   },
                   child: Container(
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
                     height: 150,
                     width: 154,
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                         children: [
                           // Image.asset('assets/images/marketplace.png',width: 137, height: 102),
                           // Text('Item name',style:TextStyle(fontSize: 20)),
                           // Text('Price', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                           Image.asset(
                             imagePaths[index],
                             width: 137, // Adjust width as needed
                             height: 102, // Adjust height as needed
                           ),
                           Text(
                             itemNames[index],
                             style: TextStyle(fontSize: 20),
                           ),
                           Text(
                             '\$${prices[index]}', // Display price with '$'
                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                           ),
                         ],
                       ),
                     ),
                   ),
                 );
               },
             )
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
       child: Icon(Icons.add),
     ),

   );
  }
}
