# edit-doc-flutter
# DocMaster 📄

O **DocMaster** é uma aplicação desenvolvida em Flutter com o objetivo de facilitar a organização, visualização e edição de documentos.

## Tecnologias utilizadas

- Flutter
- Dart
- Material UI
- Shared Preferences

## Estrutura do projeto

O projeto foi organizado utilizando o padrão arquitetural **MVVM (Model-View-ViewModel)**, separando as responsabilidades em diferentes pastas:

```text
lib/
├── main.dart
├── models/
│   ├── usuario.dart
│   ├── documento.dart
│   └── services/
│       ├── preferences_service.dart
│       └── banco_local_service.dart
├── viewmodels/
│   ├── auth_viewmodel.dart
│   └── documentos_viewmodel.dart
├── views/
│   ├── login_view.dart
│   ├── cadastro_view.dart
│   ├── home_view.dart
│   └── editor_view.dart
└── utils/
    └── validadores.dart
```

## Relatório de Migração Arquitetural

### 1. Mapeamento de Classes e Widgets

O código original, que estava concentrado em um único arquivo Dart, foi dividido conforme as responsabilidades de cada elemento.

| Elemento original | Novo local |
|---|---|
| `Usuario` | `models/usuario.dart` |
| `Documento` | `models/documento.dart` |
| `SharedPreferences` | `models/services/preferences_service.dart` |
| `BancoDadosLocal` | `models/services/banco_local_service.dart` |
| `validarNome()` | `utils/validadores.dart` |
| `validarEmail()` | `utils/validadores.dart` |
| `validarSenha()` | `utils/validadores.dart` |
| `MeuApp` e `main()` | `main.dart` |
| `TelaLogin` | `views/login_view.dart` |
| `TelaCadastro` | `views/cadastro_view.dart` |
| `TelaHome` | `views/home_view.dart` |
| Tela de edição | `views/editor_view.dart` |
| Regras de autenticação e preferências | `viewmodels/auth_viewmodel.dart` |
| Gerenciamento de documentos | `viewmodels/documentos_viewmodel.dart` |

### 2. Alterações de Estrutura e Imports

A principal mudança foi a separação do código em arquivos independentes, permitindo organizar melhor as funcionalidades da aplicação.

Foram realizados ajustes nos imports para permitir a comunicação entre as diferentes partes do projeto. Os construtores dos modelos foram organizados para receber os dados necessários, e as funções auxiliares foram transferidas para arquivos específicos.

As operações de autenticação, cadastro e consulta de usuários foram direcionadas aos serviços e ViewModels, enquanto as telas ficaram responsáveis pela interface.

Também foram configuradas as rotas nomeadas no `main.dart`:

- `/` – Login;
- `/cadastro` – Cadastro;
- `/home` – Página principal;
- `/editor` – Edição de documentos.

### 3. Mudanças no Gerenciamento de Estado

O gerenciamento de estado foi reorganizado para concentrar as regras de negócio nos ViewModels, utilizando `ChangeNotifier`.

No `AuthViewModel`, foram centralizadas as variáveis e funcionalidades relacionadas à autenticação e às preferências do usuário, como:

- `carregando`: controla o estado de carregamento;
- `usuarioLogado`: armazena o usuário autenticado;
- `fazerLogin()`: realiza a autenticação;
- `cadastrarUsuario()`: realiza o cadastro;
- `obterUsuarios()`: recupera os usuários cadastrados;
- `salvarPreferencias()`: salva as preferências;
- `obterPreferencias()`: recupera as preferências;
- `logout()`: encerra a sessão.

O `DocumentosViewModel` foi destinado ao gerenciamento das operações relacionadas aos documentos.

O método `notifyListeners()` é utilizado para comunicar alterações de estado às telas. Para que a interface reaja a essas mudanças, é previsto o uso de `ListenableBuilder`, permitindo atualizar os componentes observados sem concentrar toda a lógica nas Views.

Dessa forma, a arquitetura busca reduzir a dependência entre interface, regras de negócio e persistência de dados, facilitando a manutenção e futuras melhorias.

## Como executar o projeto

Com o Flutter instalado, execute os seguintes comandos no terminal:

```bash
flutter pub get
flutter run
```

---

**Projeto desenvolvido para fins acadêmicos.**
