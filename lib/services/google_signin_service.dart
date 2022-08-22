



import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly', // acceso a los comntactos no se recomienda
    ],
  );

  static Future<GoogleSignInAccount?> signInWithGooogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account == null) return null;
      
      // idToken lo genera google al logearse una cuenta se debe tomar e introducirlo en el back end
      // obtnemos los token generados por google
      final googleKey = await account.authentication;

      print('jean: $account');
      print('jean: ========= ID Token ========');
      print('jean: ${googleKey.idToken}');

      // TODO: llamar un servicio rest a bakcend con el id token   

      return account;
    } catch (e) {
      print('jean: Error Google SignIn, $e');
      return null; 
    }
  }

  static Future signOut() async {
    final GoogleSignInAccount? signOut = await _googleSignIn.signOut();
    // aqui devuelve null
    print('jean: $signOut');
  }

}