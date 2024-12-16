


part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
  const AuthEvent();
}


class SignUpWithPasswordEvent extends AuthEvent{
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpWithPasswordEvent({required this.email, required this.password, required this.firstName, required this.lastName,});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SignWithEmailPasswordEvent extends AuthEvent{
  final String email;
  final String password;


  const SignWithEmailPasswordEvent({ required this.email, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class SignInWithGoogleEvent extends AuthEvent{

  const SignInWithGoogleEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SelectUserAvatarEvent extends AuthEvent{
  final ImageSource source;
  const SelectUserAvatarEvent({required this.source} );
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class UploadImageEvent extends AuthEvent{
  final String imageUrl;
  const UploadImageEvent({required this.imageUrl} );
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}