# Consumindo dados de uma API (dart)

Agora que já vimos como funciona uma API Rest na teoria, vamos construir um código que consuma os dados da API vista no artigo passado.

## Configurando Projeto

### Criando Projeto

Para tornar mais simples o entendimento trabalharemos inicialmente com o dart puro no nosso projeto, para isso crie um projeto dart colando a linha abaixo no terminal dentro do diretório desejado.

```bash
dart create consume_api
```

### Instalando dependências

Para fazer as requisições utilizaremos uma biblioteca chamada `http` , para fazer sua instalação abra o arquivo `pubspec.yaml` e adicione, dependência como mostrado abaixo e pressione 

`Ctrl + S` para instalar.

![Untitled](Consumindo%20dados%20de%20uma%20API%20(dart)%20c647c721270b47eaa2b6932ee74a1d6d/Untitled.png)

## Construindo o Projeto

Iremos construir o código no arquivo `bin/consume_api.dart` .

![Untitled](Consumindo%20dados%20de%20uma%20API%20(dart)%20c647c721270b47eaa2b6932ee74a1d6d/Untitled%201.png)

Adicionando Dependências:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
```

### Função que consome os dados da API

Para lidar com a API criaremos uma função `**assíncrona**` que irá consultar uma rota e nos trazer a resposta.

Podemos perceber que o tipo da função é `**Future<Album>**` oque quer dizer que ela retorna um possível objeto album caso não tenhamos nenhum erro.

O `**async**` logo após o nome da função quer dizer que a função é assíncrona, métodos `**assíncronos**` não respondem imediatamente, essas funções são utilizadas quando queremos que nosso código espere um pouco antes de ir para o próximo passo, no nosso caso queremos esperar até que a API responda nossa requisição.

Quando utilizamos `await` queremos que o código espere até que seja retornada uma resposta daquela linha.

```dart
Future<Album> fetchAlbum() async {
	// fazendo a requisição do album com id = 1
  final response = await http 
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
	
  if (response.statusCode == 200) { // se deu certo
    final info = Album.fromJson(jsonDecode(response.body)); 
    return info; // retorna o album
  } else { 
    throw Exception('Failed to load album'); // retorn um erro
  }
}
```

## Criando a classe Album

Como já vimos no artigo anterior recebemos um JSON do API, para tornar mais fácil a manipulação dessa informação a converteremos em um objeto Album.

```dart
class Album {
  final int userId;
  final int id;
  final String title;

  Album({ // Construtor
    required this.userId,
    required this.id,
    required this.title,
  });

	// Função para tranformar um JSon em um Album
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

	// Função para mostrar Album
  showAlbum() {
    return '''
      title: ${title}
      IdUser: ${userId} 
      Id: ${id} 
    ''';
  }
}
```

### Main

Adicionaremos a propriedade `async` na main para podermos utilizar o `await` .

```dart
void main() async {
  var myAlbum = await fetchAlbum();
  print(myAlbum.showAlbum());
}
```

Resultado:

![Untitled](Consumindo%20dados%20de%20uma%20API%20(dart)%20c647c721270b47eaa2b6932ee74a1d6d/Untitled%202.png)

Para fins de teste tire o `await` e perceba que ele não retorna mais um Album, mas sim um futuro album que é só uma promessa.

## Desafio

Para fixar a ideia vou propor um desafio simples, altere a função `fetchAlbum()` de forma que ela receba um id e retorne o album correspondente aquele id.

exemplo:

```dart
void main() async {
  var myAlbum = await fetchAlbumById(2);
  print(myAlbum.showAlbum());
}

/** console:
*			title: sunt qui excepturi placeat culpa
*		  IdUser: 1 
*		  Id: 2
*/
```

Dica: altere a url dentro da função `fetchAlbum()` para o id desejado por meio do operador `${}` .