# Controle Financeiro

Um aplicativo Flutter para controle de despesas e receitas mensais, com foco em alertas de vencimento.

## Funcionalidades

### 📊 Dashboard Principal
- **Saldo Atual**: Mostra o saldo disponível no momento
- **Limite Disponível**: Calcula o saldo esperado para o final do mês
- **Indicador Visual**: Ícones que mostram se o saldo vai aumentar ou diminuir

### ⚠️ Alertas de Vencimento
- **Despesas Vencidas**: Destaque vermelho para contas em atraso
- **Próximas ao Vencimento**: Alerta laranja para contas que vencem em 0-1 dias
- **Ação Rápida**: Botão para marcar como pago diretamente na lista

### 📈 Resumo Financeiro Completo
- Total Pago no mês
- Total Recebido no mês  
- Restante a Pagar
- Restante a Receber
- Total de Despesas do mês
- Total de Receitas do mês

### 🎨 Interface Moderna
- Material Design 3
- Cores intuitivas (verde para receitas, vermelho para despesas)
- Cards com elevação e bordas arredondadas
- Gradientes no cartão principal
- Pull-to-refresh

## Como Executar

### Pré-requisitos
- Flutter SDK instalado
- Android Studio configurado
- Emulador Android ou dispositivo físico

### Passos
1. Clone ou baixe o projeto
2. Abra o terminal na pasta do projeto
3. Execute: `flutter pub get`
4. Execute: `flutter run`

## Estrutura do Projeto

```
lib/
├── modelos/
│   ├── movimentacao.dart      # Modelo de dados para despesas/receitas
│   └── resumo_financeiro.dart # Modelo para resumo mensal
├── servicos/
│   └── servico_financeiro.dart # Lógica de negócio e dados mock
├── telas/
│   └── tela_principal.dart    # Tela principal do app
├── widgets/
│   ├── cartao_saldo.dart      # Widget do saldo atual/projetado
│   ├── cartao_resumo.dart     # Widget do resumo financeiro
│   └── lista_movimentacoes.dart # Widget para listas de despesas/receitas
└── main.dart                  # Ponto de entrada da aplicação
```

## Dados de Exemplo

O app vem com dados mockados para demonstração:
- Despesas: Conta de luz, internet, cartão de crédito, aluguel, supermercado
- Receitas: Salário, freelance, extra
- Diferentes status: pago, pendente, vencido
- Datas variadas para testar os alertas

## Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Material Design 3**: Sistema de design
- **Dart**: Linguagem de programação

## Características Técnicas

- Arquitetura simples
- Separação de responsabilidades
- Widgets reutilizáveis
- Gerenciamento de estado com StatefulWidget
- Padrão Singleton para o serviço
- Código documentado

## Próximas Funcionalidades

- Filtros por período
- Gráficos de gastos
- Categorização de despesas
- Persistência de dados local