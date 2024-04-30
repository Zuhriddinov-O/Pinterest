import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pinterest/domain/data/comments/model/model.dart';
import 'package:http/http.dart' as http;

abstract class CommentRepository {
  Future<List<Comments>> getComments();
}

class CommentsRepositoryImpl extends CommentRepository {
  @override
  Future<List<Comments>> getComments() async {
    try {
      final url = Uri.parse("https://jsonplaceholder.typicode.com/comments");
      final response = await http.get(url);
      final jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((e) => Comments.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
