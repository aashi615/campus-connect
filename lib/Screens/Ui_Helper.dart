import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class UIHelper {
  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
      );
    });
  }
  static Widget buildCustomBottomNavigationBar({

    required int currentIndex,
    required Function(int) onTap,
    required Color backgroundColor,
  }) {
    return Container(
      color: backgroundColor,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon:IconButton(
              icon:Image.asset("assets/Icons/Home page/Home.png"),
              onPressed: (){},
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:IconButton(
              icon:Image.asset("assets/Icons/Home page/community.png"),
              onPressed: (){},
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:IconButton(
              icon:Image.asset("assets/Icons/Home page/markeptplace.png"),
              onPressed: (){},
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon:IconButton(
          //     icon:Image.asset("assets/Icons/Home page/profile.png"),
          //     onPressed: (){},
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
class PDFAPi{
  static Future<File> loadNetwork(String url) async{
    final response = await http.get(url as Uri);
    final bytes = response.bodyBytes;
    return _storeFile(url,bytes);
  }
  static Future<File> _storeFile(String url,List<int> bytes) async{
    final filename= basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file=File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,flush:true);
    return file;
}
}
