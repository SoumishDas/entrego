import 'package:entrego/globalState.dart';
import 'package:entrego/utils/MyRoutes.dart';
import 'package:entrego/utils/f_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class investPg extends StatefulWidget {
  const investPg({super.key});

  @override
  State<investPg> createState() => _investPgState();
}

class _investPgState extends State<investPg> {
  double _enteredValue = 0;
  bool flag = true;
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BaseState baseState = Provider.of<BaseState>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/BG.jpg"),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: const Text(
                        "Invest",
                        style: TextStyle(
                            color: Color.fromRGBO(43, 98, 102, 1),
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'PortFolio:  ${baseState.user.capital}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        double val = double.tryParse(value) ?? 0;
                        if (val >= baseState.user.capital) {
                          showErrorMessage(
                              "Entered amount is greater than available Capital");
                          flag = false;
                          return;
                        } else if (val >
                            (baseState.idea.fundingNeeded -
                                baseState.idea.capitalRaised)) {
                          showErrorMessage(
                              "More funding given than what is needed");
                          flag = false;
                          return;
                        }
                        setState(() {
                          _enteredValue = val;
                          flag = true;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Amount to allocate',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Percentage of Portfolio: ${(_enteredValue / baseState.user.capital) * 100}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Equity you get in return: ${(_enteredValue / baseState.idea.fundingNeeded) * baseState.idea.equityOffered}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(43, 98, 102, 1)),
                      onPressed: () {
                        if (!flag) {
                          showErrorMessage("There are errors in form");
                          return;
                        }
                        // Implement Invest button functionality
                        Investor investment =
                            Investor(investorId: baseState.user.uid);
                        Portfolio portfolio =
                            Portfolio(uid: baseState.user.uid);

                        investment.addInvestmentIfNotExists().then((value) {
                          investment
                              .addInvestmentAndUpdateEquity(
                                  _enteredValue,
                                  (_enteredValue /
                                          baseState.idea.fundingNeeded) *
                                      baseState.idea.equityOffered)
                              .then(
                            (value) {
                              baseState.idea
                                  .addInvestment(investment)
                                  .then((value) {
                                portfolio.addInvestment(investment).then(
                                  (value) {
                                    baseState.user
                                        .subtractCapital(_enteredValue.toInt())
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, MyRoutes.homeINVPage);
                                    });
                                  },
                                );
                              });
                            },
                          );
                        });
                      },
                      child: const Text('Invest'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tip: We recommend investing small amounts into multiple businesses',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
