abstract class Veiculo{
  late String _marca;
  late String _modelo;
  late int _ano;
  late bool ligado;

  //Construtor
  Veiculo(String marca, String modelo, int ano){
    this.marca = marca;
    this.modelo = modelo;
    this.ano = ano;
  }

  //Getters
  String get marca => _marca;
  String get modelo => _modelo;
  int get ano => _ano;

  //Setters
  set marca(String novaMarca){
    if(novaMarca.isNotEmpty){
      _marca = novaMarca;
    }
  }

  set modelo(String novoModelo){
    if(novoModelo.isNotEmpty){
      _modelo = novoModelo;
    }
  }

  set ano(int novoAno){
    if(novoAno >= 1900 && novoAno <= DateTime.now().year){
      _ano = novoAno;
    }
  }

  void exibirDetalhes(){
    print("Marca: $_marca");
    print("Modelo: $_modelo");
    print("Ano: $_ano");
  }

  //Método abstrato
  void ligar();
}