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
  double _enteredValue = 0.0;

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
                height: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3))
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
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'PortFolio:  ${baseState.user.capital}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          _enteredValue = double.tryParse(value) ?? 0.0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Amount to allocate',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Percentage of Portfolio: ${(_enteredValue / baseState.user.capital) * 100}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Equity you get in return: ${(_enteredValue / baseState.idea.fundingNeeded) * baseState.idea.equityOffered}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(43, 98, 102, 1)),
                      onPressed: () {
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
                                portfolio.addInvestment(investment);
                              });
                            },
                          );
                        });
                      },
                      child: Text(
                        'Invest',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
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
