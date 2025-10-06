import 'animal.dart';
import 'cachorro.dart';

void main(){
  Cachorro c1 = Cachorro("Vira-lata");
  Cachorro c2 = Cachorro("Pitbull");
  Cachorro c3 = Cachorro("Labrador");

  c1.fazerSom();
  c2.fazerSom();
  c3.fazerSom();

  Animal.exibirQuantidade();
}