import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Future<void> signUpUser(
      {required String email, required String password}) async {
    emit(SignUpLoaded());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpsuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errorMessage: 'weak password'));
        //showSnackBar(context, 'weak password');
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(errorMessage: 'this account already exists'));
        //showSnackBar(context, 'this account already exists');
      }
    } catch (ex) {
      emit(SignUpFailure(errorMessage: 'there was an error'));
      //showSnackBar(context, 'there was an error');
    }
  }
}
