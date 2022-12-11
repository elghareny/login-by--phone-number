abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class Loading extends PhoneState {}

class Error extends PhoneState 
{
  final String? error;

  Error({required this.error});

}

class PhoneNumberSubmited extends PhoneState {}

class PhoneOTPVerifiyed extends PhoneState {}
