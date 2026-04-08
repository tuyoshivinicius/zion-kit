# Plano de Implementação — Correções Conceituais do zionkit-model.md v0.6

## Visão Geral

Este plano detalha a implementação de 5 correções conceituais (ISSUE-02, ISSUE-03, ISSUE-04, ISSUE-05, ISSUE-06) no documento `zionkit-model.md` v0.6. As correções abordam:

- **ISSUE-02** — Fronteira indefinida entre Domain Builder e Domain Expert: explicitar que papéis representam perspectivas, não necessariamente pessoas distintas.
- **ISSUE-03** — Etapa 3 sem governança para descobertas emergentes: adicionar aprovação leve com escalação condicional via guardrails.
- **ISSUE-04** — Canonical Change Plan incremental sem tipagem: adicionar o quinto tipo `incremental-plan`.
- **ISSUE-05** — Decisão de Continuidade pode violar o fluxo sequencial: adicionar pré-condição explícita para o caminho (b).
- **ISSUE-06** — Inconsistência na aprovação da Edição Direta entre seções: alinhar diagrama e tabela com o texto normativo da seção 2.2.6.

### Dependências entre issues

- **ISSUE-04 → ISSUE-03**: A ISSUE-04 adiciona o tipo `incremental-plan` à lista de tipos de Change Plan. A ISSUE-03 referencia essa lista ao definir que descobertas emergentes escaladas usam tipos existentes. A ISSUE-04 deve ser implementada primeiro para que a lista de tipos esteja completa quando a ISSUE-03 for integrada.
- **ISSUE-02 → ISSUE-06**: Ambas modificam a seção 4 (tabela de papéis). A ISSUE-02 adiciona parágrafo introdutório à seção 4; a ISSUE-06 modifica células da tabela. Sem conflito direto, mas devem ser implementadas em sequência para evitar sobreposição de edições.
- **ISSUE-03, ISSUE-04, ISSUE-05, ISSUE-06**: Todas modificam o diagrama da seção 3. As alterações ocorrem em trechos distintos do diagrama, sem conflito textual, mas a execução sequencial é preferível para controle de edições.

### Organização em fases de execução

| Fase | Issues | Justificativa |
|------|--------|---------------|
| Fase 1 | ISSUE-04 | Fundacional — adiciona tipo que completa o sistema de tipagem antes das demais correções |
| Fase 2 | ISSUE-05 | Independente — altera seção 2.2.4 e diagrama (trecho distinto) |
| Fase 3 | ISSUE-03 | Depende de ISSUE-04 — referencia lista de tipos já atualizada; altera seção 2.4, diagrama e seções 8/9.4 |
| Fase 4 | ISSUE-02 | Independente — altera Resumo Executivo, seção 1.2 e seção 4 (parágrafo introdutório) |
| Fase 5 | ISSUE-06 | Após ISSUE-02 — altera diagrama e tabela da seção 4, que já recebeu o parágrafo da ISSUE-02 |

---

## Fase 1 — Estratégias de Integração

### ISSUE-02: Domain Builder vs Domain Expert — fronteira de papéis indefinida

**Seções afetadas:** Resumo Executivo (linha 12), seção 1.2 (linha 28), seção 4 (linha 432–434)

**Estratégia:** Inserção de novo conteúdo + reescrita parcial.

- **Seção 4 (linha 434):** Inserção de novo parágrafo após a frase de abertura ("O ZionKit define quatro papéis com autoridades complementares e não sobrepostas."). O parágrafo explicita que os papéis representam perspectivas distintas sobre o conhecimento do produto, não necessariamente pessoas distintas. A frase de abertura existente é preservada — o novo parágrafo a complementa sem contradizê-la.
- **Resumo Executivo (linha 12):** Reescrita parcial do trecho que menciona "Domain Builders" e "Architects" para incluir "Domain Experts", corrigindo a assimetria de visibilidade.
- **Seção 1.2 (linha 28–34):** Reescrita parcial do título e do primeiro parágrafo para referenciar tanto Domain Builders quanto Domain Experts, resolvendo a ambiguidade sobre quem é excluído.

**Justificativa:** O parágrafo introdutório na seção 4 é a alteração central — define a regra de acumulação de papéis como perspectivas. As correções no Resumo Executivo e na seção 1.2 são consequências de consistência. Nenhuma mecânica é alterada; a solução explicita o que já está implícito no princípio "Separação de autoridade".

