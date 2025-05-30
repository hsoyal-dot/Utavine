// class UserEntity {
//   String? fullName;
//   String? email;
//   String? password;


//   UserEntity({
//     this.fullName,
//     this.email,
//     this.password,
//   });
// }



class UserEntity {
  final String fullName;
  final String email;
  final bool emailVerified; 

  UserEntity({
    required this.fullName,
    required this.email,
    required this.emailVerified,
  });
}