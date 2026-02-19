import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationSearchWidget extends StatefulWidget {
  final List<String> locations;
  final Function(Placemark) onLocationSelected;

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
  final ScrollController _scrollController = ScrollController();
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
    _scrollController.dispose();
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

  void _selectPlace(Placemark place) {
    setState(() {
      _searchController.text = place.name!;
      _filteredPlaces = [];
      _searchFocusNode.unfocus();
    });
    widget.onLocationSelected(place);
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onLocationSelected(Placemark());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final horizontalPadding = screenWidth * 0.04; // 4% ของความกว้าง
    final borderRadius = screenWidth * 0.03; // 3% ของความกว้าง

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search TextField
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            screenHeight * 0.01,
            horizontalPadding,
            screenHeight * 0.01,
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            style: TextStyle(fontSize: isSmallScreen ? 13 : 15),
            decoration: InputDecoration(
              hintText: 'ค้นหาสถานที่ในมช. เช่น หอสมุด, คณะวิทยาศาสตร์',
              hintStyle: TextStyle(fontSize: isSmallScreen ? 12 : 14),
              prefixIcon: Icon(Icons.search, size: isSmallScreen ? 20 : 24),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, size: isSmallScreen ? 20 : 24),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
            ),
          ),
        ),

        // Search Results
        if (_filteredPlaces.isNotEmpty)
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              constraints: BoxConstraints(
                maxHeight: isSmallScreen
                    ? 96
                    : 144, // แสดงได้สูงสุด 2 รายการ (48px/72px ต่อรายการ)
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[850]
                    : Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]!
                      : Colors.grey[300]!,
                  width: isSmallScreen ? 1.5 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: isSmallScreen ? 6 : 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                thickness: isSmallScreen ? 3 : 4,
                radius: Radius.circular(borderRadius * 0.5),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
                  itemCount: _filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = _filteredPlaces[index];
                    return ListTile(
                      dense: isSmallScreen,
                      leading: Icon(
                        Icons.location_on,
                        size: isSmallScreen ? 20 : 24,
                      ),
                      title: Text(
                        place,
                        style: TextStyle(fontSize: isSmallScreen ? 13 : 15),
                      ),
                      onTap: () => _selectPlace(Placemark(name: place)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius * 0.67,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
