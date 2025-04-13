import 'dart:io';
import 'Carro.dart';

void main(){
  List<Carro> carros = [];
  int opcao = -1;

  while(opcao != 0){
     print("\n==== MENU DE CARROS ====");
     print("1 - Adicionar");
     print("2 - Listar Todos");
     print("3 - Busca por modelo");
     print("4 - Remover carro");
     print("5 - Editar informações do carro");
     print("0 - Sair");

     stdout.write("Escolha: ");
     opcao = int.parse(stdin.readLineSync()!);

     switch(opcao){
      case 1 :
      stdout.write("Marca: ");
      String marca = stdin.readLineSync()!;
      stdout.write("Modelo: ");
      String modelo = stdin.readLineSync()!;
      stdout.write("Ano: ");
      int ano = int.tryParse(stdin.readLineSync()!)?? 0;

      Carro c1 = Carro(marca, modelo, ano);
      carros.add(c1);
      print("O carro $modelo foi adicionado com suceso!");

      break;

      case 2 :
      print("\n== Lista de Produtos ==");
      if(carros.isEmpty){
        print("Lista vazia...");
      }else{
         for(Carro carro in carros){
          carro.exibirDetalhes();
          print("----------------------");
         }
      }
      break;

      case 3 :
      

      case 0 :
      print("Sair...");
      break;

      default : 
      print("Opção inválida");
      break;
     }
  }
}