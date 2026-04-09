# Plano de Implementacao — Secao: Processo Tecnico Completo do ZionKit

**Status:** Pronto para implementacao  
**Data:** 2026-04-08  
**Posicao no site:** Apos secao 12 (Edicao Direta do Domain Expert) — nova secao 13  
**Renumeracao necessaria:** Secoes 13-16 atuais passam para 14-17  

---

## 1. Analise do Processo — Texto Simples

O ZionKit opera em um ciclo fechado de tres etapas principais, um canal complementar e guardrails transversais. A seguir, cada processo na ordem correta com todas as particularidades.

### 1.1 Etapa 1 — Canon Building (Construcao e Manutencao da Product Canon)

Objetivo: Construir e manter a Product Canon — fonte central de verdade do produto — atraves de tres cerimonias formais sequenciais com gates de aprovacao entre elas.

**Entrada global:** Conhecimento tacito de dominio, documentos existentes, experiencia dos participantes.  
**Saida global:** Product Canon populada/atualizada com artefatos versionados em ambas as camadas (negocio + arquitetura).  
**Papeis envolvidos:** Domain Builder, Domain Expert, Architect, IA.  

#### 1.1.1 Cerimonia 1 — Domain Discovery Session

- **O que e:** Sessao conversacional que replica Event Storming digital. O Domain Builder descreve fluxos de negocio em linguagem natural e a IA ajuda a identificar/organizar elementos estruturais.
- **Fases explicitas:**
  1. Descoberta de eventos de dominio (fatos no passado: "PedidoCriado", "PagamentoConfirmado")
  2. Identificacao de comandos e atores (o que causou cada evento, quem disparou)
  3. Mapeamento de agregados e bounded contexts (agrupamentos coesos, fronteiras naturais)
  4. Decomposicao de casos de uso (pre-condicoes, pos-condicoes, fluxos alternativos)
- **Participantes ativos:** Domain Builder + IA
- **Saida:** Canonical Change Plan tipado como `discovery-plan`
- **Gate de aprovacao:**
  - Aprovacao primaria: Domain Expert (valida fidelidade semantica)
  - Aprovacao secundaria assincrona: Architect (valida viabilidade tecnica + bounded contexts + context map)
  - Janela de veto: duracao-default 48h uteis (configuravel pelo Architect)
  - Expiracao sem manifestacao = aprovacao tacita
- **Bloqueio:** Proxima cerimonia so e habilitada apos aprovacao
- **Rejeicao:** Devolucao com motivo em texto livre; autor decide se revisa/resubmete ou abandona

#### 1.1.2 Cerimonia 2 — Technical Constitution Session

- **O que e:** Cerimonia conduzida pelo Architect para definir principios tecnicos constitucionais e ADRs estrategicos. Sem fases rigidas.
- **Pre-requisito:** Canonical Change Plan da Domain Discovery Session aprovado.
- **Insumos:** Estruturas de dominio descobertas (bounded contexts, eventos, agregados).
- **Define:** Stack tecnologica, padroes de comunicacao entre contextos, estrategias de persistencia, politicas de seguranca, requisitos de observabilidade, nivel de aderencia IEEE 29148.
- **Niveis de aderencia IEEE 29148:**
  - Minimo: tipo + descricao + SBE (prototipacao)
  - Moderado: + subtipo + rastreabilidade + dependencias (produto em crescimento)
  - Completo: taxonomia integral + rastreabilidade bidirecional (produto maduro)
  - Pode variar por bounded context
  - SBE obrigatorio em todos os niveis
- **Participantes ativos:** Architect + IA
- **Saida:** Canonical Change Plan tipado como `constitution-plan`
- **Gate de aprovacao:**
  - Aprovacao primaria: Architect (adequacao tecnica)
  - Aprovacao secundaria assincrona: Domain Expert (principios nao restringem necessidades de negocio)
- **Bloqueio:** Proxima cerimonia so e habilitada apos aprovacao

