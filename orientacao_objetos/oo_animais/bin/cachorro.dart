import 'animal.dart';

class Cachorro extends Animal {
  late String raca;
  late bool adestrado;

  Cachorro(this.raca, {this.adestrado = false});

  @override
  void fazerSom() {
    print("AuAu! (Raça: $raca, Adestrado: $adestrado)");
  }
}
