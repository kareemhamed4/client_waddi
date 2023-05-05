// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import 'package:flutter/material.dart';

class searchData extends SearchDelegate
{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: (){}, icon: const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('No Result'));
  }

}