import 'package:material_ui/material_ui.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../utils/validadores.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  Future<void> _fazerLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final sucesso = await _authViewModel.fazerLogin(
      _emailController.text.trim(),
      _senhaController.text,
    );

    if (!mounted) return;

    if (sucesso) {
      final nome = _authViewModel.usuarioLogado!.nome;

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: nome,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha incorretos!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _logoDocMaster(),

                  const SizedBox(height: 24),

                  const Text(
                    'Bem-vindo de volta!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Entre na sua conta para continuar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoracaoCampo(
                      'E-mail',
                      Icons.email_outlined,
                    ),
                    validator: validarEmail,
                  ),

                  const SizedBox(height: 18),

                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: _decoracaoCampo(
                      'Senha',
                      Icons.lock_outline,
                    ),
                    validator: validarSenha,
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    height: 55,
                    child: AnimatedBuilder(
                      animation: _authViewModel,
                      builder: (context, child) {
                        return ElevatedButton(
                          onPressed: _authViewModel.carregando
                              ? null
                              : _fazerLogin,
                          style: _estiloBotao(),
                          child: _authViewModel.carregando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Não tem uma conta? ',
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Cadastre-se',
                            style: TextStyle(
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _logoDocMaster() {
  return Column(
    children: [
      Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.description,
              size: 75,
              color: Color(0xFF2563EB),
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.inventory_2,
                size: 30,
                color: Color(0xFF2452B5),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'DocMaster',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2452B5),
        ),
      ),
    ],
  );
}

InputDecoration _decoracaoCampo(
  String label,
  IconData icone,
) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icone),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  );
}

ButtonStyle _estiloBotao() {
  return ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2563EB),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );
}