import 'dart:io';

class Produto{
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  void exibirDetalhes(){
    print("Produto: $nome");
    print("Preço: R\$${preco.toStringAsFixed(2)}");
    print("Quantidade em estoque: $quantidade");
  }

  void reporEstoque(int qtd){
    quantidade += qtd;
    print("Reposição realizada. Estoque atualizado para $quantidade unidades.");
  }

  void vender(int qtd){
    if(qtd <= quantidade){
      quantidade -= qtd;
      print("Venda realizada. $qtd unidade(s) vendida(s). Estoque agora com $quantidade.");
    }else{
      print("Estoque insuficiente para vender $qtd unidades.");
    }
  }

  void menuProduto(){
    int opcao = -1;
    while(opcao != 0){
      print("********** MENU DE PRODUTO **********");
      print("1 - Exibir Produto");
      print("2 - Repor Estoque");
      print("3 - Vender Produto");
      print("0 - Sair...");

      stdout.write("Digite uma opção: ");
      opcao = int.tryParse(stdin.readLineSync()!)?? 0;

      switch (opcao){
        case 1 :
        exibirDetalhes();
        voltarMenu();
        break;

        case 2 :
        stdout.write("Digite a quantidade a repor: ");
        int qtd = int.tryParse(stdin.readLineSync()!) ?? 0;
        reporEstoque(qtd);
        voltarMenu();
        break;

        case 3 :
        stdout.write("Digite a quantidade a ser vendida: ");
        int qtd = int.tryParse(stdin.readLineSync()!) ?? 0;
        vender(qtd);
        voltarMenu();
        break;

        case 0 :
        print("Saindo do menu de produtos...");
        stdin.readLineSync();
        break;

        default :
        print("Opção inválida. Tente novamente!");
        stdin.readLineSync();
        break;
      }
    }
  }

  void voltarMenu(){
    stdout.write("Digite ENTER para voltar ao menu de produtos...");
    stdin.readLineSync();
  }
}