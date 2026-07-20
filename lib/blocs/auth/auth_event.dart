abstract class AuthEvent {
  const AuthEvent();
}

class AuthSubscriptionRequested extends AuthEvent {}

class SignInAnonymouslyRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class SignInWithGoogleRequested extends AuthEvent {}
