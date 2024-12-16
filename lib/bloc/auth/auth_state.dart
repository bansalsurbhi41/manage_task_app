

part of 'auth_bloc.dart';


class AuthState {
 StateStatus signUpStatus;
 StateStatus signInStatus;
 StateStatus googleSignInStatus;
 StateStatus addProfileImageStatus;
 StateStatus uploadAvatarStatus;
  AuthState({
    this.signUpStatus = const StateNotLoaded(),
    this.signInStatus = const StateNotLoaded(),
    this.googleSignInStatus = const StateNotLoaded(),
    this.addProfileImageStatus = const StateNotLoaded(),
    this.uploadAvatarStatus = const StateNotLoaded(),
  });

  AuthState get initialState => AuthState();

  AuthState copyWith({
    StateStatus? signUpStatus,
    StateStatus? signInStatus,
    StateStatus? googleSignInStatus,
    StateStatus? addProfileImageStatus,
    StateStatus? uploadAvatarStatus,
  }) {
    return AuthState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      signInStatus: signInStatus ?? this.signInStatus,
      googleSignInStatus: googleSignInStatus ?? this.googleSignInStatus,
      addProfileImageStatus: addProfileImageStatus ?? this.addProfileImageStatus,
      uploadAvatarStatus: uploadAvatarStatus ?? this.uploadAvatarStatus,
    );
  }
}