**Dependências:** Nenhuma. Pode ser implementada em qualquer ordem relativa a ISSUE-03/04/05. Deve preceder ISSUE-06 por ambas tocarem a seção 4.

---

### ISSUE-03: Etapa 3 (Retroalimentação) sem governança de aprovação

**Seções afetadas:** seção 2.4 (linhas 323–333), diagrama da seção 3 (linhas 410–425), seção 8 — princípio "Governança por cerimônia" (linha 559), seção 9.4 (linhas 577–579)

**Estratégia:** Reescrita parcial da seção 2.4 + atualização do diagrama + inserção de cláusula na seção 9.4.

- **Seção 2.4:** Reescrita parcial. O segundo parágrafo (linhas 327–329) afirma que "as alterações declaradas no plano são refletidas na Product Canon, junto com as descobertas emergentes do ciclo de implementação" sem definir governança para as descobertas emergentes. Este parágrafo e o parágrafo seguinte (linhas 331–333) serão reescritos para distinguir explicitamente os dois componentes da Etapa 3 (integração de Change Plans aprovados vs. descobertas emergentes) e definir o mecanismo de aprovação leve com escalação condicional. O primeiro parágrafo (linhas 323–325) e os parágrafos finais (linhas 331–333) permanecem com ajustes de integração.
- **Diagrama da seção 3 (linhas 410–425):** Inserção de linhas no bloco da Etapa 3 para refletir a governança de descobertas emergentes (guardrails + revisão/escalação).
- **Seção 8 — "Governança por cerimônia":** Nenhuma alteração necessária. O texto atual ("toda mudança no corpo de conhecimento do produto passa por um processo formal — seja cerimônia ou edição direta com guardrails") já acomoda a solução — descobertas emergentes passarão por guardrails + revisão, satisfazendo o princípio.
- **Seção 9.4:** Inserção de cláusula complementar ao risco existente, abordando o risco inverso (incorporação sem validação).

**Justificativa:** A reescrita parcial da seção 2.4 é necessária porque o parágrafo atual trata Change Plans aprovados e descobertas emergentes como um bloco único sem distinção de governança. Separar os dois componentes e definir a mecânica de cada um exige reestruturação do texto, não mera inserção.

**Dependências:** Depende de ISSUE-04 (a lista de tipos de Change Plan referenciada na seção 2.4 deve incluir `incremental-plan`).

---

### ISSUE-04: Canonical Change Plan incremental — tipagem indefinida

**Seções afetadas:** seção 2.3.3 (linha 266), seção 5 (linha 472), diagrama da seção 3 (linha 399)

**Estratégia:** Reescrita cirúrgica de trechos específicos.

- **Seção 2.3.3 (linha 266):** Reescrita da frase que lista os 4 tipos para incluir `incremental-plan` como quinto tipo, com definição inline. A frase atual será expandida para 5 tipos e o Change Plan incremental será explicitamente associado ao tipo `incremental-plan`.
- **Seção 5 (linha 472):** Atualização da lista de tipos no item "Canonical Change Plans (com envelope tipado)" para incluir `incremental-plan` com descrição.
- **Diagrama da seção 3 (linha 399):** Atualização da linha que descreve o Canonical Change Plan incremental para incluir o tipo `incremental-plan`.

**Justificativa:** Alterações cirúrgicas — cada ponto de alteração é uma frase ou item de lista que precisa ser expandido, não uma seção inteira. A inserção do tipo é autocontida e não afeta a narrativa circundante.

**Dependências:** Nenhuma. Deve ser implementada antes de ISSUE-03.

---

### ISSUE-05: Decisão de Continuidade pode violar o fluxo sequencial

**Seções afetadas:** seção 2.2.4 (linhas 187–196), diagrama da seção 3 (linhas 368–372)

**Estratégia:** Inserção de parágrafo na seção 2.2.4 + atualização de linha no diagrama.

- **Seção 2.2.4:** Inserção de novo parágrafo após a definição dos três caminhos (após linha 193) e antes do parágrafo sobre autoridade do Domain Builder (linha 195). O parágrafo define a pré-condição para o caminho (b): o Domain Builder só pode voltar diretamente para Requirements Specification Session se os novos requisitos pertencem a bounded contexts já mapeados e com princípios técnicos constitucionais já definidos.
- **Diagrama da seção 3 (linha 371):** Atualização da linha `→ Mais requisitos (↑ Specification)` para incluir a pré-condição.

