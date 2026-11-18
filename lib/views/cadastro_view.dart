import 'package:material_ui/material_ui.dart';
import '../models/usuario.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../utils/validadores.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final AuthViewModel _authViewModel = AuthViewModel();

  String temaSelecionado = 'Claro';
  bool notificacoesAtivadas = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    if (!_formKey.currentState!.validate()) return;

    final usuario = Usuario(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      senha: _senhaController.text,
    );

    final cadastrado =
        await _authViewModel.cadastrarUsuario(usuario);

    if (!mounted) return;

    if (cadastrado) {
      await _authViewModel.salvarPreferencias(
        tema: temaSelecionado,
        notificacoes: notificacoesAtivadas,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
        ),
      );

      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Este e-mail já está cadastrado!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        title: const Text(
          'Criar conta',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1E293B),
        ),
      ),
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
                    'Crie sua conta!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Preencha seus dados para começar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: _nomeController,
                    decoration: _decoracaoCampo(
                      'Nome completo',
                      Icons.person_outline,
                    ),
                    validator: validarNome,
                  ),

                  const SizedBox(height: 18),

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

                  const SizedBox(height: 25),

                  const Text(
                    'Tema do aplicativo',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  RadioGroup<String>(
                    groupValue: temaSelecionado,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        temaSelecionado = value;
                      });
                    },
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Tema Claro'),
                          value: 'Claro',
                          activeColor: const Color(0xFF2563EB),
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<String>(
                          title: const Text('Tema Escuro'),
                          value: 'Escuro',
                          activeColor: const Color(0xFF2563EB),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Preferências adicionais',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  SwitchListTile(
                    title: const Text('Ativar notificações'),
                    subtitle: const Text(
                      'Receber notificações do aplicativo',
                    ),
                    value: notificacoesAtivadas,
                    activeTrackColor: const Color(0xFF2563EB),
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        notificacoesAtivadas = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 55,
                    child: AnimatedBuilder(
                      animation: _authViewModel,
                      builder: (context, child) {
                        return ElevatedButton(
                          onPressed: _authViewModel.carregando
                              ? null
                              : _cadastrar,
                          style: _estiloBotao(),
                          child: _authViewModel.carregando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Já tem uma conta? Entrar',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
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