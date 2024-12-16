

class UserModel {
  int? id;
  String? authId;
  String? firstName;
  String? lastName;
  String? avatarUrl;


  UserModel({this.id, this.authId, this.firstName, this.lastName, this.avatarUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authId = json['auth_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(this.id != null){
      data['id'] = id;
    }
   if(this.authId != null){
     data['auth_id'] = authId;
   }
    if(this.firstName != null){
      data['first_name'] = firstName;
    }
   if(this.lastName != null){
     data['last_name'] = lastName;
   }
   if(this.avatarUrl != null){
     data['avatar_url'] = avatarUrl;
   }
    return data;
  }
}