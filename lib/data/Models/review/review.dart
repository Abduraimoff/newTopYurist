import 'package:top_yurist/data/Models/user/user.dart';

class Review {
  final int id;
  final User user;
  final bool isResolved;
  final String title;
  final DateTime time;
  final bool? isShowOnProfile;
  Review({
    required this.id,
    required this.user,
    required this.isResolved,
    required this.title,
    required this.time,
    this.isShowOnProfile,
  });

  Review copyWith({
    int? id,
    User? user,
    bool? isResolved,
    String? title,
    DateTime? time,
    bool? isShowOnProfile,
  }) {
    return Review(
      id: id ?? this.id,
      user: user ?? this.user,
      isResolved: isResolved ?? this.isResolved,
      title: title ?? this.title,
      time: time ?? this.time,
      isShowOnProfile: isShowOnProfile ?? this.isShowOnProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.id == id &&
        other.user == user &&
        other.isResolved == isResolved &&
        other.title == title &&
        other.time == time &&
        other.isShowOnProfile == isShowOnProfile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        isResolved.hashCode ^
        title.hashCode ^
        time.hashCode ^
        isShowOnProfile.hashCode;
  }
}
