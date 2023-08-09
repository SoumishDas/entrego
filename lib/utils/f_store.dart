import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';

class FStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class Investor {
  String investorId; // ID of the investor
  double amountInvested;
  double equityObtained;

  Investor({
    required this.investorId,
    required this.amountInvested,
    required this.equityObtained,
  });

  Map<String, dynamic> toMap() {
    return {
      'investorId': investorId,
      'amountInvested': amountInvested,
      'equityObtained': equityObtained,
    };
  }
}

class EntrepreneurIdea {
  String entrepreneurId; // ID of the entrepreneur
  String name;
  String sIdeaDescription;
  String bIdeaDescription;
  double fundingNeeded;
  double equityOffered; // Percentage of equity offered to investors
  double capitalRaised;
  String contactInfo;
  List<String> tags;
  List<String> techUsed;
  List<Investor> investors;

  EntrepreneurIdea({
    this.tags = const [],
    this.techUsed = const [],
    this.name = '',
    this.entrepreneurId = "",
    this.bIdeaDescription = '',
    this.sIdeaDescription = '',
    this.contactInfo = '',
    this.fundingNeeded = 0,
    this.equityOffered = 0,
    this.capitalRaised = 0,
    this.investors = const [],
  });

  Future<bool> saveIdea() async {
    return await FirebaseFirestore.instance
        .collection('app_users')
        .doc(entrepreneurId)
        .collection('ideas')
        .add({
      'name': name,
      'sIdeaDescription': sIdeaDescription,
      'bIdeaDescription': bIdeaDescription,
      'fundingNeeded': fundingNeeded,
      'equityOffered': equityOffered,
      'capitalRaised': capitalRaised,
      "tags": tags,
      'techUsed': techUsed,
    }).then((value) {
      print("Idea Saved");
      return true;
    }).catchError((error) {
      print("Failed to save idea: $error");
      return false;
    });
  }

  Future<bool> getIdea() async {
    final QuerySnapshot res = await FirebaseFirestore.instance
        .collection('app_users')
        .doc(entrepreneurId)
        .collection('ideas')
        .get();

    final List<DocumentSnapshot> documents = res.docs;
    if (documents.isEmpty) {
      return false;
    } else {
      Map<String, dynamic> data =
          documents.first.data()! as Map<String, dynamic>;

      name = data["name"];
      sIdeaDescription = data["sIdeaDescription"];
      bIdeaDescription = data["bIdeaDescription"];
      fundingNeeded = data["fundingNeeded"];
      equityOffered = data["equityOffered"];
      capitalRaised = data["capitalRaised"];
      contactInfo = data["contactInfo"];
      tags = List<String>.from(data["tags"] ?? []);
      techUsed = List<String>.from(data["techUsed"] ?? []);

      // Load investors
      List<dynamic> investorList = data["investors"] ?? [];
      investors = investorList.map((item) {
        return Investor(
          investorId: item["investorId"],
          amountInvested: item["amountInvested"],
          equityObtained: item["equityObtained"],
        );
      }).toList();

      return true;
    }
  }

  Future<void> addInvestment(Investor investor) async {
    investors.add(investor);
    capitalRaised += investor.amountInvested;

    // Calculate equity based on the entrepreneur's equity offered and investor's investment
    double entrepreneurEquity =
        investor.amountInvested * (equityOffered / fundingNeeded);
    investor.equityObtained += entrepreneurEquity;

    await FirebaseFirestore.instance
        .collection('app_users')
        .doc(entrepreneurId)
        .collection('ideas')
        .doc()
        .update({
      'capitalRaised': capitalRaised,
      'investors': FieldValue.arrayUnion([investor.toMap()])
    });
  }
}

class Portfolio {
  String uid; // User ID or document ID
  List<Investment> investments;

  Portfolio({
    required this.uid,
    this.investments = const [],
  });

  Future<void> addInvestment(Investment investment) async {
    investments.add(investment);
    await FirebaseFirestore.instance
        .collection('app_users')
        .doc(uid)
        .collection('portfolio')
        .doc('investments')
        .set({
      'investments': FieldValue.arrayUnion([investment.toMap()])
    }, SetOptions(merge: true));
  }
}

class Investment {
  String ideaId; // ID of the entrepreneur's idea
  double amountInvested;
  double equityPercentage;

  Investment({
    required this.ideaId,
    required this.amountInvested,
    required this.equityPercentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'ideaId': ideaId,
      'amountInvested': amountInvested,
      'equityPercentage': equityPercentage,
    };
  }
}

class AppUser {
  String uid;
  String firstName;
  String lastName;
  String email;
  // If Entrepreneur
  String company;

  // If Investor
  bool isInvestor;
  List<String> prefTags;
  int capital;

  AppUser({
    this.uid = "",
    this.firstName = "",
    this.lastName = "",
    this.email = '',
    this.company = "",
    this.isInvestor = false,
    this.prefTags = const [],
    this.capital = 0,
  });

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users =
      FirebaseFirestore.instance.collection('app_users');

  Future<bool> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.doc(uid).set(
      {
        "uid": uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'company': company,
        'isInvestor': isInvestor,
        'prefTags': prefTags,
        'capital': capital,
      },
    ).then((value) {
      print("User Added");
      return true;
    }).catchError((error) {
      print("Failed to add user: $error");
      return false;
    });
  }

  Future<bool> getUser(String uid) async {
    final QuerySnapshot res = await FirebaseFirestore.instance
        .collection('app_users')
        .where('uid', isEqualTo: uid)
        .get(); //firebase query to get information about user

    final List<DocumentSnapshot> documents = res.docs;
    if (documents.isEmpty) {
      return false;
    } else {
      Map<String, dynamic> data =
          documents.first.data()! as Map<String, dynamic>;

      firstName = data["firstName"];
      lastName = data["lastName"];
      email = data["email"];
      company = data["company"];
      isInvestor = data["isInvestor"];
      prefTags = List<String>.from(data["prefTags"] ?? []);

      capital = data["capital"];

      return true;
    }
  }

  Future<void> addIdea(EntrepreneurIdea idea) async {
    if (!isInvestor) {
      await idea.saveIdea();
    } else {
      print("Investors cannot submit ideas.");
    }
  }

  // Add a portfolio to an entrepreneur's document
  Future<void> addPortfolio(List<Map<String, dynamic>> investments) async {
    if (!isInvestor) {
      await users.doc(email).collection('portfolio').add({
        'investments': investments,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      print("Investors cannot have a portfolio.");
    }
  }
}
