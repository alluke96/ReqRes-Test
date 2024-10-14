# Flutter Login Screen Challenge

Este repositório contém uma implementação de uma tela de login desenvolvida em Flutter, conforme o desafio proposto. O objetivo é demonstrar habilidades em Flutter, design responsivo e integração com APIs RESTful.

## Requisitos

- **Flutter SDK:** Certifique-se de que o [Flutter](https://flutter.dev/docs/get-started/install) esteja instalado na sua máquina. Utilizei a versão 3.24.3
- **Emulador/Dispositivo Físico/Navegador:** Para rodar o projeto, tenha um emulador configurado ou um dispositivo físico conectado. Você também pode rodar no navegador (versão web).

## Como clonar e rodar o projeto

1. **Clonar o repositório:**
```bash
   git clone https://github.com/alluke96/ReqRes-Test.git
   cd ReqRes-Test
```

2. **Instalar dependências:**
   Certifique-se de ter o Flutter instalado. Depois, instale as dependências do projeto:
```bash
   flutter pub get
```

3. **Rodar o projeto:**
   Para rodar o projeto no emulador ou dispositivo conectado:
```bash
   flutter run
```

4. **Rodar testes:**
   Execute os testes unitários com o comando:
```bash
   flutter test
```

## Descrição do Projeto

- **Comunicação com Backend REST:** A aplicação se comunica com a API [ReqRes](https://reqres.in) para autenticação de usuários.
- **Design Responsivo:** A interface foi projetada para funcionar adequadamente em dispositivos iOS, Android e Web, garantindo uma experiência de usuário consistente em diferentes tamanhos de tela.
- **Navegação:** Após a autenticação bem-sucedida, o usuário é redirecionado para uma nova tela, onde suas informações são armazenadas e podem ser acessadas em qualquer tela subsequente.
- **Gerenciamento de Estado:** O projeto utiliza BLoC como gerenciador de estado por várias razões:

1. **Separação de Preocupações:** O BLoC permite uma clara distinção entre a lógica de negócios e a interface do usuário, facilitando a manutenção e escalabilidade do código.

2. **Reatividade:** Com o uso de streams, a interface do usuário se atualiza automaticamente com mudanças no estado, tornando a experiência do usuário mais fluida.

3. **Testabilidade:** O BLoC facilita a escrita de testes unitários, ajudando a garantir que a lógica de autenticação e manipulação de dados funcione corretamente.

4. **Popularidade no Mercado:** O BLoC é um dos gerenciadores de estado mais procurados pelas empresas, como mencionado neste artigo da Alura: [Gerenciamento de Estados Flutter: Principais Ferramentas](https://www.alura.com.br/artigos/gerenciamento-de-estados-flutter-principais-ferramentas?srsltid=AfmBOooPZtA0iwwLhpxH4qpmGW0wbz3OonFqz4aLstg3O-ric1Dix0eO).


## Funcionalidades

- Tela de login com campos para e-mail e senha.
- Validação de entradas do usuário.
- Comunicação com a API para login e gerenciamento de sessão.
- Navegação entre telas e acesso a informações do usuário.
- Testes unitários cobrindo as principais funcionalidades.

## Tecnologias Utilizadas

- **Flutter:** Framework para desenvolvimento de aplicativos multiplataforma.
- **Dart:** Linguagem de programação usada para desenvolver a aplicação.
- **HTTP:** Pacote para fazer requisições HTTP.
- **Gerenciador de Estado:** BLoC.
- **Testes Unitários:** Utilizado para garantir a qualidade e a funcionalidade do código.

## Estrutura do Projeto

```plaintext
lib/
├── main.dart
├── app.dart
├── view/
│   └── pages/
│       ├── login_screen.dart
│       └── home_screen.dart
│   └── widgets/
│       ├── login_form.dart
│       └── login_header.dart
├── data/
│   └── data_sources/
│       └── user_api_data_source.dart
│   └── repositories/
│       └── user_repository.dart
├── models/
│   └── user.dart
└──  blocs/
    └── login/
        ├── login_bloc.dart
        ├── login_events.dart
        └── login_states.dart
```

A arquitetura escolhida segue o padrão **MVVM (Model-View-ViewModel)**, combinada com o uso de **BLoC** para o gerenciamento de estado. Essa abordagem traz várias vantagens que garantem a modularidade, testabilidade e reatividade do projeto. Abaixo estão as razões para essa escolha:

- **Model**: Representa os dados e a lógica de negócios. No projeto, isso está implementado na pasta `models/` (definindo o modelo de dados `user.dart`) e `data/` (que contém os repositórios e as fontes de dados que manipulam a API e o backend).
  
- **View**: A camada de apresentação, localizada na pasta `view/`, é responsável por exibir a interface do usuário e observar as mudanças de estado. As telas (`login_screen.dart`, `home_screen.dart`) e os componentes (`login_form.dart`, `login_header.dart`) respondem às atualizações vindas do BLoC.

- **ViewModel (BLoC)**: O **BLoC** atua como o ViewModel na arquitetura MVVM. Ele gerencia o estado da aplicação e a lógica de negócios. O BLoC processa os eventos da interface do usuário (como tentativas de login), realiza as operações necessárias (como requisições à API) e emite novos estados que atualizam a View. A pasta `blocs/` contém o `login_bloc.dart`, que é responsável por coordenar essa comunicação.
