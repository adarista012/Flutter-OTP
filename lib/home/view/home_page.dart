import 'package:firebase_bloc/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AppBloc bloc) => bloc.state.user,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppLogoutRequested(),
                  );
            },
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.email ?? 'email',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              user.name ?? 'name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
