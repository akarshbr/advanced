import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';

class MovieWishList extends StatelessWidget {
  const MovieWishList({super.key});

  @override
  Widget build(BuildContext context) {
    var movieS = context.watch<MovieProvider>().movies;
    var wishLIST = context.watch<MovieProvider>().wishList;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("WishList"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: wishLIST.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue.shade300,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ListTile(
                      title: Text(wishLIST[index].title),
                      subtitle: Text(wishLIST[index].time),
                      trailing: IconButton(
                          onPressed: () {
                            context.read<MovieProvider>().removeWishList(movieS[index]);
                          },
                          icon: FaIcon(Icons.delete)),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
