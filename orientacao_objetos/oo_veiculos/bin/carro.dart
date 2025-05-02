import 'veiculo.dart';

class Carro extends Veiculo {
  Carro(super.marca, super.modelo, super.ano);

  @override
  void ligar() {
    super.ligado = true;
  }
}