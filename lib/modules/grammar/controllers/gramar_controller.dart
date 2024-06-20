import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/grammar.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class GrammarController extends GetxController {
  final String grammar;
   var lines = <String>[].obs;

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
        fileName = Grammar.pronouns;
        debugPrint(fileName);

        break;
      case "Adjective":
        // Xử lý cho "Adjective"
        print("Handling Adjective");
        fileName = Grammar.adjective;

        break;
      case "Verbs":
        // Xử lý cho "Verbs"
        print("Handling Verbs");
        fileName = Grammar.verbs;

        break;
      case "Adverbs":
        // Xử lý cho "Adverbs"
        print("Handling Adverbs");
        fileName = Grammar.adverbs;

        break;
      case "Prepositions":
        // Xử lý cho "Prepositions"
        print("Handling Prepositions");
        fileName = Grammar.prepositions;

        break;
      case "Conjunctions":
        // Xử lý cho "Conjunctions"
        print("Handling Conjunctions");
        fileName = Grammar.conjuncsitions;

        break;
      case "Interjections":
        // Xử lý cho "Interjections"
        print("Handling Interjections");
        fileName = Grammar.interjections;

        break;
      case "Articles":
        // Xử lý cho "Articles"
        print("Handling Articles");
        fileName = Grammar.articles;

        break;
      case "Determiners":
        // Xử lý cho "Determiners"
        print("Handling Determiners");
        fileName = Grammar.determiners;

        break;
      case "Present Simple":
        // Xử lý cho "Present Simple"
        print("Handling Present Simple");
        fileName = Grammar.present_simple;

        break;
      case "Present Continuous":
        // Xử lý cho "Present Continuous"
        print("Handling Present Continuous");
        fileName = Grammar.present_continuous;

        break;
      case "Present Perfect":
        // Xử lý cho "Present Perfect"
        print("Handling Present Perfect");
        fileName = Grammar.present_perfect;

        break;
      case "Present Perfect Continuous":
        // Xử lý cho "Present Perfect Continuous"
        print("Handling Present Perfect Continuous");
        fileName = Grammar.present_continuous;

        break;
      case "Past Simple":
        // Xử lý cho "Past Simple"
        print("Handling Past Simple");
        fileName = Grammar.past_simple;

        break;
      case "Past Continuous":
        // Xử lý cho "Past Continuous"
        print("Handling Past Continuous");
        fileName = Grammar.past_continuous;

        break;
      case "Past Perfect":
        // Xử lý cho "Past Perfect"
        print("Handling Past Perfect");
        fileName = Grammar.past_perfect;

        break;
      case "Past Perfect Continuous":
        // Xử lý cho "Past Perfect Continuous"
        print("Handling Past Perfect Continuous");
        fileName = Grammar.past_perfect_continuous;

        break;
      case "Future Simple":
        // Xử lý cho "Future Simple"
        print("Handling Future Simple");
        fileName = Grammar.future_simple;

        break;
      case "Future Continuous":
        // Xử lý cho "Future Continuous"
        print("Handling Future Continuous");
        fileName = Grammar.future_continuous;

        break;
      case "Future Perfect":
        // Xử lý cho "Future Perfect"
        print("Handling Future Perfect");
        fileName = Grammar.future_perfect;

        break;
      case "Future Perfect Continuous":
        // Xử lý cho "Future Perfect Continuous"
        print("Handling Future Perfect Continuous");
        fileName = Grammar.future_perfect_conntinuous;

        break;
      case "Modals":
        // Xử lý cho "Modals"
        print("Handling Modals");
        fileName = Grammar.modals;

        break;
      case "Zero Conditional":
        // Xử lý cho "Zero Conditional"
        print("Handling Zero Conditional");
        fileName = Grammar.zero_conditional;

        break;
      case "First Conditional":
        // Xử lý cho "First Conditional"
        print("Handling First Conditional");
        fileName = Grammar.first_conditional;

        break;
      case "Second Conditional":
        // Xử lý cho "Second Conditional"
        print("Handling Second Conditional");
        fileName = Grammar.second_conditional;

        break;
      case "Third Conditional":
        // Xử lý cho "Third Conditional"
        print("Handling Third Conditional");
        fileName = Grammar.third_conditional;

        break;
      case "Mixed Conditional":
        // Xử lý cho "Mixed Conditional"
        print("Handling Mixed Conditional");
        fileName = Grammar.mixed_conditional;

        break;
      case "Passice Voice":
        // Xử lý cho "Passice Voice"
        print("Handling Passice Voice");
        fileName = Grammar.passive_voice;

        break;
      case "Reported Speech":
        // Xử lý cho "Reported Speech"
        print("Handling Reported Speech");
        fileName = Grammar.reported_speech;

        break;
      case "Yes/No Questions":
        // Xử lý cho "Yes/No Questions"
        print("Handling Yes/No Questions");
        fileName = Grammar.yes_no_questions;

        break;
      case "Wh- Questions":
        // Xử lý cho "Wh- Questions"
        print("Handling Wh- Questions");
        fileName = Grammar.wh_questions;

        break;
      case "Tag Questions":
        // Xử lý cho "Tag Questions"
        print("Handling Tag Questions");
        fileName = Grammar.tags_questions;

        break;
      case "Defining and Non-defining relative clauses":
        // Xử lý cho "Defining and Non-defining relative clauses"
        print("Handling Defining and Non-defining relative clauses");
        fileName = Grammar.definiting_non_definiting_relatives_clauses;

        break;
      case "Relative pronouns":
        // Xử lý cho "Relative pronouns"
        print("Handling Relative pronouns");
        fileName = Grammar.relative_pronounns;

        break;
      default:
        // Xử lý cho các trường hợp không khớp
        print("Unknown input");
    }

    try {
      String content = await rootBundle.loadString(fileName);
      debugPrint(content);

      lines.value = content.split('\n');
      //debugPrint(lines.value.length as String?);

    } catch (e) {
      lines.value = "Error loading file" as List<String>;
    }
  }

  List<Widget> parseTextToWidgets(String text) {
    List<Widget> widgets = [];
    List<String> lines = text.split('\n');

    for (String line in lines) {
      if (line.startsWith('###')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            line.substring(3),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
          ),
        ));
      } else if (line.startsWith('*')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            line.substring(1),
            style: TextStyle(color: Colors.yellow[800], fontSize: 18),
          ),
        ));
      } else {
        widgets.add(Text(line, style: TextStyle(fontSize: 16)));
      }
    }
    return widgets;
  }
}
