// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/src/providers/home_provider.dart';
import 'package:pokemon/src/widgets/home/pokemon_card.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController serachText = TextEditingController();

  late double w, h;
  final ScrollController _scrollController = ScrollController();
  late bool isloading;
  late int count;
  @override
  void initState() {
    isloading = Provider.of<HomeProvider>(context, listen: false).isLoading;
    //loadPokemos

    count = Provider.of<HomeProvider>(context, listen: false).counterPokemon;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isloading) {
          setState(() {
            ////loadPokemons();
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    var homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            Align(
              alignment: Alignment.center,
              child: _searchInput(context, homeProvider),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            _btnSerachAction(context, homeProvider),
            //lista
            Expanded(
              child: homeProvider.listPokemon.isEmpty &&
                      homeProvider.isLoading == false
                  ? Center(
                      child: Text('No se encontraron pokemones'),
                    )
                  : homeProvider.isLoading == false
                      ? _listGridPokemon(homeProvider, context)
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  _searchInput(BuildContext context, HomeProvider provider) {
    return Container(
      width: w * 0.5,
      height: h * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 3,
        child: TextFormField(
          controller: serachText,
          onChanged: (value) {
            if (serachText.text.isEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
              //function to reload the 30 pokemons in provider
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          keyboardType: TextInputType.text,
          autocorrect: false,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(5.0, 1, 5, 1),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            prefixIcon: Icon(Icons.search, size: 30, color: Colors.grey),
            hintText: 'Busca un pokemon',
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    );
  }

  _btnSerachAction(BuildContext context, HomeProvider provider) {
    return RoundedLoadingButton(
      width: w * 0.3,
      height: h * 0.05,
      color: Colors.black,
      controller: provider.btnSearchController,
      onPressed: () async {
        await provider.getPokemons(serachText.text, context);
        //callFunction to search and upload listView data
      },
      borderRadius: 12,
      child: Text('Buscar'),
    );
  }

  _listGridPokemon(HomeProvider provider, BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: provider.listPokemon.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return PokemonCard(
            pokemon: provider.listPokemon[index],
          );
        });
  }
}
