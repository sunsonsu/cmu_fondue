import 'package:flutter/material.dart';

class LocationSearchWidget extends StatefulWidget {
  final List<String> locations;
  final Function(String) onLocationSelected;

  const LocationSearchWidget({
    super.key,
    required this.locations,
    required this.onLocationSelected,
  });

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;

    setState(() {
      if (query.isEmpty) {
        _filteredPlaces = [];
      } else {
        _filteredPlaces = widget.locations
            .where((place) => place.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectPlace(String place) {
    setState(() {
      _searchController.text = place;
      _filteredPlaces = [];
      _searchFocusNode.unfocus();
    });
    widget.onLocationSelected(place);
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onLocationSelected('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search TextField
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'ค้นหาสถานที่ในมช. เช่น หอสมุด, คณะวิทยาศาสตร์',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),

        // Search Results
        if (_filteredPlaces.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = _filteredPlaces[index];
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(place),
                  onTap: () => _selectPlace(place),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
