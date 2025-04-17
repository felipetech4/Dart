import 'dart:io';
import 'Carro.dart';

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
        break;

      case 4:
        if (carros.isEmpty) {
          print("A lista de carros está vazia...");
        } else {
          stdout.write("Modelo a ser excluído: ");
          String modelo = stdin.readLineSync()!;

          for (Carro carro in carros) {
            if (carro.modelo == modelo) {
              carros.remove(carro);
              print("O modelo foi removido com sucesso!");
            } else {
              print("Modelo não encontrado...");
            }
            break;
          }
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
