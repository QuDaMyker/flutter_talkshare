import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_talkshare/core/values/supabase_table.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:intl/intl.dart';

class Blog {  
  final String blogId; 
  final String userId;
  final String created_at;
  final List<String> images;
  final String content;
  final String fullname;
  final String avatarUrl; 

  Blog({
    required this.blogId,
    required this.userId,
    required this.created_at,
    required this.images,
    required this.content,
    required this.fullname, 
    required this.avatarUrl });

  static BlogSupabaseTable table = const BlogSupabaseTable();

  static Blog fromJson(Map<String, dynamic> json) {
    List<String> images = (json[table.images] as List<dynamic>).cast<String>();
    DateTime createdAt = DateTime.parse(json[table.created_at] as String);
    String formattedCreatedAt = DateFormat('HH:mm dd:MM:yyyy').format(createdAt);
    return Blog(
      blogId: json[table.blogId] as String,
      userId: json[table.userId] as String,
      created_at: formattedCreatedAt,
      images: images,
      content: json[table.content] as String,
      fullname: json[table.fullname] as String,
      avatarUrl: json[table.avatUrl] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.blogId: blogId,
        table.userId: userId,
        table.created_at: created_at,
        table.images: images,
        table.content: content,
        table.avatUrl: avatarUrl,
        table.fullname: fullname,
      };
}