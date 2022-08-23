


import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {

  // el Id de la aplicacion en Android y en Apple 
  static String clientId = 'com.nftlatinoamerica.fluttersigningoogleapple';
  // url call back al hacer toda la autorizacion de apple
  static Uri redirectUri = Uri.https( 'google-sign-in-token.herokuapp.com', '/callbacks/sign_in_with_apple' );
  static void signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // esto para android
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: clientId, 
          redirectUri: redirectUri
        )
      );
      print('jean: $credential');
      print(credential.authorizationCode); // Id token de google
      
      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this 
      const hostName = 'google-sign-in-token.herokuapp.com';
      final signInWithAppleEndPoint = Uri.https(
        hostName, // authority del https
        '/sign_in_with_apple', // unencodedPath
        {
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS ? 'true' : 'false',
          if(credential.state != null) 'state' : credential.state // opcional 
        }
      ); 
      // hacer la peticion 
      final session = await http.post( signInWithAppleEndPoint );

      print('jean: ========= Respuesta Apple SignIn BackEnd =========');
      print(session); 
    } catch (e) {
      print('jean: ========= Error SignIn ========');
      print(e.toString());
      
      
    }
  }
}