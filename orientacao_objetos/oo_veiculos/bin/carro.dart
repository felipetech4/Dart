import 'veiculo.dart';

class Carro extends Veiculo {
  Carro(String marca, String modelo, int ano) : super (marca, modelo, ano);

  @override
  void ligar() {
    super.ligado = true;
  }
}