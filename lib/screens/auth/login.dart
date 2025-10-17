import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:temuin_app/providers/auth_provider.dart';
import 'package:temuin_app/screens/home/company_home.dart';
import 'package:temuin_app/screens/home/influencer_home.dart';
import 'package:temuin_app/shared/styled_buttons.dart';
import 'package:temuin_app/shared/styled_text.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // handling login
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // listen to auth changes and navigate
    ref.listen(authProvider, (prev, next) {
      if (next.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                next.isInfluencer ? const InfluencerHome() : CompanyHome(),
          ),
        );
      }
    });

    // handling error through snackbar
    ref.listen(authProvider, (prev, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorMessage!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GradientText(
              text: Text(
                "TEMUIN",
                style: GoogleFonts.kablammo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Lottie.asset(
            'assets/lotties/login_lottie.json',
            width: 200,
            height: 200,
            repeat: true,
            animate: true,
            frameRate: FrameRate.max,
            options: LottieOptions(
              enableMergePaths: true, // Can help with some files
            ),
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 200,
                height: 200,
                child: Center(child: Icon(Icons.animation, size: 100)),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Connect ", style: const TextStyle(fontSize: 20)),
              GradientText(
                text: Text(
                  "Influencers ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("with ", style: const TextStyle(fontSize: 20)),
              GradientText(
                text: Text(
                  "Brands ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 24),
                  // if (authState.errorMessage != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: 16),
                  //     child: Text(
                  //       authState.errorMessage!,
                  //       style: const TextStyle(color: Colors.red),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              child: GradientButtons(
                text: 'Login',
                onPressed: authState.isLoading ? null : _handleLogin,
                isLoading: authState.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
