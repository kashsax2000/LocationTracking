import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/viewmodels/base_provider.dart';

typedef ViewBuilder<T> = Widget Function(
  BuildContext context,
  T provider,
  Widget? child,
);
class BaseView<T extends BaseProvider> extends StatelessWidget {
  final T Function(BuildContext context) create;
  final Future<void> Function(T model)? model;
  final Widget Function(
    BuildContext context,
    T provider,
    Widget? child,
  ) builder;

  const BaseView({
    super.key,
    required this.create,
    required this.builder,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        final provider = create(context);

        if (model != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            model!(provider);
          });
        }

        return provider;
      },
      child: Consumer<T>(
        builder: (context, provider, child) {
          return builder(context, provider, child);
        },
      ),
    );
  }
}