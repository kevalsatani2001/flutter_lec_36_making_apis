
class Student {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? createdAt;
  final String? avatar;
  final String? mobileNumber;
  final String? countryName;
  Student(
      {this.id,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.avatar,
      this.mobileNumber,
      this.countryName});

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        createdAt: map['createdAt'],
        avatar: map['avatar'],
        mobileNumber: map['mobileNumber'],
        countryName: map['countryName']);
  }

  @override
  String toString() {
    return 'Student(id: $id, firstName: $firstName, lastName: $lastName, createdAt: $createdAt,avatar:$avatar,mobileNumber:$mobileNumber,countryName:$countryName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.createdAt == createdAt &&
        other.avatar == avatar &&
        other.mobileNumber == mobileNumber &&
        other.countryName == countryName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        createdAt.hashCode ^
        avatar.hashCode ^
        mobileNumber.hashCode ^
        countryName.hashCode;
  }
}
