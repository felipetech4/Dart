import 'dart:io';

void main(){

}

void menu(int opcao){

  print("********** MENU **********");
  
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