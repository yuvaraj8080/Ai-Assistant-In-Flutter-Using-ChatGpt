import 'package:flutter/foundation.dart' show immutable;

@immutable
class GeminiChatMessageModel {
  final String id;
  final String message;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isMine;

  const GeminiChatMessageModel({
    required this.id,
    required this.message,
    this.imageUrl,
    required this.createdAt,
    required this.isMine,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isMine': isMine,
    };
  }

  factory GeminiChatMessageModel.fromMap(Map<String, dynamic> map) {
    return GeminiChatMessageModel(
      id: map['id'] as String,
      message: map['message'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isMine: map['isMine'] as bool,
    );
  }

  GeminiChatMessageModel copyWith({
    String? imageUrl,
  }) {
    return GeminiChatMessageModel(
      id: id,
      message: message,
      createdAt: createdAt,
      isMine: isMine,
      imageUrl: imageUrl,
    );
  }
}
