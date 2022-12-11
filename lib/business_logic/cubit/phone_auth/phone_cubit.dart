import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {

  late String? verificationId;

  PhoneCubit() : super(PhoneInitial());


  Future <void> submitPhoneNumber(String? phoneNumber) async
  {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+2$phoneNumber',
    timeout: const Duration(seconds: 14),
    verificationCompleted: verificationCompleted,
    verificationFailed: verificationFailed,
    codeSent: codeSent,
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  );
  }



void verificationCompleted(PhoneAuthCredential credential)async
{
  print('verificationCompleted');
  await signIn(credential);
}

void verificationFailed(FirebaseAuthException error)async
{
   print('verificationFailed${error.toString()}');
  emit(Error(error: error.toString()));
}

void codeSent(String verificationId, int? resendToken)async
{
   print('codeSent');
  this.verificationId = verificationId;
  emit(PhoneNumberSubmited());
}

void codeAutoRetrievalTimeout(String verificationId)async
{
  print('codeAutoRetrievalTimeout');
}

Future <void> submitOTP(String? otpCode)async
{
  PhoneAuthCredential credential = PhoneAuthProvider
  .credential(verificationId: this.verificationId!,
   smsCode: otpCode!
   );

  await signIn(credential);

}

Future <void> signIn(PhoneAuthCredential credential)async
{
  try {
  await FirebaseAuth.instance.signInWithCredential(credential);
  emit(PhoneOTPVerifiyed());
  }catch(error)
  {
    emit(Error(error: error.toString()));
  }
}


Future<void> signOut () async
{
  await FirebaseAuth.instance.signOut();
}

User getLoggedInUser()
{
  return FirebaseAuth.instance.currentUser!;
}
  
}
