import '../usuario.dart';
import '../documento.dart';

class BancoDadosLocal {
 static final List<Usuario> _tabelaUsuarios = [
Usuario(
nome: 'Professor',
email: 'prof@email.com',
senha: '123456',
),
Usuario(
nome: 'Rafaela',
email: 'rafa@email.com',
senha: '123456',
),
Usuario(
nome: 'Geovana',
email: 'geo@email.com',
senha: '123456',
),
 ];
 static Future<bool> cadastrarUsuario(
Usuario novoUsuario) async {
await Future.delayed(const Duration(milliseconds: 300));
bool jaExiste = _tabelaUsuarios.any(
(u) => u.email.toLowerCase() ==
novoUsuario.email.toLowerCase(),
);

if (jaExiste) return false;
_tabelaUsuarios.add(novoUsuario);
return true;
 }
 static Future<Usuario?> autenticar(
String email, String senha) async {
await Future.delayed(const Duration(milliseconds: 300));
try {
return _tabelaUsuarios.firstWhere(
(u) =>
u.email.toLowerCase() == email.toLowerCase() &&
u.senha == senha,
);
} catch (e) {
return null;
}
 }
 static Future<List<Usuario>> obterTodosUsuarios() async {
await Future.delayed(const Duration(milliseconds: 200));
return List.unmodifiable(_tabelaUsuarios);
 }

 static final List<Documento> _tabelaDocumentos = [];

static Future<List<Documento>> obterTodosDocumentos() async {
  return _tabelaDocumentos;
}

static Future<void> adicionarDocumento(Documento documento) async {
  _tabelaDocumentos.add(documento);
}

static Future<void> editarDocumento(Documento documento) async {
  final index = _tabelaDocumentos.indexWhere(
    (d) => d.id == documento.id,
  );

  if (index != -1) {
    _tabelaDocumentos[index] = documento;
  }
}

static Future<void> excluirDocumento(String id) async {
  _tabelaDocumentos.removeWhere(
    (documento) => documento.id == id,
  );
}
}