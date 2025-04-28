class AuthService {
  static bool isLoggedIn = false;

  static void logIn() {
    isLoggedIn = true;
  }

  static void logOut() {
    isLoggedIn = false;
  }
}
