// ===================================================================
// ATIVIDADE DE REVISÃO - SA02
// Lista de Compras
//
// Código baseado na estrutura fornecida pela professora.
// Foram completados os TODOs e melhorado apenas o visual da aplicação.
// ===================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

// ===================================================================
// APP PRINCIPAL
// ===================================================================

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',

      // Identidade visual
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D5A),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF6F8F7),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D5A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color(0xFFE5EAE7),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDDE5E1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDDE5E1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF2E7D5A),
              width: 2,
            ),
          ),
        ),
      ),

      home: const TelaLista(),
    );
  }
}

// ===================================================================
// TODO 1 - CLASSE / MODELO ITEM
// ===================================================================

// Cada objeto Item representa um produto da lista de compras.
class Item {
  String nome;
  int quantidade;
  bool comprado;

  Item({
    required this.nome,
    required this.quantidade,
    this.comprado = false,
  });
}

// ===================================================================
// TELA PRINCIPAL
// ===================================================================

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  // =================================================================
  // TODO 2 - LISTA QUE GUARDA OS ITENS
  // =================================================================

  final List<Item> itens = [
    Item(
      nome: 'Arroz',
      quantidade: 2,
    ),
    Item(
      nome: 'Leite',
      quantidade: 3,
    ),
    Item(
      nome: 'Pão',
      quantidade: 1,
    ),
  ];

  // Quantidade de itens marcados como comprados.
  int get quantidadeComprados {
    return itens.where((item) => item.comprado).length;
  }

  // =================================================================
  // TODO 3 - ABRIR TELA DE CADASTRO
  // =================================================================

  Future<void> abrirTelaAdicionar() async {
    // Navigator.push abre a segunda tela e espera um Item de volta.
    final Item? novoItem = await Navigator.push<Item>(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaAdicionarItem(),
      ),
    );

    // Caso o usuário tenha realmente salvo um item.
    if (novoItem != null) {
      setState(() {
        itens.add(novoItem);
      });

      // Feedback de item adicionado.
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF2E7D5A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${novoItem.nome} adicionado à lista',
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // =================================================================
  // TODO 4 - REMOVER ITEM
  // =================================================================

  void removerItem(int indice) {
    // Guardamos o item antes de remover para usar o nome no SnackBar.
    final Item itemRemovido = itens[indice];

    setState(() {
      itens.removeAt(indice);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF3D4742),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${itemRemovido.nome} removido da lista',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =================================================================
  // ESTRUTURA VISUAL DA TELA
  // =================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===============================================================
      // APPBAR
      // ===============================================================

      appBar: AppBar(
        toolbarHeight: 74,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de Compras',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Organize o que precisa comprar',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),

        // =============================================================
        // TODO 5 - CONTADOR DE ITENS COMPRADOS
        // =============================================================

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              12,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$quantidadeComprados de ${itens.length} comprados',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ===============================================================
      // TODO 6 - LISTVIEW.BUILDER
      // ===============================================================

      body: itens.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 70,
                      color: Color(0xFFB4BDB8),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Sua lista está vazia',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34423B),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Toque no botão + para adicionar seu primeiro item.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF87938D),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    22,
                    20,
                    10,
                  ),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meus itens',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3933),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Marque os produtos que já comprou',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8A9690),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F3EC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shopping_basket_outlined,
                          color: Color(0xFF2E7D5A),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 100,
                    ),
                    itemCount: itens.length,

                    itemBuilder: (context, indice) {
                      final Item item = itens[indice];

                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),

                          // =================================================
                          // CHECKBOX
                          // =================================================

                          leading: Checkbox(
                            value: item.comprado,
                            activeColor: const Color(0xFF2E7D5A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (valor) {
                              setState(() {
                                item.comprado = valor!;
                              });
                            },
                          ),

                          // =================================================
                          // NOME DO ITEM
                          // =================================================

                          title: Text(
                            item.nome,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,

                              // Texto riscado quando comprado.
                              decoration: item.comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,

                              color: item.comprado
                                  ? const Color(0xFF9AA49F)
                                  : const Color(0xFF2C3832),
                            ),
                          ),

                          // =================================================
                          // QUANTIDADE
                          // =================================================

                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: item.comprado
                                        ? const Color(0xFFE5F3EC)
                                        : const Color(0xFFF1F3F2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Quantidade: ${item.quantidade}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: item.comprado
                                          ? const Color(0xFF2E7D5A)
                                          : const Color(0xFF69756F),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                if (item.comprado)
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 14,
                                        color: Color(0xFF2E7D5A),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Comprado',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF2E7D5A),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),

                          // =================================================
                          // ICONBUTTON DE REMOVER
                          // =================================================

                          trailing: IconButton(
                            tooltip: 'Remover item',
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                            ),
                            color: const Color(0xFFD9534F),
                            onPressed: () {
                              removerItem(indice);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

      // ===============================================================
      // TODO 7 - FLOATING ACTION BUTTON
      // ===============================================================

      floatingActionButton: FloatingActionButton(
        onPressed: abrirTelaAdicionar,
        backgroundColor: const Color(0xFF2E7D5A),
        foregroundColor: Colors.white,
        tooltip: 'Adicionar item',
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}

// ===================================================================
// TELA DE ADICIONAR ITEM
// ===================================================================

class TelaAdicionarItem extends StatefulWidget {
  const TelaAdicionarItem({super.key});

  @override
  State<TelaAdicionarItem> createState() => _TelaAdicionarItemState();
}

class _TelaAdicionarItemState extends State<TelaAdicionarItem> {
  // =================================================================
  // TODO 8 - TEXTEDITINGCONTROLLER
  // =================================================================

  final TextEditingController nomeController = TextEditingController();

  final TextEditingController quantidadeController =
      TextEditingController();

  // =================================================================
  // TODO 9 - FUNÇÃO SALVAR
  // =================================================================

  void salvar() {
    // Lê os textos digitados nos campos.
    final String nome = nomeController.text.trim();
    final String textoQuantidade = quantidadeController.text.trim();

    // Se o nome estiver vazio, avisa e não continua.
    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFD9534F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'Digite o nome do item.',
              ),
            ],
          ),
        ),
      );

      return;
    }

    // Converte a quantidade digitada.
    // Caso esteja vazia ou inválida, usa 1.
    int quantidade = int.tryParse(textoQuantidade) ?? 1;

    if (quantidade <= 0) {
      quantidade = 1;
    }

    // Cria um novo Item.
    final Item novoItem = Item(
      nome: nome,
      quantidade: quantidade,
    );

    // Navigator.pop fecha a tela e devolve o objeto.
    Navigator.pop(
      context,
      novoItem,
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    quantidadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===============================================================
      // APPBAR DA SEGUNDA TELA
      // ===============================================================

      appBar: AppBar(
        title: const Text(
          'Novo Item',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ===============================================================
      // CONTEÚDO
      // ===============================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabeçalho visual
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F3EC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF2E7D5A),
                    foregroundColor: Colors.white,
                    child: Icon(
                      Icons.add_shopping_cart,
                    ),
                  ),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adicionar à lista',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3832),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Informe o produto e a quantidade.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF68766F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // =========================================================
            // TODO 10 - TEXTFIELD NOME
            // =========================================================

            const Text(
              'Nome do item',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF46534D),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nomeController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Ex: Arroz',
                prefixIcon: Icon(
                  Icons.shopping_basket_outlined,
                  color: Color(0xFF2E7D5A),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // TODO 11 - TEXTFIELD QUANTIDADE
            // =========================================================

            const Text(
              'Quantidade',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF46534D),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ex: 2',
                prefixIcon: Icon(
                  Icons.numbers_rounded,
                  color: Color(0xFF2E7D5A),
                ),
              ),
              onSubmitted: (_) {
                salvar();
              },
            ),

            const SizedBox(height: 28),

            // =========================================================
            // TODO 12 - ELEVATEDBUTTON SALVAR
            // =========================================================

            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: salvar,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D5A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                icon: const Icon(
                  Icons.check,
                ),

                label: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}