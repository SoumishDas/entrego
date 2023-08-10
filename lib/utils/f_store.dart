import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';

class FStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class Investor {
  String uid;
  String investorId; // ID of the investor
  String ideaId;
  double amountInvested;
  double equityObtained;

  Investor({
    this.uid = "",
    this.investorId = "",
    this.ideaId = "",
    this.amountInvested = 0,
    this.equityObtained = 0,
  });

  Future<void> addInvestmentIfNotExists() async {
    
      await FirebaseFirestore.instance
          .collection('investments')
          .add({
        'investorId': investorId,
        'amountInvested': 0.0,
        'equityObtained': 0.0,
      }).then((value) {
        uid = value.id;
        FirebaseFirestore.instance
          .collection('investments').doc(uid).set({"uid":uid});
      },);
    
  }
  Future<void> addInvestmentAndUpdateEquity(
      double amount, double equity) async {
    final DocumentReference investorRef =
        FirebaseFirestore.instance.collection('investments').doc(uid);

    // Update the amountInvested and equityObtained fields
    await investorRef.update({
      'amountInvested': FieldValue.increment(amount),
      'equityObtained': FieldValue.increment(equity),
    });
    // Update the local Investor object
  amountInvested += amount;
  equityObtained += equity;
    
  }

  Map<String, dynamic> toMap() {
    return {
      'investorId': investorId,
      'amountInvested': amountInvested,
      'equityObtained': equityObtained,
    };
  }
}

class EntrepreneurIdea {
  String imgLink;
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
    this.imgLink = "",
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
        .collection('ideas').doc(entrepreneurId)
        .set({
      'imgLink':imgLink,
      'entrepreneurId':entrepreneurId,
      'name': name,
      'sIdeaDescription': sIdeaDescription,
      'bIdeaDescription': bIdeaDescription,
      'fundingNeeded': fundingNeeded,
      'equityOffered': equityOffered,
      'capitalRaised': capitalRaised,
      "tags": tags,
      'techUsed': techUsed,
      "contactInfo":contactInfo,
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
      imgLink = data["imgLink"] ?? "";
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
   Future<List<EntrepreneurIdea>> getIdeasByTags(List<String> tags) async {
    final QuerySnapshot res = await FirebaseFirestore.instance
        .collectionGroup('ideas')
        .where('tags', arrayContainsAny: tags)
        .get();

    final List<DocumentSnapshot> documents = res.docs;
    List<EntrepreneurIdea> ideas = [];

    for (var document in documents) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      ideas.add(EntrepreneurIdea(
        imgLink : data["imgLink"] ?? "",
        entrepreneurId: data["entrepreneurId"],
        name: data["name"],
        sIdeaDescription: data["sIdeaDescription"],
        bIdeaDescription: data["bIdeaDescription"],
        fundingNeeded: data["fundingNeeded"],
        equityOffered: data["equityOffered"],
        capitalRaised: data["capitalRaised"],
        contactInfo: data["contactInfo"],
        tags: List<String>.from(data["tags"] ?? []),
        techUsed: List<String>.from(data["techUsed"] ?? []),
        // You can leave investors empty for now or fetch them separately if needed
        investors: [],
      ));
    }

    return ideas;
   }

  Future<void> addInvestment(Investor investor) async {
    investors.add(investor);
    capitalRaised += investor.amountInvested;

    

    await FirebaseFirestore.instance
        .collection('app_users')
        .doc(entrepreneurId)
        .collection('ideas')
        .doc(entrepreneurId)
        .update({
      'capitalRaised': capitalRaised,
      'investors': FieldValue.arrayUnion([investor.toMap()])
    });
  }
}

class Portfolio {
  String uid; // User ID or document ID
  List<Investor> investments;

  Portfolio({
    this.uid ="",
    this.investments = const [],
  });

  Future<void> addInvestment(Investor investment) async {
    // Get a reference to the user's portfolio document
    final portfolioRef = FirebaseFirestore.instance
        .collection('app_users')
        .doc(uid)
        .collection('portfolio')
        .doc('investments');

    // Check if the portfolio document exists
    final portfolioSnapshot = await portfolioRef.get();

    if (portfolioSnapshot.exists) {
      // Portfolio document exists, update the investments field
      await portfolioRef.set(
        {
          'investments': FieldValue.arrayUnion([investment.toMap()])
        },
        SetOptions(merge: true),
      );
    } else {
      // Portfolio document doesn't exist, create a new portfolio and add the investment
      await portfolioRef.set(
        {
          'investments': [investment.toMap()]
        },
      );
    }
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

  Future<void> subtractCapital(int amount) async {
    if (isInvestor) {
      // Calculate new capital value after subtracting the amount
      int newCapital = capital - amount;

      if (newCapital >= 0) {
        await FirebaseFirestore.instance
            .collection('app_users')
            .doc(uid)
            .update({
          'capital': newCapital,
        });

        capital = newCapital;
      } else {
        print('Insufficient capital');
      }
    } else {
      print("Only investors can subtract capital.");
    }
  }

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
