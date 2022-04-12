import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Icon(Icons.menu),
        title: Text('Football Teams'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.notification_important_outlined),
              onPressed: onnotification),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              print('search of football');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png'),
                ),
                Container(
                  color: Colors.black.withOpacity(0.7),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 100.0,
                  ),
                  child: Text(
                    'Fc BaRcELoNA',
                    style: TextStyle(color: Colors.blue, fontSize: 30.0),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                      'https://logos-world.net/wp-content/uploads/2020/11/Milan-Logo-1997-1998.png'),
                ),
                Container(
                  color: Colors.black.withOpacity(0.7),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 100.0,
                  ),
                  child: Text(
                    'Ac milan',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/1200px-Manchester_United_FC_crest.svg.png'),
                ),
                Container(
                  color: Colors.black.withOpacity(0.8),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 100.0,
                  ),
                  child: Text(
                    'MaNcHeSteR UnItEd',
                    style: TextStyle(color: Colors.red, fontSize: 30.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onnotification() {
    print('notification click');
  } //print
}//class
// mainAxisSize: MainAxisSize.max,
            // resbonsible of Text
            // mainAxisAlignment: MainAxisAlignment.start,
           // crossAxisAlignment: CrossAxisAlignment.stretch,
           
              // Expanded(chil