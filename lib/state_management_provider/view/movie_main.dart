import 'package:advanced/state_management_provider/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:advanced/state_management_provider/provider/movie_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MovieProvider>(
    create: (context) => MovieProvider(),
    child: MaterialApp(
      home: MovieMain(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MovieMain extends StatelessWidget {
  const MovieMain({super.key});
  @override
  Widget build(BuildContext context) {
    var movieS = context.watch<MovieProvider>().movies;
    var wishLIST = context.watch<MovieProvider>().wishList;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movie WishList"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(children: [
        ElevatedButton.icon(
            onPressed: () {
              Navigator.push((context), MaterialPageRoute(builder: (context) => MovieWishList()));
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: Text("Wishlist ${wishLIST.length}")),
        Expanded(
          child: ListView.builder(
            itemCount: 51,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.lightBlue.shade300,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ListTile(
                  title: Text(movieS[index].title),
                  subtitle: Text(movieS[index].time),
                  trailing: IconButton(
                      onPressed: () {
                        if (!wishLIST.contains(movieS[index])) {
                          context.read<MovieProvider>().addWishList(movieS[index]);
                        } else {
                          context.read<MovieProvider>().removeWishList(movieS[index]);
                        }
                      },
                      icon: wishLIST.contains(movieS[index])
                          ? FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            )
                          : FaIcon(
                              FontAwesomeIcons.heartCrack,
                              color: Colors.grey.shade600,
                            )),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
