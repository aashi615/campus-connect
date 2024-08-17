import 'package:campus_connect/Pages/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
class PlacementPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
        ListView(
          children: [
            Text('Let us Explore Placement Documents',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D719F),
              fontSize: 30,
            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPdfViewerPB()));
                },
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: Text('Placement Brochure',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color:Colors.black87,
                       fontSize: 18,
                     ),
                     ),
                   ),
                     Icon(Icons.navigate_next)
                   ],
                 ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Industrial Training Performa',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Placement Rules-I',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Placement Rules-II',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Placement Rules-III',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Training Forms',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87,// Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Placement Format',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            )


          ],
        )
    );
  }

}