#### 1.1.3 Cerimonia 3 — Requirements Specification Session

- **O que e:** Cerimonia conversacional de formalizacao de requisitos em IEEE 29148 + SBE. Opera em dois niveis: regra individual e documento.
- **Pre-requisito:** Canonical Change Plan da Technical Constitution Session aprovado.
- **Fluxo por regra individual:**
  1. Domain Builder descreve requisito em linguagem natural
  2. IA ativa simultaneamente: Clarificacao de Conformidade + validacao semantica interna (SBVR) + Validacao de Consistencia + Padronizacao Canonica
  3. IA consolida problemas e apresenta perguntas de clarificacao em linguagem natural
  4. Domain Builder refina em ciclo iterativo
  5. IA formaliza em IEEE 29148 + SBE
  6. Domain Builder valida resultado
- **Fluxo por documento:** IA verifica completude estrutural via taxonomia IEEE 29148 (sinalizacao, nao bloqueio)
- **Participantes ativos:** Domain Builder + IA
- **Saida:** Canonical Change Plan tipado como `specification-plan`
- **Gate de aprovacao:**
  - Aprovacao primaria: Domain Expert (fidelidade semantica)
  - Aprovacao secundaria assincrona: Architect (avaliacao tecnica)

#### 1.1.4 Decisao de Continuidade do Ciclo

- **O que e:** Ponto de decisao explicito apos aprovacao do specification-plan.
- **Tres caminhos:**
  - (a) Mapear mais fluxos e contextos → volta para Domain Discovery Session
  - (b) Formalizar mais requisitos → volta para Requirements Specification Session (pre-condicao: bounded contexts ja mapeados e com constituicao tecnica)
  - (c) Encerrar ciclo → prossegue para Etapa 2 (Spec Crafting)
- **Checkpoint IEEE 29148:** IA apresenta sinais indicativos de que o nivel de aderencia pode ser insuficiente (heuristicas qualitativas, nao thresholds)
- **Autoridade:** Domain Builder decide, com input da IA sobre cobertura
- **IA sinaliza:** Areas nao mapeadas, requisitos pendentes, bounded contexts mencionados mas nao explorados

### 1.2 Canal Complementar — Edicao Direta do Domain Expert

- **O que e:** Canal de manutencao (nao de rotina) para capturar conhecimento que emerge fora das cerimonias. Escopo limitado a camada de negocio.
- **Restricoes:** Apenas refinamentos/correcoes de artefatos existentes; conceitos novos requerem cerimonia
- **Fluxo de guardrails (ciclo iterativo antes do Change Plan):**
  1. Domain Expert propoe alteracao em linguagem natural/formato livre
  2. IA executa simultaneamente: Clarificacao de Conformidade + validacao semantica (SBVR) + Validacao de Consistencia + Padronizacao Canonica (reescrita IEEE 29148 + SBE)
  3. IA apresenta: perguntas de clarificacao + versao formalizada como proposta + Relatorio de Conformidade
  4. Domain Expert decide: aceitar, ajustar, responder perguntas, ou reescrever
  5. Ciclo repete ate aceitacao e resolucao de divergencias
- **Saida:** Canonical Change Plan tipado como `expert-edit-plan`
- **Gate de aprovacao (sequencial, ordem fixa):**
  1. Domain Expert aprova primeiro (fidelidade semantica da formalizacao)
  2. Architect aprova depois (impacto tecnico — obrigatorio, nao delegavel, sem janela de veto)

### 1.3 Guardrails Transversais da Product Canon

Operam em todas as etapas e cerimonias:

