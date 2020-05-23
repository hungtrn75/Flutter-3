import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_train_3/utils/dio.dart';

class Auth with ChangeNotifier {
  String _token;
  String _refreshToken;
  DateTime _expiryDate;
  String _userId;
  bool _isLoading = false;
  final String API_KEY = 'AIzaSyBALUOZh7oy6djHsl4KcFrbrvru-Mp6O6E';

  bool get isLoading => _isLoading;
  bool get isAuth => _token != null;
  String get userToken => _token;
  String get userId => _userId;

  Future<void> signUp(String email, String password, Function showError) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY',
        data: {'email': email, 'password': password, 'returnSecureToken': true},
      );
      final map = json.decode(res.toString());
      _token = map['idToken'];
      _refreshToken = map['refreshToken'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(map['expiresIn'])));
      _userId = map['localId'];
      showError(
        'Signup successfully!',
        backgroundColor: Colors.green,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        final String error = e.response.data.toString();
        if (error.contains('EMAIL_EXISTS')) {
          showError(
            'The email address is already in use by another account.',
          );
        }
        if (error.contains('OPERATION_NOT_ALLOWED')) {
          showError(
            'Password sign-in is disabled for this project.',
          );
        }
        if (error.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
          showError(
            'We have blocked all requests from this device due to unusual activity. Try again later.',
          );
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      // throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password, Function showError,
      Function navigateToHome) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY',
        data: {'email': email, 'password': password, 'returnSecureToken': true},
      );
      final map = json.decode(res.toString());
      _token = map['idToken'];
      _refreshToken = map['refreshToken'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(map['expiresIn'])),
      );
      _userId = map['localId'];
      // notifyListeners();

    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        final String error = e.response.data.toString();
        if (error.contains('EMAIL_NOT_FOUND')) {
          showError(
              'There is no user record corresponding to this identifier. The user may have been deleted.');
        }
        if (error.contains('INVALID_PASSWORD')) {
          showError(
              'The password is invalid or the user does not have a password.');
        }
        if (error.contains('USER_DISABLED')) {
          showError('The user account has been disabled by an administrator.');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
      // throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
      if (_token != null) navigateToHome();
    }
  }

  Future<void> getRefreshToken() async {
    try {
      print('get refresh token');
      final res = await http.post(
          'https://securetoken.googleapis.com/v1/token?key=$API_KEY',
          data: {
            'grant_type': "refresh_token",
            'refresh_token': _refreshToken,
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
      final map = json.decode(res.toString());
      _token = map['idToken'];
      _refreshToken = map['refreshToken'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(map['expiresIn'])),
      );
      _userId = map['localId'];
    } catch (e) {} finally {
      notifyListeners();
    }
  }
}
