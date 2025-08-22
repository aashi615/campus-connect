import 'package:flutter/material.dart';
class ContactsPage extends StatefulWidget{
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Map<String, dynamic>> dataList = [
    {"name": "Training and Placement Office", "number": "+91-0129-2242141", "image": "assets/images/TPO.png"},
    {"name": "Training and Placement Officer", "number": "+91-9990477433", "image": "assets/images/img.png"},
    {"name": "Prof. Sushil Kumar Tomar", "number": "0129-2310102", "image": "assets/images/img_1.png"},
    {"name": "Admission Helpline No", "number": " 0129-2310160", "image": "assets/images/img_2.png"},
    {"name": "Prof. Atul Mishra", "number": "0129-2310130", "image": "assets/images/img_2.png"},
    {"name": "Dr. Munish Vashishath", "number": "0129-2310119", "image": "assets/images/img_2.png"},
    {"name": "Prof. Komal Kr. Bhatia", "number": " 0129-2310178", "image": "assets/images/img_2.png"},
    {"name": "Chairperson (Electrical Engineering)", "number": "0129-2310191", "image": "assets/images/img_2.png"},
    {"name": "Chairperson (Electronics  Engineering)", "number": "0129-2310141", "image": "assets/images/img_2.png"},
    {"name": "Chairperson (Mechanical  Engineering)	", "number": "0129-2310128", "image": "assets/images/img_2.png"},
    {"name": "Chairperson (Management Studies)", "number": "0129-2310172", "image": "assets/images/img_2.png"},


  ];
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar:AppBar(
         automaticallyImplyLeading: false,
         backgroundColor: Color(0xff0095FF),
         title: Text('College Contacts',style: TextStyle(
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
       body:Padding(
         padding: const EdgeInsets.only(top: 15),
         child: ListView.builder(
           itemCount: dataList.length,
           itemBuilder: (context, index) {
             return ListTile(
               leading: CircleAvatar(
                 backgroundImage: AssetImage(dataList[index]["image"]), // Load image from asset
               ),
               title: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(dataList[index]["name"],
                    style:TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                   ),
                   Text(
                     dataList[index]["number"],
                     style: TextStyle(fontSize: 12,

                     ), // Optional: Adjust font size
                   ),
                 ],
               ),

             );
           },
         ),
       ),

     );
  }
}