1. **Clarificacao de Conformidade:** Sinaliza divergencias terminologicas com o glossario e principios tecnicos. Atua nas sessoes de Discovery e Constitution. Sensivel a hotspots de dominio.
2. **Validacao de Consistencia:** Confronta alteracoes com estado atual da Product Canon (ambas camadas). Identifica contradicoes.
3. **Validacao Semantica Interna:** IA usa SBVR internamente para detectar ambiguidade, incompletude, contradicao. Resultados apresentados como perguntas em linguagem natural.
4. **Padronizacao Canonica:** Garante formato IEEE 29148 + SBE. Dois modos: implicito (cerimonias) e explicito (edicao direta). Respeita nivel de aderencia configurado.
5. **Versionamento Gradual por Estrangulamento (Strangler Fig):** Mudancas estruturais significativas sao versionadas com faces `current` e `next`. Heuristica de impacto cross-context para sinalizacao automatica. Conclusao de transicao e decisao explicita do Architect.

### 1.4 Etapa 2 — Spec Crafting (Especificacao Contextualizada)

- **O que e:** Criacao de especificacao de feature consumindo contexto de ambas as camadas da Product Canon.
- **Pre-requisito:** Ciclo de Canon Building encerrado (Etapa 1 concluida).
- **Participantes ativos:** Domain Builder ou Architect + IA + Product Canon
- **Sub-processos:**
  1. **Injecao de Contexto:** IA carrega seletivamente fragmentos relevantes da Product Canon (glossario, eventos, regras, ADRs do bounded context afetado)
  2. **Clarificacao e Validacao Contextualizada:** Termos inconsistentes sinalizados, contradicoes flagradas, dependencias entre contexts identificadas
  3. **Geracao do Canonical Change Plan Incremental:** IA gera `incremental-plan` automaticamente quando detecta impactos emergentes na Product Canon. Organizado em duas secoes: camada de negocio + camada de arquitetura
  4. **Aprovacao Condicional:**
     - Se Change Plan vazio (sem impacto): aprovacao dispensada, spec flui para implementacao
     - Se houver impacto: aprovacao roteada por camada afetada (Domain Expert p/ negocio, Architect p/ arquitetura)
     - Especificacoes que afetam ambas camadas exigem ambas aprovacoes
  5. **Implementacao:** Somente apos aprovacoes pertinentes, IA implementa a especificacao

### 1.5 Etapa 3 — Canon Enrichment (Retroalimentacao da Product Canon)

- **O que e:** Retroalimentacao formal da Product Canon com descobertas emergentes da implementacao.
- **Dois componentes:**

  **Componente 1 — Integracao de Change Plans aprovados:**
  - Change Plans do Canon Building e `incremental-plan` da Etapa 2 sao refletidos na Product Canon
  - Mecanicamente seguro — decisoes ja tomadas e aprovadas
  - Via Versionamento por Estrangulamento quando aplicavel

  **Componente 2 — Descobertas emergentes da implementacao:**
  - Identificacao por dois mecanismos: sinalizacao explicita (`// CANON-DISCOVERY: [descricao]`) + deteccao assistida pela IA
  - Fluxo de aprovacao leve com escalacao condicional:
    1. IA formaliza descoberta e submete aos guardrails
    2. Sem problemas detectados → revisao assincrona (janela de veto); expiracao = aprovacao tacita
    3. Com problemas detectados → escalacao para Canonical Change Plan formal do tipo apropriado
  - Guardrails como mecanismo de triagem: mesmos criterios de deteccao, consequencia diferente

- **Resultado:** Glossario atualizado, eventos registrados, regras incorporadas, ADRs formalizados, principios atualizados. Tudo versionado e disponivel como contexto futuro.
- **Loop:** Volta para Etapa 1 ou Etapa 2 — ciclo continuo que se retroalimenta.

### 1.6 Papeis (resumo de atuacao)

| Papel | Descricao | Atuacao principal |
|-------|-----------|-------------------|
| Domain Builder | Analista de negocio/PO/gestor que conhece o produto | Autor das cerimonias conversacionais; escreve specs; decide continuidade |
| Architect | Autoridade sobre decisoes tecnicas e estruturais | Conduz Technical Constitution; aprovador tecnico em todos os gates |
| Domain Expert | Guardiao da integridade semantica do dominio | Aprovador semantico; edicao direta; hotspots; anotacoes contextuais |
| IA (Agentes LLM) | Mediador sem autonomia decisoria | Conduz sessoes; gera Change Plans; opera guardrails; implementa codigo |

