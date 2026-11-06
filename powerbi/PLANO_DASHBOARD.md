# Plano do Dashboard - Parte 12

## Página 1 - Visão Geral

### Cards
1. **Valor Atual do Estoque**
2. **Total Produtos**
3. **Produtos Críticos**
4. **% Produtos Críticos**
5. **Total Movimentações**

### Gráficos
- **Gráfico de barras:** Valor Atual do Estoque por `categoria`
- **Gráfico de rosca:** Produtos por `status_estoque`
- **Tabela:** produtos críticos com:
  - produto
  - categoria
  - fornecedor
  - quantidade_estoque
  - estoque_minimo

### Segmentadores
- categoria
- fornecedor

---

## Página 2 - Movimentações

### Cards
1. **Total Entradas**
2. **Total Saídas**
3. **Saldo Movimentado**
4. **Última Movimentação**

### Gráficos
- **Gráfico de colunas:** Total Entradas e Total Saídas por `Calendario[Ano Mes]`
- **Gráfico de barras:** quantidade por categoria e tipo
- **Tabela detalhada:**
  - data_hora
  - tipo
  - produto
  - quantidade
  - unidade_medida
  - motivo
  - usuario
  - perfil

### Segmentadores
- Calendario[Date]
- tipo
- categoria
- usuario

---

## Modelo de relacionamentos

Use:

```text
Produtos[id_produto]            1  ----  *  Movimentacoes[id_produto]
Calendario[Date]                1  ----  *  Movimentacoes[data_movimentacao]
```

Direção de filtro: simples, da dimensão para a fato.

Não crie relacionamento bidirecional nesta etapa.
