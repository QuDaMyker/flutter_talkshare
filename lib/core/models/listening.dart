import 'package:freezed_annotation/freezed_annotation.dart';

class Listening {
  final String name;
  final Duration time;
  final String script;
  final String audioURL;
  final String type;

  const Listening({
    required this.name,
    required this.time,
    required this.script,
    required this.audioURL,
    required this.type,
  });
}

class ListeningList {
  static final List<Listening> listeningShortList = [
    Listening(name: 'My flower garden', time: Duration(seconds: 57), 
      script:'My name is Anne. \nI love flowers. \nI have a flower garden.  \nMy garden is in front of my house. \nMy neighbor has a garden too. \nMy garden has different types of flowers. '+
      '\nI have roses in my garden. \nI have tulips in my garden. \nI have petunias in my garden. \nMy garden has different colors. \nI plant red flowers. \nI plant orange flowers. \nI plant blue flowers. \nI plant purple flowers. \nI take care of my garden. \nI water my garden every day. \nI kill the weeds in my garden. \nI kill insects that eat my flowers. \nI love my beautiful garden.',
      audioURL: 'https://dailydictation.com/upload/general-english/3-my-flower-garden-2019-03-15-01-07-24/0-3-my-flower-garden.mp3', type:'Short Stories'),
    Listening(name: 'Halloween Night', time: Duration(minutes: 1,seconds: 16), 
      script:"Halloween is fun. \nMy mom buys candy. \nMy mom buys potato chips. \nMy mom buys chocolate bars. \nIt is for the "+
      "trick-or-treaters. \nMy mom buys me a costume. \nIt is a ghost costume. \nI am going to be scary. \nMy sister is going to "+
      "dress up as a princess. \nShe will have a wand. \nShe will have a crown. \nShe will look beautiful. \nMy dad buys a pumpkin. "+
      "\nIt is going to be a Jack O'Lantern. \nWe draw a face on the pumpkin. \nWe carve the face with a knife. \nOur Jack O'Lantern "+
      "looks funny. We go trick-or-treating. \nWe knock on the neighbor's door. \nWe say, 'trick or treat'. \nOur neighbors give us "+
      "candy.\nWe say 'Thanks'. \nWe go to many houses. \nWe go home. \nOur parents check our candy. \nIt's safe. \nWe eat lots of "+
      "candy. \nWe don't feel very good. We go to bed.",
      audioURL: 'https://dailydictation.com/upload/general-english/15-halloween-night-2019-03-20-04-55-19/0-15-halloween-night.mp3', type:'Short Stories'),
    Listening(name: 'School', time: Duration(minutes: 2,seconds: 15), 
      script:"There are different types of schools. \nThere is an elementary school. \nThe children at the elementary school are young. "+
      "\nThere is a playground for them to play in. \nThe classrooms are bright and airy. \nThere are blackboards in the classrooms. "+
      "\nThe children sit in desks to do their work. \nThere is a parking lot for the teachers to park in. \nThere is a cafeteria for "+
      "the students to get food. \nThe principal has an office. \nNobody wants to go to the principal's office. \nIt usually means that "+
      "you are in trouble if you have to go to the principal's office. \nWhen you finish elementary school, you go to high school. "+
      "\nMost of the students in high school are teenagers. \nThere is a parking lot outside the high school. \nThere is also a football "+
      "field outside. \nThe students go to classes in different classrooms. \nThey move from classroom to classroom for each subject. "+
      "\nThere is a cafeteria where they can get their lunches or eat the lunches that they have brought from home. \nThere is a gymnasium"+
      " where students have physical education. \nDances are also held in the gymnasium. \nSome students go on to university from high "+
      "school. \nStudents at the university are older. \nSome of the students are even senior citizens. \nPeople come from all over the world"+
      " to attend the university. \nThere are lots of different things at the university. \nThere is a theater where plays and concerts "+
      "are held. \nThere is a bookstore where students can buy their textbooks. \nThere is a physical education building that has a "+
      "swimming pool in it. \nThe parking lot at the university is very big. \nThey call the land that the university is on a campus. "+
      "\nSome of the students live on campus in residence.",
      audioURL: 'https://dailydictation.com/upload/general-english/26-school-2019-03-20-08-59-42/0-26-school.mp3', type:'Short Stories'),
    Listening(name: 'Summer vacation', time: Duration(minutes: 1,seconds: 6), 
        script:"Today is the last day of school. \nIt is summer vacation. \nGrace is very excited. \nThis summer will be fun. Grace is going "+
        "to visit her grandparents. \nThey have a cottage. \nThe cottage is on Lake Erie. \nIt is a lot of fun. \nGrace is going to swim. \n"+
        "She is going to play board games. \nShe is going to talk with her grandparents. \nGrace is going to have fun. \nGrace is going to a "+
        "summer camp. \nShe will sleep in a cabin. \nShe will make lots of new friends. \nGrace will learn campfire songs. \nCamp will be fun. \n"+
        "Grace is going to Cape Cod with her parents. \nWe are going for two weeks. \nWe are going to drive. \nGrace will see the ocean. \n"+
        "Cape Cod will be beautiful. \nSummer vacation is fun.",
        audioURL: 'https://dailydictation.com/upload/general-english/11-summer-vacation-2019-04-08-11-16-05/0-11-summer-vacation.mp3', type:'Short Stories'),
  ];

