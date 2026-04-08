# Plano de Implementação — Integração de Melhorias ao ZionKit v0.6

**Data:** 2026-04-08  
**Documento-alvo:** docs/zionkit-model.md (v0.6)

---

## Visão Geral das Fases

| Fase | Melhorias incluídas | Justificativa de agrupamento |
|------|---------------------|------------------------------|
| 1 — Correções Estruturais de Governança | Melhoria 1 (Fluxo de Rejeição) e Melhoria 2 (Tabela de Papéis) | Correções fundacionais sem dependências entre si. A Melhoria 1 define um mecanismo novo (rejeição) que é pré-requisito para que a Melhoria 4 (janela de veto) faça sentido completo. A Melhoria 2 é uma correção factual independente. Ambas devem ser integradas primeiro para estabilizar a base. |
| 2 — Versionamento por Estrangulamento | Melhoria 3 (Semântica de Transições) e Melhoria 7 (Limiar de Ativação) | Ambas tratam do guardrail de Versionamento Gradual por Estrangulamento. A Melhoria 3 define semânticas de conclusão, cancelamento e concorrência; a Melhoria 7 define o critério de ativação. São complementares e afetam os mesmos trechos do documento. |
| 3 — Comportamento de Janela de Veto e Ciclos de Vida | Melhoria 4 (Expiração da Janela de Veto), Melhoria 5 (Ciclo de Vida de Hotspots) e Melhoria 6 (Ciclo de Vida de Anotações) | A Melhoria 4 complementa a Melhoria 1 (rejeição = ação; expiração = inação). As Melhorias 5 e 6 tratam de ciclos de vida de metadados análogos (hotspots e anotações), com mecanismos similares (revisão via Canon Building). As três dependem da estabilização dos gates feita na Fase 1. |

---

## Pré-requisitos e Dependências entre Fases

```
Fase 1 ──► Fase 2 ──► Fase 3
```

**Fase 1 → Fase 2:** A Melhoria 3 (semântica do Strangler Fig) referencia indiretamente os gates de aprovação. A definição do fluxo de rejeição (Melhoria 1) deve estar integrada antes para que referências a "aprovação ou abandono" no contexto do versionamento sejam consistentes.

**Fase 2 → Fase 3:** A Melhoria 7 (limiar de ativação) define o papel do Architect na decisão de ativar o Strangler Fig. A Melhoria 4 (janela de veto) trata o comportamento de expiração em gates onde o Architect atua. Integrar o limiar antes evita reescritas na seção 2.2.5 durante a Fase 3.

**Dentro de cada fase:** As melhorias dentro de uma mesma fase são independentes entre si e podem ser integradas em qualquer ordem interna.

---

## Fase 1 — Correções Estruturais de Governança

