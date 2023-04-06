import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/src/models/info_pokemon_model.dart';

class PokemonDetail extends StatelessWidget {
  final InfoPokemonModel pokemon;
  PokemonDetail({super.key, required this.pokemon});
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan[600],
        elevation: 0,
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: w,
          height: h,
          color: Colors.cyan[600],
          child: Column(
            children: [
              //
              _cardImgPokemon(),
              SizedBox(
                height: h * 0.02,
              ),
              _counterAbilityesMoves(),
              SizedBox(
                height: h * 0.01,
              ),
              _listsAbilityesMoves(),
            ],
          ),
        ),
      ),
    );
  }

  _cardImgPokemon() {
    return SizedBox(
      width: w * 0.5,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Hero(
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
      ),
    );
  }

  _counterAbilityesMoves() {
    return SizedBox(
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Abilidades: ${pokemon.abilities.length}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          Text(
            'Movimientos: ${pokemon.moves.length}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    );
  }

  _listsAbilityesMoves() {
    return SizedBox(
      width: w,
      height: h * 0.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _listAbilities(),
          SizedBox(
            width: w * 0.02,
          ),
          _listMoves(),
        ],
      ),
    );
  }

  _listAbilities() {
    return Container(
      width: w * 0.47,
      height: h * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        itemCount: pokemon.abilities.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 30,
              child: Image.asset(
                'assets/icons/pokelogo.png',
                fit: BoxFit.fill,
              ),
            ),
            title: Text(pokemon.abilities[index].name),
          );
        },
      ),
    );
  }

  _listMoves() {
    return Container(
      width: w * 0.47,
      height: h * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        itemCount: pokemon.moves.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 30,
              child: Image.asset(
                'assets/icons/pokelogo.png',
                fit: BoxFit.fill,
              ),
            ),
            title: Text(pokemon.moves[index].name),
          );
        },
      ),
    );
  }
}
