import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';

class Book {
  final String imageUrl;
  final String title;
  final String type;
  final String author;
  final String description;
  final String snippet;
  final String url;

  Book ({
    required this.imageUrl, 
     required this.title, 
     required this.type,
     required this.author,
     this.description ='',
     this.snippet = '',
     this.url = '',

});
}

 List<Book> listBooks  = [
  Book(imageUrl: ImageAssets.imageUncleTom, title: "Uncle Tom's cabin", type: 'Popular', author: 'Herriet Beecher Stowe',
   description: """Uncle Tom's Cabin tells the story of Uncle Tom, an enslaved person, depicted as saintly and dignified, noble and steadfast in his beliefs. While being transported by boat to auction in New Orleans, Tom saves the life of Little Eva, an angelic and forgiving young girl, whose grateful father then purchases Tom.""", 
snippet:  """Late in the afternoon of a chilly day in February, two gentlemen were sitting alone over their wine, in a well-furnished dining parlor, in the town of P—, in Kentucky.There were no servants present, and the gentlemen, with chairs closely approaching, seemed to be discussing some subject with great earnestness.""", 
url: "https://utc.iath.virginia.edu/uncletom/uthp.html"),
  Book(imageUrl: ImageAssets.imageCookieWriter, title: 'The Fortune Cookie Writer', type: 'Popular', author: 'Robert W. William', description: 'Book one in The Peter Durant Series is a feast of comedic abuse, The Fortune Cookie Writer is a snarky and biting roast of social media and a twisted take about shedding negativity on the way to finding love and happiness! This is an eBook you absolutely want to share  with your friends.', url: "https://www.free-ebooks.net/humor/The-Fortune-Cookie-Writer#gs.88mga9"),
  Book(imageUrl: ImageAssets.imageHowInno, title: 'How Innovation Works', type: 'Popular',author: 'Matt Ridley', description: """Innovation is the main event of the modern age, the reason we experience both dramatic improvements in our living standards and unsettling changes in our society. Forget short-term symptoms like Donald Trump and Brexit, it is innovation itself that explains them and that will itself shape the 21st century for good and ill. Yet innovation remains a mysterious process, poorly understood by policy makers and businessmen, hard to summon into existence to order, yet inevitable and inexorable when it does happen.
""", url: "https://www.goodreads.com/book/show/52219273-how-innovation-works"),
  Book(imageUrl: ImageAssets.imageBookPsychology, title: 'The Psychology of Money', type: 'Popular', author: ' Morgan Housel'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Popular', author: 'J. K. Rowling'),

  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Viễn tưởng',author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Viễn tưởng', author: 'J. K. Rowling'),


 ];

 List<Book> listPopular = [
  Book(imageUrl: ImageAssets.imageUncleTom, title: "Uncle Tom's cabin",
   type: 'Popular', author: 'Herriet Beecher Stowe',
   description: """Uncle Tom's Cabin tells the story of Uncle Tom, an enslaved person, depicted as saintly and dignified, noble and steadfast in his beliefs. While being transported by boat to auction in New Orleans, Tom saves the life of Little Eva, an angelic and forgiving young girl, whose grateful father then purchases Tom.""", 
snippet:  """Late in the afternoon of a chilly day in February, two gentlemen were sitting alone over their wine, in a well-furnished dining parlor, in the town of P—, in Kentucky.There were no servants present, and the gentlemen, with chairs closely
approaching, seemed to be discussing some subject with great earnestness.""", 
url: "https://utc.iath.virginia.edu/uncletom/uthp.html"),
  Book(imageUrl: ImageAssets.imageCookieWriter, title: 'The Fortune Cookie Writer', 
  type: 'Popular', author: 'Robert W. William', 
  description: 'Book one in The Peter Durant Series is a feast of comedic abuse, The Fortune Cookie Writer is a snarky and biting roast of social media and a twisted take about shedding negativity on the way to finding love and happiness! This is an eBook you absolutely want to share  with your friends.', 
  snippet: """Dog walker by day and fortune cookie writer by night, Marissa is broke. Blindsided by divorce and one year short of an Ivy League degree, she’s determined to support her young son, Owen, musically gifted and struggling to hide his peculiar behaviors from the world. When a mysterious stranger offers her a week’s pay to cook dinners for Rose, an irritable widow in her apartment building, Marissa accepts, despite her doubts. She’d be a fool to turn down such easy cash.""",
  url: "https://www.free-ebooks.net/humor/The-Fortune-Cookie-Writer#gs.88mga9"),
    Book(imageUrl: ImageAssets.imageHowInno, title: 'How Innovation Works', 
    type: 'Popular',author: 'Matt Ridley', 
    description: """Innovation is the main event of the modern age, the reason we experience both dramatic improvements in our living standards and unsettling changes in our society.
""", snippet: """Ridley derives these and other lessons from the lively stories of scores of innovations, how they started and why they succeeded or failed. Some of the innovation stories he tells are about steam engines, jet engines, search engines, airships, coffee, potatoes, vaping, vaccines, cuisine, antibiotics, mosquito nets, turbines, propellers, fertilizer, zero, computers, dogs, farming, fire, genetic engineering, gene editing, container shipping, railways, cars, safety rules, wheeled suitcases, mobile phones, corrugated iron, powered flight, chlorinated water, toilets, vacuum cleaners, shale gas, the telegraph, radio, social media, block chain, the sharing economy, artificial intelligence, fake bomb detectors, phantom games consoles, fraudulent blood tests, hyperloop tubes, herbicides, copyright, and even life itself.""",
url: "https://www.goodreads.com/book/show/52219273-how-innovation-works"),
  Book(imageUrl: ImageAssets.imageBookPsychology, title: 'The Psychology of Money', type: 'Popular', author: ' Morgan Housel'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Popular', author: 'J. K. Rowling'),
  
 ];

 List<Book> listAdventure = [
    Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Adventure', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Adventure',author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Adventure', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Adventure', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Adventure', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Adventure', author: 'J. K. Rowling'),
 ];

 List<Book> listChild = [
  Book(imageUrl: ImageAssets.imageCookieWriter, title: 'The Fortune Cookie Writer', type: 'Children', author: 'Robert W. William', description: 'Book one in The Peter Durant Series is a feast of comedic abuse, The Fortune Cookie Writer is a snarky and biting roast of social media and a twisted take about shedding negativity on the way to finding love and happiness! This is an eBook you absolutely want to share  with your friends.', url: "https://www.free-ebooks.net/humor/The-Fortune-Cookie-Writer#gs.88mga9"),
  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Children', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Children',author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Children', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Children', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Children', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Children', author: 'J. K. Rowling'),
 ];