**Protocolo de Perspectiva Assistida:** Uma pessoa pode acumular papeis. A IA apresenta perguntas especificas por perspectiva para garantir que cada papel e exercido de forma diferenciada.

---

## 2. Estrategia de Implementacao

### 2.1 Decisao: Astro-First

A secao sera implementada como **componente Astro puro** (`.astro`), sem React. Justificativa:
- Nao ha interatividade que exija state management ou bibliotecas JS
- A secao e narrativa/informativa — o usuario percorre verticalmente
- Animacoes de scroll-reveal ja existem no projeto (componente `ScrollReveal`)
- Conforme Principio III da constituicao: "React somente se houver interatividade real necessaria"

### 2.2 Tipo de Layout: Timeline Vertical Narrativa

A secao usara um layout de **timeline vertical** com cards de processo revelados via scroll:

- **Desktop (>= 1024px):** Timeline central com cards alternando esquerda/direita. Linha vertical conectora com pontos de conexao nos nodes. Cards com ilustracao SVG inline + texto descritivo.
- **Tablet (768px-1023px):** Timeline alinhada a esquerda, todos os cards a direita.
- **Mobile (< 768px):** Cards empilhados verticalmente sem timeline visivel, separadores visuais entre processos.

### 2.3 Estrutura Visual dos Blocos

Cada processo sera representado por um **card de processo** com:
- Icone/ilustracao SVG inline representando a etapa (aurora palette)
- Titulo do processo
- Descricao curta (1-2 frases)
- Badge de papeis envolvidos (com cores distintas por papel)
- Indicador de tipo: cerimonia | gate | decisao | guardrail | canal
- Conexoes visuais: setas/linhas para o proximo processo e loops de retorno

### 2.4 Animacoes

- `ScrollReveal` com `fade-up` e delays incrementais (padrao existente)
- Linha da timeline desenhada progressivamente via CSS `@keyframes` (desenho de borda com `stroke-dashoffset`)
- Pontos de conexao com pulse glow ao entrar no viewport
- `prefers-reduced-motion`: desativa animacoes, mostra tudo estaticamente (Principio V)

### 2.5 Representacao Visual de Elementos Especiais

- **Gates de aprovacao:** Cards com borda destacada em `--color-aurora-pink`, icone de escudo/cadeado
- **Guardrails transversais:** Barra lateral continua com gradiente aurora que acompanha toda a Etapa 1, representando que operam em todas as cerimonias
- **Loops de retorno:** Setas curvas em CSS/SVG que conectam a Decisao de Continuidade de volta as cerimonias anteriores
- **Canal complementar (Edicao Direta):** Card lateral deslocado da timeline principal, conectado por linha tracejada
- **Tres etapas principais:** Agrupadas visualmente com headers de etapa e background diferenciado (section-odd/section-even alternando por sub-secao)
- **Condicionalidade (Etapa 2):** Indicador visual de bifurcacao (com/sem impacto)

### 2.6 Agrupamento por Etapa

A secao sera dividida em sub-secoes visuais:

1. **Header da secao** — SectionHeader padrao com titulo "Processo Tecnico Completo"
2. **Bloco Etapa 1** — Canon Building (4 cerimonias + decisao de continuidade + guardrails)
3. **Bloco Canal Complementar** — Edicao Direta (posicionado lateralmente)
4. **Bloco Etapa 2** — Spec Crafting (injecao + validacao + change plan + aprovacao)
5. **Bloco Etapa 3** — Canon Enrichment (integracao + descobertas + loop de retorno)
6. **Indicador de ciclo** — Seta visual de retorno ao inicio

---

## 3. Inventario de Processos Visuais

Cada bloco/card do diagrama com seus atributos:

### Etapa 1 — Canon Building

