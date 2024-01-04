class AuthException implements Exception {}

class CloudAuthException implements AuthException {}

class UserNotFoundAuthException implements AuthException {}

class WrongPasswordAuthException implements AuthException {}

class InvalidLoginCredentialsAuthException implements AuthException {}

class MissingEmailAuthException implements AuthException {}

//Register Exceptions

class WeakPasswordAuthException implements AuthException {}

class EmailAlreadyInUseAuthException implements AuthException {}

class InvalidEmailAuthException implements AuthException {}

//generic auth exception

class GenericAuthException implements AuthException {}

class UserNotLoggedInException implements AuthException {}