  static final List<Listening> listeningDailyList = [
    Listening(name: 'First snowfall', time: Duration(minutes: 1,seconds: 8), 
      script:"Today is November 26th. \nIt snowed all day today. \nThe snow is beautiful. \nThe snow finally stopped. \nMy sister and I "+
      "are excited. \nMy mom doesn't like the snow. \nMy mom has to shovel the driveway. \nMy sister and I get to play. \nI put on my hat"+
      " and mittens. \nMy mom puts on my scarf. \nMy mom zippers my jacket. \nMy sister puts on her hat and mittens. \nMy mom puts on her "+
      "scarf. \nMy mom zippers her jacket. \nMy sister and I go outside. \nWe begin to make a snowman. \nMy mom starts to shovel the snow. \n"+
      "My sister and I make snow angels. \nMy sister and I throw snowballs. \nIt starts to snow again. \nWe go inside for hot chocolate.",
      audioURL: 'https://dailydictation.com/upload/general-english/1-first-snowfall-2019-03-14-04-19-38/0-1-first-snowfall.mp3', type:'Daily Conversations'),
    Listening(name: 'Going camping', time: Duration(minutes: 1,seconds: 5), 
      script:"The Bright family went camping on the weekend. \nThe Bright family went to Silent Lake. \nThe Bright family left on Friday. "+
      "\nThey camped for three days. \nThe Bright family brought a big tent. \nThey brought a lot of food. \nThey brought insect repellent. "+
      "\nThe Bright family had a campfire on Friday. \nThey roasted marshmallows. \nThey sang campfire songs. \nOn Saturday they went canoeing."+
      " \nOn Saturday they went fishing. \nOn Saturday they went swimming. \nThey went hiking on Sunday. \nThe Bright family saw many birds. \n"+
      "They saw blue jays. \nThey saw hummingbirds. \nThe Bright family saw many animals. \nThey saw a raccoon. \nThey saw a squirrel. \nBut they "+
      "didn't see a bear. \nThe Bright family had a fun vacation.",
      audioURL: 'https://dailydictation.com/upload/general-english/15-halloween-night-2019-03-20-04-55-19/0-15-halloween-night.mp3', type:'Daily Conversations'),
    Listening(name: 'School', time: Duration(minutes: 2,seconds: 15), 
      script:"There are different types of schools. \nThere is an elementary school. \nThe children at the elementary school are young. "+
      "\nThere is a playground for them to play in. \nThe classrooms are bright and airy. \nThere are blackboards in the classrooms. "+
      "\nThe children sit in desks to do their work. \nThere is a parking lot for the teachers to park in. \nThere is a cafeteria for "+
      "the students to get food. \nThe principal has an office. \nNobody wants to go to the principal's office. \nIt usually means that "+
      "you are in trouble if you have to go to the principal's office. \nWhen you finish elementary school, you go to high school. "+
      "\nMost of the students in high school are teenagers. \nThere is a parking lot outside the high school. \nThere is also a football "+
      "field outside. \nThe students go to classes in different classrooms. \nThey move from classroom to classroom for each subject. "+
      "\nThere is a cafeteria where they can get their lunches or eat the lunches that they have brought from home. \nThere is a gymnasium"+
      " where students have physical education. \nDances are also held in the gymnasium. \nSome students go on to university from high "+
      "school. \nStudents at the university are older. \nSome of the students are even senior citizens. \nPeople come from all over the world"+
      " to attend the university. \nThere are lots of different things at the university. \nThere is a theater where plays and concerts "+
      "are held. \nThere is a bookstore where students can buy their textbooks. \nThere is a physical education building that has a "+
      "swimming pool in it. \nThe parking lot at the university is very big. \nThey call the land that the university is on a campus. "+
      "\nSome of the students live on campus in residence.",
      audioURL: 'https://dailydictation.com/upload/general-english/26-school-2019-03-20-08-59-42/0-26-school.mp3', type:'Daily Conversations'),
    Listening(name: 'Summer vacation', time: Duration(minutes: 1,seconds: 6), 
        script:"Today is the last day of school. \nIt is summer vacation. \nGrace is very excited. \nThis summer will be fun. Grace is going "+
        "to visit her grandparents. \nThey have a cottage. \nThe cottage is on Lake Erie. \nIt is a lot of fun. \nGrace is going to swim. \n"+
        "She is going to play board games. \nShe is going to talk with her grandparents. \nGrace is going to have fun. \nGrace is going to a "+
        "summer camp. \nShe will sleep in a cabin. \nShe will make lots of new friends. \nGrace will learn campfire songs. \nCamp will be fun. \n"+
        "Grace is going to Cape Cod with her parents. \nWe are going for two weeks. \nWe are going to drive. \nGrace will see the ocean. \n"+
        "Cape Cod will be beautiful. \nSummer vacation is fun.",
        audioURL: 'https://dailydictation.com/upload/general-english/11-summer-vacation-2019-04-08-11-16-05/0-11-summer-vacation.mp3', type:'Daily Conversations'),
  ];

