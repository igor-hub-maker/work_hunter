class User {
  final String uId;
  String name;
  String companyName;
  String adress;
  String phoneNumber;
  String email;

  User({
    required this.uId,
    required this.name,
    required this.adress,
    required this.phoneNumber,
    required this.email,
    required this.companyName,
  });

  User.fromJsonm(Map<String, dynamic> json)
      : this(
          uId: json['uId'],
          name: json['name'],
          adress: json['adress'],
          phoneNumber: json['phoneNumber'],
          email: json['email'],
          companyName: json['companyName'],
        );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'name': name,
        'adress': adress,
        'phoneNumber': phoneNumber,
        'email': email,
        'companyName': companyName,
      };
}