### Melhoria 1 — Fluxo de Rejeição de Canonical Change Plans

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 1.1 | Seção 2.2, parágrafo introdutório (gates de aprovação) | Direto — é onde o modelo define a mecânica geral de aprovação. O fluxo de rejeição deve ser definido aqui como complemento ao fluxo de aprovação. |
| 1.2 | Seção 2.2.1, parágrafo final (aprovação do discovery-plan) | Direto — gate de aprovação da Domain Discovery Session. Deve refletir a possibilidade de rejeição com devolução. |
| 1.3 | Seção 2.2.2, parágrafo final (aprovação do constitution-plan) | Direto — gate de aprovação da Technical Constitution Session. Mesmo tratamento. |
| 1.4 | Seção 2.2.3, parágrafo final (aprovação do specification-plan) | Direto — gate de aprovação da Requirements Specification Session. Mesmo tratamento. |
| 1.5 | Seção 2.2.6, subseção "`expert-edit-plan` e Aprovação Sequencial" | Direto — aprovação sequencial da edição direta. A rejeição aqui tem particularidades: aprovação do Architect é obrigatória e não delegável. |
| 1.6 | Seção 2.3.4 (Aprovação Condicional da Etapa 2) | Direto — aprovação do incremental-plan. Deve contemplar rejeição. |
| 1.7 | Seção 8, princípio "Governança por cerimônia" | Indireto — o princípio menciona "gate de aprovação". A definição de gate fica mais completa com o caminho de rejeição, mas o texto atual não precisa de alteração significativa — apenas confirmar que o princípio se sustenta. |
| 1.8 | Seção 9.5 (Disponibilidade de aprovadores) | Indireto — a rejeição com resubmissão pode agravar a demanda sobre aprovadores. Deve ser mencionada como cenário. |
| 1.9 | Diagrama da seção 3 (O Ciclo Completo) | Indireto — o diagrama mostra os gates mas não mostra rejeição. Avaliar se o diagrama precisa de ajuste. |
| 1.10 | Seção 10, prioridade 4 (Validação de Canonical Change Plans) | Indireto — menciona aprovação por aprovadores reais. Deve contemplar o teste do fluxo de rejeição. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 1.1 (Seção 2.2, introdução) | **Extensão natural de parágrafo existente.** Adicionar, após a frase sobre aprovação primária e secundária, a definição do fluxo de rejeição como regra complementar. | O parágrafo introdutório já define a mecânica geral dos gates. A rejeição é o complemento natural — inserir aqui evita criar subseção nova para algo que é parte integrante da mecânica de gates. |
| 1.2–1.4 (Seções 2.2.1, 2.2.2, 2.2.3) | **Sem alteração.** Os parágrafos finais dessas seções descrevem aprovação e habilitação da próxima cerimônia. A regra geral de rejeição definida em 2.2 se aplica uniformemente — não é necessário repetir em cada cerimônia. | Repetir a mecânica de rejeição em cada cerimônia seria redundante e contrário à uniformidade da regra. A definição geral em 2.2 é suficiente. |
| 1.5 (Seção 2.2.6) | **Extensão natural de parágrafo existente.** Adicionar, no final da subseção de aprovação sequencial, o comportamento de rejeição no contexto específico da edição direta. | A aprovação sequencial da edição direta já tem particularidades (ordem fixa, Architect não delegável). A rejeição nesse contexto deve especificar para qual ponto o Change Plan retorna. |
| 1.6 (Seção 2.3.4) | **Extensão natural de parágrafo existente.** Adicionar, após a descrição de aprovação condicional, o comportamento de rejeição do incremental-plan. | A aprovação condicional já é descrita em detalhe. A rejeição é o caminho complementar. |
| 1.7 (Seção 8) | **Sem alteração.** O princípio "Governança por cerimônia" menciona "gate de aprovação e rastreabilidade" — a rejeição com registro no histórico é consistente com esse texto sem necessidade de alteração. | O princípio é suficientemente genérico para acomodar a rejeição sem reescrita. |
| 1.8 (Seção 9.5) | **Extensão natural de parágrafo existente.** Adicionar menção ao cenário de rejeição-resubmissão como fator adicional de demanda. | O risco de disponibilidade de aprovadores já é discutido. A rejeição-resubmissão é um agravante que cabe em uma frase adicional. |
| 1.9 (Diagrama da seção 3) | **Sem alteração.** O diagrama é um resumo visual do fluxo principal. Adicionar caminhos de rejeição (setas de retorno) complicaria a visualização sem benefício proporcional — o fluxo de rejeição está documentado textualmente na seção 2.2. | Diagramas de fluxo com múltiplos caminhos de retorno perdem legibilidade. A documentação textual é suficiente. |
| 1.10 (Seção 10, prioridade 4) | **Extensão natural de parágrafo existente.** Adicionar ao escopo do teste a validação do fluxo de rejeição. | A prioridade 4 já trata de "Validação de Canonical Change Plans por aprovadores reais" — o teste de rejeição é extensão natural. |

#### C. Especificação da Mudança

**Trecho 1.1 — Seção 2.2, parágrafo introdutório dos gates**

Localização: após a frase "Somente após a aprovação do Change Plan de uma cerimônia a próxima cerimônia é habilitada."

Inserir o seguinte parágrafo:

> Toda rejeição — primária ou secundária — é uma devolução do Canonical Change Plan ao contexto da cerimônia de origem, com motivo em texto livre registrado no histórico. O Change Plan retorna ao estado "em elaboração". O autor decide se revisa e resubmete ou abandona. A cerimônia subsequente permanece bloqueada até aprovação ou abandono explícito. O abandono é registrado no histórico com motivo. Não há rejeição parcial: o Change Plan é devolvido como unidade. Essa regra se aplica uniformemente a todos os gates de aprovação no modelo.

**Trecho 1.5 — Seção 2.2.6, subseção "`expert-edit-plan` e Aprovação Sequencial"**

Localização: após o parágrafo que descreve a ordem de aprovação (Domain Expert primeiro, Architect depois) e sua justificativa.

Inserir o seguinte parágrafo:

> Se o Domain Expert rejeita o `expert-edit-plan`, o Change Plan retorna ao ciclo iterativo de guardrails — o Domain Expert pode revisar a edição original e resubmeter. Se o Architect rejeita, o Change Plan retorna ao Domain Expert com o motivo do Architect registrado — o Domain Expert decide se ajusta a edição (potencialmente com novo ciclo de guardrails) e resubmete, ou abandona. Em ambos os casos, a rejeição segue a regra geral de devolução com motivo registrado no histórico.

**Trecho 1.6 — Seção 2.3.4 (Aprovação Condicional)**

Localização: após a frase "Somente após a(s) aprovação(ões) pertinente(s) — quando necessárias — a IA implementa a especificação."

