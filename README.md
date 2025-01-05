# Atividade 1 - Gerenciador de Tarefas

## Descrição
Este é um aplicativo Flutter que permite aos usuários criar, visualizar, editar e excluir tarefas. As tarefas são armazenadas localmente usando `SharedPreferences`, garantindo que as informações sejam persistentes entre as sessões.

## Funcionalidades
- **Adicionar Tarefas**: Permite aos usuários adicionar novas tarefas com título e descrição.
- **Editar Tarefas**: Os usuários podem editar tarefas existentes.
- **Excluir Tarefas**: Possibilidade de remover tarefas da lista.
- **Persistência de Dados**: As tarefas são salvas localmente utilizando `SharedPreferences`.

## Estrutura de Pastas
```
Lista-de-Tarefas-Flutter/
├── lib/
│   ├── data/
│   │   └── models/
│   │       └── task_model.dart
│   ├── screens/
│   │   ├── add_task_screen.dart
│   │   └── home_screen.dart
│   ├── widgets/
│   │   ├── custom_app_bar.dart
│   │   └── textbox.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## Instalação

1. Certifique-se de ter o Flutter instalado. Se não, siga as instruções em [flutter.dev](https://flutter.dev/docs/get-started/install).
2. Clone este repositório:
   ```bash
   git clone https://github.com/Journeyexe/Lista-de-Tarefas-Flutter
   ```
3. Navegue até o diretório do projeto:
   ```bash
   cd Lista-de-Tarefas-Flutter
   ```
4. Instale as dependências:
   ```bash
   flutter pub get
   ```
5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Uso

1. Na tela inicial, visualize a lista de tarefas existentes.
2. Para adicionar uma nova tarefa, clique no botão de adição (botão flutuante com ícone de "+") e preencha o título e a descrição.
3. Para editar uma tarefa, clique no ícone de edição ao lado da tarefa desejada e atualize as informações.
4. Para excluir uma tarefa, clique no ícone de lixeira ao lado da tarefa desejada.

## Dependências
- `flutter`: SDK principal do Flutter.
- `shared_preferences`: Para armazenar e recuperar dados localmente.

## Contribuição
1. Fork este repositório.
2. Crie uma nova branch:
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```
3. Faça suas modificações e commit:
   ```bash
   git commit -m 'Adiciona nova funcionalidade'
   ```
4. Envie para o repositório remoto:
   ```bash
   git push origin feature/nova-funcionalidade
   ```
5. Abra um Pull Request.

## Licença
Este projeto está licenciado sob a MIT License. Consulte o arquivo `LICENSE` para mais informações.

