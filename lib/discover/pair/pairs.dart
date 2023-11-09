import 'package:flutter/material.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/discover/pair/pair_card.dart';
import 'package:unsplash_client/unsplash_client.dart';

class Pairs extends StatefulWidget {
  const Pairs({super.key});

  @override
  State<Pairs> createState() => _PairsState();
}

class _PairsState extends State<Pairs> {
  final client = UnsplashClient(
    settings: ClientSettings(
        credentials: AppCredentials(
      accessKey: '8UnzLmStSBZiVXROPkdMgcMfYl1TyWmBPGNZm3Oqyr0',
      secretKey: 'EFCOpO6Hic2xHh1ANMWCNHg3Vr0HDRXXz0VTjUx_gG8',
    )),
  );

  List<String> urlsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPic();
  }

  void fetchPic() async {
    final urls = await client.photos.random(count: 10).goAndGet();
    for (Photo i in urls) {
      urlsList.add(i.urls.small.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.appBlack,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.map,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                        )),
                    CircleAvatar(
                      radius: 20,
                      child: Container(),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 256,
                        mainAxisSpacing: 20),
                    itemCount: urlsList.length,
                    itemBuilder: (context, index) {
                      print(urlsList.elementAt(index));
                      return PairCard(
                          url: urlsList.elementAt(index),
                          name: "name",
                          age: 2,
                          distance: 2,
                          profession: "profession");
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
