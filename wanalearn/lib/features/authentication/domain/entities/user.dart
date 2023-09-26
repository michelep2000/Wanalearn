import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.profilePic,
    required this.bio,
    required this.points,
    required this.fullname,
    required this.groupIds,
    required this.enrolledCourseIds,
    required this.following,
    required this.followers,
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          profilePic: '',
          bio: '',
          points: 0,
          fullname: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullname;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() => 'LocalUser: { uid: $uid, email: $email,'
      ' bio: $bio, points: $points, fullname: $fullname }';
}
