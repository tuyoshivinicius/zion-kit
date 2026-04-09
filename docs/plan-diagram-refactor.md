# Plano de Refatoracao dos Diagramas ZionKit

## Resumo Executivo

Os 12 diagramas do ZionKit (10 React Flow + 2 Astro) sofrem de problemas criticos de responsividade, legibilidade em mobile, e overhead de bundle desnecessario. A biblioteca `@xyflow/react` (ReactFlow) + `elkjs` adiciona ~200KB de JavaScript para renderizar diagramas que nao possuem nenhuma interatividade (drag, pan, zoom estao todos desabilitados). Em viewports mobile, o `fitView` encolhe tudo proporcionalmente, tornando texto ilegivel e nós cortados.

**Proposta:** Eliminar `@xyflow/react` e `elkjs` completamente, substituindo por uma abordagem hibrida que combina:
- **CSS Grid/Flexbox cards** para layout responsivo dos nos
- **SVG overlay leve** para conectores onde necessario
- **Timeline components** (ja existente no codebase) para fluxos sequenciais
- **Manutencao das 2 Astro components** que ja funcionam bem

**Impacto esperado:** ~200KB de JS removido, texto legivel em todos os viewports, responsividade nativa mobile-first, manutencao simplificada.

---

## Inventario dos Diagramas Atuais

### Diagramas React Flow (10)

