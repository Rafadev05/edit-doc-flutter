import 'package:material_ui/material_ui.dart';
import 'views/login_view.dart';
import 'views/cadastro_view.dart';
import 'views/home_view.dart';
import 'views/editor_view.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocMaster',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const LoginView(),
        '/cadastro': (context) => const CadastroView(),
        '/home': (context) => const HomeView(),
        '/editor': (context) => const EditorView(),
      },

      localizationsDelegates:
          GlobalMaterialLocalizations.delegates,

      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
    );
  }
}