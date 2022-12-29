import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/pokemon.dart';
import 'package:pokemonapp/pokemondetails.dart';

void main() => runApp(MaterialApp(
      title: "Pokemon App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  var res;

  PokeHub? pokehub;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    res = await http.get(Uri.parse(url));
    var decoded = jsonDecode(res.body);
    pokehub = PokeHub.fromJson(decoded);
    print(pokehub);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: pokehub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokehub?.pokemon
                      ?.map((Pokemon poke) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            pokemondetails(pokemon: poke)));
                              },
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Hero(
                                      tag: poke.img!,
                                      child: Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(poke.img!))),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10.0,
                                    // ),

                                    Text(
                                      poke.name!,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      ?.toList() ??
                  [],
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