  static final List<Listening> listeningToeicList = [
    Listening(name: 'Summer vacation', time: Duration(minutes: 1,seconds: 6), 
        script:"Today is the last day of school. \nIt is summer vacation. \nGrace is very excited. \nThis summer will be fun. Grace is going "+
        "to visit her grandparents. \nThey have a cottage. \nThe cottage is on Lake Erie. \nIt is a lot of fun. \nGrace is going to swim. \n"+
        "She is going to play board games. \nShe is going to talk with her grandparents. \nGrace is going to have fun. \nGrace is going to a "+
        "summer camp. \nShe will sleep in a cabin. \nShe will make lots of new friends. \nGrace will learn campfire songs. \nCamp will be fun. \n"+
        "Grace is going to Cape Cod with her parents. \nWe are going for two weeks. \nWe are going to drive. \nGrace will see the ocean. \n"+
        "Cape Cod will be beautiful. \nSummer vacation is fun.",
        audioURL: 'https://dailydictation.com/upload/general-english/11-summer-vacation-2019-04-08-11-16-05/0-11-summer-vacation.mp3', type:'TOEIC Listening'),  
    Listening(name: 'First snowfall', time: Duration(minutes: 1,seconds: 8), 
      script:"Today is November 26th. \nIt snowed all day today. \nThe snow is beautiful. \nThe snow finally stopped. \nMy sister and I "+
      "are excited. \nMy mom doesn't like the snow. \nMy mom has to shovel the driveway. \nMy sister and I get to play. \nI put on my hat"+
      " and mittens. \nMy mom puts on my scarf. \nMy mom zippers my jacket. \nMy sister puts on her hat and mittens. \nMy mom puts on her "+
      "scarf. \nMy mom zippers her jacket. \nMy sister and I go outside. \nWe begin to make a snowman. \nMy mom starts to shovel the snow. \n"+
      "My sister and I make snow angels. \nMy sister and I throw snowballs. \nIt starts to snow again. \nWe go inside for hot chocolate.",
      audioURL: 'https://dailydictation.com/upload/general-english/1-first-snowfall-2019-03-14-04-19-38/0-1-first-snowfall.mp3', type:'TOEIC Listening'),
      Listening(name: 'School', time: Duration(minutes: 2,seconds: 15), 
      script:"There are different types of schools. \nThere is an elementary school. \nThe children at the elementary school are young. "+
      "\nThere is a playground for them to play in. \nThe classrooms are bright and airy. \nThere are blackboards in the classrooms. "+
      "\nThe children sit in desks to do their work. \nThere is a parking lot for the teachers to park in. \nThere is a cafeteria for "+
      "the students to get food. \nThe principal has an office. \nNobody wants to go to the principal's office. \nIt usually means that "+
      "you are in trouble if you have to go to the principal's office. \nWhen you finish elementary school, you go to high school. "+
      "\nMost of the students in high school are teenagers. \nThere is a parking lot outside the high school. \nThere is also a football "+
      "field outside. \nThe students go to classes in different classrooms. \nThey move from classroom to classroom for each subject. "+
      "\nThere is a cafeteria where they can get their lunches or eat the lunches that they have brought from home. \nThere is a gymnasium"+
      " where students have physical education. \nDances are also held in the gymnasium. \nSome students go on to university from high "+
      "school. \nStudents at the university are older. \nSome of the students are even senior citizens. \nPeople come from all over the world"+
      " to attend the university. \nThere are lots of different things at the university. \nThere is a theater where plays and concerts "+
      "are held. \nThere is a bookstore where students can buy their textbooks. \nThere is a physical education building that has a "+
      "swimming pool in it. \nThe parking lot at the university is very big. \nThey call the land that the university is on a campus. "+
      "\nSome of the students live on campus in residence.",
      audioURL: 'https://dailydictation.com/upload/general-english/26-school-2019-03-20-08-59-42/0-26-school.mp3', type:'TOEIC Listening'),
    Listening(name: 'Going camping', time: Duration(minutes: 1,seconds: 5), 
      script:"The Bright family went camping on the weekend. \nThe Bright family went to Silent Lake. \nThe Bright family left on Friday. "+
      "\nThey camped for three days. \nThe Bright family brought a big tent. \nThey brought a lot of food. \nThey brought insect repellent. "+
      "\nThe Bright family had a campfire on Friday. \nThey roasted marshmallows. \nThey sang campfire songs. \nOn Saturday they went canoeing."+
      " \nOn Saturday they went fishing. \nOn Saturday they went swimming. \nThey went hiking on Sunday. \nThe Bright family saw many birds. \n"+
      "They saw blue jays. \nThey saw hummingbirds. \nThe Bright family saw many animals. \nThey saw a raccoon. \nThey saw a squirrel. \nBut they "+
      "didn't see a bear. \nThe Bright family had a fun vacation.",
      audioURL: 'https://dailydictation.com/upload/general-english/15-halloween-night-2019-03-20-04-55-19/0-15-halloween-night.mp3', type:'TOEIC Listening'),
    
    ];
}