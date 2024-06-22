import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/modules/auth/models/fail_model.dart';
import 'package:flutter_talkshare/modules/auth/models/success_model.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  AuthServices._();
  static final AuthServices instance = AuthServices._();
  factory AuthServices() => instance;
  SupabaseClient supabase = SupabaseService.instance.supabase;
  Future<Either<FailModel, SuccessModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print(res);
      return Right(SuccessModel(message: 'message'));
    } catch (e) {
      return Left(FailModel(message: e.toString()));
    }
  }

  Future<Either<FailModel, AuthResponse>> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      print(email);
      print(fullname);
      print(password);
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      AuthResponse authResponse = res;
      return Right(authResponse);
    } catch (e) {
      print(e);
      return Left(FailModel(message: e.toString()));
    }
  }

  Future<Either<FailModel, AuthResponse>> nativeGoogleSignIn() async {
    try {
      final webClientId = '${dotenv.get('web_google_client_id')}';
      print(webClientId);
      final iosClientId = '${dotenv.get('ios_google_client_id')}';
      print(webClientId);
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      print(accessToken);
      print(idToken);

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      var res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return Right(res);
    } catch (e) {
      debugPrint(e.toString());
      return Left(FailModel(message: e.toString()));
    }
  }

  Future<Either<FailModel, UserModel>> addUserProfile({
    required UserModel userModel,
  }) async {
    try {
      if (await AuthServices.instance.getEmail(userModel.email) == 0) {
        await supabase.from('users').insert(userModel.toMap());
      } else {
        UserModel? existUser = await getUserFromDB(email: userModel.email);
        return Right(existUser!);
      }

      print('thanh cong');
      return Right(userModel);
    } catch (e) {
      debugPrint(e.toString());
      return Left(FailModel(message: e.toString()));
    }
  }

  Future<int> getEmail(String email) async {
    final query =
        await supabase.from('users').select('email').eq('email', email).count();
    return query.count;
  }

  Future<UserModel?> getUserFromDB({required String email}) async {
    try {
      final query = await supabase
          .from('users')
          .select(
            'user_id, fullname, avatar_url, password, email, isGoogle, role',
          )
          .eq('email', email);

      return UserModel.fromJson(jsonEncode(query[0]));
    } catch (e) {
      debugPrint('[AuthServices][getUserFromDB]: ${e.toString()}');
      return null;
    }
  }
}
