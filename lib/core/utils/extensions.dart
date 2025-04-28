// utils.dart
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> launchPhone(
      String phoneNumber, BuildContext context) async {
    final url = Uri.parse('tel:$phoneNumber');
    await launchUrlWrapper(url, 'Could not launch phone dialer', context);
  }

  static Future<void> launchWhatsApp(
      String phoneNumber, BuildContext context) async {
    final url = Uri.parse('https://wa.me/$phoneNumber');
    await launchUrlWrapper(url, 'Could not launch WhatsApp', context);
  }

  static Future<void> launchMaps(String address, BuildContext context) async {
    final url = Uri.parse(
      Uri.encodeFull(
          'https://www.google.com/maps/search/?api=1&query=$address'),
    );
    await launchUrlWrapper(url, 'Could not launch maps', context);
  }

  static Future<void> launchUrlWrapper(
      Uri url, String errorMessage, BuildContext context) async {
    developer.log('Launching URL: $url', name: 'Utils');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        showSnackBar(errorMessage,
            backgroundColor: Colors.redAccent, context: context);
      }
    } catch (e) {
      developer.log('URL launch error: $e', name: 'Utils', error: e);
      showSnackBar(errorMessage,
          backgroundColor: Colors.redAccent, context: context);
    }
  }

  static void showSnackBar(
    String message, {
    Color backgroundColor = Colors.black87,
    SnackBarAction? action,
    required BuildContext context,
  }) {
    developer.log('Showing snackbar: $message', name: 'Utils');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor,
        action: action,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}

// String extension for capitalization
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
