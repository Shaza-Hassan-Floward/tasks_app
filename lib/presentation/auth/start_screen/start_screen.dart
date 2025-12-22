import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Logo / Icon
              Icon(
                Icons.task_alt,
                size: 72,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(height: 16),

              Text(
                'Tasks App',
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Organize your tasks and stay productive',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),

              const Spacer(),

              // Login
              ElevatedButton(
                onPressed: () {
                  context.goNamed('login');
                },
                child: const Text('Login'),
              ),

              const SizedBox(height: 12),

              // Signup
              OutlinedButton(
                onPressed: () {
                  context.goNamed('signup');
                  },
                child: const Text('Create Account'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}