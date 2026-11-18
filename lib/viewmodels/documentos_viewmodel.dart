import 'package:material_ui/material_ui.dart';
import '../models/documento.dart';
import '../models/services/banco_local_service.dart';

class DocumentosViewModel extends ChangeNotifier {
  List<Documento> documentos = [];

  Future<void> carregarDocumentos() async {
    documentos = await BancoDadosLocal.obterTodosDocumentos();
    notifyListeners();
  }

  Future<void> adicionarDocumento(Documento documento) async {
    await BancoDadosLocal.adicionarDocumento(documento);
    await carregarDocumentos();
  }


  Future<void> editarDocumento(Documento documento) async {
    await BancoDadosLocal.editarDocumento(documento);
    await carregarDocumentos();
  }


  Future<void> excluirDocumento(String id) async {
    await BancoDadosLocal.excluirDocumento(id);
    await carregarDocumentos();
  }
}
