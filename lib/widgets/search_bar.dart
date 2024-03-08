import 'package:flutter/material.dart';

Widget _buildSearchResults() {
  var searchResults;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'Search Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10),
      Expanded(
        child: searchResults.isEmpty
            ? _buildEmptyResults()
            : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: ListTile(
                      title: Text(searchResults[index]),
                      // Customize the appearance of search request cards
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(searchResults[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    ],
  );
}

///detail screen
DetailScreen(searchResult) {}

Widget _buildEmptyResults() {
  return Center(
    child: Text(
      'No search results found.',
      style: TextStyle(fontSize: 16),
    ),
  );
}
