import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final List<String> _userTypes = ['Jugador', 'Administrador']; // <-- AJUSTA SI ES NECESARIO
  String? _selectedUserType;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() {
    if (_selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona un tipo de usuario')),
      );
      return;
    }

    ref.read(loginControllerProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _selectedUserType!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);

    ref.listen<AsyncValue<void>>(
      loginControllerProvider,
      (previous, next) {
        if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error.toString())),
          );
        }
        if (next is AsyncData) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Login exitoso!')),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
                Image.asset(
                  'assets/images/isotipo.png',
                  height: 150.0,
                ),
                const SizedBox(height: 48.0),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                const SizedBox(height: 16.0),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                const SizedBox(height: 16.0),

                DropdownButtonFormField<String>(
                  value: _selectedUserType,
                  hint: const Text('Tipo de Usuario'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserType = newValue;
                    });
                  },
                  items: _userTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: state.isLoading ? null : _performLogin,
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Ingresar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}