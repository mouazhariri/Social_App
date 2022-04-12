import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  'https://meteorsport.eu/eng_pl_ADIDAS-FOOTBALL-BALL-FINALE-19-CAPITANO-DY2553-white-multicolor-36552_1.jpg'),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              'Fottball',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 15.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 15.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text('search'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://cdn.vox-cdn.com/thumbor/m0oi_NKOxPkroClzWr8TdF3M-I0=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/22642176/1318347069.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Lionel messi',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://icdn.strettynews.com/wp-content/uploads/2021/08/Screenshot-2021-08-27-at-16.57.15.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'cristeano ronaldo   ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://s.hs-data.com/bilder/spieler/gross/142105.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'neyma jr',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://e0.365dm.com/21/03/2048x1152/skysports-mohamed-salah-liverpool_5323725.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'mohamad salah',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://editorial.uefa.com/resources/0257-0de5acf69903-7224a60456b7-1000/andres_iniesta_fc_barcelona_.jpeg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'andreas ineasta',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://static.toiimg.com/thumb/msid-77863861,width-1200,height-900,resizemode-4/.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                                bottom: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          ' ibrahimovic',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
            //Expanded(
            //child: SingleChildScrollView(
            //child:
            Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://cdn.vox-cdn.com/thumbor/m0oi_NKOxPkroClzWr8TdF3M-I0=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/22642176/1318347069.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lionel Messi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://icdn.strettynews.com/wp-content/uploads/2021/08/Screenshot-2021-08-27-at-16.57.15.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'cristeano ronaldo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://s.hs-data.com/bilder/spieler/gross/142105.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Neymar jr',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://e0.365dm.com/21/03/2048x1152/skysports-mohamed-salah-liverpool_5323725.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'mohamad salah',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://editorial.uefa.com/resources/0257-0de5acf69903-7224a60456b7-1000/andres_iniesta_fc_barcelona_.jpeg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'anreas iniasta',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://static.toiimg.com/thumb/msid-77863861,width-1200,height-900,resizemode-4/.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 3.0,
                            bottom: 3.0,
                          ),
                          child: CircleAvatar(
                            radius: 6.0,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ibrahimovic',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Hello and welcom to my profile',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Text('02:33 pm'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
