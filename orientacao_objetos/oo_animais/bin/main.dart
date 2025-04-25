import 'animal.dart';
import 'cachorro.dart';
import 'gato.dart';


void main(){
  List<Animal> animais = [];

  animais.add(Cachorro());
  animais.add(Gato());
  animais.add(Cachorro());

  for(Animal animal in animais){
    animal.fazerSom();
  }
}