| # | Titulo | Descricao | Ilustracao SVG Proposta | Papeis | Conexoes |
|---|--------|-----------|------------------------|--------|----------|
| 1 | Domain Discovery Session | Sessao conversacional de Event Storming digital. Domain Builder descreve fluxos, IA organiza em eventos, comandos, atores e bounded contexts. | Post-its empilhados em timeline com aurora glow (--color-aurora-green) | Domain Builder, IA | → Gate 1 |
| 2 | Gate: Aprovacao Discovery | Canonical Change Plan `discovery-plan`. Aprovacao primaria pelo Domain Expert, secundaria pelo Architect. | Escudo com checkmarks duplos em aurora-pink | Domain Expert, Architect | → Technical Constitution |
| 3 | Technical Constitution Session | Architect define principios tecnicos: stack, comunicacao, persistencia, seguranca, observabilidade, nivel IEEE 29148. | Pilares/colunas estruturais com engrenagem (--color-aurora-cyan) | Architect, IA | → Gate 2 |
| 4 | Gate: Aprovacao Constitution | Canonical Change Plan `constitution-plan`. Aprovacao primaria pelo Architect, secundaria pelo Domain Expert. | Escudo com checkmarks duplos em aurora-pink | Architect, Domain Expert | → Requirements Specification |
| 5 | Requirements Specification Session | Formalizacao iterativa de requisitos em IEEE 29148 + SBE. Ciclo de clarificacao e validacao semantica. | Documento com lupa e ciclo iterativo (--color-aurora-violet) | Domain Builder, IA | → Gate 3 |
| 6 | Gate: Aprovacao Specification | Canonical Change Plan `specification-plan`. Aprovacao primaria pelo Domain Expert, secundaria pelo Architect. | Escudo com checkmarks duplos em aurora-pink | Domain Expert, Architect | → Decisao de Continuidade |
| 7 | Decisao de Continuidade | Tres caminhos: mais fluxos (→ Discovery), mais requisitos (→ Specification), encerrar (→ Etapa 2). Checkpoint IEEE 29148. | Losango de decisao com tres setas divergentes (--color-aurora-blue) | Domain Builder, IA | → Discovery / Specification / Etapa 2 |

### Guardrails Transversais (representados como barra lateral)

| # | Titulo | Descricao | Representacao Visual |
|---|--------|-----------|---------------------|
| G1 | Clarificacao de Conformidade | Alinhamento terminologico com glossario e principios tecnicos | Icone de livro aberto |
| G2 | Validacao de Consistencia | Confronto com estado atual da Product Canon | Icone de balanca |
| G3 | Validacao Semantica Interna (SBVR) | Deteccao de ambiguidade, incompletude, contradicao | Icone de lupa com exclamacao |
| G4 | Padronizacao Canonica | Formato IEEE 29148 + SBE conforme nivel de aderencia | Icone de template/formulario |
| G5 | Versionamento por Estrangulamento | Faces current/next para mudancas estruturais | Icone de arvore com ramificacao |

### Canal Complementar

| # | Titulo | Descricao | Ilustracao SVG Proposta | Papeis | Conexoes |
|---|--------|-----------|------------------------|--------|----------|
| C1 | Edicao Direta do Domain Expert | Canal complementar para refinamentos fora das cerimonias. Ciclo iterativo de guardrails antes do Change Plan. | Caneta sobre documento com linha tracejada (--color-aurora-cyan) | Domain Expert, IA | → Gate Edicao Direta |
| C2 | Gate: expert-edit-plan | Aprovacao sequencial: Domain Expert (1o, fidelidade) → Architect (2o, impacto tecnico, obrigatorio). | Escudo sequencial com setas | Domain Expert, Architect | → Product Canon |

### Etapa 2 — Spec Crafting

