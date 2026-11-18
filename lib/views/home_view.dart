import 'package:material_ui/material_ui.dart';
import '../viewmodels/auth_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthViewModel _authViewModel = AuthViewModel();

  late Future<List<dynamic>> _usuariosFuture;
  late Future<Map<String, dynamic>> _preferenciasFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = _authViewModel.obterUsuarios();
    _preferenciasFuture = _authViewModel.obterPreferencias();
  }

  @override
  void dispose() {
    _authViewModel.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  Future<void> _mostrarPreferencias() async {
    final preferencias = await _preferenciasFuture;

    if (!mounted) return;

    final tema = preferencias['tema'] as String;
    final notificacoes = preferencias['notificacoes'] as bool;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.settings_outlined,
                color: Color(0xFF2563EB),
              ),
              SizedBox(width: 10),
              Text('Minhas preferências'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.palette_outlined,
                  color: Color(0xFF2563EB),
                ),
                title: const Text('Tema do aplicativo'),
                subtitle: Text('Tema $tema'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF2563EB),
                ),
                title: const Text('Notificações'),
                subtitle: Text(
                  notificacoes ? 'Ativadas' : 'Desativadas',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarUsuarios() async {
    final usuarios = await _usuariosFuture;

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.people_outline,
                color: Color(0xFF2563EB),
              ),
              SizedBox(width: 10),
              Expanded(child: Text('Usuários cadastrados')),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: usuarios.isEmpty
                ? const Text('Nenhum usuário cadastrado.')
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: usuarios.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final usuario = usuarios[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE5EDFF),
                          child: Icon(
                            Icons.person_outline,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                        title: Text(usuario.nome),
                        subtitle: Text(usuario.email),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget _criarCardInformacao({
    required IconData icone,
    required String titulo,
    required String descricao,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icone,
                  size: 30,
                  color: const Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      descricao,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: Color(0xFF2563EB),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _criarArquivo({
    required String nome,
    required String tipo,
  }) {
    final ehPdf = tipo.toUpperCase().startsWith('PDF');

    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(
              ehPdf
                  ? Icons.picture_as_pdf_outlined
                  : Icons.description_outlined,
              size: 38,
              color: const Color(0xFF2563EB),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tipo,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            _criarAcao(
              icone: Icons.visibility_outlined,
              titulo: 'Visualizar',
              onTap: () {
                _mostrarMensagem(
                  'Visualização demonstrativa: $nome',
                );
              },
            ),
            Container(
              height: 45,
              width: 1,
              color: const Color(0xFFDCE5FA),
              margin: const EdgeInsets.symmetric(horizontal: 5),
            ),
            _criarAcao(
              icone: Icons.edit_outlined,
              titulo: 'Editar',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/editor',
                  arguments: nome,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarAcao({
    required IconData icone,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icone,
              size: 25,
              color: const Color(0xFF2563EB),
            ),
            const SizedBox(height: 5),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF263858),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nomeUsuario =
        ModalRoute.of(context)?.settings.arguments as String? ??
            'Usuário';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        title: const Text(
          'DocMaster',
          style: TextStyle(
            color: Color(0xFF2452B5),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xFF2452B5),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Olá, $nomeUsuario!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Gerencie seus documentos de forma simples.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFDCE5FA),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      size: 55,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Envie seus documentos',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Adicione seus arquivos para organizar tudo em um só lugar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _mostrarMensagem(
                          'O envio de arquivos ainda é demonstrativo.',
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar documento'),
                      style: _estiloBotao(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Minha conta',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 10),

              _criarCardInformacao(
                icone: Icons.settings_outlined,
                titulo: 'Preferências do usuário',
                descricao: 'Consultar tema e notificações salvos',
                onTap: _mostrarPreferencias,
              ),

              _criarCardInformacao(
                icone: Icons.people_outline,
                titulo: 'Usuários cadastrados',
                descricao: 'Visualizar registros do banco local',
                onTap: _mostrarUsuarios,
              ),

              const SizedBox(height: 25),

              const Text(
                'Meus documentos',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 12),

              _criarArquivo(
                nome: 'Relatorio_Final.pdf',
                tipo: 'PDF • Documento',
              ),

              _criarArquivo(
                nome: 'Trabalho_Faculdade.docx',
                tipo: 'DOCX • Documento',
              ),

              _criarArquivo(
                nome: 'Anotacoes_Aula.pdf',
                tipo: 'PDF • Documento',
              ),

              _criarArquivo(
                nome: 'Planilha_Projeto.xlsx',
                tipo: 'XLSX • Planilha',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFDCE5FA),
            ),
          ),
        ),
        child: const Text(
          'Desenvolvido por Rafaela Canguçu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
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