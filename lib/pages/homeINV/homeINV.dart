import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbarINV.dart';

class homeINV extends StatefulWidget {
  const homeINV({Key? key}) : super(key: key);

  @override
  State<homeINV> createState() => _homeINVState();
}

class _homeINVState extends State<homeINV> {
  List<EntrepreneurIdea> _data = [];
  int _pageIndex = 0;
  int _pageSize = 20;

  final GlobalKey<_homeINVState> _widgetKey = GlobalKey<_homeINVState>();
  

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
    final user = Provider.of<BaseState>(context, listen: false).user;

      // Now you can use myVariable in initState
      _loadData(user.prefTags);
});

    
  }

  void _loadData(List<String> tags) {
    // Simulating fetching data from an API
    EntrepreneurIdea idea = EntrepreneurIdea();
    idea.getIdeasByTags(tags).then((value) {
      setState(() {
        print("#########################");
        _data.addAll(value);
        print(value);
      });
    });

    
  }

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    return Scaffold(
      
      bottomNavigationBar: const NavINV(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: _data.length + 1, // +1 for the loading indicator
          itemBuilder: (context, index) {
            if (index == _data.length) {
              // Show loading indicator at the end
              return Center(child: CircularProgressIndicator());
            }
            return InkWell(
              onTap: () {
                    // Handle item tap
                    print("Image Link: ${_data[index].imgLink}");
                    baseState.idea.entrepreneurId = _data[index].entrepreneurId;
                    baseState.idea.getIdea().then((value) {
                      Navigator.pushNamed(context,MyRoutes.ideapage);
                    },);
                  },
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text('Item ${_data[index].name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150, // Adjust the image container's height as needed
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_data[index].imgLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Add spacing between image and description
                      Text(_data[index].sIdeaDescription),
                    ],
                  ),
                  
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
