import 'package:delala/config/routes/route_name.dart';
import 'package:delala/features/auth/sign_up/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:delala/features/auth/sign_up/presentation/bloc/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  String _selectedRole = "Merchant";

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            try {
              context.pop();
            } catch (e) {
              _showErrorSnackBar(context, 'Error navigating back: $e');
            }
          },
        ),
        title: const Text(
          "New Account",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<SignUpBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            try {
              _showSuccessToast(state.message, state.userId);
            } catch (e) {
              _showErrorSnackBar(context, 'Error showing success message: $e');
            }
          } else if (state is AuthFailure) {
            _showErrorSnackBar(context, 'Sign up failed: ${state.error}');
          }
        },
        child: BlocBuilder<SignUpBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: "Full name",
                            hint: "Gemeda Tamiru",
                            obscure: false,
                            controller: _fullNameController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Full name is required'
                                : null,
                          ),
                          _buildPasswordField(),
                          _buildTextField(
                            label: "Email",
                            hint: "example@example.com",
                            obscure: false,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "Mobile Number",
                            hint: "0914.....",
                            obscure: false,
                            controller: _mobileNumberController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Mobile number is required'
                                : null,
                          ),
                          _buildRoleDropdown(),
                          const SizedBox(height: 15),
                          Center(
                            child: RichText(
                              text: const TextSpan(
                                text: "By continuing, you agree to ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Terms of Use",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy Policy.",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  state is AuthLoading ? null : _handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Center(
                            child: Text(
                              "or sign up with",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialButton(
                                  FontAwesomeIcons.google, "Google"),
                              const SizedBox(width: 15),
                              _buildSocialButton(
                                  FontAwesomeIcons.facebook, "Facebook"),
                              const SizedBox(width: 15),
                              _buildSocialButton(
                                  FontAwesomeIcons.fingerprint, "Fingerprint"),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () =>
                                  _navigateTo(context, RouteName.login),
                              child: RichText(
                                text: const TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Log in",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required bool obscure,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.blue.shade100.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          validator: (value) =>
              value == null || value.isEmpty ? 'Password is required' : null,
          decoration: InputDecoration(
            hintText: "Enter your password",
            filled: true,
            fillColor: Colors.blue.shade100.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                try {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                } catch (e) {
                  _showErrorSnackBar(
                      context, 'Error toggling password visibility: $e');
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Role", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          items: ["Merchant", "Customer", "Super Admin"]
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (value) {
            try {
              if (value != null) {
                setState(() {
                  _selectedRole = value;
                });
              }
            } catch (e) {
              _showErrorSnackBar(context, 'Error selecting role: $e');
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue.shade100.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => value == null ? 'Please select a role' : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return IconButton(
      icon: FaIcon(icon, size: 30, color: Colors.blue.shade700),
      onPressed: () {
        try {
          _handleSocialSignUp(label);
        } catch (e) {
          _showErrorSnackBar(context, 'Error with $label sign up: $e');
        }
      },
    );
  }

  void _handleSignUp() {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final user = UserModel(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phoneNumber: _mobileNumberController.text.trim(),
          address: "Addis Ababa, Ethiopia",
          userType: _selectedRole.toUpperCase(),
        );
        final signUpBloc = BlocProvider.of<SignUpBloc>(context, listen: false);
        signUpBloc.add(SignUpEvent(user));
      } else {
        _showErrorSnackBar(context, 'Please fill all fields correctly');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error during sign up: $e');
    }
  }

  void _handleSocialSignUp(String provider) {
    try {
      print("$provider sign up initiated!");
      _showSuccessToast("Signed up with $provider!", null);
    } catch (e) {
      _showErrorSnackBar(context, 'Social sign-up failed: $e');
    }
  }

  void _navigateTo(BuildContext context, String route) {
    try {
      context.go(route);
    } catch (e) {
      _showErrorSnackBar(context, 'Navigation error to $route: $e');
    }
  }

  void _showSuccessToast(String? message, String? userId) {
    try {
      FToast fToast = FToast();
      fToast.init(context);

      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade700,
              Colors.greenAccent.shade400,
              Colors.limeAccent.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.6, 1.0],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade600.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 3,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.celebration,
                key: ValueKey('celebration_icon'),
                color: Colors.white,
                size: 36,
              ),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 500),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      letterSpacing: 0.8,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "You have successfully registered! You can Log in now",
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 700),
                    child: Text(
                      userId != null
                          ? "👤 User ID: $userId"
                          : message ?? "Registration complete!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      showCustomToast(context, toast);
    } catch (e) {
      _showErrorSnackBar(context, 'Error showing toast: $e');
    }
  }

  void showCustomToast(BuildContext context, Widget toast) {
    FToast fToast = FToast();
    fToast.init(context);

    try {
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 4),
        positionedToastBuilder: (context, child, gravity) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: gravity == ToastGravity.TOP ? 60.0 : null,
                left: 20.0,
                right: 20.0,
                curve: Curves.easeOutCubic,
                child: AnimatedSlide(
                  offset: Offset(0, gravity == ToastGravity.TOP ? 0 : -1.5),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                    child: child,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint("Error showing toast: $e");
      _showErrorSnackBar(context, 'Failed to show success message: $e');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      debugPrint('Error showing SnackBar: $e');
    }
  }
}
