import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/urban_theme.dart';
import '../repositories/supabase_auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = SupabaseAuthRepository();
  bool _isLoading = false;

  Future<void> _handleSignIn(Future<void> Function() signInMethod) async {
    setState(() => _isLoading = true);
    try {
      await signInMethod();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка входа: $e'), backgroundColor: UrbanTheme.errorColor),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              UrbanTheme.backgroundColor,
              UrbanTheme.primaryColor.withOpacity(0.1),
              UrbanTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: UrbanTheme.primaryColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: UrbanTheme.primaryColor.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_city,
                          size: 80,
                          color: UrbanTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'URBAN',
                        style: UrbanTheme.headingLarge.copyWith(
                          fontSize: 48,
                          letterSpacing: 8,
                          color: Colors.white,
                          shadows: [
                            const Shadow(color: UrbanTheme.primaryColor, blurRadius: 10),
                            const Shadow(color: UrbanTheme.secondaryColor, blurRadius: 20),
                          ],
                        ),
                      ),
                      Text(
                        'CITY OPERATING SYSTEM',
                        style: UrbanTheme.bodySmall.copyWith(
                          letterSpacing: 4,
                          color: UrbanTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: UrbanTheme.cardDecoration,
                    child: Column(
                      children: [
                        Text(
                          'ВОЙТИ В СЕТЬ',
                          style: UrbanTheme.headingSmall.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 32),
                        _buildSocialButton(
                          label: 'ВОЙТИ ЧЕРЕЗ GOOGLE',
                          icon: Icons.g_mobiledata,
                          color: UrbanTheme.primaryColor,
                          onPressed: () => _handleSignIn(_auth.signInWithGoogle),
                        ),
                        const SizedBox(height: 16),
                        _buildSocialButton(
                          label: 'ВОЙТИ ЧЕРЕЗ VK ID',
                          icon: Icons.alternate_email,
                          color: UrbanTheme.secondaryColor,
                          onPressed: () => _handleSignIn(_auth.signInWithVK),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(color: UrbanTheme.primaryColor),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: UrbanTheme.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
