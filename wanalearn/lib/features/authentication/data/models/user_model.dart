import 'dart:convert';

import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullname,
    super.bio,
    super.profilePic,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullname: '',
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullname: map['fullname'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>),
          enrolledCourseIds:
              List<String>.from(map['enrolledCourseIds'] as List<dynamic>),
          following: List<String>.from(map['following'] as List<dynamic>),
          followers: List<String>.from(map['followers'] as List<dynamic>),
        );

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source) as DataMap);

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'profilePic': profilePic,
        'bio': bio,
        'points': points,
        'fullname': fullname,
        'groupIds': groupIds,
        'enrolledCourseIds': enrolledCourseIds,
        'following': following,
        'followers': followers,
      };

  String toJson() => json.encode(toMap());

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullname,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullname: fullname ?? this.fullname,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