Inserir o seguinte parágrafo:

> Se um aprovador rejeita sua camada do Canonical Change Plan incremental, o plano é devolvido com motivo registrado. O autor da especificação decide se ajusta a especificação para endereçar o motivo da rejeição e gera novo `incremental-plan`, ou abandona a especificação. A rejeição de uma camada não invalida a aprovação de outra camada — o ajuste é localizado na camada rejeitada. A rejeição segue a regra geral de devolução com motivo descrita na seção 2.2.

**Trecho 1.8 — Seção 9.5 (Disponibilidade de aprovadores)**

Localização: após a frase sobre roteamento por camada na Etapa 2. Adicionar ao final do parágrafo:

> A rejeição com devolução e resubmissão pode aumentar o número de ciclos de aprovação em um mesmo Change Plan, agravando a demanda sobre aprovadores — especialmente em cenários com múltiplas rejeições consecutivas. A resubmissão é decisão do autor, não obrigatória — o abandono com motivo registrado é a saída para evitar ciclos improdutivos.

**Trecho 1.10 — Seção 10, prioridade 4**

Localização: na prioridade 4, após "Avaliar se o artefato é compreensível e se a separação entre camadas é clara."

Adicionar a seguinte frase:

> Testar também o fluxo de rejeição: avaliar se o motivo em texto livre é suficiente para orientar a revisão, se o ciclo rejeição-revisão-resubmissão é percebido como produtivo, e se o abandono explícito é exercido naturalmente quando o impasse é real.

---

### Melhoria 2 — Inconsistência entre Tabela de Papéis e Texto da Etapa 3

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 2.1 | Seção 4, tabela "Resumo de atuação por etapa", coluna "Etapa 3 — Canon Enrichment" | Direto — é o trecho que contém a contradição. As células de Domain Expert, Architect e Domain Builder exibem "—" onde deveria haver descrição condicional. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 2.1 (Tabela, seção 4) | **Ajuste de tabela existente.** Substituir "—" por descrições condicionais nas células de Domain Expert e Architect. Manter "—" para Domain Builder. | A tabela existe como referência rápida. A correção é localizada — substituir o conteúdo incorreto pelo correto, alinhando com o texto da seção 2.4. As descrições das outras colunas já são frases completas, então descrições condicionais não quebram o padrão visual. |

#### C. Especificação da Mudança

**Trecho 2.1 — Tabela de resumo de atuação por etapa (seção 4)**

Substituir as células da coluna "Etapa 3 — Canon Enrichment" conforme abaixo:

| Papel | Valor atual | Novo valor |
|-------|-------------|------------|
| Domain Builder | — | — |
| Architect | — | Revisão assíncrona (janela de veto) para descobertas na camada de arquitetura; aprovação ativa quando descoberta é escalada para Change Plan formal |
| Domain Expert | — | Revisão assíncrona (janela de veto) para descobertas na camada de negócio; aprovação ativa quando descoberta é escalada para Change Plan formal |
| IA (Agentes LLM) | Atualiza Product Canon | Atualiza Product Canon *(sem alteração)* |

---

## Fase 2 — Versionamento por Estrangulamento

