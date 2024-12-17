class UserModel {
  String? name;
  String? email;
  String? id;

  UserModel({this.name, this.email, this.id});
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['details'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