**Justificativa:** A inserção de parágrafo é suficiente — a definição dos três caminhos permanece intacta, e a pré-condição é uma cláusula adicional, não uma reescrita. O diagrama requer apenas atualização de uma linha para refletir a restrição.

**Dependências:** Nenhuma.

---

### ISSUE-06: Aprovação da Edição Direta — inconsistência entre seções

**Seções afetadas:** diagrama da seção 3 (linha 385), seção 4 — tabela de papéis (linhas 454–455)

**Estratégia:** Reescrita cirúrgica de linhas específicas.

- **Diagrama da seção 3 (linha 385):** Substituição de `Gate: Architect aprova expert-edit-plan` por `Gate: Domain Expert aprova (1°) + Architect aprova (2°) expert-edit-plan`.
- **Tabela da seção 4 (linhas 454–455):** Atualização das células da coluna "Edição Direta" para incluir ordinalidade e foco de cada aprovador.

**Justificativa:** Correção de consistência pura. A seção 2.2.6 é a fonte de verdade; diagrama e tabela devem refletir a mecânica sequencial já definida. Alterações cirúrgicas sem impacto na narrativa.

**Dependências:** Deve ser implementada após ISSUE-02 (que adiciona parágrafo à seção 4, antes da tabela).

---

## Fase 2 — Plano de Execução

### Fase de Execução 1: Tipagem do Canonical Change Plan incremental (ISSUE-04)

**Issues:** ISSUE-04  
**Seções modificadas:** seção 2.3.3, seção 5, diagrama da seção 3

#### Alteração 1.1: Atualizar lista de tipos na seção 2.3.3

**Local:** Seção 2.3.3, linha 266 — frase que lista os tipos de Change Plan.

**Texto atual (linha 266):**
```
O modelo define quatro tipos de Canonical Change Plan — `discovery-plan`, `constitution-plan`, `specification-plan` e `expert-edit-plan` — cada um originado em uma cerimônia ou canal distinto; o `expert-edit-plan` corresponde a planos de mudança originados por edição direta do Domain Expert (seção 2.2.6).
```

**Texto substituto:**
```
O modelo define cinco tipos de Canonical Change Plan — `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan` e `incremental-plan` — cada um originado em uma cerimônia, canal ou etapa distinta. O `expert-edit-plan` corresponde a planos de mudança originados por edição direta do Domain Expert (seção 2.2.6). O `incremental-plan` designa Canonical Change Plans gerados na Etapa 2 — captura impactos emergentes da especificação contra a Product Canon, com condicionalidade (pode ser vazio, dispensando aprovação), aprovação por camada afetada e conteúdo misto (negócio + arquitetura).
```

**Integração:** A frase substituta mantém a mesma posição e função narrativa — listar e definir os tipos. A expansão de 4 para 5 tipos é absorvida naturalmente pela estrutura enumerativa existente. A definição do `incremental-plan` segue o mesmo padrão de explicação inline usado para o `expert-edit-plan`.

#### Alteração 1.2: Atualizar a lista de tipos na seção 5

**Local:** Seção 5, linha 472 — item "Canonical Change Plans (com envelope tipado)".

**Texto atual (linha 472):**
```
- **Canonical Change Plans** (com envelope tipado): `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan` — registros dos planos de mudança aprovados em cada cerimônia, onde `expert-edit-plan` designa planos de mudança originados por edição direta do Domain Expert. Todos os tipos contêm requisitos em formato IEEE 29148 + SBE
```

**Texto substituto:**
```
- **Canonical Change Plans** (com envelope tipado): `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan`, `incremental-plan` — registros dos planos de mudança aprovados em cada cerimônia, canal ou etapa, onde `expert-edit-plan` designa planos de mudança originados por edição direta do Domain Expert e `incremental-plan` designa planos de mudança gerados na Etapa 2 com condicionalidade e aprovação por camada afetada. Todos os tipos contêm requisitos em formato IEEE 29148 + SBE
```

**Integração:** A lista enumerativa é expandida com o novo tipo. A descrição segue o padrão existente (tipo + origem + característica distintiva).

#### Alteração 1.3: Atualizar o diagrama da seção 3

**Local:** Diagrama da seção 3, linha 399.

**Texto atual (linha 399):**
```
│  → Canonical Change Plan incremental (condicional)          │
```