### Melhoria 3 — Semântica do Versionamento Current/Next com Transições

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 3.1 | Seção 2.2.5, guardrail "Versionamento Gradual por Estrangulamento" | Direto — é a seção que define o mecanismo. Precisa incorporar escopo, conclusão, cancelamento e posição sobre concorrência. |
| 3.2 | Seção 2.2.5, exemplo do Strangler Fig (bounded context "Faturamento") | Direto — o exemplo ilustra uma transição singular. Deve refletir minimamente as novas semânticas (pelo menos a conclusão). |
| 3.3 | Seção 2.4 (Canon Enrichment), frase sobre integração via Versionamento por Estrangulamento | Indireto — menciona que Change Plans aprovados são integrados via este mecanismo. A semântica de conclusão afeta quando a integração é considerada completa. |
| 3.4 | Seção 6.3 (cenário de mudança conceitual) | Indireto — o cenário descreve a transição "Faturamento" → "Cobrança" + "Receita". O passo 4 menciona "quando todas as dependências forem migradas" sem definir quem declara isso. Deve refletir a semântica de conclusão. |
| 3.5 | Seção 8, princípio "Alterações radicais são graduais" | Indireto — referencia o Strangler Fig. O princípio é suficientemente genérico para não requerer alteração. |
| 3.6 | Seção 9, riscos | Indireto — o adiamento da semântica de concorrência é um risco/limitação consciente que deve ser documentado. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 3.1 (Seção 2.2.5, Strangler Fig) | **Reescrita parcial do guardrail.** Expandir o parágrafo existente para incorporar escopo declarado, condição de conclusão, cancelamento e posição sobre concorrência, mantendo a estrutura narrativa. | O parágrafo atual define o mecanismo em alto nível. As novas semânticas são detalhes operacionais do mesmo mecanismo — não justificam subseção separada, mas exigem mais que uma frase adicional. |
| 3.2 (Exemplo do Strangler Fig) | **Atualização de exemplo existente.** Ajustar o passo final do exemplo para refletir a conclusão explícita pelo Architect. | O exemplo já é funcional. Basta ajustar o desfecho para incorporar a nova semântica de conclusão. |
| 3.3 (Seção 2.4) | **Sem alteração.** A frase "integrados à Product Canon via Versionamento Gradual por Estrangulamento" é referência genérica ao mecanismo. As novas semânticas são detalhadas na seção 2.2.5 e não precisam ser repetidas aqui. | Evitar redundância. A referência ao mecanismo é suficiente. |
| 3.4 (Seção 6.3) | **Extensão natural do cenário.** Ajustar o passo 4 para mencionar explicitamente a decisão do Architect na conclusão. | O cenário já é quase completo. Falta apenas explicitar quem declara o fim da transição. |
| 3.5 (Seção 8) | **Sem alteração.** O princípio é genérico e acomoda as novas semânticas sem reescrita. | Manter princípios sucintos. |
| 3.6 (Seção 9) | **Adição de subseção nova.** Adicionar um novo item na seção 9 sobre a limitação de concorrência não normatizada. | A seção 9 já contém riscos numerados. A concorrência adiada é uma limitação consciente que merece registro explícito — padrão consistente com os demais riscos. |

#### C. Especificação da Mudança

**Trecho 3.1 — Seção 2.2.5, guardrail "Versionamento Gradual por Estrangulamento"**

Substituir o parágrafo atual do Strangler Fig (desde "Nem toda alteração na Product Canon..." até "...que já reflete a divisão.") pelo seguinte texto:

> **Versionamento Gradual por Estrangulamento (Strangler Fig).** Nem toda alteração na Product Canon deve ser refletida imediatamente. Inspirado no padrão Strangler Fig de Martin Fowler, mudanças estruturais significativas — como a divisão de um bounded context, a redefinição de um conceito central ou a remoção de um evento de domínio — devem ser versionadas e aplicadas gradualmente, por criticidade. A Product Canon mantém duas faces: o estado vigente (current) e o estado aprovado em transição (next). Especificações de manutenção referenciam current; especificações de novos produtos podem referenciar next. Canonical Change Plans aprovados são integrados à Product Canon via este mecanismo.
>
> Cada transição possui escopo declarado — a lista explícita de artefatos e bounded contexts afetados pela mudança. O escopo é definido no Canonical Change Plan que origina a transição e delimita quais artefatos mantêm faces `current` e `next`.
>
> A conclusão de uma transição — o momento em que `next` se torna `current` e a face anterior é descontinuada — é uma decisão explícita do Architect, registrada no histórico da Product Canon com justificativa. Não há conclusão automática: o Architect avalia que todas as dependências no escopo declarado foram migradas e declara a transição como concluída.
>
> O cancelamento de uma transição em andamento é possível via Canonical Change Plan que restaura `current` como estado único, descartando `next`. O Change Plan de cancelamento segue os gates de aprovação correspondentes à natureza dos artefatos afetados.
>
> Múltiplas transições simultâneas (concorrência) são reconhecidas como cenário válido, mas não normatizadas nesta versão do modelo. Se ocorrerem, o Architect avalia caso a caso com suporte da Validação de Consistência. A semântica de concorrência será refinada com base na prototipação (ver seção 9).
>
> **Exemplo.** A equipe decide que o bounded context de "Faturamento" precisa ser dividido em "Cobrança" e "Receita." O escopo da transição é declarado: bounded context "Faturamento" e todos os seus artefatos (glossário, eventos, regras, fluxos). A alteração é registrada como mudança em transição na Product Canon. Especificações existentes continuam referenciando "Faturamento" (current). Novas especificações para os contextos separados podem ser escritas contra a versão next, que já reflete a divisão. Quando todas as dependências de "Faturamento" forem migradas, o Architect declara a conclusão da transição e "Cobrança" e "Receita" passam a ser o estado vigente (current).

**Trecho 3.4 — Seção 6.3, passo 4**

Substituir o passo 4 atual:

> 4\. A migração ocorre gradualmente. Cada spec implementada no novo modelo conceitual contribui para a transição. Quando todas as dependências de "Faturamento" forem migradas, a versão current é descontinuada.

Pelo seguinte:

