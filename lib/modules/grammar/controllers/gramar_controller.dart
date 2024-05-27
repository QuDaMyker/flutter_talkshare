import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/grammar.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class GrammarController extends GetxController {
  final String grammar;
  var fileContent = ''.obs;

  GrammarController ({required this.grammar});

 @override
  Future<void> onInit()async {
    super.onInit();
    await loadGrammarFile(grammar);
  }
  
  Future<void> loadGrammarFile(String grammar) async {
    String fileName = '';
    switch (grammar) {
      case "Nouns":
        // Xử lý cho "Nouns"
        fileName = Grammar.nouns;
        break;
      case "Pronouns":
        // Xử lý cho "Pronouns"
        print("Handling Pronouns");
        fileName = Grammar.nouns;
        debugPrint(fileName);


        break;
      case "Adjective":
        // Xử lý cho "Adjective"
        print("Handling Adjective");
        fileName = Grammar.nouns;

        break;
      case "Verbs":
        // Xử lý cho "Verbs"
        print("Handling Verbs");
        fileName = Grammar.nouns;

        break;
      case "Adverbs":
        // Xử lý cho "Adverbs"
        print("Handling Adverbs");
        fileName = Grammar.nouns;

        break;
      case "Prepositions":
        // Xử lý cho "Prepositions"
        print("Handling Prepositions");
        fileName = Grammar.nouns;

        break;
      case "Conjunctions":
        // Xử lý cho "Conjunctions"
        print("Handling Conjunctions");
        fileName = Grammar.nouns;

        break;
      case "Interjections":
        // Xử lý cho "Interjections"
        print("Handling Interjections");
        fileName = Grammar.nouns;

        break;
      case "Articles":
        // Xử lý cho "Articles"
        print("Handling Articles");
        fileName = Grammar.nouns;

        break;
      case "Determiners":
        // Xử lý cho "Determiners"
        print("Handling Determiners");
        fileName = Grammar.nouns;

        break;
      case "Present Simple":
        // Xử lý cho "Present Simple"
        print("Handling Present Simple");
        fileName = Grammar.nouns;

        break;
      case "Present Continuous":
        // Xử lý cho "Present Continuous"
        print("Handling Present Continuous");
        fileName = Grammar.nouns;

        break;
      case "Present Perfect":
        // Xử lý cho "Present Perfect"
        print("Handling Present Perfect");
        fileName = Grammar.nouns;

        break;
      case "Present Perfect Continuous":
        // Xử lý cho "Present Perfect Continuous"
        print("Handling Present Perfect Continuous");
        fileName = Grammar.nouns;

        break;
      case "Past Simple":
        // Xử lý cho "Past Simple"
        print("Handling Past Simple");
        fileName = Grammar.nouns;

        break;
      case "Past Continuous":
        // Xử lý cho "Past Continuous"
        print("Handling Past Continuous");
        fileName = Grammar.nouns;

        break;
      case "Past Perfect":
        // Xử lý cho "Past Perfect"
        print("Handling Past Perfect");
        fileName = Grammar.nouns;

        break;
      case "Past Perfect Continuous":
        // Xử lý cho "Past Perfect Continuous"
        print("Handling Past Perfect Continuous");
        fileName = Grammar.nouns;

        break;
      case "Future Simple":
        // Xử lý cho "Future Simple"
        print("Handling Future Simple");
        fileName = Grammar.nouns;

        break;
      case "Future Continuous":
        // Xử lý cho "Future Continuous"
        print("Handling Future Continuous");
        fileName = Grammar.nouns;

        break;
      case "Future Perfect":
        // Xử lý cho "Future Perfect"
        print("Handling Future Perfect");
        fileName = Grammar.nouns;

        break;
      case "Future Perfect Continuous":
        // Xử lý cho "Future Perfect Continuous"
        print("Handling Future Perfect Continuous");
        fileName = Grammar.nouns;

        break;
      case "Modals":
        // Xử lý cho "Modals"
        print("Handling Modals");
        fileName = Grammar.nouns;

        break;
      case "Zero Conditional":
        // Xử lý cho "Zero Conditional"
        print("Handling Zero Conditional");
        fileName = Grammar.nouns;

        break;
      case "First Conditional":
        // Xử lý cho "First Conditional"
        print("Handling First Conditional");
        fileName = Grammar.nouns;

        break;
      case "Second Conditional":
        // Xử lý cho "Second Conditional"
        print("Handling Second Conditional");
        fileName = Grammar.nouns;

        break;
      case "Third Conditional":
        // Xử lý cho "Third Conditional"
        print("Handling Third Conditional");
        fileName = Grammar.nouns;

        break;
      case "Mixed Conditional":
        // Xử lý cho "Mixed Conditional"
        print("Handling Mixed Conditional");
        fileName = Grammar.nouns;

        break;
      case "Passice Voice":
        // Xử lý cho "Passice Voice"
        print("Handling Passice Voice");
        fileName = Grammar.nouns;

        break;
      case "Reported Speech":
        // Xử lý cho "Reported Speech"
        print("Handling Reported Speech");
        fileName = Grammar.nouns;

        break;
      case "Yes/No Questions":
        // Xử lý cho "Yes/No Questions"
        print("Handling Yes/No Questions");
        fileName = Grammar.nouns;

        break;
      case "Wh- Questions":
        // Xử lý cho "Wh- Questions"
        print("Handling Wh- Questions");
        fileName = Grammar.nouns;

        break;
      case "Tag Questions":
        // Xử lý cho "Tag Questions"
        print("Handling Tag Questions");
        fileName = Grammar.nouns;

        break;
      case "Defining and Non-defining relative clauses":
        // Xử lý cho "Defining and Non-defining relative clauses"
        print("Handling Defining and Non-defining relative clauses");
        fileName = Grammar.nouns;

        break;
      case "Relative pronouns":
        // Xử lý cho "Relative pronouns"
        print("Handling Relative pronouns");
        fileName = Grammar.nouns;

        break;
      default:
        // Xử lý cho các trường hợp không khớp
        print("Unknown input");
    }


    try {
      String content = await rootBundle.loadString(fileName);
      fileContent.value = content;
      debugPrint(fileContent.value);
    } catch (e) {
      fileContent.value = "Error loading file";
    }
  }
}
