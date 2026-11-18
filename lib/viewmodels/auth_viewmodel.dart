import 'package:material_ui/material_ui.dart';
import '../models/usuario.dart';
import '../models/services/banco_local_service.dart';
import '../models/services/preferences_service.dart';

class AuthViewModel extends ChangeNotifier {
  bool carregando = false;
  Usuario? usuarioLogado;

  // Fazer login
  Future<bool> fazerLogin(String email, String senha) async {
    carregando = true;
    notifyListeners();

    final usuario = await BancoDadosLocal.autenticar(email, senha);

    usuarioLogado = usuario;

    carregando = false;
    notifyListeners();

    return usuario != null;
  }

  // Cadastrar usuário
  Future<bool> cadastrarUsuario(Usuario usuario) async {
    carregando = true;
    notifyListeners();

    final resultado =
        await BancoDadosLocal.cadastrarUsuario(usuario);

    carregando = false;
    notifyListeners();

    return resultado;
  }

  // Recuperar usuários cadastrados
  Future<List<Usuario>> obterUsuarios() async {
    return await BancoDadosLocal.obterTodosUsuarios();
  }

  // Salvar preferências
  Future<void> salvarPreferencias({
    required String tema,
    required bool notificacoes,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('tema', tema);
    await prefs.setBool('notificacoes', notificacoes);
  }

  // Recuperar preferências
  Future<Map<String, dynamic>> obterPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'tema': prefs.getString('tema') ?? 'Não informado',
      'notificacoes': prefs.getBool('notificacoes') ?? false,
    };
  }

  // Encerrar sessão
  void logout() {
    usuarioLogado = null;
    notifyListeners();
  }
}