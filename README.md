# 📌 List Windows - Todo List & Pomodoro Flutuante

**List Windows** é um aplicativo de produtividade minimalista desenvolvido em **Flutter** voltado para o sistema operacional Windows Desktop. O grande diferencial do aplicativo é a sua interface híbrida flutuante que se posiciona sempre no topo da tela, permitindo que você acompanhe suas tarefas e seu tempo de foco sem interromper seu fluxo de trabalho.

---

## ✨ Funcionalidades Principais

### 🫧 1. Janela Flutuante & Interativa
*   **Always-on-Top & Frameless:** O aplicativo roda em uma janela sem bordas nativas (`frameless`), com fundo translúcido e sempre no topo de outras janelas, garantindo visibilidade contínua.
*   **Arraste Livre:** Arraste facilmente a bolha minimizada ou a barra de título da janela expandida para qualquer posição na sua área de trabalho.
*   **Expansão Inteligente:** Alterne instantaneamente entre o modo bolha (compacto) e o modo expandido (painel detalhado) com um simples clique.

### 🔴 2. Modo Minimizado (Collapsed View)
*   **Bolha Compacta (80x80 px):** Uma bolha sutil que não obstrui sua tela.
*   **Progresso Visual:**
    *   Quando o **timer Pomodoro está ativo**, o círculo ao redor da bolha mostra o progresso do tempo restante de foco ou pausa.
    *   Quando o **timer está inativo**, o círculo exibe a porcentagem de conclusão das suas tarefas atuais.
*   **Contador Dinâmico:** Uma badge vermelha indica o número exato de tarefas pendentes.
*   **Alertas de Fim de Timer:** Ao terminar o ciclo do Pomodoro, a bolha pulsa visualmente para capturar sua atenção de forma sutil.

### 📋 3. Modo Expandido (Expanded View)
*   **Painel Glassmorphism (320x480 px):** Um design escuro premium com bordas brilhantes e transparência elegante.
*   **Duas Abas Principais:**
    *   **Tarefas (Todo List):**
        *   **Sub-tarefas Integradas:** Crie sub-tarefas para organizar grandes metas em pequenos passos. As tarefas mostram um contador numérico de progresso (ex: `1/3`).
        *   **Sincronização de Conclusão:** Ao marcar a tarefa principal, todas as suas sub-tarefas são marcadas automaticamente. Se você completar individualmente todas as sub-tarefas, a tarefa pai é marcada como concluída de forma automática.
        *   **Adição e Remoção Rápida:** Atalho intuitivo para adicionar tarefas e sub-tarefas com facilidade.
        *   **Visualização Expansível:** Cada item da lista pode ser colapsado ou expandido para exibir suas sub-tarefas apenas quando necessário.
    *   **Timer (Pomodoro):**
        *   **Modos Pré-definidos:** Foco (25 min), Pausa Curta (5 min) e Pausa Longa (15 min).
        *   **Controles Completos:** Play, Pause, Reset e atalho para pular o ciclo atual (Skip).
        *   **Foco Automático:** Quando o timer chega a zero, o aplicativo traz a janela automaticamente para o primeiro plano da tela para notificá-lo.

---

## 🛠️ Arquitetura e Estrutura do Projeto

O projeto adota o padrão de arquitetura **MVVM (Model-View-ViewModel)** com gerenciamento de estado nativo, garantindo um código limpo, reativo e de fácil manutenção.

```
lib/
├── main.dart                 # Inicialização da janela (window_manager) e app
├── models/
│   ├── todo_item.dart        # Modelo de dados para Tarefas principais
│   └── sub_task.dart         # Modelo de dados para as Sub-tarefas
├── viewmodels/
│   ├── todo_viewmodel.dart   # Gerenciamento de estado e lógica das tarefas
│   └── timer_viewmodel.dart  # Lógica do cronômetro Pomodoro
└── views/
    ├── floating_todo_app.dart # Controlador central da expansão/tabs
    ├── collapsed_view.dart    # Interface da bolha flutuante compacta
    ├── expanded_view.dart     # Painel principal expandido
    └── widgets/               # Componentes visuais auxiliares (tiles, timer, tab)
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado na máquina.
*   Suporte ao desenvolvimento Windows habilitado no Flutter (`flutter config --enable-windows-desktop`).

### Passos para Rodar

1.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

2.  **Execute o aplicativo em modo de desenvolvimento:**
    ```bash
    flutter run -d windows
    ```

3.  **Gerar o executável de produção (.exe):**
    ```bash
    flutter build windows
    ```
    O executável final e suas dependências compiladas serão gerados no diretório:
    `build\windows\x64\runner\Release\`

---

## 📦 Tecnologias & Bibliotecas Utilizadas

*   **Flutter (Dart):** Framework principal para construção da interface multiplataforma.
*   **window_manager:** Gerenciamento avançado do comportamento da janela Windows (posicionamento, transparência, dimensões dinâmicas, comportamento de arrastar, sempre no topo).
*   **Material Design:** Ícones e componentes estilizados para o design de sistema.
