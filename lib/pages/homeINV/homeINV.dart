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
  final List<EntrepreneurIdea> _data = [];
  Portfolio portfolio = Portfolio();
  double totalMoney = 0;
  int numInvestments = 0;
  int capitalLeft = 0;

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final user = Provider.of<BaseState>(context, listen: false).user;
      portfolio.uid = user.uid;
      portfolio.getAllInvestments().then(
        (value) {
          print(value.length);
          numInvestments = value.length;
          capitalLeft = user.capital;
          for (Investor invest in value) {
            totalMoney += invest.amountInvested;
          }
          setState(() {});
        },
      ).onError((error, stackTrace) {
        showErrorMessage("Could Not Load Investments $error");
      });
      _loadData(user.prefTags);
    });
  }

  void _loadData(List<String> tags) {
    EntrepreneurIdea idea = EntrepreneurIdea();
    idea.getIdeasByTags(tags).then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: const NavINV(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.96,
          width: MediaQuery.of(context).size.width * 0.96,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Statistics",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(43, 98, 102, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // Set your desired color
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width *
                      0.9, // Adjust the container's height as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Money Invested: $totalMoney",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text("No. of investments: $numInvestments",
                                style: const TextStyle(fontSize: 20)),
                            Text("Portfolio left: $capitalLeft",
                                style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(height: 10),
              const Text(
                "Feed",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(43, 98, 102, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _data.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      child: InkWell(
                        onTap: () {
                          print("Image Link: ${_data[index].imgLink}");
                          baseState.idea.entrepreneurId =
                              _data[index].entrepreneurId;
                          baseState.idea.getIdea().then(
                            (value) {
                              Navigator.pushNamed(context, MyRoutes.ideapage);
                            },
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(3.0),
                          child: ListTile(
                            title: Text(
                              _data[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Container(
                                  height: 145,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_data[index].imgLink),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
