import 'package:flutter/material.dart';

// Função principal que inicia o aplicativo Flutter.
void main() {
  runApp(MyApp()); // Executa o app.
}

// Classe que representa um jogador com nome e pontuação.
class Jogador {
  final String nome; // Nome do jogador.
  final int pontos; // Pontuação do jogador.

  // Construtor da classe Jogador.
  Jogador(this.nome, this.pontos);
}

// Classe principal do aplicativo que é um StatefulWidget.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState(); // Cria o estado do app.
}

// Classe de estado para controlar a lógica do aplicativo.
class _MyAppState extends State<MyApp> {
  // Lista de perguntas do quiz com opções e a resposta correta.
  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': 'Qual empresa criou o sistema operacional Windows?',
      'opcoes': ['Apple', 'Microsoft', 'Google'],
      'respostaCorreta': 'Microsoft',
    },
    {
      'pergunta': 'Qual linguagem é usada para apps Flutter?',
      'opcoes': ['Kotlin', 'Dart', 'Swift'],
      'respostaCorreta': 'Dart',
    },
    {
      'pergunta': 'Quem fundou a Apple?',
      'opcoes': ['Bill Gates', 'Steve Jobs', 'Elon Musk'],
      'respostaCorreta': 'Steve Jobs',
    },
    {
      'pergunta': 'O que significa "HTML"?',
      'opcoes': [
        'HyperText Markup Language',
        'HighText Machine Language',
        'Hyper Transfer Markup Language',
      ],
      'respostaCorreta': 'HyperText Markup Language',
    },
    {
      'pergunta': 'Qual navegador é feito pelo Google?',
      'opcoes': ['Safari', 'Firefox', 'Chrome'],
      'respostaCorreta': 'Chrome',
    },
    {
      'pergunta': 'Qual desses é um banco de dados?',
      'opcoes': ['Python', 'MySQL', 'CSS'],
      'respostaCorreta': 'MySQL',
    },
    {
      'pergunta': 'Qual sistema operacional é baseado em Linux?',
      'opcoes': ['Windows', 'macOS', 'Ubuntu'],
      'respostaCorreta': 'Ubuntu',
    },
    {
      'pergunta': 'O que é CPU?',
      'opcoes': [
        'Central Process Unit',
        'Computer Personal Unit',
        'Central Processing Unit',
      ],
      'respostaCorreta': 'Central Processing Unit',
    },
    {
      'pergunta': 'Qual linguagem é usada para web?',
      'opcoes': ['C++', 'HTML', 'Assembly'],
      'respostaCorreta': 'HTML',
    },
    {
      'pergunta': 'O que é um bug em programação?',
      'opcoes': ['Erro no código', 'Inseto na tela', 'Comando secreto'],
      'respostaCorreta': 'Erro no código',
    },
  ];

  List<Jogador> ranking = []; // Lista que armazena o ranking dos jogadores.
  String nomeUsuario = ''; // Nome do jogador atual.
  int perguntaAtual = 0; // Índice da pergunta atual.
  int pontos = 0; // Pontuação do jogador.
  String? mensagem; // Mensagem de feedback (acertou/errou).
  bool quizFinalizado = false; // Define se o quiz terminou.
  bool quizIniciado = false; // Define se o quiz começou.
  String? respostaSelecionada; // Resposta que o usuário escolheu.

  // Conquista do jogador ao final do quiz.
  String conquista = ''; // Armazena o texto da conquista com base na pontuação.

  // Controlador do campo de texto para capturar o nome do jogador.
  final TextEditingController nomeController = TextEditingController();

  // Função que inicia o quiz, capturando o nome do jogador.
  void iniciarQuiz() {
    setState(() {
      nomeUsuario = nomeController.text.trim(); // Pega o nome do campo.
      quizIniciado = true; // Marca o quiz como iniciado.
    });
  }

  // Função que verifica se a resposta escolhida está correta.
  void verificarRespostas(String respostaEscolhida) {
    final respostaCorreta = perguntas[perguntaAtual]['respostaCorreta'];

    setState(() {
      respostaSelecionada = respostaEscolhida; // Salva resposta do usuário.
      if (respostaEscolhida == respostaCorreta) {
        pontos++; // Adiciona ponto se acertou.
        mensagem = 'Acertou! +1 ponto'; // Mensagem de acerto.
      } else {
        mensagem =
            'Errou! A resposta correta é: $respostaCorreta'; // Mensagem de erro.
      }
    });

    // Aguarda 2 segundos antes de passar para a próxima pergunta ou finalizar.
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mensagem = null; // Limpa mensagem anterior.
        respostaSelecionada = null; // Limpa resposta selecionada.

        if (perguntaAtual < perguntas.length - 1) {
          perguntaAtual++; // Vai para a próxima pergunta.
        } else {
          quizFinalizado = true; // Marca como finalizado.
          ranking.add(Jogador(nomeUsuario, pontos)); // Adiciona ao ranking.
          ranking.sort(
            (a, b) => b.pontos.compareTo(a.pontos),
          ); // Ordena por pontuação (maior primeiro).

          // NOVO: Define conquista com base na pontuação.
          if (pontos == perguntas.length) {
            conquista = 'Gênio da Tecnologia!'; //apenas se acertar todas
          } else if (pontos >= (perguntas.length * 0.7).floor()) {
            conquista = 'Dev Formando'; //  apenas se acertar de 7 a 9
          } else if (pontos >= (perguntas.length * 0.4).floor()) {
            conquista = 'Força Dev '; // apenas se acertar de 4 a 6
          } else {
            conquista = 'Dev Iniciante'; // acertou menos de 4 perguntas
          }
        }
      });
    });
  }

  // Reinicia o quiz para novo jogador ou repetição.
  void reiniciarQuiz() {
    setState(() {
      perguntaAtual = 0;
      pontos = 0;
      mensagem = null;
      respostaSelecionada = null;
      quizFinalizado = false;
      quizIniciado = false;
      nomeController.clear(); // Limpa o campo de nome.
      conquista = ''; // Limpa a conquista ao reiniciar.
    });
  }

  // Método que define a interface visual do app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple, // Cor primária roxa.
        scaffoldBackgroundColor: Colors.purple[100], // Fundo roxo claro.
      ),
      //configurações visuais da appBar
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz de Tecnologia',
            style: TextStyle(color: Colors.white), // cor das palavras da appBar
          ), // Título da AppBar.
          centerTitle: true, //centralizar a appBar
          backgroundColor: Colors.purple,//definir a cor da appBar
        ),
        body: Center(
          child:
              quizIniciado
                  ? quizFinalizado
                      ? Column(
                        // Tela final do quiz.
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text( // conigurações visuais da pagina final do quiz
                            'Fim do Quiz!',
                            style: TextStyle(
                              fontSize: 24,// tamanho do titulo fim de quiz 
                              color: Colors.deepPurple,//cor do titulo de fim de quiz
                            ),
                          ),
                          SizedBox(height: 20),//altura da parte do texto de conquista
                          Text(
                            'Sua pontuação foi $pontos de ${perguntas.length}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Conquista: $conquista', //determina qual a conquista vai receber
                            style: TextStyle(// configurações visuais das conquistas
                              fontSize: 18,
                              fontWeight: FontWeight.bold,//determina que o texto fique em negrito
                              color: Colors.orange, //determina a cor do texto da conquista
                            ),
                          ),
                          SizedBox(height: 20), //determina a altura do ranking
                          Text(
                            'Ranking:',
                            style: TextStyle( // configurações visuais do ranking
                              fontSize: 22,//tamanho
                              fontWeight: FontWeight.bold, // estilo de texto
                            ),
                          ),
                          SizedBox(height: 10),
                          // Lista todos os jogadores e suas pontuações.
                          ...ranking.map(
                            (j) => Text('${j.nome} - ${j.pontos} pontos'), // função que mostra o nome do jogador e sua pontuação
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: reiniciarQuiz, // Botão de recomeçar.
                            child: Text('Recomeçar'),
                          ),
                        ],
                      )
                      : Column(
                        // Tela de perguntas do quiz.
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            perguntas[perguntaAtual]['pergunta'],// configurações para que as perguntas apareçam
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,//tamanho da pergunta
                              color: Colors.deepPurple[900], //cor da pergunta
                            ),
                          ),
                          SizedBox(height: 20),
                          // Gera os botões das opções da pergunta atual.
                          ...(perguntas[perguntaAtual]['opcoes'] //configuração para que as opções apareçam
                                  as List<String>)
                              .map((opcao) { //map usado pra trazer a ton os elemento de uma lista 
                                Color? corBotao;
                                //configurar os botões da cor dos botões das respostas
                                return Padding(
                                  padding: const EdgeInsets.symmetric( // deixar os botões de opção alihados e assimetricos 
                                    vertical: 4.0,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          corBotao ?? Colors.purple,//determina a cor do botão de opção 
                                      foregroundColor: Colors.white,//cor do texto das opções
                                      padding: EdgeInsets.symmetric( // configuração para alinhar o texto dentro dos botões
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),

                                    // percebe a utilização do botão e envia a opção selecionada para a verificarResposta
                                    onPressed: //serve para definir a ação ao pressionar o botão
                                        respostaSelecionada == null 
                                            ? () => verificarRespostas(opcao)
                                            : null,
                                    child: Text(opcao),
                                  ),
                                );
                              }),
                          SizedBox(height: 20),
                          // Exibe mensagem de acerto/erro.
                          if (mensagem != null)
                            Text(
                              mensagem!,
                              style: TextStyle( // configuração visual dos feedbacks da resposta 
                                fontSize: 16,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          SizedBox(height: 20),
                          Text( // configurações visuais dos pontos no decorrer das questões
                            'Pontuação: $pontos',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                  : Padding(
                    // Tela inicial, antes do quiz começar.
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Digite seu nome para começar:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 50), // espaçamento da altura do titulo
                        TextField(
                          controller:
                              nomeController, // Controlador do campo de nome.
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (nomeController.text.trim().isNotEmpty) {
                              iniciarQuiz(); // Inicia o quiz ao clicar.
                            }
                          },
                          child: Text('Iniciar Quiz'),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
