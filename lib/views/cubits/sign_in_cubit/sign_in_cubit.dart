import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  Future<void> signInUser(
      {required String email, required String passWord}) async {
    try {
      emit(SignInLoaded());
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passWord);
      emit(SignInsuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailure(errorMessage: 'user not found'));
        // showSnackBar(context, 'user not found');
      } else if (e.code == 'wrong-password') {
        emit(SignInFailure(errorMessage: 'wrong password'));
        // showSnackBar(context, 'wrong password');
      }
    } catch (ex) {
      emit(SignInFailure(errorMessage: 'there was an error'));
      //showSnackBar(context, 'there was an error');
    }
  }
}
