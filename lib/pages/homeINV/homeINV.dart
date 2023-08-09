import 'package:flutter/material.dart';
import 'navbarINV.dart';

class homeINV extends StatefulWidget {
  const homeINV({Key? key}) : super(key: key);

  @override
  State<homeINV> createState() => _homeINVState();
}

class _homeINVState extends State<homeINV> {
  List<int> _data = [];
  int _pageIndex = 0;
  int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Simulating fetching data from an API
    for (int i = 0; i < _pageSize; i++) {
      _data.add(i + _pageIndex * _pageSize);
    }
    _pageIndex++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavINV(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: _data.length + 1, // +1 for the loading indicator
          itemBuilder: (context, index) {
            if (index == _data.length) {
              // Show loading indicator at the end
              _loadData();
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Text(
                  'Row ${index ~/ 2 + 1}', // Index divided by 2 for row number
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text('Item ${_data[index]}'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