**Texto substituto:**
```
│  → Canonical Change Plan incremental-plan (condicional)     │
```

**Integração:** Alteração mínima — adiciona o nome do tipo ao Change Plan no diagrama, alinhando com a nomenclatura tipada usada em todos os outros blocos do diagrama (`discovery-plan`, `constitution-plan`, `specification-plan`).

#### Alteração 1.4: Atualizar o Resumo Executivo

**Local:** Resumo Executivo, linha 12 — trecho que menciona "Canonical Change Plans (Planos de Mudança Canônicos) aprovados".

**Texto atual (trecho da linha 12):**
```
cujos artefatos seguem o formato canônico IEEE 29148 + SBE e são submetidos a validação semântica interna; criação de especificações contextualizadas com um Canonical Change Plan incremental aprovado condicionalmente, no formato canônico IEEE 29148 + SBE;
```

**Texto substituto:**
```
cujos artefatos seguem o formato canônico IEEE 29148 + SBE e são submetidos a validação semântica interna; criação de especificações contextualizadas com um Canonical Change Plan tipado como `incremental-plan`, aprovado condicionalmente, no formato canônico IEEE 29148 + SBE;
```

**Integração:** Inserção mínima — adiciona a tipagem ao trecho que já descreve o Change Plan incremental, mantendo consistência com a nomenclatura atualizada.

---

### Fase de Execução 2: Pré-condição na Decisão de Continuidade (ISSUE-05)

**Issues:** ISSUE-05  
**Seções modificadas:** seção 2.2.4, diagrama da seção 3

#### Alteração 2.1: Inserir pré-condição para caminho (b) na seção 2.2.4

**Local:** Seção 2.2.4, entre a lista de caminhos (linhas 191–193) e o parágrafo de autoridade (linha 195).

**Texto a inserir após a linha 193 (`c) **Encerrar ciclo** → prosseguir para Etapa 2`):**

```

O caminho (b) possui uma pré-condição derivada do fluxo sequencial: o Domain Builder só pode voltar diretamente para a Requirements Specification Session se os novos requisitos pertencem a bounded contexts já mapeados na Product Canon e cujos princípios técnicos constitucionais já foram definidos na Technical Constitution Session. Essa pré-condição é logicamente necessária porque a Requirements Specification Session consome contexto produzido pelas cerimônias anteriores — operar sem esse contexto significa especificar requisitos contra um domínio incompletamente mapeado ou sem restrições técnicas definidas. Se os novos requisitos tocam bounded contexts não mapeados ou sem constituição técnica, o caminho correto é (a) — voltar para Domain Discovery Session e percorrer o fluxo sequencial completo. A IA sinaliza quando a pré-condição não é atendida; a decisão final permanece com o Domain Builder.
```

**Integração:** O parágrafo é inserido como qualificação dos caminhos listados, antes do parágrafo de autoridade. O fluxo narrativo é: definição dos caminhos → qualificação do caminho (b) → autoridade sobre a decisão. A linguagem segue o tom declarativo do documento e referencia conceitos existentes (fluxo sequencial, bounded contexts, princípios técnicos constitucionais).

#### Alteração 2.2: Atualizar caminho (b) no diagrama da seção 3

**Local:** Diagrama da seção 3, linha 371.

**Texto atual (linha 371):**
```
│  │   → Mais requisitos (↑ Specification)                │    │
```

**Texto substituto:**
```
│  │   → Mais requisitos (↑ Specification, se contexto    │    │
│  │     de Discovery e Constitution já existe)            │    │
```

**Integração:** A pré-condição é refletida de forma concisa no diagrama, sem detalhar a mecânica completa (que está na seção 2.2.4). O diagrama opera como representação visual resumida.

---

### Fase de Execução 3: Governança da Etapa 3 (ISSUE-03)

**Issues:** ISSUE-03  
**Seções modificadas:** seção 2.4, diagrama da seção 3, seção 9.4

#### Alteração 3.1: Reescrever seção 2.4

**Local:** Seção 2.4, linhas 323–333 (do título ao último parágrafo antes da seção 3).