| # | Componente | Secao | Nos | Edges | Altura | Topologia | Layout |
|---|-----------|-------|-----|-------|--------|-----------|--------|
| 1 | `ContextVoidDiagram` | HeroSection (#problema) | 4 | 3 | 350px | Linear com branch | Manual |
| 2 | `ThreeGapsDiagram` | ConsequenciasSection (#consequencias) | 3 | 2 | 180px | 3 cards horizontais | Manual |
| 3 | `CycleDiagram` | CycleOverviewSection (#ciclo) | 6 | 7 | 680px | Ciclico multi-path | Manual |
| 4 | `CanonBuildingDiagram` | CanonBuildingSection (#canon-building) | 6 | 5 | 380px | 3 colunas sequenciais | Manual |
| 5 | `CeremonyFlowDiagram` | CanonBuildingSection (#canon-building) | 7 | 6 | 620px | Linear vertical + feedback loops | Manual |
| 6 | `ContextualSpecDiagram` | SpecCraftingSection (#spec-crafting) | 3 | 2 | 550px | Vertical simples | Manual |
| 7 | `FeedbackDiagram` | EnrichmentSection (#enrichment) | 7 | 8 | 580px | Bifurcacao + merge | Manual |
| 8 | `GuardrailsDiagram` | GuardrailsSection (#guardrails) | 9 | 12 | 550px | Radial/hub-spoke | Manual |
| 9 | `DirectEditFlowDiagram` | DirectEditSection (#edicao-direta) | 7 | 6 | 550px | Linear com loop iterativo | Manual |
| 10 | `ChangePlanEnvelopeDiagram` | ChangePlanSection (#change-plan) | 11 | 9 | 700px | Hierarquico | Manual |

### Diagramas Astro (2)

| # | Componente | Secao | Tipo | Status |
|---|-----------|-------|------|--------|
| 11 | `RolesMatrixDiagram` | RolesSection (#papeis) | Tabela HTML | Em uso, funcional |
| 12 | `BeforeAfterDiagram` | - | CSS Grid comparacao | Orfao (nao importado em nenhuma secao) |

### Arquivos de Dados Compartilhados

- `src/lib/diagrams/shared-config.ts` — Config de ReactFlow (desabilitado: drag, pan, zoom)
- `src/lib/diagrams/use-responsive-flow.ts` — Hook para breakpoint 768px
- `src/lib/diagrams/use-elk-layout.ts` — Hook de layout ELK (nao utilizado na pratica — todos usam layout manual)
- `src/lib/diagrams/use-reduced-motion.ts` — Hook para `prefers-reduced-motion`
- `src/components/ui/NodeCard.tsx` — Card compartilhado com 7 variantes de cor
- `src/components/ui/DiagramContainer.astro` — Wrapper com titulo e padding

---

## Problemas Identificados

### P1 — Responsividade Quebrada em Mobile (Critico)

**Evidencia visual:** Screenshots mobile (375px) mostram:
- `ContextVoidDiagram`: Apenas 1 de 4 nos visivel. Os demais cortados ou fora do viewport.
- `CycleDiagram`: Product Canon (no principal) cortado no topo, "Etapa 3" e "Edicao Direta" cortados na direita. Textos truncados ("3 sessoes formais com aprov..." / "a) Mais fluxos -> Specifica...").
- `GuardrailsDiagram`: Texto cortado em multiplos nos ("Alinhamento terminologico..." / "Deteccao de ambiguidade..."). Layout radial nao funciona em tela estreita.

**Causa raiz:** ReactFlow usa um viewport interno com `transform: scale()`. O `fitView` reduz tudo proporcionalmente — em 375px de largura, diagramas de 960px sao reduzidos a ~39% do tamanho original. Texto de 14px renderiza como ~5.5px, abaixo do minimo legivel.

### P2 — Bundle Size Desnecessario

- `@xyflow/react`: ~150KB gzipped
- `elkjs/lib/elk.bundled.js`: ~50KB gzipped (importado dinamicamente, mas ainda carregado)
- Toda essa carga para diagramas com interatividade completamente desabilitada (`nodesDraggable: false, panOnDrag: false, panOnScroll: false, zoomOnScroll: false`)

### P3 — Alturas Fixas Criam Espaco Desperdicado

Cada diagrama tem uma altura fixa em pixels (180px a 700px) definida no container ReactFlow. Em desktop, isso cria grandes areas vazias ao redor de diagramas menores. Em mobile, a altura fixa nao acomoda o reflow do conteudo.

### P4 — Layout Manual Fragilizado

Todos os 10 diagramas React usam posicionamento manual de nos (`position: { x: N, y: N }`). Comentarios no codigo confirmam que ELK foi abandonado:
- `cycle-diagram.ts`: *"ELK stress nao produz bom resultado com smoothstep edges em grafos ciclicos"*
- `canon-building-diagram.ts`: Layout manual necessario porque ELK hierarquico cria coluna unica
- `change-plan-envelope-diagram.ts`: ELK hierarquico comprime 11 nos em coluna estreita

### P5 — Labels de Edges Pequenos e Pouco Legiveis

Edge labels como "vazio", "resultado", "contexto injetado", "descobertas", "mais fluxos / requisitos" sao renderizados com fonte minuscula dentro do viewport SVG do ReactFlow, tornando-se praticamente invisiveis em mobile.

### P6 — Titulo Raw no CeremonyFlowDiagram

O titulo exibido e "CEREMONYFLOWDIAGRAM" (nome do componente em maiusculas) ao inves de um titulo descritivo como os demais diagramas. Isso e um bug no DiagramContainer ou na prop `title`.

### P7 — BeforeAfterDiagram Orfao

O componente existe em `src/components/diagrams/BeforeAfterDiagram.astro` mas nao e importado em nenhuma secao. A `ComparisonSection` usa `ComparisonRow` components diretamente.

---

## Estrategias de Visualizacao Pesquisadas

### Analise Comparativa

| Criterio | CSS-Only | SVG Estatico | React+Grid | Timeline | Path Animado | Cards Infografico | Grid Matrix | Stepper | Hibrido (SVG+Cards) |
|----------|----------|-------------|------------|----------|-------------|-------------------|-------------|---------|---------------------|
| **JS Bundle** | 0 KB | 0 KB | ~2 KB | 0 KB | ~5 KB (GSAP) | 0 KB | 0 KB | ~1 KB | ~3-5 KB |
| **Legibilidade Mobile** | Excelente | Ruim-Media | Excelente | Excelente | Boa | Excelente | Moderada | Boa | Excelente |
| **Fidelidade Visual** | Baixa-Media | Alta | Media | Media | Alta | Baixa-Media | N/A | Baixa | Alta |
| **Esforco Impl.** | Baixo | Alto | Medio | Baixo (existe) | Medio-Alto | Baixo | Baixo (existe) | Baixo | Medio |
| **Fluxos Lineares** | Bom | Bom | Bom | Excelente | Bom | Bom | N/A | Excelente | Bom |
| **Fluxos Ciclicos** | Ruim | Bom | Ruim | Ruim | Bom | Ruim | N/A | N/A | Bom |
| **Fluxos Hierarquicos** | Medio | Bom | Bom | Medio | Bom | Medio | N/A | N/A | Bom |
| **Comparacao/Matriz** | N/A | N/A | Medio | N/A | N/A | N/A | Excelente | N/A | N/A |
| **Compat. Tema Borealis** | Boa | Superba | Excelente | Excelente | Excepcional | Excelente | Boa | Muito Boa | Excelente |
| **Manutencao** | Baixa | Alta | Baixa | Baixa | Media | Baixa | Baixa | Baixa | Media |

### Descricao das Estrategias

#### 1. CSS-Only Flowcharts (Flexbox/Grid + Pseudo-elements)
Nos como `<div>` em Flex/Grid. Conectores via `::before`/`::after` com borders e CSS triangles. Zero JS. Excelente responsividade — `flex-direction` muda de `row` para `column` em mobile. Limitacao: topologias complexas (ciclos, cross-edges) sao dificeis.

#### 2. SVG Estatico com Animacoes CSS
SVG hand-crafted com `viewBox` para escalabilidade. `<foreignObject>` para texto HTML dentro do SVG. Animacoes via `@keyframes` em elementos SVG. Problema: texto encolhe proporcionalmente como ReactFlow (mesmo issue). Solucao: dois SVGs (desktop/mobile), mas duplica manutencao.

#### 3. React Component-Based (CSS Grid sem biblioteca de grafos)
Nos como React components em CSS Grid. Reusa `NodeCard` data model sem ReactFlow. Grid reflow natural: `grid-template-columns: repeat(3, 1fr)` -> `1fr` em mobile. Conectores simplificados (setas CSS ou SVG overlay leve).

#### 4. Vertical Timeline
Ja implementado no codebase como `ProcessTimeline.astro` + `ProcessCard.astro`. Linha vertical central com dots e cards alternados. Tres breakpoints responsivos (alternado -> esquerda -> empilhado). Ideal para fluxos sequenciais com gates.

#### 5. Animated Path Diagrams (SVG stroke-dashoffset)
Paths SVG que "se desenham" via animacao de `stroke-dashoffset`. Efeito visual impressionante (neon wire drawing), mas paths precisam ser recalculados em resize. GSAP `ScrollTrigger` ja disponivel no projeto. Melhor usado seletivamente (1-2 diagramas hero).

#### 6. Infographic-Style Cards com Conectores
Cards estilizados com icones, badges de cor, e setas direcionais simples entre eles. Enfase no conteudo, nao na topologia. Excelente para diagramas explanatorios onde clareza > precisao topologica.

#### 7. CSS Grid Matrix
Tabela/matriz via CSS Grid com sticky headers. Ja implementado em `RolesMatrixDiagram.astro`. Scroll horizontal com fade mask em mobile. Ideal exclusivamente para dados matriciais.

#### 8. Stepper/Wizard
Circulos numerados conectados por linhas, com painel de conteudo expandivel. Compacto e familiar. Limitado a fluxos lineares sem branching.

#### 9. Hibrido (Cards CSS + SVG Overlay Leve)
Nos como HTML/React em CSS Grid (responsivo), com camada SVG absoluta calculando paths entre elementos via `getBoundingClientRect()` + `ResizeObserver`. Melhor equilibrio: texto legivel em qualquer viewport + conectores visuais preservados. ~3-5KB de JS custom vs ~200KB ReactFlow.

---

## Estrategia Escolhida

### Abordagem: Mix de Estrategias por Tipo de Diagrama

Nao existe uma solucao unica ideal para todos os 12 diagramas. A topologia, complexidade e proposito de cada um demanda a estrategia mais adequada. A distribuicao recomendada:

| Estrategia | Diagramas | Justificativa |
|-----------|-----------|--------------|
| **Hibrido (SVG+Cards)** | CycleDiagram, FeedbackDiagram, GuardrailsDiagram | Topologias complexas (ciclos, bifurcacoes, hub-spoke) que precisam de conectores visuais mas tambem de texto legivel |
| **Timeline** | CeremonyFlowDiagram, DirectEditFlowDiagram | Fluxos sequenciais com gates — mapeiam perfeitamente para timeline vertical. Componente ja existe |
| **Infographic Cards** | ContextVoidDiagram, ThreeGapsDiagram, ContextualSpecDiagram | Diagramas explanatorios simples onde a clareza do conteudo importa mais que topologia precisa |
| **Stepper + Cards** | CanonBuildingDiagram, ChangePlanEnvelopeDiagram | Fluxos hierarquicos/sequenciais com muitos nos — stepper compacto + detalhamento expandivel |
| **Manter (Grid Matrix)** | RolesMatrixDiagram | Ja funcional e responsivo. Ajustar apenas mobile UX |
| **Avaliar remocao** | BeforeAfterDiagram | Componente orfao. Decidir se integra na ComparisonSection ou remove |

### Justificativa Geral

1. **Elimina ReactFlow + ELK completamente** — ~200KB de JS removido
2. **Texto nunca encolhe** — nos estao no document flow, nao em viewport escalado
3. **Responsividade nativa** — CSS Grid/Flexbox reflui sem calculo de viewport
4. **Reutiliza componentes existentes** — ProcessTimeline, ProcessCard, NodeCard data model
5. **Conectores visuais preservados onde importam** — SVG overlay leve para os 3 diagramas complexos
6. **Aderencia ao tema Borealis** — mesmas variaveis CSS, glows, gradientes aurora
7. **Acessibilidade melhorada** — HTML semantico, `aria-flowto`, `prefers-reduced-motion`

---

## Redesign por Diagrama

### 3.1 — ContextVoidDiagram (O Vazio de Contexto)

**Estrategia:** Infographic Cards

**Conceito:** Tres cards horizontais (desktop) / empilhados (mobile) representando o pipeline `Conhecimento -> Especificacao -> Codigo`, com um quarto card abaixo mostrando o resultado ("Bugs de logica de negocio"). A "ruptura" entre Conhecimento e Especificacao e representada por um gap visual + icone de alerta, nao por uma edge dashed.

**Layout:**
```
Desktop:
[Conhecimento] ---X--- [Especificacao] -----> [Codigo gerado]
                 gap                              |
                                                  v
                                    [Bugs de logica de negocio]

Mobile (empilhado):
[Conhecimento]
     X (gap visual)
[Especificacao]
     |
[Codigo gerado]
     |
[Bugs de logica de negocio]
```

**Implementacao:**
- Container: CSS Grid `grid-template-columns: 1fr auto 1fr auto 1fr` (desktop) / `1fr` (mobile)
- Cards: Reusar estilo `NodeCard` (variantes `problem`, `default`)
- Gap visual: Icone de ruptura (relampago ou X) com animacao pulse vermelha
- Seta "resultado": Pseudo-element `::after` com border + triangle CSS
- Componente: Astro puro (zero JS)

**Responsividade:**
- `@media (max-width: 768px)`: Grid muda para coluna unica, setas rotacionam para vertical
- Texto permanece em tamanho nativo (14-16px)

**Aderencia Borealis:**
- Cards com `background: var(--color-bg-elevated)`, `border: 1px solid var(--color-border-default)`
- Card de bugs: `border-left: 3px solid var(--color-semantic-problem)`
- Gap: `color: var(--color-semantic-problem)` com `box-shadow: var(--shadow-glow-cyan)` invertido para vermelho

---

### 3.2 — ThreeGapsDiagram (Os Tres Gaps)

**Estrategia:** Infographic Cards

**Conceito:** Tres cards lado a lado (desktop) / empilhados (mobile), cada um representando um gap. Sem conectores — os cards ja comunicam "tres problemas independentes". Dashed border ao redor de cada card reforco o tema de "desconexao".

**Layout:**
```
Desktop:
[IA sem Contexto]   [Negocio Excluido]   [Conhecimento Descartavel]

Mobile:
[IA sem Contexto]
[Negocio Excluido]
[Conhecimento Descartavel]
```

**Implementacao:**
- CSS Grid: `grid-template-columns: repeat(3, 1fr); gap: var(--space-6)`
- Mobile: `grid-template-columns: 1fr`
- Cards: `border: 2px dashed var(--color-semantic-problem)` com `border-radius: var(--radius-lg)`
- Icone + titulo + descricao dentro de cada card
- Componente: Astro puro (zero JS)

**Responsividade:** Trivial — grid reflow natural. Sem conectores para gerenciar.

---

### 3.3 — CycleDiagram (O Ciclo ZionKit)

**Estrategia:** Hibrido (Cards CSS Grid + SVG Overlay)

**Conceito:** Este e o diagrama mais complexo do site — topologia ciclica com 6 nos e 7 edges, incluindo feedback loops e canal complementar. Precisa de conectores visuais para comunicar o ciclo. A abordagem hibrida coloca os nos em CSS Grid (responsivo) com SVG paths calculados dinamicamente.

**Layout Desktop:**
```
                [Product Canon]
                  /         \
    contexto injetado    descobertas
              /               \
[Etapa 1 — Construir]  [Etapa 3 — Devolver]
        |                       |
        v                       |
[Decisao de Continuidade]  [Edicao Direta]
        |
        v
[Etapa 2 — Especificar]
```

**Layout Mobile (empilhado com setas):**
```
[Product Canon]
      |  contexto injetado
[Etapa 1 — Construir]
      |
[Decisao de Continuidade]
      |  encerrar ciclo
[Etapa 2 — Especificar]
      |  descobertas
[Etapa 3 — Devolver]
      |
[Edicao Direta] (canal complementar)
      ^  feedback para Product Canon
```

**Implementacao:**
- Novo componente React: `CycleDiagramV2.tsx`
- Grid desktop: `grid-template-areas` para posicionamento 2D preciso
- SVG overlay: `<svg>` absolutamente posicionado com `pointer-events: none`
- Paths SVG calculados via `useLayoutEffect` + `ResizeObserver` no container
- Path function: para smoothstep-like curves, calcular bezier entre centros dos cards
- Edge labels: `<div>` posicionados no midpoint de cada path (HTML, nao SVG text)
- Mobile: grid muda para `1fr`, SVG paths recalculados como linhas verticais simples
- Animacao: `stroke-dashoffset` nos paths com `prefers-reduced-motion` check

**Responsividade:**
- Desktop: Grid 3 colunas com areas nomeadas
- Tablet (768px): Grid 2 colunas
- Mobile (480px): Coluna unica, paths verticais simplificados

**Aderencia Borealis:**
- Paths SVG: `stroke: rgba(34, 211, 238, 0.5)` (cyan atual) com `filter: drop-shadow(0 0 4px rgba(34, 211, 238, 0.3))`
- Canal complementar (Edicao Direta): `border-color: var(--color-aurora-pink)`
- Feedback path: `stroke-dasharray: 8 4` animado

---

### 3.4 — CanonBuildingDiagram (Visao Geral do Canon Building)

**Estrategia:** Stepper + Cards

**Conceito:** O Canon Building e um processo sequencial de 3 sessoes, cada uma seguida por um gate de aprovacao. Um stepper horizontal (desktop) / vertical (mobile) mostra a progressao, com cards expandiveis para detalhes de cada sessao.

**Layout Desktop:**
```
[1. Discovery] --aprovado--> [2. Constitution] --aprovado--> [3. Specification]
   Session           Gate 1        Session            Gate 2       Session        Gate 3
```

**Layout Mobile:**
```
(1) Discovery Session
    Gate 1 — Aprovacao
      |
(2) Technical Constitution Session
    Gate 2 — Aprovacao
      |
(3) Requirements Specification Session
    Gate 3 — Aprovacao
```

**Implementacao:**
- Stepper component reutilizavel: `StepperFlow.astro`
- Cada step: circulo numerado + titulo + badge de gate
- Linha conectora horizontal (desktop) com gradiente cyan->amarelo->cyan
- Vertical em mobile com mesma estetica
- Cards de detalhe abaixo de cada step (sempre visiveis, nao colapsados)
- Componente: Astro puro com CSS animations para hover

**Responsividade:**
- Desktop: `flex-direction: row`, stepper horizontal
- Mobile: `flex-direction: column`, stepper vertical
- Gate badges: `background: var(--color-semantic-warning)` (amarelo)

---

### 3.5 — CeremonyFlowDiagram (Fluxo de Cerimonia Sequencial)

**Estrategia:** Timeline Vertical

**Conceito:** Este diagrama mostra 7 passos sequenciais (3 sessoes + 3 gates + 1 decisao) com 2 feedback loops. A timeline vertical do `ProcessTimeline.astro` e perfeita para isso — ja existe, ja e responsiva, ja tem tres breakpoints.

**Layout (todos os viewports):**
```
Timeline vertical:
  o  Domain Discovery Session
  |    Baseada em Event Storming | Saida: discovery-plan
  |
  o  Gate — Aprovacao
  |    Domain Expert (primaria) + Architect
  |
  o  Technical Constitution Session
  |    Architect define principios tecnicos | Saida: constitution-plan
  |
  o  Gate — Aprovacao
  |    Architect (primaria) + Domain Expert
  |
  o  Requirements Specification Session
  |    Clarificacao iterativa (8 passos) | Saida: specification-plan
  |
  o  Gate — Aprovacao
  |    Domain Expert (primaria) + Architect
  |
  ◇  Decisao do Canon — Variante do canon-type
       (a) Mais fluxos -> volta para Discovery
       (b) Mais requisitos -> volta para Requirements Specification
       (c) Encerrar -> prosseguir para Spec Crafting
```

**Implementacao:**
- Reutilizar `ProcessTimeline.astro` com extensoes:
  - Novo marker type `gate` (losango amarelo ao inves de circulo)
  - Novo marker type `decision` (losango violeta)
  - Feedback loop indicators: badges ao lado dos steps "(a)" e "(b)" com seta curva icone + texto descritivo
- Dados: array de steps com `type: 'session' | 'gate' | 'decision'`
- Feedback loops representados textualmente (nao visualmente como arcos) — mais claro e acessivel

**Responsividade:** Ja resolvida pelo ProcessTimeline (3 breakpoints).

**Aderencia Borealis:**
- Sessions: marker cyan `var(--color-aurora-cyan)`
- Gates: marker amarelo `var(--color-semantic-warning)`
- Decision: marker violeta `var(--color-aurora-violet)`
- Timeline line: gradiente `var(--color-aurora-cyan)` -> `var(--color-aurora-violet)`

---

### 3.6 — ContextualSpecDiagram (Especificacao Contextualizada)

**Estrategia:** Infographic Cards

**Conceito:** Tres cards verticais mostrando o fluxo `Product Canon -> Especificacao -> Plano de Implementacao`. A injecao de contexto e representada por uma seta decorativa com label, nao por um edge SVG.

**Layout:**
```
Desktop/Mobile (sempre vertical):
[Product Canon]
    | contexto relevante injetado
    v
[Especificacao]
    - [ ] Validacao de conformidade
    - [ ] Clarificacao contextualizada
    - [ ] Rastreabilidade
    | impactos rastreados
    v
[Plano de Implementacao]
    - Impactos em negocio
    - Impactos em arquitetura
```

**Implementacao:**
- Stack vertical com `display: flex; flex-direction: column; align-items: center; gap: var(--space-6)`
- Cards largos com checklists/bullets internos
- Seta entre cards: `<div>` com icone de seta + label text (CSS styled)
- Componente: Astro puro

**Responsividade:** Naturalmente vertical, funciona em qualquer viewport.

---

### 3.7 — FeedbackDiagram (Canon Enrichment com Versionamento)

**Estrategia:** Hibrido (Cards CSS + SVG Overlay)

**Conceito:** Diagrama de bifurcacao: `Implementacao concluida` -> dois caminhos paralelos (`Sinalizacao explicita` e `Deteccao IA`) -> merge em `Guardrails` -> bifurca novamente em `Review Assincrono` ou `Escalacao` -> `Canon Atualizado`. Mais a secao HTML de versionamento (Part B).

**Layout Desktop:**
```
        [Implementacao concluida]
           /              \
[Sinalizacao explicita]  [Deteccao IA]
           \              /
          [Guardrails]
           /          \
[Review Assincrono]  [Escalacao]
           \          /
      [Canon Atualizado]

--- Part B: Versionamento ---
[current] | [next]
```

**Layout Mobile:**
```
[Implementacao concluida]
      |
[Sinalizacao explicita]
[Deteccao IA]
      |
[Guardrails]
      |
[Review Assincrono]
[Escalacao]
      |
[Canon Atualizado]

[Versionamento info]
```

**Implementacao:**
- Part A: Grid com areas nomeadas para posicionamento 2D
- SVG overlay para paths de bifurcacao/merge
- Mobile: empilhado em coluna, paths bifurcacao substituidos por grouping visual (dois cards lado a lado em sub-grid `repeat(2, 1fr)`)
- Part B: Manter HTML section de versionamento (`current` | `next`) como cards CSS Grid

**Responsividade:**
- Desktop: Grid 2D com SVG overlay
- Mobile: Coluna unica, pares paralelos em sub-grid de 2 colunas (Sinalizacao/Deteccao lado a lado, Review/Escalacao lado a lado)

---

### 3.8 — GuardrailsDiagram (Camadas de Protecao)

**Estrategia:** Hibrido (Cards CSS Grid + SVG Overlay)

**Conceito:** Hub-spoke layout com Product Canon no centro e 5 guardrails ao redor, cada um ligado a stages especificos. Em mobile, transforma para lista vertical com badges de stage.

**Layout Desktop:**
```
[1. Conformidade]        [Canon Enrichment - Etapa 3]        [2. Consistencia]
        \                         |                          /
         \                        |                         /
                    [Product Canon]
         /                        |                         \
        /                         |                          \
[3. Semantica Interna]   [Canon Building - Etapa 1]    [4. Formatacao]
                                  |
                     [5. Versionamento Strangler]
```

**Layout Mobile:**
```
[Product Canon] (header card com glow)

Guardrails:
  1. [Conformidade] — Etapa 1, 3
  2. [Consistencia] — Etapa 1, 3
  3. [Semantica Interna] — Etapa 1
  4. [Formatacao] — Etapa 1, 3
  5. [Versionamento Strangler] — Mudancas estruturais
```

**Implementacao:**
- Desktop: CSS Grid com areas nomeadas simulando layout radial
- Product Canon card central com `box-shadow: var(--shadow-glow-cyan)`
- SVG overlay para linhas radiais do centro para cada guardrail
- Stage badges como `<span>` dentro de cada guardrail card
- Mobile: Card header + lista vertical de guardrails com stage badges inline
- Componente: React (precisa de SVG overlay reativo)

**Responsividade:**
- Desktop: Grid areas 3x3
- Mobile: Stack vertical com Product Canon como card hero no topo

---

### 3.9 — DirectEditFlowDiagram (Fluxo de Edicao Direta)

**Estrategia:** Timeline Vertical

**Conceito:** Fluxo sequencial: Proposta -> Guardrails -> Relatorio -> Revisao -> (loop ou) Aprovacao Sequencial. O loop iterativo (Revisao -> Guardrails) e representado como anotacao textual no step de Revisao.

**Layout:**
```
Timeline:
  o  Proposta do Domain Expert
  |    Sugestao em linguagem natural
  |
  o  Guardrails Automaticos
  |    Validacao imediata
  |
  o  Relatorio de Conformidade
  |    Resultado da validacao
  |
  ◇  Revisao Humana
  |    Se rejeitado: volta para Guardrails (iterativo)
  |
  o  Plano de Mudancas
  |    expert-edit-plan gerado
  |
  o  Aprovacao Tacita
  |    Nao-aprovacao = aceitacao automatica (48h)
  |
  o  Aprovacao Sequencial
       Camadas relevantes
```

**Implementacao:** Reutilizar `ProcessTimeline.astro` com mesmas extensoes da CeremonyFlowDiagram.

---

### 3.10 — ChangePlanEnvelopeDiagram (Estrutura do Canonical Change Plan)

**Estrategia:** Stepper + Cards Hierarquicos

**Conceito:** O diagrama mostra a estrutura do envelope Change Plan (7 campos universais), seus 5 tipos, e o fluxo de aprovacao. Redesign como card de envelope expandivel + grid de tipos + fluxo de aprovacao simplificado.

**Layout Desktop:**
```
[Envelope: Canonical Change Plan]
  Campos Universais: origin, scope, business-impact, ...
  Campos Condicionais: session-artifacts, expert-justification

Tipos (grid 5 colunas):
[discovery] [constitution] [specification] [expert-edit] [incremental]

Aprovacao:
  expert-edit-plan: aprovacao NAO-tacita
  demais: aprovacao tacita (48h)
```

**Layout Mobile:**
```
[Envelope card expandivel]
  Lista de campos

Tipos (grid 2 colunas + wrap):
[discovery] [constitution]
[specification] [expert-edit]
[incremental]

Aprovacao (cards de info)
```

**Implementacao:**
- Envelope: Card com lista de campos (ul/li com badges `universal` / `condicional`)
- Tipos: CSS Grid `repeat(auto-fit, minmax(160px, 1fr))`
- Aprovacao: 2 cards informativos (tacita vs nao-tacita)
- Componente: Astro puro
- Hierarquia visual via indentacao e containment (cards dentro de cards)

---

### 3.11 — RolesMatrixDiagram (Quem Faz O Que em Cada Etapa)

**Estrategia:** Manter (Grid Matrix) com melhorias

**Conceito:** O componente ja funciona bem como tabela HTML. Melhorias pontuais:

**Melhorias:**
1. Mobile: Adicionar transformacao responsiva — em < 480px, cada linha da tabela vira um card com key-value pairs ao inves de scroll horizontal
2. Sticky first column: `position: sticky; left: 0` para manter o nome do papel visivel durante scroll
3. Hover highlight: melhorar contraste da linha em hover

**Implementacao:** Ajustes CSS no componente existente. Sem rewrite.

---

### 3.12 — BeforeAfterDiagram (Comparacao Antes/Depois)

**Estrategia:** Avaliar integracao ou remocao

**Opcao A — Integrar na ComparisonSection:**
- A ComparisonSection usa `ComparisonRow` components. O `BeforeAfterDiagram` e redundante.
- Se o design do BeforeAfterDiagram for preferivel, substituir ComparisonRow por ele.

**Opcao B — Remover:**
- Deletar `BeforeAfterDiagram.astro` se a ComparisonSection atende a necessidade.

**Recomendacao:** Opcao B (remover). A ComparisonSection ja resolve o caso de uso com 9 rows de comparacao. Manter um componente orfao gera confusao.

---

## Plano de Implementacao

### Fase 0 — Infraestrutura (1 PR)

**Objetivo:** Criar componentes base reutilizaveis.

1. **Criar `FlowCard.astro`** — Card reutilizavel para nos de diagrama
   - Aceita props: `variant` (problem/solution/gate/canon/decision/complementary), `icon`, `title`, `description`, `badges[]`
   - Estilo baseado no `variantColors` do NodeCard atual
   - Arquivo: `src/components/ui/FlowCard.astro`

2. **Criar `SvgConnector.tsx`** — Componente React para SVG overlay leve
   - Props: `connections: Array<{ from: string, to: string, label?: string, animated?: boolean, dashed?: boolean }>`
   - Usa `useLayoutEffect` + `ResizeObserver` para medir posicoes dos elementos
   - Calcula bezier paths entre centros de bordas (top/bottom/left/right)
   - Respeita `prefers-reduced-motion`
   - Arquivo: `src/components/ui/SvgConnector.tsx`

3. **Estender `ProcessTimeline.astro`** — Adicionar suporte para marker types
   - Novo tipo `gate` (losango amarelo)
   - Novo tipo `decision` (losango violeta)
   - Feedback annotations como badges laterais
   - Arquivo: modificar `src/components/ui/ProcessTimeline.astro`

4. **Criar `StepperFlow.astro`** — Stepper horizontal/vertical reutilizavel
   - Steps numerados com conectores
   - Responsivo: horizontal (desktop) -> vertical (mobile)
   - Arquivo: `src/components/ui/StepperFlow.astro`

**Arquivos a criar:**
- `src/components/ui/FlowCard.astro`
- `src/components/ui/SvgConnector.tsx`
- `src/components/ui/StepperFlow.astro`

**Arquivos a modificar:**
- `src/components/ui/ProcessTimeline.astro`

### Fase 1 — Diagramas Simples: Infographic Cards (1 PR)

**Ordem:** Comecar pelos mais simples para validar a abordagem.

1. **ThreeGapsDiagram** -> Astro puro com CSS Grid 3 colunas
   - Criar: `src/components/diagrams/ThreeGapsDiagramV2.astro`
   - Modificar: `src/components/sections/ConsequenciasSection.astro` (trocar import)

2. **ContextVoidDiagram** -> Astro puro com CSS Grid + gap visual
   - Criar: `src/components/diagrams/ContextVoidDiagramV2.astro`
   - Modificar: `src/components/sections/HeroSection.astro`

3. **ContextualSpecDiagram** -> Astro puro com stack vertical
   - Criar: `src/components/diagrams/ContextualSpecDiagramV2.astro`
   - Modificar: `src/components/sections/SpecCraftingSection.astro`

**Validacao:** Testar em 375px, 768px, 1440px. Texto deve ser legivel em todos.

### Fase 2 — Diagramas Timeline (1 PR)

1. **CeremonyFlowDiagram** -> ProcessTimeline estendido
   - Criar: `src/components/diagrams/CeremonyFlowDiagramV2.astro`
   - Modificar: `src/components/sections/CanonBuildingSection.astro`

2. **DirectEditFlowDiagram** -> ProcessTimeline estendido
   - Criar: `src/components/diagrams/DirectEditFlowDiagramV2.astro`
   - Modificar: `src/components/sections/DirectEditSection.astro`

### Fase 3 — Diagramas Stepper (1 PR)

1. **CanonBuildingDiagram** -> StepperFlow
   - Criar: `src/components/diagrams/CanonBuildingDiagramV2.astro`
   - Modificar: `src/components/sections/CanonBuildingSection.astro`

2. **ChangePlanEnvelopeDiagram** -> Cards hierarquicos + Grid de tipos
   - Criar: `src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro`
   - Modificar: `src/components/sections/ChangePlanSection.astro`

### Fase 4 — Diagramas Hibridos (1 PR)

**Mais complexos — requerem o SvgConnector.**

1. **CycleDiagram** -> CSS Grid + SVG Overlay
   - Criar: `src/components/diagrams/CycleDiagramV2.tsx` (React para SVG reativo)
   - Modificar: `src/components/sections/CycleOverviewSection.astro`

2. **FeedbackDiagram** -> CSS Grid + SVG Overlay
   - Criar: `src/components/diagrams/FeedbackDiagramV2.tsx`
   - Modificar: `src/components/sections/EnrichmentSection.astro`

3. **GuardrailsDiagram** -> CSS Grid radial + SVG Overlay
   - Criar: `src/components/diagrams/GuardrailsDiagramV2.tsx`
   - Modificar: `src/components/sections/GuardrailsSection.astro`

### Fase 5 — Melhorias e Cleanup (1 PR)

1. **RolesMatrixDiagram** — Adicionar transformacao responsiva para mobile < 480px
   - Modificar: `src/components/diagrams/RolesMatrixDiagram.astro`

2. **BeforeAfterDiagram** — Remover componente orfao
   - Deletar: `src/components/diagrams/BeforeAfterDiagram.astro`

3. **Fix CeremonyFlowDiagram title** — Corrigir titulo raw "CEREMONYFLOWDIAGRAM"
   - Ja resolvido pelo V2 na Fase 2

4. **Remover dependencias**
   - `npm uninstall @xyflow/react elkjs`
   - Deletar: `src/lib/diagrams/use-elk-layout.ts`
   - Deletar: `src/lib/diagrams/use-responsive-flow.ts`
   - Deletar: `src/lib/diagrams/shared-config.ts`
   - Deletar: `src/components/ui/NodeCard.tsx` (se nao usado em outro lugar)
   - Deletar: todos os arquivos `.tsx` de diagramas V1 em `src/components/diagrams/`
   - Deletar: todos os arquivos de dados em `src/lib/diagrams/*-diagram.ts`

5. **Remover CSS desnecessario**
   - Limpar `animations.css` de keyframes especificos de ReactFlow (`edge-flow`)
   - Limpar estilos de `.react-flow` no CSS global

### Dependencias a Remover

```json
{
  "@xyflow/react": "remover",
  "elkjs": "remover"
}
```

### Dependencias a Manter

- `gsap` — ja presente, usado para scroll animations em outras partes do site. Opcionalmente usar para path animations no SvgConnector.

### Dependencias a Adicionar

Nenhuma. Toda a implementacao usa CSS, SVG inline, e React vanilla.

---

## Acceptance Criteria

### Por Diagrama

#### AC-01: ContextVoidDiagram
- [ ] Todos os 4 nos visiveis e legiveis em 375px
- [ ] Gap visual entre "Conhecimento" e "Especificacao" e claro
- [ ] Fluxo direcional e perceptivel (setas ou indicadores visuais)
- [ ] Variantes de cor (problem, default) aplicadas corretamente
- [ ] Zero JavaScript carregado para este diagrama

#### AC-02: ThreeGapsDiagram
- [ ] 3 cards visiveis em 375px (empilhados)
- [ ] 3 cards lado a lado em 1440px
- [ ] Dashed border vermelha em cada card
- [ ] Icones e textos completos (sem truncamento)
- [ ] Zero JavaScript

#### AC-03: CycleDiagram
- [ ] Todos os 6 nos visiveis e legiveis em 375px
- [ ] Conectores visiveis indicando ciclo em desktop
- [ ] Edge labels legiveis ("contexto injetado", "descobertas", etc.)
- [ ] Canal complementar (Edicao Direta) visualmente diferenciado (pink)
- [ ] Animacao de edges respeita `prefers-reduced-motion`

#### AC-04: CanonBuildingDiagram
- [ ] 3 sessoes + 3 gates claramente sequenciais
- [ ] Stepper horizontal em desktop, vertical em mobile
- [ ] Gates com cor amarela diferenciada
- [ ] Labels "aprovado" visiveis entre steps

#### AC-05: CeremonyFlowDiagram
- [ ] 7 steps em timeline vertical legivel em qualquer viewport
- [ ] Markers diferenciados: sessoes (cyan), gates (amarelo), decisao (violeta)
- [ ] Feedback loops (a) e (b) indicados com texto descritivo
- [ ] Titulo corrigido (nao "CEREMONYFLOWDIAGRAM")

#### AC-06: ContextualSpecDiagram
- [ ] 3 cards verticais com setas entre eles
- [ ] Checklists/bullets visiveis dentro dos cards
- [ ] Fluxo top-down claro
- [ ] Zero JavaScript

#### AC-07: FeedbackDiagram
- [ ] Bifurcacao (Sinalizacao/Deteccao) visivel em desktop
- [ ] Em mobile: pares lado a lado ou empilhados com grouping
- [ ] Secao de versionamento (Part B) preservada
- [ ] Merge de caminhos indicado visualmente

#### AC-08: GuardrailsDiagram
- [ ] Product Canon central com glow em desktop
- [ ] 5 guardrails ao redor com badges de stage
- [ ] Em mobile: lista vertical com Product Canon como header
- [ ] Todas as labels completas (sem truncamento)

#### AC-09: DirectEditFlowDiagram
- [ ] Timeline vertical com 7 steps
- [ ] Loop iterativo (Revisao -> Guardrails) indicado textualmente
- [ ] Aprovacao tacita e sequencial diferenciadas

#### AC-10: ChangePlanEnvelopeDiagram
- [ ] Envelope com campos listados
- [ ] 5 tipos em grid responsivo
- [ ] Fluxo de aprovacao claro (tacita vs nao-tacita)
- [ ] Em mobile: grid de tipos wrapa para 2 colunas

#### AC-11: RolesMatrixDiagram
- [ ] Tabela funcional em desktop
- [ ] Em mobile < 480px: cards empilhados OU scroll com sticky column
- [ ] Hover highlight visivel

#### AC-12: BeforeAfterDiagram
- [ ] Arquivo removido do codebase
- [ ] Nenhuma referencia quebrada

### Globais

- [ ] `@xyflow/react` e `elkjs` removidos do `package.json`
- [ ] Nenhum import de ReactFlow restante no codebase
- [ ] Todos os diagramas usam tokens do Borealis (nao cores hardcoded fora do sistema)
- [ ] `prefers-reduced-motion` respeitado em todos os diagramas com animacao
- [ ] Todos os diagramas possuem `aria-label` descritivo
- [ ] Texto legivel (>= 14px) em viewport 375px para todos os diagramas
- [ ] Lighthouse Performance score nao regride (esperado melhora pelo bundle reduction)
- [ ] Nenhum scroll horizontal forcado em diagramas (exceto RolesMatrix que ja tinha)
- [ ] Build do Astro completa sem erros
- [ ] Screenshots de comparacao antes/depois para cada diagrama em 375px e 1440px
