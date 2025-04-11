class Produto{
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  void exibirDetalhes(){
    print("Produto: $nome");
    print("Preço: R\$${preco.toStringAsFixed(2)}");
    print("Qunatidade em estoque: $quantidade");
  }
}

void main(){
  Produto p1 = Produto("Farol Gol G5", 109.90, 5);
  p1.exibirDetalhes();
}