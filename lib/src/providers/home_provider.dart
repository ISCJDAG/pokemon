// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon/src/global/api_routes.dart';
import 'package:pokemon/src/models/info_pokemon_model.dart';
import 'package:pokemon/src/models/pokemon_model.dart';
import 'package:pokemon/src/services/getService.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  ApiRoutes apiRoutes = ApiRoutes();
  //variables
  late RoundedLoadingButtonController btnSearchController =
      RoundedLoadingButtonController();
  late List<InfoPokemonModel> listPokemon = [];
  late bool isLoading = true;
  late int counterPokemon = 0;

  getPokemons(String text, BuildContext context) async {
    try {
      isLoading = true;
      String url = '';
      listPokemon = [];
      Map<String, String> header = {
        "Content-Type": "application/json",
      };

      if (text.isNotEmpty) {
        //
        url = '${apiRoutes.urlDefult}$text';
        await getPokemonData(url);
        btnSearchController.reset();
      } else {
        //
        url = '${apiRoutes.urlDefult}?limit=30&offset=0';
        var response = await GetService().getPokemonsService(url, header);
        var decodedJson = json.decode(response.body);
        var list = decodedJson['results'] as List;

        if (response.statusCode == 200 && list.isNotEmpty) {
          var results = decodedJson["results"];
          url = decodedJson["next"];
          var pokemons = List.from(results)
              .map((pokemonResult) => PokemonModel.fromJson(pokemonResult))
              .toList();
          for (var result in pokemons) {
            getPokemonData(result.url);
          }
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              'No se encontro información.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blueAccent,
            duration: const Duration(seconds: 3),
          ));
          listPokemon = [];
          btnSearchController.reset();
        }
      }
      isLoading = false;
      notifyListeners();
      getCountPoke();
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'No se puedo conectar al servidor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ));
      btnSearchController.reset();
    }
  }

  getPokemonData(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.body != "Not Found") {
      var decodedJson = jsonDecode(response.body);
      var pokemon = InfoPokemonModel.fromJson(decodedJson);

      listPokemon.add(pokemon);
      listPokemon.sort((a, b) => a.id.compareTo(b.id));
    } else {}

    isLoading = false;
    notifyListeners();
  }

  getCountPoke() {
    counterPokemon = listPokemon.length;
    //print(counterPokemon);
    notifyListeners();
  }
}
