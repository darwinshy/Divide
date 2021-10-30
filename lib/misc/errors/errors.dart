String errorDescription(String firebaseErrorCode) {
  switch (firebaseErrorCode) {
    case 'session-expired':
      return "The current session has expired, wait for 1 minutes and try again";

    case 'invalid-phone-number':
      return "You have entered an invalid mobile number. Try entering a 10 digit valid phone number";

    case 'invalid-credential':
      return "Looks like the credentials have expired";

    case 'operation-not-allowed':
      return "The requested operation is not allowed";

    case 'user-disabled':
      return "The requested user is disabled by the administrator";

    case 'user-not-found':
      return "The user was not found";

    case 'invalid-verification-code':
      return "You have entered wrong OTP";

    case 'invalid-verification-id':
      return "Invalid verification ID";

    case 'too-many-requests':
      return "Take a break ! You have attempted too many times. Try again later";

    default:
      return "Something went wrong. Try Again Later";
  }
}
