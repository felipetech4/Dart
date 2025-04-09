import 'dart:io';

void main(){

print("Olá Mundo!");

int opcao = 1;

menu(opcao);

}

void menu(int opcao){
  
    print("********** MENU DE PRODUTOS **********");
    print("1 - Cadastrar");
    print("2 - Consultar");
    print("3 - Alterar");
    print("4 - Excluir");
    print("5 - Listar Todos");
    print("0 - Sair");
    print("**************************************");
  
  Map<String , double> mapaProdutos = {};

  stdout.write("Escolha uma opção: ");
  opcao = int.tryParse(stdin.readLineSync()!)?? 0;

  switch(opcao){
    case 1 :
    stdout.write("Digite o nome do produto a ser cadastrado: ");
    String produto = stdin.readLineSync()!;
    stdout.write("Digite o valor do produto: ");
    double valor = double.tryParse(stdin.readLineSync()!) ?? 0.00;
    cadastrarProduto(mapaProdutos, produto, valor);
    break;
  }
}

void cadastrarProduto(Map<String , double> mapaProdutos, String produto, double valor){
  mapaProdutos[produto] = valor;
  print("O produto '$produto' foi cadastrado com sucesso!");
}

void editarProduto(Map<String , double> mapaProdutos, String produto, double valor){
  mapaProdutos[produto] = valor;
  print("O produto '$produto' foi alterado com sucesso!");
}

void excluirProduto(Map<String , double> mapaProdutos, String produto){
  mapaProdutos.remove(produto);
  print("O produto '$produto' foi excluído com sucesso!");
}

void detalharProduto(Map<String , double> mapaProdutos, String produtoEntrada){
  mapaProdutos.forEach((produto, valor){
    if(produto == produtoEntrada){
      print("---------------------------------");
      print("Detalhes do Produto");
      print("---------------------------------");
      print("Produto: $produto | Valor: R\$${valor.toStringAsFixed(2)}");
    }
  });
}

void listarProdutos(Map<String , double> mapaProdutos){
  mapaProdutos.forEach((produto, valor){
    print("---------------------------------");
    print("---------------------------------");
    print("Lista de Produtos");
    print("---------------------------------");
    print("---------------------------------");
    print("Produto: $produto | Valor: R\$${valor.toStringAsFixed(2)}");
    print("---------------------------------");
  });
}

/*void voltarMenuPrincipal(){
    stdout.write("Voltar ao menu principaç.");
    int teste = int.tryParse(stdin.readLineSync()!)?? 0;

}
*/
/*
import 'dart:io';

void main() {
  Map<String, double> mapaProdutos = {
    "Farol de neblina gol G5": 109.90,
    "Lâmpada de Lanterna Traseira Fusca 1969": 399.90,
    "Seta Esquerda Siena 2007": 39.00
  };

  int opcao = -1;

  while (opcao != 0) {
    print("\n===== MENU =====");
    print("1 - Cadastrar produto");
    print("2 - Remover produto");
    print("3 - Listar produtos");
    print("0 - Sair");
    stdout.write("Escolha uma opção: ");
    opcao = int.tryParse(stdin.readLineSync()!) ?? -1;

    switch (opcao) {
      case 1:
        stdout.write("Digite o nome do produto: ");
        String produto = stdin.readLineSync()!;
        stdout.write("Digite o valor do produto: ");
        double valor = double.tryParse(stdin.readLineSync()!) ?? 0.0;
        cadastrarProduto(mapaProdutos, produto, valor);
        break;

      case 2:
        stdout.write("Digite o nome do produto a remover: ");
        String produto = stdin.readLineSync()!;
        removerProduto(mapaProdutos, produto);
        break;

      case 3:
        listarProdutos(mapaProdutos);
        break;

      case 0:
        print("Encerrando o programa...");
        break;

      default:
        print("Opção inválida. Tente novamente.");
    }
  }
}

void cadastrarProduto(Map<String, double> mapaProdutos, String produto, double valor) {
  mapaProdutos[produto] = valor;
  print("Produto '$produto' cadastrado com sucesso!");
}

void removerProduto(Map<String, double> mapaProdutos, String produto) {
  if (mapaProdutos.containsKey(produto)) {
    mapaProdutos.remove(produto);
    print("Produto '$produto' removido com sucesso!");
  } else {
    print("Produto '$produto' não encontrado.");
  }
}

void listarProdutos(Map<String, double> mapaProdutos) {
  if (mapaProdutos.isEmpty) {
    print("Nenhum produto cadastrado.");
  } else {
    print("\n--- Produtos em Estoque ---");
    mapaProdutos.forEach((produto, valor) {
      print("Produto: $produto | Valor: R\$${valor.toStringAsFixed(2)}");
    });
  }
}

*/