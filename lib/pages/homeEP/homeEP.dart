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
      final BaseState baseState =
          Provider.of<BaseState>(context, listen: false);
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/BG.jpg"),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: SingleChildScrollView(
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
                      elevation: 5,
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
                    SizedBox(
                      height: 20,
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
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: investors.length == 0
                          ? Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  "No Investors Yet",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: investors.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 175,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                                  margin: EdgeInsets.all(8),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Name: ${investors[index].firstName}'),
                                        SizedBox(height: 8),
                                        Text(
                                            'Amount Invested: ${idea.investors[index].amountInvested}'),
                                        SizedBox(height: 8),
                                        Text(
                                            'Equity Received: ${idea.investors[index].equityObtained}%'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              idea.name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height:
                                  250, // Adjust the image container's height as needed
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
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(43, 98, 102, 1),
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.ideapage_EP);
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
          ),
        ),
      ),
      bottomNavigationBar: const NavEP(),
    );
  }
}
