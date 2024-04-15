import 'package:flutter/material.dart';
import 'package:social_sense/utils/type_def.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final InputCallback callback;
  const SearchInput({
    super.key,
    required this.searchController,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: callback,
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Color(0xff242424),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
