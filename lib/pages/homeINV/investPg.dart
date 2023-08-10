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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'PortFolio: \$ ${baseState.user.capital}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
              SizedBox(height: 10),
              Text(
                '% of Portfolio: ${(_enteredValue/baseState.user.capital)*100}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Equity you get in return: ${(_enteredValue/baseState.idea.fundingNeeded) * baseState.idea.equityOffered}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement Invest button functionality
                  Investor investment = Investor(investorId: baseState.user.uid);
                  Portfolio portfolio = Portfolio(uid: baseState.user.uid);

                  investment.addInvestmentIfNotExists().then((value) {
                    investment.addInvestmentAndUpdateEquity( _enteredValue, (_enteredValue/baseState.idea.fundingNeeded) * baseState.idea.equityOffered).then((value) {
                      baseState.idea.addInvestment(investment).then((value) {
                        portfolio.addInvestment(investment).then((value) {
                          Navigator.pushNamed(context, MyRoutes.homeINVPage);
                        },);
                      });
                    },);
                  });
                },
                child: Text('Invest'),
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
    );
  }
}