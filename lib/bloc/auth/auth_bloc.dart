import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_project/utilities/state_status.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../src/model/user_model.dart';
import '../../utilities/string_const.dart';
import '../../utilities/table_names.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<SignUpWithPasswordEvent>(onSignUpWithPasswordEvent);
    on<SignWithEmailPasswordEvent>(onSignWithEmailPasswordEvent);
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<SelectUserAvatarEvent>(onSelectUserAvatarEvent);
    on<UploadImageEvent>(onUploadImageEvent);
  }
  final SupabaseClient supabase = Supabase.instance.client;

  FutureOr<void> onSignUpWithPasswordEvent(SignUpWithPasswordEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(signUpStatus: StateLoading()));
    try {
      final credential = await supabase.auth.signUp(
        email: event.email,
        password: event.password,
      );
      if (credential.user?.email != null) {
       bool result =  await saveUserInfo(firstName: event.firstName,lastName: event.lastName);
       if(result){
         emit(state.copyWith(signUpStatus: const StateLoaded()));
       }else{
         emit(state.copyWith(signUpStatus: const StateFailed()));
       }
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(signUpStatus: const StateFailed()));
    }
  }



  FutureOr<void> onSignWithEmailPasswordEvent(SignWithEmailPasswordEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(signInStatus: StateLoading()));
    try {
      final credential = await supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      if (credential.user?.email != null) {
        await saveAuthData(isLogIn: true,authId: credential.user!.id,);
        debugPrint('-------------------UUID----------${credential.user!.id}');
        emit(state.copyWith(signInStatus: const StateLoaded()));
      }
    } catch (e) {
      emit(state.copyWith(signInStatus: const StateFailed()));
    }
  }

  FutureOr<void> onSignInWithGoogleEvent(SignInWithGoogleEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(googleSignInStatus: StateLoading()));
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn(
          clientId: '369683348460-ejkmpcfi13d2hlebfssf644b0b2pnnup.apps.googleusercontent.com',
          serverClientId: '369683348460-nmp102v9k926hep6ekf15h8i2il6crmf.apps.googleusercontent.com'
      );
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      final userName = googleUser.displayName;
       String? firstName;
       String? lastName;
      if( userName != null){
        final nameParts = userName.split(' ');
        firstName = nameParts.isNotEmpty ? nameParts[0] : null;
        lastName = nameParts.length > 1 ? nameParts[1] : null;
      }
      if (accessToken == null) {
        emit(state.copyWith(googleSignInStatus: const StateFailed()));
      }
      if (idToken == null) {
        emit(state.copyWith(googleSignInStatus: const StateFailed()));
      }
      final credential = await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, accessToken: accessToken, idToken: idToken ?? '');
      debugPrint('---------UUID----------${credential.user?.id}');
      bool result = await isUserExist(authId: credential.user?.id ?? '');
      print('---------------isUserExist----------${result}');
      if(!result){
        bool result =  await saveUserInfo(firstName: firstName ?? '',lastName: lastName ?? '');
      }
      if (credential.user != null) {
        await saveAuthData(isLogIn: true,authId: credential.user!.id,);
        emit(state.copyWith(googleSignInStatus: const StateLoaded()));
      }
    }catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(googleSignInStatus: const StateFailed()));
    }
  }



  Future<bool> isUserExist({required String authId}) async{
    try{
      final result = await supabase
          .from(TableNames.tUsers).select('id').eq('auth_id', authId).maybeSingle();
      return result != null;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> saveUserInfo({required String firstName, required String lastName}) async{
    try{
      String authId = supabase.auth.currentUser!.id;
      final requestModel = UserModel(
          authId: authId,
          firstName: firstName,
          lastName: lastName
      );
      await supabase
          .from(TableNames.tUsers)
          .insert(requestModel);
      return true;
    }catch (e){
      debugPrint(e.toString());
      return false;

    }

  }

  Future<void> saveAuthData({required bool isLogIn, required String authId}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StringConst.kIsLogIn, true);
    await prefs.setString(StringConst.kAuthId, authId);

  }

  Future<void> onSelectUserAvatarEvent(
      SelectUserAvatarEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(addProfileImageStatus: StateLoading()));

    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) {
      emit(state.copyWith(addProfileImageStatus: const StateFailed()));
      return;
    }

    try {
      // Read the image bytes
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';

      // Upload to Supabase Storage
      await supabase.storage.from('avatars').uploadBinary(
        fileName,
        bytes,
        fileOptions: FileOptions(
          contentType: imageFile.mimeType ?? 'application/octet-stream',
        ),
      );

      // Generate a signed URL
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);

      // Emit success by adding an event
      add(UploadImageEvent(imageUrl: imageUrlResponse));
    } on StorageException catch (e) {
      // Specific error handling for storage exceptions
      emit(state.copyWith(addProfileImageStatus: StateFailed()));
    } catch (e) {
      // Generic error handling
      emit(state.copyWith(addProfileImageStatus: StateFailed()));
    }
  }


  /* FutureOr<void> onSelectUserAvatarEvent(SelectUserAvatarEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(addProfileImageStatus: StateLoading()));
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      emit(state.copyWith(addProfileImageStatus: const StateFailed()));
    }
    try {
      final bytes = await imageFile?.readAsBytes();
      final fileExt = imageFile?.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
        filePath,
        bytes!,
        fileOptions: FileOptions(contentType: imageFile?.mimeType),
      );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      add(UploadImageEvent(imageUrl: imageUrlResponse));
    } on StorageException catch (error) {
      emit(state.copyWith(addProfileImageStatus: const StateFailed()));
    } catch (error) {
      emit(state.copyWith(addProfileImageStatus: const StateFailed()));
    }
  }*/

  FutureOr<void> onUploadImageEvent(UploadImageEvent event, Emitter<AuthState> emit) async{
    emit(state.copyWith(uploadAvatarStatus: StateLoading()));
    try {
      final userId = await fetchUserId();
      if(userId != null){
        final requestModel = UserModel(
          avatarUrl: event.imageUrl
        );
        await supabase.from(TableNames.tUsers).upsert(requestModel.toJson()).eq('id', userId);
        emit(state.copyWith(uploadAvatarStatus: const StateLoaded()));
      }else{
        emit(state.copyWith(uploadAvatarStatus: const StateFailed()));
      }
    } on PostgrestException catch (error) {
      emit(state.copyWith(uploadAvatarStatus: const StateFailed()));
    } catch (error) {
      emit(state.copyWith(uploadAvatarStatus: const StateFailed()));
    }

    // setState(() {
    //   _avatarUrl = imageUrl;
    // });
  }

  Future<int?> fetchUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authId = prefs.getString(StringConst.kAuthId);

      if (authId == null || authId.isEmpty) {
        throw Exception('authId is null or empty.');
      }

      final result = await supabase
          .from(TableNames.tUsers)
          .select('id')
          .eq('auth_id', authId)
          .maybeSingle();

      if (result == null) {
        debugPrint('No user found with the given auth_id.');
        return null;

      }
      return result['id'] as int?;

    } catch (e) {
      debugPrint('Error fetching userId: $e');

    }
    return null;

  }
}
