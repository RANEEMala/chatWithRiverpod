import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  int? id;
  String? created_at;
  bool? is_me;
  String message;
  ChatModel({
     this.id,
     this.created_at,
     this.is_me,
    required this.message,
  });

  ChatModel copyWith({
    int? id,
    String? created_at,
    String? message,
    bool? is_me,
  }) {
    return ChatModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      message: message ?? this.message,
      is_me: is_me ?? this.is_me,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'message': message,
      'is_me': is_me,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      message: map['message'] as String,
      is_me: map['is_me'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, created_at: $created_at, message: $message, is_me: $is_me)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.created_at == created_at &&
      other.message == message &&
      other.is_me == is_me;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      created_at.hashCode ^
      message.hashCode ^
      is_me.hashCode;
  }
}
