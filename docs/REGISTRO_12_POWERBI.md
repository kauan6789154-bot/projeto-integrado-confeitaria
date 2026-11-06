# Registro 12 - Power BI conectado ao MySQL

## Objetivo

Integrar o Power BI Desktop ao banco MySQL do projeto e desenvolver um dashboard gerencial para acompanhamento do estoque e das movimentações.

## Preparação do banco

Foram criadas duas views específicas para análise:

- `vw_bi_produtos`;
- `vw_bi_movimentacoes`.

As views concentram os relacionamentos e os campos necessários ao dashboard.

## Power Query

As views são importadas pelo Power BI e os tipos de dados são revisados no Power Query.

As consultas são renomeadas para:

- Produtos;
- Movimentacoes.

## Modelo

Relacionamentos principais:

- Produtos 1:N Movimentacoes;
- Calendario 1:N Movimentacoes.

## Indicadores

Foram definidos indicadores para:

- total de produtos;
- produtos críticos;
- percentual de produtos críticos;
- valor atual do estoque;
- quantidade atual;
- total de movimentações;
- entradas;
- saídas;
- saldo movimentado;
- valor estimado de entradas e saídas;
- última movimentação.

## Dashboard

O dashboard foi planejado em duas páginas:

1. Visão Geral;
2. Movimentações.

## Próxima etapa

Parte 13 - Fluxograma e documentação técnica.