> 4\. A migração ocorre gradualmente. Cada spec implementada no novo modelo conceitual contribui para a transição. Quando todas as dependências de "Faturamento" forem migradas, o Architect declara formalmente a conclusão da transição — "Cobrança" e "Receita" passam a ser o estado vigente (current) e a versão anterior é descontinuada. A decisão é registrada no histórico da Product Canon.

**Trecho 3.6 — Seção 9, novo item**

Adicionar após a seção 9.7 (Perda de detalhamento estrutural):

> ### 9.8 Concorrência de transições no Versionamento por Estrangulamento
>
> O modelo define semânticas para escopo, conclusão e cancelamento de transições no Versionamento Gradual por Estrangulamento, mas não normatiza o cenário de múltiplas transições simultâneas. Se duas transições afetam artefatos interdependentes — por exemplo, a divisão de um bounded context ocorre simultaneamente à redefinição de um conceito central em um contexto adjacente — os conflitos são avaliados pelo Architect caso a caso com suporte da Validação de Consistência. Essa abordagem pode produzir inconsistências se o cenário se tornar frequente. A limitação é uma decisão consciente: normatizar concorrência sem dados empíricos sobre frequência e padrões de conflito é over-engineering. A prototipação revelará se a normatização é necessária.

---

### Melhoria 7 — Limiar de Ativação do Versionamento por Estrangulamento

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 7.1 | Seção 2.2.5, guardrail "Versionamento Gradual por Estrangulamento" | Direto — a definição de "mudanças estruturais significativas" como critério de ativação está neste trecho. Deve incorporar a heurística de impacto cross-context e o override do Architect. |
| 7.2 | Seção 4, papel do Architect | Indireto — o Architect ganha uma responsabilidade adicional (decisão de ativar ou não o Strangler Fig). Verificar se a descrição do papel acomoda essa responsabilidade naturalmente. |
| 7.3 | Seção 4, papel da IA | Indireto — a IA ganha uma função de sinalização (detecção de impacto cross-context). Verificar se a descrição do papel acomoda. |
| 7.4 | Seção 10, prioridades de prototipação | Indireto — o critério heurístico de ativação deve ser incluído como item a ser validado na prototipação. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 7.1 (Seção 2.2.5) | **Extensão natural do guardrail.** Adicionar, após a definição do mecanismo (já reescrita pela Melhoria 3), um parágrafo sobre o critério de ativação. | O critério de ativação é parte da definição do guardrail. Não justifica subseção própria — é complemento direto. |
| 7.2 (Seção 4, Architect) | **Sem alteração.** A descrição do Architect já inclui "autoridade sobre decisões técnicas e estruturais" e "garante que toda mudança é compatível com os princípios constitucionais ou formaliza a exceção como ADR". A decisão de ativar o Strangler Fig se enquadra nessa autoridade. | A descrição existente é suficientemente genérica para acomodar a nova responsabilidade. |
| 7.3 (Seção 4, IA) | **Sem alteração.** A lista de atos operacionais da IA já inclui "sinalizar inconsistência". A sinalização de impacto cross-context é uma instância desse ato. | Listar cada sinalização específica tornaria a descrição do papel exaustiva e frágil. |
| 7.4 (Seção 10) | **Extensão natural da prioridade 5** (ciclo completo em escopo reduzido). A validação do critério de ativação cabe no contexto de um ciclo completo. | O teste do limiar de ativação faz sentido dentro de um ciclo completo, não como prioridade isolada. |

#### C. Especificação da Mudança

**Trecho 7.1 — Seção 2.2.5, critério de ativação**

Localização: após o parágrafo sobre concorrência (inserido pela Melhoria 3), antes do exemplo.

Inserir o seguinte parágrafo:

> A ativação do Versionamento por Estrangulamento é orientada por uma heurística de impacto cross-context: quando uma mudança afeta artefatos em múltiplos bounded contexts, a IA sinaliza automaticamente a recomendação de versionamento gradual. A sinalização é informativa — a decisão de ativar o mecanismo é do Architect. O Architect pode ativar o Strangler Fig mesmo para mudanças single-context que julgue estruturalmente significativas, ou decidir não ativá-lo para mudanças cross-context que julgue ordinárias, registrando a justificativa em ambos os casos. O registro de justificativa no override é análogo ao tratamento de exceções aos princípios técnicos constitucionais (ADRs).

**Trecho 7.4 — Seção 10, prioridade 5**

Localização: na prioridade 5, após "avaliar se a Product Canon resultante é efetivamente mais rica e útil após um ciclo completo."

Adicionar a seguinte frase:

> Incluir no ciclo uma mudança que ative o Versionamento por Estrangulamento para validar a heurística de impacto cross-context: avaliar se a sinalização automática da IA é percebida como útil, e se o override do Architect com justificativa é exercido naturalmente.

---

## Fase 3 — Comportamento de Janela de Veto e Ciclos de Vida

