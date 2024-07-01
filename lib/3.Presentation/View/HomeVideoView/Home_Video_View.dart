import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class Home_Video_View {

  Widget HomePage_Video( BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
          children: [
            Container(
                width: width,
                height: height * .3,
                child: Image.network(
                    "http://www.listercarterhomes.com/wp-content/uploads/2013/11/dummy-image-square.jpg")),
            SizedBox(height: height * .02),
            Container(
              child: Text("df"),
            )
          ],
        ),
    )
    ;
  }
}