| # | Titulo | Descricao | Ilustracao SVG Proposta | Papeis | Conexoes |
|---|--------|-----------|------------------------|--------|----------|
| 8 | Injecao de Contexto | IA carrega seletivamente fragmentos relevantes da Product Canon na janela de contexto. | Funil com fragmentos coloridos entrando (--color-aurora-green) | IA | → Clarificacao |
| 9 | Clarificacao e Validacao | Termos inconsistentes sinalizados, contradicoes flagradas, dependencias identificadas. | Lupa sobre documento com highlights (--color-aurora-cyan) | Domain Builder/Architect, IA | → Change Plan |
| 10 | Canonical Change Plan Incremental | `incremental-plan` gerado automaticamente. Duas secoes: camada de negocio + camada de arquitetura. | Documento dividido em duas metades (verde=negocio, azul=arquitetura) | IA | → Aprovacao Condicional |
| 11 | Aprovacao Condicional | Se vazio: dispensada. Se impacto: roteada por camada afetada. | Bifurcacao com caminho direto e caminho com escudo (--color-aurora-pink) | Domain Expert, Architect | → Implementacao |
| 12 | Implementacao | IA implementa codigo apos aprovacoes pertinentes. | Terminal/codigo com check (--color-aurora-green) | IA | → Etapa 3 |

### Etapa 3 — Canon Enrichment

| # | Titulo | Descricao | Ilustracao SVG Proposta | Papeis | Conexoes |
|---|--------|-----------|------------------------|--------|----------|
| 13 | Integracao de Change Plans | Change Plans aprovados refletidos na Product Canon via Versionamento por Estrangulamento. | Documento com seta entrando em repositorio (--color-aurora-violet) | IA | → Product Canon |
| 14 | Descobertas Emergentes | Sinalizacao explicita (CANON-DISCOVERY) + deteccao assistida pela IA. | Lampada com exclamacao e radar (--color-aurora-cyan) | Desenvolvedor, IA | → Triagem |
| 15 | Triagem por Guardrails | Sem problemas: revisao assincrona. Com problemas: escalacao para Change Plan formal. | Filtro/peneira com dois caminhos (--color-aurora-blue) | Guardrails, IA | → Revisao ou Escalacao |
| 16 | Product Canon Atualizada | Glossario, eventos, regras, ADRs, principios — tudo versionado e disponivel para ciclos futuros. | Repositorio brilhante com aurora glow (gradiente completo) | Todos | → Loop para Etapa 1/2 |

---

## 4. Estrutura de Componentes

### 4.1 Arquivos a Criar

```
src/components/sections/FullProcessSection.astro    — Secao principal (nova)
src/components/ui/ProcessCard.astro                  — Card reutilizavel de processo (novo)
src/components/ui/ProcessGate.astro                  — Card de gate de aprovacao (novo)
src/components/ui/ProcessTimeline.astro              — Linha/conector da timeline (novo)
src/components/ui/GuardrailBar.astro                 — Barra lateral de guardrails (novo)
src/components/ui/EtapaHeader.astro                  — Header de sub-secao de etapa (novo)
```

### 4.2 Arquivos a Modificar

```
src/pages/index.astro                                — Adicionar FullProcessSection (posicao 13)
                                                       Renumerar secoes 13→14, 14→15, 15→16, 16→17
src/components/layout/StickyNav.astro                — Adicionar item "processo-completo" na posicao correta
```

### 4.3 Hierarquia de Componentes

