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
   description: """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu""", 
snippet:  """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu""", 
url: "https://utc.iath.virginia.edu/uncletom/uthp.html"),
  Book(imageUrl: ImageAssets.imageCookieWriter, title: 'The Fortune Cookie Writer', type: 'Popular', author: 'Robert W. William', description: 'Book one in The Peter Durant Series is a feast of comedic abuse, The Fortune Cookie Writer is a snarky and biting roast of social media and a twisted take about shedding negativity on the way to finding love and happiness! This is an eBook you absolutely want to share  with your friends.', url: "https://www.free-ebooks.net/humor/The-Fortune-Cookie-Writer#gs.88mga9"),
  Book(imageUrl: ImageAssets.imageHowInno, title: 'How Innovation Works', type: 'Popular',author: 'Matt Ridley'),
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
  Book(imageUrl: ImageAssets.imageUncleTom, title: "Uncle Tom's cabin", type: 'Popular', author: 'Herriet Beecher Stowe',
   description: """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu""", 
snippet:  """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu""", 
url: "https://utc.iath.virginia.edu/uncletom/uthp.html"),
  Book(imageUrl: ImageAssets.imageCookieWriter, title: 'The Fortune Cookie Writer', type: 'Popular', author: 'Robert W. William', description: 'Book one in The Peter Durant Series is a feast of comedic abuse, The Fortune Cookie Writer is a snarky and biting roast of social media and a twisted take about shedding negativity on the way to finding love and happiness! This is an eBook you absolutely want to share  with your friends.', url: "https://www.free-ebooks.net/humor/The-Fortune-Cookie-Writer#gs.88mga9"),
  Book(imageUrl: ImageAssets.imageHowInno, title: 'How Innovation Works', type: 'Popular',author: 'Matt Ridley'),
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
