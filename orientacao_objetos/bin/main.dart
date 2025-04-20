import 'dart:io';
import 'Carro.dart';
import 'package:collection/collection.dart';

void main() {
  List<Carro> carros = [];
  int opcao = -1;

  while (opcao != 0) {
    print("\n==== MENU DE CARROS ====");
    print("1 - Adicionar");
    print("2 - Listar Todos");
    print("3 - Busca por modelo");
    print("4 - Remover carro");
    print("5 - Editar informações do carro");
    print("0 - Sair");

    stdout.write("Escolha: ");
    opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        stdout.write("Marca: ");
        String marca = stdin.readLineSync()!;
        stdout.write("Modelo: ");
        String modelo = stdin.readLineSync()!;
        stdout.write("Ano: ");
        int ano = int.tryParse(stdin.readLineSync()!) ?? 0;

        Carro c1 = Carro(marca, modelo, ano);
        carros.add(c1);
        print("O carro $modelo foi adicionado com sucesso!");
        voltarMenu();
        break;

      case 2:
        print("\n== Lista de Carros ==");
        if (carros.isEmpty) {
          print("Lista vazia...");
        } else {
          for (Carro carro in carros) {
            carro.exibirDetalhes();
            print("----------------------");
          }
        }
        voltarMenu();
        break;

      case 3:
        if(carros.isEmpty){
          print("Lista de carros está vazia.");
        }else{
          stdout.write("Digite o modelo a ser buscado: ");
          String busca = stdin.readLineSync()!.toLowerCase();

          List<Carro> encontrados = carros.where((carro) => carro.modelo.toLowerCase().contains(busca)).toList();

          if(encontrados.isEmpty){
            print("Nenhum carro encontrado :(");
          }else{
            for(Carro carro in encontrados){
              carro.exibirDetalhes();
              print("----------------------");
            }
          }
        }
        voltarMenu();
        break;

      case 4:
        if (carros.isEmpty) {
          print("A lista de carros está vazia...");
        } else {
          int quantidadeInicial = carros.length;
          stdout.write("Modelo a ser excluído: ");
          String modelo = stdin.readLineSync()!;

          carros.removeWhere((carro) => carro.modelo == modelo);

          if(carros.length < quantidadeInicial){
            print("Carro removido com sucesso!");
          }else{
            print("Carro não encontrado");
          }
        }
        voltarMenu();
        break;

      case 5 :
        stdout.write("Digite o nome do modelo a ser alterado: ");
        String modelo = stdin.readLineSync()!;

        Carro? carroEncontrado = carros.firstWhereOrNull((carro) => modelo == carro.modelo);

        if(carroEncontrado != null){
          stdout.write("Marca atual: ${carroEncontrado.marca} | Nova marca: ");
          String novaMarca = stdin.readLineSync()!;
          stdout.write("Marca atual: ${carroEncontrado.marca} | Nova marca: ");
          String novoModelo = stdin.readLineSync()!;
          stdout.write("Marca atual: ${carroEncontrado.marca} | Nova marca: ");
          int novoAno = int.tryParse(stdin.readLineSync()!) ?? 0;

          carroEncontrado.marca = novaMarca;
          carroEncontrado.modelo = novoModelo;
          carroEncontrado.ano = novoAno;

          print("Carro atualizado com sucesso!");
        }else{
          print("Carro não encontrado.");
        }

        voltarMenu();
        break;

      case 0:
        print("Sair...");
        break;

      default:
        print("Opção inválida");
        break;
    }
  }
}

void voltarMenu() {
  stdout.write("Digite ENTER para voltar ao menu inicial...");
  stdin.readLineSync();
}