### Melhoria 4 — Comportamento da Janela de Veto ao Expirar

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 4.1 | Seção 2.2, parágrafo introdutório dos gates (aprovação secundária assíncrona) | Direto — é onde a "janela de veto" é mencionada pela primeira vez no contexto de aprovação secundária. O comportamento de expiração deve ser definido aqui. |
| 4.2 | Seção 2.2.6, subseção de aprovação sequencial | Direto — a aprovação do Architect é "obrigatória e não delegável". Deve explicitar que expiração = bloqueio neste contexto. |
| 4.3 | Seção 2.4 (Canon Enrichment), mecanismo de revisão assíncrona | Direto — "janela de veto para reverter a integração". O comportamento de expiração deve ser definido aqui. |
| 4.4 | Seção 9.5 (Disponibilidade de aprovadores) | Indireto — o risco de disponibilidade é afetado pelo comportamento de expiração. Onde expiração = bloqueio, o risco se agrava; onde = aprovação tácita, é mitigado. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 4.1 (Seção 2.2, introdução) | **Extensão natural de parágrafo existente.** Adicionar, logo após a menção à "aprovação secundária assíncrona com janela de veto", o comportamento de expiração para este contexto. | O comportamento de expiração é um detalhe operacional da janela de veto — pertence ao mesmo parágrafo que a define. |
| 4.2 (Seção 2.2.6) | **Extensão natural de parágrafo existente.** Adicionar, na descrição da aprovação do Architect, a explicitação de que expiração não equivale a aprovação neste contexto. | A seção já distingue esta aprovação das demais ("obrigatória e não delegável"). O comportamento de expiração é consequência lógica. |
| 4.3 (Seção 2.4) | **Extensão natural de parágrafo existente.** Adicionar ao mecanismo de revisão assíncrona o comportamento de expiração da janela de veto. | O parágrafo já descreve a janela de veto. O comportamento de expiração é complemento direto. |
| 4.4 (Seção 9.5) | **Extensão natural de parágrafo existente.** Adicionar menção ao impacto diferenciado da expiração sobre disponibilidade. | O risco já é discutido. O comportamento diferenciado de expiração é fator relevante. |

#### C. Especificação da Mudança

**Trecho 4.1 — Seção 2.2, parágrafo introdutório dos gates**

Localização: após a frase "Cada Canonical Change Plan requer aprovação primária pelo papel com expertise na cerimônia correspondente, e aprovação secundária assíncrona com janela de veto pelo outro papel humano."

Inserir a seguinte frase:

> Se a janela de veto da aprovação secundária expira sem manifestação do aprovador, a expiração equivale a aprovação tácita — a aprovação primária já foi concedida pelo papel com expertise principal, e a aprovação secundária é salvaguarda adicional. A expiração é registrada no histórico.

**Trecho 4.2 — Seção 2.2.6, subseção de aprovação sequencial**

Localização: após a frase "A aprovação do Architect é obrigatória e não delegável."

Inserir a seguinte frase:

> A janela de veto não se aplica à aprovação do Architect no `expert-edit-plan`: por ser obrigatória e não delegável, a expiração sem manifestação equivale a bloqueio — o `expert-edit-plan` permanece pendente até que o Architect se manifeste ativamente.

**Trecho 4.3 — Seção 2.4, mecanismo de revisão assíncrona**

Localização: após a frase "Na ausência de veto dentro da janela, a descoberta é incorporada."

A frase existente já descreve implicitamente a aprovação tácita por expiração ("na ausência de veto dentro da janela, a descoberta é incorporada"). Reformular para ser explícita:

Substituir:

> Na ausência de veto dentro da janela, a descoberta é incorporada.

Por:

> Se a janela de veto expira sem manifestação do aprovador, a expiração equivale a aprovação tácita e a descoberta é incorporada — coerente com o caráter de aprovação leve deste mecanismo. A expiração é registrada no histórico.

**Trecho 4.4 — Seção 9.5, disponibilidade de aprovadores**

Localização: após o texto já existente (incluindo a adição da Melhoria 1 sobre rejeição-resubmissão).

Inserir a seguinte frase:

> O comportamento diferenciado da expiração da janela de veto mitiga parcialmente o risco de disponibilidade: nas aprovações secundárias do Canon Building e na revisão assíncrona da Etapa 3, a expiração equivale a aprovação tácita, impedindo que a indisponibilidade temporária de um aprovador secundário bloqueie o fluxo. Na aprovação do Architect em `expert-edit-plan`, a expiração equivale a bloqueio — o risco de indisponibilidade persiste nesse contexto.

---

