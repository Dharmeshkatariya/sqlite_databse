import 'package:flutter/material.dart';

import '../modal/dao/carddao.dart';
import '../modal/entity/card.dart';

class DataListView extends StatefulWidget {
  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  List<CardItem> _data = []; // Store fetched data
  int _pageSize = 10; // Number of items per page
  int _currentPage = 1; // Current page
  bool _ascending = true; // Sorting order

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await CardItemDao().getPaginatedAndSortedData(
      page: _currentPage,
      pageSize: _pageSize,
      ascending: _ascending,
    );

    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination and Sorting Example'),
      ),
      body: Column(
        children: [
          _buildSortHeaders(),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('ID: ${item.id}'),
                );
              },
            ),
          ),
          _buildPaginationButtons(),
        ],
      ),
    );
  }

  Widget _buildSortHeaders() {
    return Row(
      children: [
        _buildSortableHeader('ID', 'id'),
        _buildSortableHeader('Name', 'name'),
        // Add more headers as needed
      ],
    );
  }

  Widget _buildSortableHeader(String label, String sortByColumn) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _ascending = !_ascending;
          });
          _fetchData();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              Icon(
                _ascending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _currentPage > 1
              ? () {
            setState(() {
              _currentPage--;
            });
            _fetchData();
          }
              : null,
          child: Text('Previous Page'),
        ),
        SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentPage++;
            });
            _fetchData();
          },
          child: Text('Next Page'),
        ),
      ],
    );
  }
}