```
FullProcessSection.astro
├── SectionHeader (sectionNumber=13, title="Processo Tecnico Completo")
├── EtapaHeader (etapa=1, titulo="Canon Building")
│   ├── GuardrailBar (guardrails G1-G5)
│   ├── ProcessTimeline
│   │   ├── ProcessCard (Domain Discovery Session)
│   │   ├── ProcessGate (Gate Discovery)
│   │   ├── ProcessCard (Technical Constitution)
│   │   ├── ProcessGate (Gate Constitution)
│   │   ├── ProcessCard (Requirements Specification)
│   │   ├── ProcessGate (Gate Specification)
│   │   └── ProcessCard (Decisao de Continuidade — com loops)
│   └── ProcessCard.lateral (Edicao Direta — canal complementar)
│       └── ProcessGate (Gate expert-edit-plan)
├── EtapaHeader (etapa=2, titulo="Spec Crafting")
│   ├── ProcessTimeline
│   │   ├── ProcessCard (Injecao de Contexto)
│   │   ├── ProcessCard (Clarificacao e Validacao)
│   │   ├── ProcessCard (Change Plan Incremental)
│   │   ├── ProcessGate (Aprovacao Condicional — com bifurcacao)
│   │   └── ProcessCard (Implementacao)
├── EtapaHeader (etapa=3, titulo="Canon Enrichment")
│   ├── ProcessTimeline
│   │   ├── ProcessCard (Integracao de Change Plans)
│   │   ├── ProcessCard (Descobertas Emergentes)
│   │   ├── ProcessCard (Triagem por Guardrails)
│   │   └── ProcessCard (Product Canon Atualizada)
└── Loop visual (seta de retorno ao inicio)
```

### 4.4 Props dos Componentes

**ProcessCard.astro:**
```typescript
interface Props {
  title: string;
  description: string;
  icon: string;           // SVG inline content ou referencia
  roles: string[];        // ["Domain Builder", "IA"]
  type: 'ceremony' | 'decision' | 'process' | 'complementary';
  accentColor: string;    // token CSS: "--color-aurora-green"
  position?: 'left' | 'right' | 'lateral';  // para timeline alternada
}
```

**ProcessGate.astro:**
```typescript
interface Props {
  title: string;
  planType: string;       // "discovery-plan", "constitution-plan", etc.
  primaryApprover: string;
  secondaryApprover: string;
  isSequential?: boolean; // para expert-edit-plan (sem janela de veto)
}
```

**EtapaHeader.astro:**
```typescript
interface Props {
  etapaNumber: 1 | 2 | 3;
  title: string;
  subtitle?: string;
}
```

**GuardrailBar.astro:**
```typescript
interface Props {
  guardrails: Array<{
    icon: string;
    title: string;
    description: string;
  }>;
}
```

---

## 5. Design Visual

### 5.1 Tokens a Utilizar

**Cores por etapa:**
- Etapa 1 (Canon Building): `--color-aurora-green` como cor dominante
- Etapa 2 (Spec Crafting): `--color-aurora-cyan` como cor dominante
- Etapa 3 (Canon Enrichment): `--color-aurora-violet` como cor dominante
- Gates de aprovacao: `--color-aurora-pink` em todas as etapas
- Decisoes: `--color-aurora-blue`

**Cores por papel (badges):**
- Domain Builder: `--color-aurora-green`
- Architect: `--color-aurora-cyan`
- Domain Expert: `--color-aurora-violet`
- IA: `--color-aurora-blue`

**Backgrounds:**
- Secao: `var(--color-bg-secondary)` (section-odd, pois secao 13 e impar)
- Cards: `var(--color-bg-tertiary)` com `var(--border-subtle)`
- Gates: Borda `var(--color-aurora-pink)` com `var(--shadow-glow-violet)`

**Espacamento:**
- Padding da secao: `var(--space-24) 0`
- Gap entre cards na timeline: `var(--space-12)`
- Padding interno dos cards: `var(--space-6)`
- Gap entre etapas: `var(--space-16)`

**Tipografia:**
- Titulos de etapa: `var(--text-3xl)` com `font-weight: var(--font-bold)`
- Titulos de cards: `var(--text-xl)` com `font-weight: var(--font-semibold)`
- Descricoes: `var(--text-base)` com `line-height: var(--leading-normal)`
- Badges de papeis: `var(--text-xs)` com `font-family: var(--font-mono)`

**Sombras e efeitos:**
- Cards com hover: `var(--shadow-glow-cyan)` ou variante por etapa
- Timeline line: borda de 2px com gradiente aurora
- Pontos de conexao: circulos com pulse animation e aurora glow

### 5.2 Layout Responsivo

