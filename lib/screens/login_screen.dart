import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.c.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.c.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: Space.h.t32,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Icon / Logo
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppTheme.c.primary,
                      borderRadius: AppProps.radiusXl.radius(),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.c.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'M',
                      style: AppText.h1b.copyWith(
                        fontSize: 48,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                  Space.y.t32,
                  // App Name
                  Text(
                    'Momentum',
                    textAlign: TextAlign.center,
                    style: AppText.h1b.copyWith(
                      letterSpacing: -1,
                      color: AppTheme.c.text,
                    ),
                  ),
                  Space.y.t08,
                  Text(
                    'Build consistency and direct your days with intention.',
                    textAlign: TextAlign.center,
                    style: AppText.b1.copyWith(
                      color: AppTheme.c.subText,
                    ),
                  ),
                  Space.y.t32,

                  // Text fields for visual premium polish
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: AppTheme.c.subBackground,
                      border: OutlineInputBorder(
                        borderRadius: AppProps.radiusXl.radius(),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Space.y.t16,
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      filled: true,
                      fillColor: AppTheme.c.subBackground,
                      border: OutlineInputBorder(
                        borderRadius: AppProps.radiusXl.radius(),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Space.y.t32,

                  if (state is AuthLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          SignInAnonymouslyRequested(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.c.primary,
                        foregroundColor: AppTheme.c.onPrimary,
                        padding: Space.v.t16,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppProps.radiusXl.radius(),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Get Started Now',
                        style: AppText.b1b.copyWith(color: AppTheme.c.onPrimary),
                      ),
                    ),
                    Space.y.t16,
                    OutlinedButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          SignInWithGoogleRequested(),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: Space.v.t16,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppProps.radiusXl.radius(),
                        ),
                        side: BorderSide(
                          color: AppTheme.c.border,
                        ),
                        backgroundColor: AppTheme.c.subBackground,
                        foregroundColor: AppTheme.c.text,
                        elevation: 0,
                      ),
                      icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppTheme.c.error,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'G',
                              style: AppText.b2b.copyWith(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      label: Text(
                        'Continue with Google',
                        style: AppText.b1b,
                      ),
                    ),
                    Space.y.t16,
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          SignInAnonymouslyRequested(),
                        );
                      },
                      child: Text(
                        'Continue as Guest',
                        style: AppText.b1b.copyWith(
                          color: AppTheme.c.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
