import 'package:material_ui/material_ui.dart';
class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  final TextEditingController _conteudoController =
      TextEditingController();

  String nomeDocumento = 'Novo documento';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final argumento =
        ModalRoute.of(context)?.settings.arguments;

    if (argumento is String) {
      nomeDocumento = argumento;
    }
  }

  @override
  void dispose() {
    _conteudoController.dispose();
    super.dispose();
  }

  void _salvarDocumento() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvamento demonstrativo!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        title: Text(
          nomeDocumento,
          style: const TextStyle(
            color: Color(0xFF2452B5),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2452B5),
        ),
        actions: [
          IconButton(
            tooltip: 'Salvar',
            onPressed: _salvarDocumento,
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Editar documento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _conteudoController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Digite o conteúdo do documento...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _salvarDocumento,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salvar alterações'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}