### Melhoria 5 — Ciclo de Vida de Hotspots de Domínio

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 5.1 | Seção 4, descrição do Domain Expert (hotspots de domínio) | Direto — é onde hotspots são definidos e onde a responsabilidade de revisão deve ser atribuída. |
| 5.2 | Seção 2.2.5, guardrail de Clarificação de Conformidade | Indireto — menciona hotspots como insumo para a Clarificação de Conformidade. A revisão periódica afeta a qualidade desse insumo. Verificar se o texto precisa de ajuste. |
| 5.3 | Seção 2.1 (Product Canon) | Indireto — menciona "metadados de hotspot de domínio" nos artefatos da Product Canon. Verificar se precisa refletir o ciclo de vida. |
| 5.4 | Seção 2.2.5, guardrail de Versionamento por Estrangulamento | Indireto — hotspots em artefatos `current` em transição para `next` precisam ter comportamento definido. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 5.1 (Seção 4, Domain Expert) | **Extensão natural de parágrafo existente.** Adicionar, após a definição de hotspots, o mecanismo de revisão periódica via Canon Building e a interação com versionamento. | A definição de hotspots já está no parágrafo do Domain Expert. O ciclo de vida é complemento direto — não justifica subseção separada. |
| 5.2 (Seção 2.2.5, Clarificação de Conformidade) | **Sem alteração.** O texto menciona que a IA "exibe proativamente a definição precisa e alerta sobre a incerteza registrada" para hotspots. A revisão periódica não altera esse comportamento — apenas garante que os hotspots exibidos sejam relevantes. | A Clarificação de Conformidade opera sobre os hotspots ativos. O mecanismo de revisão está documentado na seção 4. |
| 5.3 (Seção 2.1) | **Sem alteração.** A menção a "metadados de hotspot de domínio" é suficiente. O ciclo de vida é detalhado na seção 4. | Evitar redundância. |
| 5.4 (Seção 2.2.5, Strangler Fig) | **Sem alteração separada.** O comportamento de hotspots em transição `current`/`next` é descrito como parte do ciclo de vida na seção 4, não na seção do Strangler Fig. | A interação é específica de hotspots, não do Strangler Fig. Documentar na seção 4 mantém a coesão. |

#### C. Especificação da Mudança

**Trecho 5.1 — Seção 4, descrição do Domain Expert (hotspots)**

Localização: após a frase "Hotspots são metadados no artefato afetado (autor, data, descrição), não impedem a aprovação, e são utilizados proativamente pela IA na Clarificação de Conformidade."

Inserir o seguinte texto:

> A cada ciclo de Canon Building que toque o bounded context afetado, a IA apresenta os hotspots ativos como item de revisão na cerimônia correspondente (Domain Discovery ou Requirements Specification). O Domain Expert decide manter ou retirar cada hotspot; a retirada é registrada no histórico com motivo. Hotspots em artefatos `current` que estão em transição para `next` via Versionamento por Estrangulamento são preservados no artefato `next` por padrão — o Domain Expert decide na revisão se o hotspot ainda é relevante no novo contexto.

---

### Melhoria 6 — Ciclo de Vida de Anotações Contextuais

#### A. Análise de Impacto

| # | Trecho afetado | Tipo de impacto |
|---|----------------|-----------------|
| 6.1 | Seção 4, descrição do Domain Expert (anotações contextuais) | Direto — é onde anotações são definidas e onde o ciclo de vida (formalizar/descartar/adiar) deve ser especificado. |
| 6.2 | Seção 2.4, parágrafo sobre anotações contextuais | Direto — menciona que "anotações não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building". Deve refletir a resolução explícita. |

#### B. Estratégia de Integração

| Trecho | Estratégia | Justificativa |
|--------|-----------|---------------|
| 6.1 (Seção 4, Domain Expert) | **Extensão natural de parágrafo existente.** Adicionar, após a definição de anotações como "insumos formais para cerimônias futuras", o mecanismo de resolução explícita. | O ciclo de vida é complemento direto da definição. Manter junto evita que o leitor precise navegar para encontrar as regras de resolução. |
| 6.2 (Seção 2.4) | **Reescrita mínima de frase.** Ajustar a frase existente para refletir que anotações são apresentadas com resolução obrigatória, não apenas como candidatos passivos. | A frase atual é correta mas incompleta. A reescrita preserva o sentido e adiciona a referência à resolução. |

#### C. Especificação da Mudança

**Trecho 6.1 — Seção 4, descrição do Domain Expert (anotações)**

Localização: após a frase "a IA as apresenta como candidatos a formalização no próximo ciclo de Canon Building."

Inserir o seguinte texto:

