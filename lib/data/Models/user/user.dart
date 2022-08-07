enum UserType { lawyer, notLawyer }

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String image;
  final bool? isVerified;
  final UserType type;
  final int? amountFavorites;
  final int? amountSelects;
  final int? amountCOmplates;
  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.image,
    this.isVerified,
    required this.type,
    this.amountFavorites,
    this.amountSelects,
    this.amountCOmplates,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.image == image &&
        other.isVerified == isVerified &&
        other.type == type &&
        other.amountFavorites == amountFavorites &&
        other.amountSelects == amountSelects &&
        other.amountCOmplates == amountCOmplates;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumber.hashCode ^
        image.hashCode ^
        isVerified.hashCode ^
        type.hashCode ^
        amountFavorites.hashCode ^
        amountSelects.hashCode ^
        amountCOmplates.hashCode;
  }

  User copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? image,
    bool? isVerified,
    UserType? type,
    int? amountFavorites,
    int? amountSelects,
    int? amountCOmplates,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      isVerified: isVerified ?? this.isVerified,
      type: type ?? this.type,
      amountFavorites: amountFavorites ?? this.amountFavorites,
      amountSelects: amountSelects ?? this.amountSelects,
      amountCOmplates: amountCOmplates ?? this.amountCOmplates,
    );
  }
}
