import 'package:delala/config/routes/route_name.dart';
import 'package:delala/features/auth/sign_in/domain/entities/user_credentials.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_bloc.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_event.dart';
import 'package:delala/features/auth/sign_in/presentation/bloc/login_state.dart';
import 'package:delala/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInBloc>(),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? _selectedRole = 'Customer';
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController(
    text: 'delala@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController();

  // Validation method for email
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  // Validation method for password
  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password cannot be empty";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  // Custom method to show a styled toast
  void showCustomToast({
    required String message,
    required Color startColor,
    required Color endColor,
    required IconData icon,
  }) {
    showOverlayNotification(
      (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ), // Small curved corners
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 24.0),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      duration: const Duration(seconds: 4),
      position: NotificationPosition.top,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: BlocConsumer<SignInBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    // Show custom success toast
                    // showCustomToast(
                    //   message: '',
                    //   startColor: const Color(0xFF6C63FF),
                    //   endColor: const Color(
                    //     0xFF8B85FF,
                    //   ), // Lighter purple for gradient
                    //   icon: Icons.check_circle,
                    // );

                    // Enhanced Success Dialog
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 8.0,
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Animated Success Icon
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0, end: 1),
                                    duration: const Duration(milliseconds: 800),
                                    builder: (context, double value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: child,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF6C63FF),
                                      size: 60.0,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Login Success",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "You have successfully logged in!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.goNamed(RouteName.home);
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6C63FF),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Let's Go!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                  } else if (state is AuthFailure) {
                    // Show custom error toast
                    showCustomToast(
                      message: '❌ ${state.error}',
                      startColor: const Color(0xFFFF4D4F),
                      endColor: const Color(
                        0xFFFF7875,
                      ), // Lighter red for gradient
                      icon: Icons.error,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome back! Please login to continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: _inputDecoration('Login as'),
                        items:
                            ['Superadmin', 'Customer', 'Merchant']
                                .map(
                                  (role) => DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(() => _selectedRole = value),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        decoration: _inputDecoration('Email'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: _inputDecoration('Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscureText = !_obscureText,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              state is AuthLoading
                                  ? null
                                  : () {
                                    // Validate input before proceeding
                                    final emailError = _validateEmail(
                                      _emailController.text,
                                    );
                                    final passwordError = _validatePassword(
                                      _passwordController.text,
                                    );

                                    if (emailError != null) {
                                      showCustomToast(
                                        message: '⚠️ $emailError',
                                        startColor: const Color(
                                          0xFFFFB300,
                                        ), // Amber for warning
                                        endColor: const Color(
                                          0xFFFFCA28,
                                        ), // Lighter amber
                                        icon: Icons.warning,
                                      );
                                      return;
                                    }

                                    if (passwordError != null) {
                                      showCustomToast(
                                        message: '⚠️ $passwordError',
                                        startColor: const Color(0xFFFFB300),
                                        endColor: const Color(0xFFFFCA28),
                                        icon: Icons.warning,
                                      );
                                      return;
                                    }

                                    // If validation passes, proceed with sign-in
                                    final credentials = UserCredentials(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      role: _selectedRole ?? 'Customer',
                                    );
                                    context.read<SignInBloc>().add(
                                      SignInEvent(credentials),
                                    );
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child:
                              state is AuthLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () => context.goNamed(RouteName.signup),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF6C63FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}