> Quando a IA apresenta uma anotação contextual como candidato a formalização em uma cerimônia de Canon Building, o Domain Builder registra uma resolução: *formalizar* (a anotação é incorporada à Product Canon via Canonical Change Plan), *descartar* (a anotação é arquivada com motivo e não será re-apresentada) ou *adiar* (será re-apresentada no próximo ciclo). Adiamentos consecutivos além de 2 ciclos ativam sinalização da IA: "esta anotação foi adiada N vezes — considerar formalizar ou descartar." A resolução é registrada no histórico da anotação.

**Trecho 6.2 — Seção 2.4, frase sobre anotações**

Substituir a frase:

> Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building.

Por:

> Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building, com resolução obrigatória: formalizar, descartar ou adiar (ver ciclo de vida de anotações na seção 4).

---

## Checklist de Consistência Pós-Integração

Após a integração de todas as melhorias, verificar os seguintes pontos:

### Verificações cruzadas entre melhorias

- [ ] **Rejeição (M1) × Janela de veto (M4):** Confirmar que rejeição e expiração são apresentados como mecanismos complementares e não conflitantes. Rejeição = ação explícita do aprovador; expiração = inação do aprovador. Os dois não se sobrepõem em nenhum cenário.
- [ ] **Rejeição (M1) × Aprovação sequencial do expert-edit-plan (M1 + M4):** Confirmar que a rejeição do Architect no expert-edit-plan (devolução com motivo) e o bloqueio por expiração (Architect não se manifesta) produzem efeitos distintos e consistentes. Rejeição = Change Plan retorna ao Domain Expert com motivo; bloqueio = Change Plan permanece pendente.
- [ ] **Hotspots (M5) × Anotações (M6):** Confirmar que ambos usam o ciclo de Canon Building como momento de revisão sem ambiguidade sobre qual mecanismo se aplica a quê. Hotspots são metadados que marcam zonas frágeis (manter/retirar); anotações são insumos de formalização (formalizar/descartar/adiar). Os dois são itens de revisão distintos na mesma cerimônia.
- [ ] **Hotspots (M5) × Versionamento (M3):** Confirmar que o comportamento de hotspots em transição `current`/`next` é consistente com a nova semântica de escopo, conclusão e cancelamento. Hotspots são preservados por padrão em `next`; na conclusão da transição, os hotspots migram com o artefato.
- [ ] **Limiar de ativação (M7) × Conclusão de transição (M3):** Confirmar que o Architect que decide ativar o Strangler Fig (M7) é o mesmo que declara a conclusão da transição (M3) — autoridade unificada.
- [ ] **Tabela corrigida (M2) × Janela de veto na Etapa 3 (M4):** Confirmar que as descrições condicionais na tabela (revisão assíncrona com janela de veto) são consistentes com o comportamento de expiração definido na seção 2.4 (aprovação tácita por expiração).

### Verificações de consistência interna do documento

- [ ] **Seção 2.2 (gates):** Verificar que o parágrafo introdutório, após as adições de M1 e M4, lê como texto coeso — aprovação, rejeição e expiração formam uma sequência lógica sem repetição.
- [ ] **Seção 2.2.5 (guardrails):** Verificar que o Strangler Fig, após as adições de M3 e M7, não ficou desproporcionalmente longo em relação aos outros guardrails. Se necessário, considerar reorganização interna (subparágrafos) sem criar subseções.
- [ ] **Seção 4 (Domain Expert):** Verificar que as adições de M5 e M6 (ciclos de vida de hotspots e anotações) não tornaram a descrição do Domain Expert desproporcionalmente longa em relação aos outros papéis.
- [ ] **Seção 9 (riscos):** Verificar que o novo item 9.8 (concorrência) segue o padrão estrutural dos demais itens (título descritivo, descrição do risco, mitigação ou justificativa de aceitação).
- [ ] **Seção 9.5 (disponibilidade):** Verificar que, após as adições de M1 e M4, o parágrafo não ficou longo demais. Se necessário, reorganizar internamente.
- [ ] **Seção 10 (prototipação):** Verificar que as adições nas prioridades 4 e 5 se integram naturalmente ao texto existente e não alteram o escopo das prioridades.
- [ ] **Referências cruzadas:** Confirmar que toda menção a "seção X" no texto inserido aponta para a seção correta após a renumeração (se houver — verificar especialmente se a adição de 9.8 causa conflito).
- [ ] **Vocabulário:** Confirmar que nenhum termo novo foi introduzido pelas mudanças. Todos os conceitos devem usar exclusivamente o vocabulário existente: Product Canon, Canonical Change Plan, bounded context, guardrail, gate, cerimônia, Domain Builder, Domain Expert, Architect, hotspot de domínio, anotação contextual, etc.
- [ ] **Tom:** Reler cada inserção e verificar que o tom é técnico-formal, declarativo e consistente com o restante do documento — sem floreios, sem jargão novo, sem linguagem informal.

---

*Plano de implementação gerado como guia para integração das melhorias ao ZionKit v0.6.*
