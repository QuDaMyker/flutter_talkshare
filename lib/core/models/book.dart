import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';

class Book {
  final String imageUrl;
  final String title;
  final String type;

  Book ({
    required this.imageUrl, 
     required this.title, 
     required this.type
  });
}
 List<Book> listBooks  = [
  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Viễn tưởng'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Viễn tưởng'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Viễn tưởng'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Viễn tưởng'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Viễn tưởng'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Viễn tưởng'),
 ];
