// import 'package:animate_do/animate_do.dart';
// import 'package:delala/features/profile/domain/entities/user_profile.dart';
// import 'package:delala/features/profile/presentation/bloc/profile_bloc.dart';
// import 'package:delala/features/profile/presentation/bloc/profile_event.dart';
// import 'package:delala/features/profile/presentation/bloc/profile_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:http/http.dart' as IconlyLight;

// class ProfileForm extends StatelessWidget {
//   const ProfileForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     return BlocConsumer<ProfileBloc, ProfileState>(
//       listener: (context, state) {
//         if (state is AccountDeleted) {
//           Navigator.of(context).pushReplacementNamed('/login');
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Account deleted successfully')),
//           );
//         } else if (state is ProfileError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProfileLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is ProfileLoaded) {
//           final profile = state.profile;
//           final fullNameController =
//               TextEditingController(text: profile.fullName);
//           final emailController = TextEditingController(text: profile.email);
//           final phoneController =
//               TextEditingController(text: profile.phoneNumber);
//           final addressController =
//               TextEditingController(text: profile.address);

//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Header
//                 FadeInDown(
//                   duration: const Duration(milliseconds: 500),
//                   child: Container(
//                     height: 200,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF0288D1), Color(0xFF03A9F4)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Colors.white.withOpacity(0.3),
//                           child: profile.profilePic != null
//                               ? ClipOval(
//                                   child: Image.network(
//                                     profile.profilePic!,
//                                     width: 100,
//                                     height: 100,
//                                     fit: BoxFit.cover,
//                                     errorBuilder:
//                                         (context, error, stackTrace) =>
//                                             const Icon(
//                                       IconlyBold.profile,
//                                       size: 50,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                               : const Icon(
//                                   IconlyBold.profile,
//                                   size: 50,
//                                   color: Colors.white,
//                                 ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           profile.fullName,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Form
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         FadeInUp(
//                           child: _buildTextField(
//                             controller: fullNameController,
//                             label: 'Full Name',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your full name';
//                               }
//                               return null;
//                             },
//                             icon: null,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 700),
//                           child: _buildTextField(
//                             controller: emailController,
//                             label: 'Email',
//                             enabled: false,
//                             validator: (value) {
//                               if (value == null ||
//                                   !RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                                       .hasMatch(value)) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             }, icon: null,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildTextField(
//                             controller: phoneController,
//                             label: 'Phone Number',
//                             icon: IconlyLight.call,
//                             keyboardType: TextInputType.phone,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your phone number';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 900),
//                           child: _buildTextField(
//                             controller: addressController,
//                             label: 'Address',
//                             icon: IconlyLight.location,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your address';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1000),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 final updatedProfile = UserProfile(
//                                   id: profile.id,
//                                   fullName: fullNameController.text,
//                                   email: emailController.text,
//                                   password: profile.password,
//                                   phoneNumber: phoneController.text,
//                                   address: addressController.text,
//                                   profilePic: profile.profilePic,
//                                   userType: profile.userType,
//                                   userStatus: profile.userStatus,
//                                   createdAt: profile.createdAt,
//                                   updatedAt: DateTime.now(),
//                                 );
//                                 context
//                                     .read<ProfileBloc>()
//                                     .add(UpdateProfile(updatedProfile));
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF0288D1),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 32, vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: const Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(IconlyLight.edit, color: Colors.white),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Update Profile',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1100),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   title: const Text('Delete Account'),
//                                   content: const Text(
//                                       'Are you sure you want to delete your account? This action cannot be undone.'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       child: const Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         context
//                                             .read<ProfileBloc>()
//                                             .add(DeleteAccount());
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Text(
//                                         'Delete',
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: Colors.red),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 32, vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(IconlyLight.delete, color: Colors.red),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Delete Account',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red,
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const Center(child: Text('Something went wrong'));
//       },
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool enabled = true,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       enabled: enabled,
//       keyboardType: keyboardType,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: const Color(0xFF0288D1)),
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF0288D1), width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         labelStyle: const TextStyle(
//           fontFamily: 'Poppins',
//           color: Colors.grey,
//         ),
//       ),
//       style: const TextStyle(
//         fontFamily: 'Poppins',
//         fontSize: 16,
//         color: Colors.black87,
//       ),
//     );
//   }
// }
