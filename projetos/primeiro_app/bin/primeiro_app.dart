import 'dart:io';

void main(){
  int opcao = -1;

  menu(opcao);
}

void menu(int opcao){
  Map<String , double> mapaProdutos = {};

  while(opcao != 0){
    print("********** MENU DE PRODUTOS **********");
    print("1 - Cadastrar");
    print("2 - Consultar");
    print("3 - Alterar");
    print("4 - Excluir");
    print("5 - Listar Todos");
    print("0 - Sair");
    print("--------------------------------------");

    stdout.write("Escolha uma opção: ");
    opcao = int.tryParse(stdin.readLineSync()!)?? 0;

    switch(opcao){
      case 1 :
      stdout.write("Digite o nome do produto a ser cadastrado: ");
      String produto = stdin.readLineSync()!;
      stdout.write("Digite o valor do produto: ");
      double valor = double.tryParse(stdin.readLineSync()!) ?? 0.00;
      cadastrarProduto(mapaProdutos, produto, valor);
      voltarMenu();
      break;

      case 2 :
      stdout.write("Digite o nome do produto a ser consultado: ");
      String produto = stdin.readLineSync()!;
      detalharProduto(mapaProdutos, produto);
      voltarMenu();
      break;

      case 3 : 
      stdout.write("Digite o nome do produto a ser alterado: ");
      String produtoAntigo = stdin.readLineSync()!;
      stdout.write("Digite o nome do produto atualizado: ");
      String produtoNovo = stdin.readLineSync()!;
      stdout.write("Digite o preço do produto '$produtoNovo': ");
      double valor = double.tryParse(stdin.readLineSync()!) ?? 0.00;
      editarProduto(mapaProdutos, produtoAntigo, produtoNovo, valor);
      voltarMenu();
      break;

      case 4 : 
      stdout.write("Digite o nome do produto a ser excluído: ");
      String produto = stdin.readLineSync()!;
      excluirProduto(mapaProdutos, produto);
      voltarMenu();
      break;

      case 5 :
      listarProdutos(mapaProdutos);
      voltarMenu();
      break;

      case 0 :
      print("Pressione ENTER para sair do programa...");
      stdin.readLineSync();

      default :
      print("Opção Inválida... Tente novamente!");
      stdin.readLineSync();
    }
  }
}

void cadastrarProduto(Map<String , double> mapaProdutos, String produto, double valor){
  mapaProdutos[produto] = valor;
  print("************************************************");
  print("O produto '$produto' foi cadastrado com sucesso!");
  print("************************************************");
}

void editarProduto(Map<String , double> mapaProdutos, String produtoAntigo, String produtoNovo, double valor){
  mapaProdutos.remove(produtoAntigo);
  mapaProdutos[produtoNovo] = valor;
  print("*************************************************************************");
  print("Produto alterado para '$produtoNovo' e o seu preço atual é R\$${valor.toStringAsFixed(2)}");
  print("*************************************************************************");
}

void excluirProduto(Map<String , double> mapaProdutos, String produto){
  mapaProdutos.remove(produto);
  print("************************************************");
  print("O produto '$produto' foi excluído com sucesso!");
  print("************************************************");
}

void detalharProduto(Map<String , double> mapaProdutos, String produtoEntrada){
  mapaProdutos.forEach((produto, valor){
    if(produto == produtoEntrada){
      print("---------------------------------");
      print("Detalhes do Produto");
      print("---------------------------------");
      print("Descrição: $produto | Valor: R\$${valor.toStringAsFixed(2)}");
      print("---------------------------------");
    }
  });
}

void listarProdutos(Map<String , double> mapaProdutos){
    print("---------------------------------");
    print("Lista de Produtos");
    mapaProdutos.forEach((produto, valor){
    print("---------------------------------");
    print("Descrição: $produto | Valor: R\$${valor.toStringAsFixed(2)}");
  });
}

void voltarMenu(){
  print("Pressione ENTER para voltar ao menu inicial...");
  stdin.readLineSync();
}