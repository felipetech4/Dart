import 'veiculo.dart';

class CarroEsportivo extends Veiculo {
  bool _modoTurbo = false;
  //Construtor
  CarroEsportivo(String marca, String modelo, int ano)
    : super(marca, modelo, ano);
  //Getter
  bool get modoTurbo => _modoTurbo;
  //Setter
  set modoTurbo(bool estadoTurbo) {
    if (!estadoTurbo) {
      _modoTurbo = estadoTurbo;
    }
    if (estadoTurbo && ano >= 2015) {
      _modoTurbo = estadoTurbo;
    } else {
      print("Carros anteriores a 2015 não suportam modo turbo.");
    }
  }

  void ativarTurbo() {
    modoTurbo = true;
    print("Modo turbo ativado!");
  }

  void desativarTurbo() {
    modoTurbo = false;
    print("Modo turbo desativado...");
  }

  @override
  void exibirDetalhes() {
    super.exibirDetalhes();
    print("Modo turbo: ${_modoTurbo ? "Ativado" : "Desativado"}");
  }

  @override
  void ligar() {
    ligado = false;
  }
}
