import 'package:flutter/material.dart';

import '../modal/dao/carddao.dart';
import '../modal/entity/card.dart';

class PaginationScreeenSorting extends StatefulWidget {
  @override
  _PaginationScreeenSortingState createState() => _PaginationScreeenSortingState();
}

class _PaginationScreeenSortingState extends State<PaginationScreeenSorting> {
  List<CardItem> _data = []; // Store fetched data
  int _pageSize = 10; // Number of items per page
  int _currentPage = 1; // Current page
  bool _ascending = true; // Sorting order

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Future<void> _fetchData() async {
  //   final data = await CardItemDao().getPaginatedAndSortedData(
  //     page: _currentPage,
  //     pageSize: _pageSize,
  //     ascending: _ascending,
  //   );
  //
  //   setState(() {
  //     _data = data;
  //   });
  // }
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
          onPressed: _data.length == _pageSize // Disable if there's no more data to fetch
              ? null
              : () {
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

  Future<void> _fetchData() async {
    final now = DateTime(2023, 12, 31);
    final sevenDaysAgo =  DateTime(2023, 1, 1);

    final data = await CardItemDao().getPaginatedAndSortedDataWithDateFilter(
      page: _currentPage,
      pageSize: _pageSize,
      ascending: _ascending,
      startDate: sevenDaysAgo,
      endDate: now,
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
                return
                  ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${item.id}'),
                        // Text('Created At: ${item.id.toLocal()}'), // Display creation date
                      ],
                    ),
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

  // Widget _buildPaginationButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       ElevatedButton(
  //         onPressed: _currentPage > 1
  //             ? () {
  //           setState(() {
  //             _currentPage--;
  //           });
  //           _fetchData();
  //         }
  //             : null,
  //         child: Text('Previous Page'),
  //       ),
  //       SizedBox(width: 16.0),
  //       ElevatedButton(
  //         onPressed: () {
  //           setState(() {
  //             _currentPage++;
  //           });
  //           _fetchData();
  //         },
  //         child: Text('Next Page'),
  //       ),
  //     ],
  //   );
  // }
}
