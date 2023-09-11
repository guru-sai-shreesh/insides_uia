enum SignInType { google, facebook, apple }

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final SignInType signInType; // Add this property

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.signInType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
      signInType: SignInType.values.firstWhere(
        (type) => type.toString() == 'SignInType.${json['signInType']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'signInType':
          signInType.toString().split('.').last, // Convert enum to string
    };
  }
}