**Texto atual (linhas 323–333):**
```
### 2.4 Etapa 3 — Retroalimentação da Product Canon

Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento — essa integração é parcialmente antecipada. A Etapa 3 concentra-se em **descobertas emergentes da implementação**: conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código, decisões técnicas não previstas.

Uma vez que o Canonical Change Plan incremental da Etapa 2 foi aprovado (quando aplicável) e a especificação foi implementada, as alterações declaradas no plano são refletidas na Product Canon, junto com as descobertas emergentes do ciclo de implementação.

Essa etapa é mecanicamente segura porque não há ambiguidade sobre o que atualizar. Os múltiplos Canonical Change Plans aprovados — tanto os do Canon Building quanto o incremental da Etapa 2 — declararam explicitamente quais artefatos da Product Canon serão afetados e como. A retroalimentação é a materialização de decisões já tomadas, complementada pelas descobertas emergentes.

Os novos termos são adicionados ao glossário. Os eventos de domínio novos ou alterados são registrados no catálogo. As regras de negócio são incorporadas. Os ADRs são formalizados. Os princípios técnicos constitucionais são atualizados quando necessário. As alterações são versionadas e passam a integrar o corpo de contexto disponível para todas as especificações futuras.

Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building.
```

**Texto substituto completo:**
```
### 2.4 Etapa 3 — Retroalimentação da Product Canon

Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento — essa integração é parcialmente antecipada. A Etapa 3 concentra-se em **descobertas emergentes da implementação**: conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código, decisões técnicas não previstas.

A Etapa 3 opera em dois componentes com governança distinta:

**Integração de Change Plans aprovados.** Uma vez que o Canonical Change Plan `incremental-plan` da Etapa 2 foi aprovado (quando aplicável) e a especificação foi implementada, as alterações declaradas no plano são refletidas na Product Canon. Esse componente é mecanicamente seguro — os múltiplos Canonical Change Plans aprovados (tanto os do Canon Building quanto o `incremental-plan` da Etapa 2) declararam explicitamente quais artefatos da Product Canon serão afetados e como. A retroalimentação é a materialização de decisões já tomadas e aprovadas.

**Descobertas emergentes da implementação.** Conceitos refinados, regras não documentadas e decisões técnicas não previstas que surgem durante a implementação não passaram por nenhum gate de aprovação prévio. Para preservar o princípio de Governança por cerimônia sem agravar o risco de disciplina (seção 9.4), essas descobertas seguem um mecanismo de aprovação leve com escalação condicional:

1. A IA formaliza cada descoberta emergente e a submete aos guardrails existentes — Padronização Canônica (formato IEEE 29148 + SBE), Validação de Consistência (contradições com regras existentes) e Clarificação de Conformidade (alinhamento terminológico).
2. Se os guardrails não detectam problemas — a descoberta é um refinamento de termo, uma correção factual ou um ajuste que não contradiz nem impacta artefatos de outros bounded contexts — a integração é aprovada com **revisão assíncrona**: o Domain Expert (para alterações na camada de negócio) ou o Architect (para alterações na camada de arquitetura) dispõe de uma janela de veto para reverter a integração. Na ausência de veto dentro da janela, a descoberta é incorporada.
3. Se os guardrails detectam inconsistências, contradições ou impacto cross-context, a descoberta é **escalada para um Canonical Change Plan formal** do tipo apropriado (`specification-plan`, `constitution-plan` ou `discovery-plan`, conforme a natureza da descoberta), que segue o fluxo de aprovação ativa correspondente. A IA não cria tipo novo — reutiliza os tipos existentes conforme o canal semântico da descoberta.

Os guardrails funcionam como mecanismo de triagem natural: operam em todas as outras etapas do modelo e utilizam os mesmos critérios de detecção. A diferença está na consequência — na Etapa 3, a ausência de problemas detectados habilita revisão passiva, enquanto a presença de problemas escala para governança completa.

Os novos termos são adicionados ao glossário. Os eventos de domínio novos ou alterados são registrados no catálogo. As regras de negócio são incorporadas. Os ADRs são formalizados. Os princípios técnicos constitucionais são atualizados quando necessário. As alterações são versionadas e passam a integrar o corpo de contexto disponível para todas as especificações futuras.

Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building.
```

**Integração:** O primeiro parágrafo é preservado integralmente. O conteúdo original é redistribuído em dois componentes nomeados (integração de Change Plans + descobertas emergentes), eliminando a ambiguidade de governança. Os parágrafos finais (glossário, anotações) permanecem inalterados. A referência ao `incremental-plan` (ISSUE-04) já estará no documento quando esta fase for executada.

#### Alteração 3.2: Atualizar o diagrama da seção 3 — bloco Etapa 3