**Desktop (>= 1024px):**
```
          [GuardrailBar]
               |
    [Card]-----|-----[Gate]
               |
    [Gate]-----|-----[Card]
               |
    [Card]-----|-----[Gate]
               |
          [Decisao]
     [Edicao Direta] ----' (lateral, linha tracejada)
```

**Tablet (768px-1023px):**
```
  |  [Card]
  |  [Gate]
  |  [Card]
  |  [Gate]
  |  [Decisao]
  [Edicao Direta]
```

**Mobile (< 768px):**
```
  [Card]
  ------
  [Gate]
  ------
  [Card]
  ------
  [Gate]
  ------
  [Decisao]
  ------
  [Edicao Direta]
```

### 5.3 SVGs

Todas as ilustracoes serao SVG inline nos componentes Astro, usando exclusivamente cores da paleta aurora via `currentColor` ou tokens CSS diretos. Estilo: lineart/outline com glow, coerente com a identidade Borealis (fundo escuro, tracos luminosos).

Dimensoes padrao dos icones: 64x64px em mobile, 80x80px em desktop.

---

## 6. Checklist de Aderencia a Constituicao

| Principio | Requisito | Como sera atendido | Status |
|-----------|-----------|-------------------|--------|
| I. Token-Driven Theming | Todas as propriedades visuais via CSS custom properties de tokens.css | Nenhum valor hardcoded; todas as cores, espacamentos, tipografia e sombras usando `var(--token)` | Planejado |
| II. Component Architecture | Hierarquia correta de diretorios | `FullProcessSection.astro` em `sections/`; `ProcessCard`, `ProcessGate`, etc. em `ui/`; sem componentes em `diagrams/` (nao e React) | Planejado |
| III. Astro-First, React Islands | React somente para interatividade real | Secao 100% Astro — sem React, sem `client:*` directives. Animacoes via CSS + ScrollReveal existente | Planejado |
| IV. Borealis Visual Identity | Dark-first, aurora gradients, alternancia section-odd/even | Secao 13 = section-odd. Paleta aurora completa. Glow effects nos SVGs e timeline | Planejado |
| V. Accessibility First | WCAG 2.1 AA, prefers-reduced-motion, aria labels, contraste | `aria-labelledby` na section; `alt` descritivo nos SVGs; animacoes desativadas com `prefers-reduced-motion: reduce`; contraste >= 4.5:1 | Planejado |
| VI. Progressive Depth System | SectionHeader com depth | `depth={2}` (Detailed) — conteudo tecnico que detalha o processo completo | Planejado |
| VII. Section Composition Pattern | ScrollReveal + SectionHeader + max-width-content | Segue padrao exato das secoes existentes (ScrollReveal com delays incrementais) | Planejado |
| VIII. Performance & Progressive Enhancement | content-visibility: auto, lazy rendering | `content-visibility: auto` na secao. SVGs inline (sem requests extras). Sem JS adicional | Planejado |

---

## 7. Notas de Implementacao

### 7.1 Ordem de Implementacao Sugerida

1. Criar `ProcessCard.astro` e `ProcessGate.astro` (componentes base)
2. Criar `ProcessTimeline.astro` e `EtapaHeader.astro`
3. Criar `GuardrailBar.astro`
4. Criar `FullProcessSection.astro` montando todos os componentes
5. Desenhar SVGs inline para cada processo
6. Modificar `index.astro` (adicionar secao, renumerar)
7. Modificar `StickyNav.astro` (adicionar item de navegacao)
8. Testar responsividade (desktop, tablet, mobile)
9. Testar acessibilidade (screen reader, contraste, reduced motion)

### 7.2 Conteudo em pt-BR

Todo o conteudo textual da secao deve estar em portugues brasileiro, consistente com o restante do site.

### 7.3 SVGs como Componentes

Cada ilustracao SVG pode ser extraida para um componente Astro separado em `src/components/ui/icons/` se a complexidade justificar, ou mantida inline no ProcessCard se for simples (< 20 linhas de SVG). Decisao a tomar durante implementacao.
