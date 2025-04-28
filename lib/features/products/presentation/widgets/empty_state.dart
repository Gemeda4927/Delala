import 'package:delala/config/theme/app_theme.dart.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/categories/presentation/bloc/category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/animations/empty.json',
            height: 200,
            width: 200,
            fit: BoxFit.contain,
            frameRate: FrameRate.max,
          ),
          const SizedBox(height: 24),
          Text(
            'No categories found!',
            style: AppTheme.heading3.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Try adjusting your search or filter to find what you're looking for.",
              style: AppTheme.bodyText.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<CategoryBloc>().add(ResetCategoriesEvent());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.borderRadius,
              ),
              elevation: 2,
              backgroundColor: AppTheme.primaryColor,
            ),
            child: Text(
              'Reset Filters',
              style: AppTheme.buttonText,
            ),
          ),
        ],
      ),
    );
  }
}

class ResetCategoriesEvent extends CategoryEvent {}