**Local:** Diagrama da seção 3, linhas 410–425 (bloco da Etapa 3).

**Texto atual (linhas 410–425):**
```
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 3                              │
│            Retroalimentação da Product Canon                  │
│                                                             │
│  Change Plans do Canon Building: integração antecipada       │
│  via Versionamento por Estrangulamento                      │
│  Foco da Etapa 3: descobertas emergentes da implementação    │
│  → Glossário atualizado                                     │
│  → Eventos de domínio registrados                           │
│  → Regras de negócio incorporadas                           │
│  → ADRs formalizados                                        │
│  → Princípios técnicos atualizados se necessário            │
│  → Tudo versionado e disponível como contexto futuro        │
└──────────────────────────┬──────────────────────────────────┘
```

**Texto substituto:**
```
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 3                              │
│            Retroalimentação da Product Canon                  │
│                                                             │
│  Change Plans aprovados: integração antecipada               │
│  via Versionamento por Estrangulamento                      │
│                                                             │
│  Descobertas emergentes da implementação:                    │
│  → Guardrails (Padronização, Consistência, Conformidade)    │
│  → Sem problemas: revisão assíncrona (janela de veto)       │
│  → Com problemas: escalação para Change Plan formal         │
│                                                             │
│  Resultado:                                                  │
│  → Glossário atualizado                                     │
│  → Eventos de domínio registrados                           │
│  → Regras de negócio incorporadas                           │
│  → ADRs formalizados                                        │
│  → Princípios técnicos atualizados se necessário            │
│  → Tudo versionado e disponível como contexto futuro        │
└──────────────────────────┬──────────────────────────────────┘
```

**Integração:** O diagrama reflete a distinção entre os dois componentes da Etapa 3. As linhas de resultado são preservadas. A representação visual da triagem por guardrails é concisa e alinhada com a descrição textual da seção 2.4.

#### Alteração 3.3: Complementar seção 9.4 com risco inverso

**Local:** Seção 9.4, após o texto atual (linha 579).

**Texto atual (linhas 577–579):**
```
### 9.4 Disciplina de retroalimentação

O modelo depende de que a Etapa 3 seja efetivamente executada após cada implementação. Se equipes sob pressão de prazo começam a pular a retroalimentação, a Product Canon se desatualiza e o modelo degrada para SDD convencional sem camada semântica. Este risco é parcialmente mitigado pelo Canon Building: se Canonical Change Plans já são integrados à Product Canon durante a Etapa 1, a Etapa 3 é um incremento menor — focado em descobertas emergentes da implementação. O risco residual concentra-se nessas descobertas emergentes.
```

**Texto substituto:**
```
### 9.4 Disciplina de retroalimentação

O modelo depende de que a Etapa 3 seja efetivamente executada após cada implementação. Se equipes sob pressão de prazo começam a pular a retroalimentação, a Product Canon se desatualiza e o modelo degrada para SDD convencional sem camada semântica. Este risco é parcialmente mitigado pelo Canon Building: se Canonical Change Plans já são integrados à Product Canon durante a Etapa 1, a Etapa 3 é um incremento menor — focado em descobertas emergentes da implementação. O risco residual concentra-se nessas descobertas emergentes.

O risco inverso também existe: descobertas emergentes incorporadas sem validação adequada podem degradar a qualidade da Product Canon. O mecanismo de aprovação leve com escalação condicional (seção 2.4) mitiga esse risco ao submeter todas as descobertas aos guardrails antes da integração — refinamentos triviais recebem revisão passiva, enquanto descobertas com inconsistências ou impacto cross-context são escaladas para aprovação ativa. A eficácia desse mecanismo de triagem depende da qualidade dos guardrails (ver seção 9.1) e será validada pela prioridade 5 da seção 10.
```

**Integração:** O parágrafo adicionado complementa o risco existente com sua contraparte. A referência cruzada à seção 2.4 e à seção 9.1 segue o padrão de referências internas do documento.

---

### Fase de Execução 4: Papéis como perspectivas (ISSUE-02)

**Issues:** ISSUE-02  
**Seções modificadas:** Resumo Executivo, seção 1.2, seção 4

#### Alteração 4.1: Inserir parágrafo introdutório na seção 4

**Local:** Seção 4, entre a linha de abertura (linha 434: "O ZionKit define quatro papéis com autoridades complementares e não sobrepostas.") e o parágrafo do Domain Builder (linha 436).

