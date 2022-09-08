import 'package:firebase_auth/firebase_auth.dart';
import '../models/Dtos.dart';

class FirebaseService {

  static Future<AuthResponseDto> auth(LoginDto ld) async  {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: ld.email,
        password: ld.password,
      );
      return AuthResponseDto(null, credential.user);

    } on FirebaseAuthException catch (e) {
      print(e);
      return AuthResponseDto(e.message, null);
    } catch (e) {
      print(e);
      return AuthResponseDto("Error desconocido", null);
    }
  }

  static Future<AuthResponseDto> register(RegisterDto rd) async {
    print(rd.email + rd.name + rd.password);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: rd.email,
        password: rd.password,
      );
      credential.user!.updateDisplayName(rd.name);
      return AuthResponseDto(null, credential.user);
      
    } on FirebaseAuthException catch (e) {
      print(e);
      return AuthResponseDto(e.message, null);
    } catch (e) {
      print(e);
      return AuthResponseDto("Error desconocido", null);
    }
  }

}