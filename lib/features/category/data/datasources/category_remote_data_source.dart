import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({required bool isDaily});
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final AuthLocalDataSource authLocalDataSource;

  CategoryRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.authLocalDataSource,
  });

  @override
  Future<List<CategoryModel>> getCategories({required bool isDaily}) async {
    try {
      final token = await authLocalDataSource.getToken();

      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await client.get(
        Uri.parse(
          '$baseUrl/api/categories?isDaily=${isDaily ? 'true' : 'false'}',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