**Texto a inserir após a linha 434:**

```

Os quatro papéis representam perspectivas distintas sobre o conhecimento do produto, não necessariamente pessoas distintas. Em equipes pequenas ou em estágios iniciais de produto, uma mesma pessoa pode exercer múltiplas perspectivas — o fundador de uma startup pode ser simultaneamente Domain Builder (descreve os fluxos de negócio) e Domain Expert (valida a fidelidade semântica). O valor da separação está na completude das perspectivas exercidas: mesmo quando acumulados por uma única pessoa, cada papel força perguntas diferentes sobre o artefato — o Domain Builder pergunta "o que o produto deve fazer?", o Domain Expert pergunta "essa descrição é fiel ao que o domínio realmente é?", o Architect pergunta "essa estrutura é tecnicamente viável e sustentável?". Quando uma pessoa acumula papéis, ela exerce os momentos de aprovação correspondentes como exercício deliberado de perspectiva — não como formalidade vazia, mas como mudança intencional de lente sobre o mesmo artefato.

```

**Integração:** O parágrafo é inserido entre a frase de abertura (que define o princípio) e as descrições individuais dos papéis (que detalham cada um). A frase de abertura permanece como declaração do princípio; o novo parágrafo a complementa com a regra de acumulação; as descrições dos papéis seguem como detalhamento. O fluxo narrativo é preservado: princípio → qualificação → detalhamento.

#### Alteração 4.2: Atualizar Resumo Executivo

**Local:** Resumo Executivo, linha 12 — trecho que menciona "Domain Builders" e "Architects" sem mencionar "Domain Experts".

**Texto atual (trecho da linha 12):**
```
Canon Building — construção e manutenção assistida da Product Canon por Domain Builders (Construtores de Domínio) e Architects (Arquitetos), através de três cerimônias formais com Canonical Change Plans (Planos de Mudança Canônicos) aprovados,
```

**Texto substituto:**
```
Canon Building — construção e manutenção assistida da Product Canon por Domain Builders (Construtores de Domínio), Domain Experts (Especialistas de Domínio) e Architects (Arquitetos), através de três cerimônias formais com Canonical Change Plans (Planos de Mudança Canônicos) aprovados,
```

**Integração:** Inserção mínima — adiciona "Domain Experts (Especialistas de Domínio)" à lista de participantes, corrigindo a omissão. A estrutura da frase é preservada.

#### Alteração 4.3: Atualizar seção 1.2

**Local:** Seção 1.2, linhas 28–30 — título e primeiro parágrafo.

**Texto atual (linhas 28–30):**
```
### 1.2 A exclusão do Domain Builder

Os frameworks de desenvolvimento orientados por especificação assumem que quem escreve especificações é um engenheiro sênior ou um arquiteto de especificações. Domain Builders — product owners, analistas de produto, gestores de operações — conhecem o produto e suas regras, mas frequentemente não possuem o vocabulário técnico ou a precisão terminológica necessária para produzir especificações que agentes de IA possam consumir com segurança.
```

**Texto substituto:**
```
### 1.2 A exclusão do Domain Builder e do Domain Expert

Os frameworks de desenvolvimento orientados por especificação assumem que quem escreve especificações é um engenheiro sênior ou um arquiteto de especificações. Domain Builders — product owners, analistas de produto, gestores de operações — conhecem o produto e suas regras, mas frequentemente não possuem o vocabulário técnico ou a precisão terminológica necessária para produzir especificações que agentes de IA possam consumir com segurança. Da mesma forma, Domain Experts — especialistas de domínio que detêm autoridade sobre o significado dos conceitos do negócio — frequentemente não participam do processo de especificação, resultando em artefatos que não passam por validação de fidelidade semântica antes de serem consumidos por agentes de IA.
```

**Integração:** O título é expandido para incluir o Domain Expert. Uma frase é adicionada ao final do primeiro parágrafo para descrever a exclusão do Domain Expert, seguindo o padrão narrativo do parágrafo (papel → competência → problema de exclusão). O segundo parágrafo (linhas 31–33) e o cenário ilustrativo (linha 34) permanecem inalterados — descrevem consequências da exclusão que se aplicam a ambos os papéis.

---

### Fase de Execução 5: Consistência da aprovação da Edição Direta (ISSUE-06)

**Issues:** ISSUE-06  
**Seções modificadas:** diagrama da seção 3, tabela da seção 4

