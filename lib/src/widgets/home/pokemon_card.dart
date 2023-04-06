// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/src/models/info_pokemon_model.dart';
import 'package:pokemon/src/pages/pokemon_detail.dart';

class PokemonCard extends StatelessWidget {
  final InfoPokemonModel pokemon;
  PokemonCard({Key? key, required this.pokemon}) : super(key: key);
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(pokemon.name),
        ),
      ),
      child: InkWell(
        onTap: () {
          //send to pokemon detail
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetail(
                  pokemon: pokemon,
                ),
              ));
        },
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Hero(
                tag: pokemon.id,
                child: Image.network(
                  pokemon.imageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
