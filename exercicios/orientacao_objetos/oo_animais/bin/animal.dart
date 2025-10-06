abstract class Animal {
  static int quantidadeCriada = 0;

  Animal(){
    quantidadeCriada++;
  }

  void fazerSom();

  static void exibirQuantidade(){
    print("Total de animais criados: $quantidadeCriada");
  }
}