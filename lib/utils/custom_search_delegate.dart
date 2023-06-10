import 'package:flutter/material.dart';

import '../screen/update_player/update_player_screen.dart';
import '../screen/delete_booking/delete_booking_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [];

  CustomSearchDelegate(this.searchTerms);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePlayerScreen(
                    result,
                  ),
                ));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 40,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (int i = 1; i <= 5; i++) {
      if (searchTerms[i].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(searchTerms[i]);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          leading: Icon(Icons.access_time),
        );
      },
    );
  }
}
