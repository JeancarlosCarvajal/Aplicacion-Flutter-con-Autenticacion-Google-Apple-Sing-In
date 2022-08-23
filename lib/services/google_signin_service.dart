



import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
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
      // final test = _googleSignIn.clientId;
      // print('jean: $test');
      // return null;
      if(account == null) return null;
      
      // idToken lo genera google al logearse una cuenta se debe tomar e introducirlo en el back end
      // obtnemos los token generados por google
      final googleKey = await account.authentication;

      // print('jean: $account');
      // print('jean: ========= ID Token ========');
      // print('jean: ${googleKey.idToken}'); // https://google-sign-in-token.herokuapp.com/google

      // llamar un servicio rest a bakcend con el id token
      const hostName = 'google-sign-in-token.herokuapp.com';
      final signInWithGoogleEndPoint = Uri.https(
        hostName, // authority del https
        '/google' // unencodedPath
      );

      // final String test = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjQwMmYzMDViNzA1ODEzMjlmZjI4OWI1YjNhNjcyODM4MDZlY2E4OTMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIyNDY3NTM3NTk5NTUtanFwMGo0dWwwbmltc2xxbzg2Yjd2YmE4ZTg3MnUwazMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyNDY3NTM3NTk5NTUtcHZwb2RvOWkxdnRjdTVsNHJiOXFyMGliNHVmZjl2MmwuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDE5NDc0NDUzNzYwMzg1MjU5MjciLCJlbWFpbCI6ImplYW5jYXJsb3NjYXJ2YWphbGF2aWxhQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiSmVhbmNhcmxvcyBDYXJ2YWphbCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQUZkWnVjb0NlNnE2TEtpeUw1SklpTUlPUExTM2xhaXpaWC1ud0tXYUxUMEE9czk2LWMiLCJnaXZlbl9uYW1lIjoiSmVhbmNhcmxvcyIsImZhbWlseV9uYW1lIjoiQ2FydmFqYWwiLCJsb2NhbGUiOiJlcy00MTkiLCJpYXQiOjE2NjEyNzY1NDYsImV4cCI6MTY2MTI4MDE0Nn0.LQ5CErU5cDWAk6PuNctzh2QuWToNA1YBADrDc6Z8OdthtxcpUoTDnHO144bqcC0XyjdF8hYB-pP6ymbfwftUEYAdqPFj2uvHV1ypgJgFVl4WrMfIYPf-zbNEtHUlTHoPuCds9CpX-a4Z3k1QlfdYQjY59jjEWpZ_7prqqnNSmkr_ZyO9MX_gnKWOZknDjYW4EV5Ahc-SaktkAP3wnONqC8kWGY8_jJMEiMJZrtLLiPlbR5D4U594d_i4ca2YpxDUG5Qcs6nsh8vywSFnVqi5YfWFMvSfI-hrqHMpSZ9g97CJ-XZEyrnmjkSqKKxd1JmzHWjWhtaQMYWfCeeb8iVPvQ";
      // print('jean: ${signInWithGoogleEndPoint}');
      
      // hacer la peticion
      final session = await http.post(
        signInWithGoogleEndPoint,
        body: {
          'token': googleKey.idToken
          // 'token': test
        }
      );

      print('jean: ========== BackEnd Server ========= ');
      print(session.body);

      // respuesta seria algo asi 
      // {
      //   "ok":true,
      //   "googleUser":{
      //     "name":"Jeancarlos Carvajal",
      //     "picture":"https://lh3.googleusercontent.com/a-/AFdZucoCe6q6LKiyL5JIiMIOPLS3laizZX-nwKWaLT0A=s96-c",
      //     "email":"jeancarloscarvajalavila@gmail.com"
      //   }
      // }
      
      
      return account;
    } catch (e) {
      print('jean: Error Google SignIn, $e');
      return null; 
    }
  }

  static Future signOut() async {
    final GoogleSignInAccount? signOut = await _googleSignIn.signOut();
    // aqui devuelve null
    print('jean: SignOut, $signOut');
  }

}