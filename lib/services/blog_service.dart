part of 'supabase_service.dart';

extension Blogervice on SupabaseService {

  Future<String?> uploadImage(File image, String userId) async {
      final fileName = basename(image.path);
      final filePath = 'public/$userId/$fileName';
      final response = await supabase.storage.from('BlogImages').upload(filePath, image,);     

      final publicUrl = supabase.storage.from('BlogImages').getPublicUrl(filePath);
      print('Public URL: $publicUrl');
      return publicUrl;  
  }

  Future<void> saveBlog(Blog blog) async {
    final response = await supabase.from(Blog.table.tableName).insert(blog.toJson());    
  }
}
