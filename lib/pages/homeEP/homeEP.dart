import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../homeEP/navbarEP.dart';
//import 'fl_chart/fl_chart.dart';

class homeEP extends StatefulWidget {
  const homeEP({super.key});

  @override
  State<homeEP> createState() => _homeEPState();
}

class _homeEPState extends State<homeEP> {

  EntrepreneurIdea idea = EntrepreneurIdea();
  List<AppUser> investors = [];
    @override
void initState() {
  super.initState();
  Future.delayed(Duration.zero, () {
    final BaseState baseState = Provider.of<BaseState>(context, listen: false);
    baseState.idea.entrepreneurId = baseState.user.uid;
    baseState.idea.getIdea().then((value) async {
      idea = baseState.idea;
      List<Future<void>> futures = [];

      for (var i in idea.investors) {
        AppUser user = AppUser(uid: i.investorId);
        futures.add(user.getUser(i.investorId));
        investors.add(user);
      }

      await Future.wait(futures);

      setState(() {});
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your Venture',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statistics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Funding Required: ${idea.fundingNeeded}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Funding Raised: ${idea.capitalRaised}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Text(
                'Investors',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                ),
              SizedBox(height: 20),
              Container(
                height: 80, // Decreased height of the horizontal list view
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: investors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.all(8),
                      color: Colors.grey[300],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Name ${investors[index].firstName}'),
                            SizedBox(height: 8),
                            Text('Amount Invested: ${idea.investors[index].amountInvested}'),
                            SizedBox(height: 8),
                            Text('Equity Received: ${idea.investors[index].equityObtained}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                       Container(
                        height: 250, // Adjust the image container's height as needed
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(idea.imgLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        idea.sIdeaDescription,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Add button 2 logic
                          Navigator.pushNamed(context, MyRoutes.ideapage_EP);
                        },
                        child: const Text('View More'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
