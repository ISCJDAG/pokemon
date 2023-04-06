// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/src/models/info_pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final InfoPokemonModel pokemon;
  PokemonCard({Key? key, required this.pokemon}) : super(key: key);
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GridTile(
      footer: Center(
        child: Text(pokemon.name),
      ),
      child: InkWell(
        onTap: () {
          //send to pokemon detail
          // Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => PokemonDetail(
          //           pokemon: pokemon,
          //         ),
          //       ));
        },
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Hero(
                tag: pokemon.id,
                child: Image.network(pokemon.imageUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}