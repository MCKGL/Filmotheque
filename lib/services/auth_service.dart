import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class AuthService {

  /// TMDB API requires a request token to be created and validated before
  /// a session can be created.
  Future<bool> login(String username, String password) async {
    try {
      // Step 1: Get request token
      await getRequestToken();
      // Step 2: Validate request token with login
      await validateRequestTokenWithLogin(username, password);
      // Step 3: Create sessionId
      await createSessionId();
    } catch (e) {
      // If any request fails, return false
      return false;
    }
    // If all requests are successful, return true
    return true;
  }

  Future<void> createSessionId() async {
    final responseSession = await http.post(
      Uri.parse(Env.CREATE_SESSION),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      body: json.encode({
        "request_token": Env.requestToken,
      }),
    );
    if (responseSession.statusCode != 200) {
      throw Exception('Failed to create session');
    }
    Env.sessionId = json.decode(responseSession.body)['session_id'];
  }

  Future<void> validateRequestTokenWithLogin(String username, String password) async {
    final responseLogin = await http.post(
      Uri.parse(Env.CREATE_SESSION_LOGIN),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      body: json.encode({
        "username": username,
        "password": password,
        "request_token": Env.requestToken,
      }),
    );
    if (responseLogin.statusCode != 200) {
      throw Exception('Failed to validate request token with login');
    }
  }

  Future<void> getRequestToken() async {
    final responseToken = await http.get(
        Uri.parse(Env.CREATE_REQUEST_TOKEN),
        headers: {
          'Authorization': 'Bearer ${Env.TOKEN}',
          'accept': 'application/json',
        });
    if (responseToken.statusCode != 200) {
      throw Exception('Failed to get request token');
    }
    Env.requestToken = json.decode(responseToken.body)['request_token'];
  }

  Future<bool> logout() async {
    try {
      final response = await http.delete(
        Uri.parse(Env.DELETE_SESSION),
        headers: {
          'Authorization': 'Bearer ${Env.TOKEN}',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: json.encode({
          "session_id": Env.sessionId,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete session');
      }
      // Clear the values of requestToken and sessionId
      Env.requestToken = "";
      Env.sessionId = "";
    } catch (e) {
      // If the request fails, return false
      return false;
    }
    // If the request is successful, return true
    return true;
  }

  getSessionId() {
    return Env.sessionId;
  }

}