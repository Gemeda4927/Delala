import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/products/data/repository/repository.dart';
import 'package:delala/features/products/data/services/products.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'subcategories_list.dart';

class SubcategoriesScreen extends StatelessWidget {
  final CategoryEntity category;

  const SubcategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${category.name} Subcategories',
          style: AppConstants.heading1,
        ),
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: AppConstants.primaryTextColor ?? Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppConstants.backgroundColor ?? Colors.white,
        elevation: 0,
      ),
      body: RepositoryProvider<ProductRepository>(
        create: (context) =>
            ProductRepositoryImpl(productService: ProductService()),
        child: BlocProvider.value(
          value: context.read<CategoryBloc>(),
          child: SubcategoriesList(categoryId: category.id),
        ),
      ),
      backgroundColor: AppConstants.backgroundColor ?? Colors.white,
    );
  }
}
