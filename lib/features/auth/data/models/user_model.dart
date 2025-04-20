import 'package:coldana_flutter/features/auth/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({required String id, required String username}): super(id: id, username: username);
  
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['user_id'].toString(),
      username: json['username'].toString()
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'user_id': id,
      'username': username
    };
  }
}