#### Alteração 5.1: Atualizar gate no diagrama da seção 3

**Local:** Diagrama da seção 3, linha 385.

**Texto atual (linha 385):**
```
│   Gate: Architect aprova expert-edit-plan          │
```

**Texto substituto:**
```
│   Gate: Domain Expert (1°) + Architect (2°)        │
│         aprovam expert-edit-plan                    │
```

**Integração:** A linha é expandida para duas linhas para acomodar a descrição completa da aprovação sequencial, mantendo o alinhamento visual do diagrama. O padrão é consistente com os gates das cerimônias no mesmo diagrama (ex: `Gate: Domain Expert (1°) + Architect (2°)`).

#### Alteração 5.2: Atualizar tabela de papéis na seção 4

**Local:** Seção 4, linhas 454–455 — células da coluna "Edição Direta" nas linhas do Architect e do Domain Expert.

**Texto atual (linha 454 — Architect):**
```
| Architect | Conduz Technical Constitution Session; aprova secundariamente Discovery e Specification; aprova primariamente Constitution | Toma decisões técnicas na spec; aprova camada de arquitetura | — | Aprova `expert-edit-plan` (obrigatório, não delegável) |
```

**Texto substituto (linha 454 — Architect):**
```
| Architect | Conduz Technical Constitution Session; aprova secundariamente Discovery e Specification; aprova primariamente Constitution | Toma decisões técnicas na spec; aprova camada de arquitetura | — | Aprova `expert-edit-plan` (2° — impacto técnico, obrigatório, não delegável) |
```

**Texto atual (linha 455 — Domain Expert):**
```
| Domain Expert | Aprova primariamente Discovery e Specification; aprova secundariamente Constitution (com anotações e hotspots) | Aprova camada de negócio do Canonical Change Plan incremental (quando aplicável) (com anotações e hotspots) | — | Edita camada de negócio; resolve divergências com IA; aprova Change Plan consolidado |
```

**Texto substituto (linha 455 — Domain Expert):**
```
| Domain Expert | Aprova primariamente Discovery e Specification; aprova secundariamente Constitution (com anotações e hotspots) | Aprova camada de negócio do Canonical Change Plan incremental (quando aplicável) (com anotações e hotspots) | — | Edita camada de negócio; resolve divergências com IA; aprova `expert-edit-plan` (1° — fidelidade semântica) |
```

**Integração:** As células da coluna "Edição Direta" passam a refletir a ordinalidade e o foco de cada aprovador, alinhando-se com a mecânica sequencial definida na seção 2.2.6. A célula do Domain Expert substitui "aprova Change Plan consolidado" (genérico) por "aprova `expert-edit-plan` (1° — fidelidade semântica)" (específico e consistente com o tipo do Change Plan). A célula do Architect adiciona "(2° — impacto técnico)" antes da cláusula existente "(obrigatório, não delegável)".

---

## Checklist de Validação Pós-Implementação

Após a execução de todas as fases, verificar:

1. **Consistência de tipos:** A lista de tipos de Change Plan contém exatamente 5 tipos (`discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan`, `incremental-plan`) em todas as ocorrências — seção 2.3.3, seção 5, diagrama da seção 3 e Resumo Executivo.
2. **Consistência de aprovação:** O gate da Edição Direta descreve aprovação sequencial (Domain Expert 1° + Architect 2°) em todas as representações — seção 2.2.6 (já correto), diagrama da seção 3, tabela da seção 4.
3. **Pré-condição do caminho (b):** A seção 2.2.4 e o diagrama da seção 3 refletem a pré-condição para o retorno direto à Requirements Specification Session.
4. **Governança da Etapa 3:** A seção 2.4 distingue explicitamente integração de Change Plans aprovados e descobertas emergentes, com mecanismo de triagem por guardrails. A seção 9.4 menciona o risco inverso.
5. **Papéis como perspectivas:** A seção 4 contém o parágrafo introdutório sobre acumulação de papéis. O Resumo Executivo menciona Domain Experts. A seção 1.2 referencia a exclusão do Domain Expert.
6. **Nenhum termo estranho:** Verificar que nenhum conceito, termo ou vocabulário não pertencente ao modelo original foi introduzido.
7. **Fluidez narrativa:** Reler cada seção modificada na íntegra para confirmar que as alterações se integram organicamente ao texto circundante, sem parecerem patches ou adendos.
