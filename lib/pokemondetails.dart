import 'package:flutter/material.dart';
import 'package:pokemonapp/pokemon.dart';

class pokemondetails extends StatelessWidget {
  pokemondetails({super.key, required this.pokemon});

  final Pokemon pokemon;

  bodyWidget(BuildContext context) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    pokemon.name!,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height ${pokemon.height}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Weight ${pokemon.weight}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.red,
                            label: Text(
                              t,
                              style: TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.id!,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(pokemon.img!), fit: BoxFit.cover)),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(pokemon.name!),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }
}
