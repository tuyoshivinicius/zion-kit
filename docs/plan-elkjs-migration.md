# Plano de Migração: Auto-layout com elkjs

## Resumo executivo

### Motivação

O projeto ZionKit possui 11 diagramas React renderizados com `@xyflow/react`. Todos utilizam **posicionamento manual** de nodes (coordenadas `{ x, y }` hardcoded em pixels), o que causa:

- **Sobreposição de edges** em diagramas complexos (GuardrailsDiagram, ChangePlanEnvelopeDiagram)
- **Falta de responsividade** — nodes não reflowam em viewports menores
- **Alturas fixas de container** que cortam conteúdo em telas pequenas
- **Hack de triple fitView** (3 chamadas com setTimeout) para contornar problemas de timing
- **Manutenção custosa** — qualquer alteração de conteúdo exige reajuste manual de coordenadas

### Decisão

Após análise comparativa de 10 bibliotecas (Reagraph, D3+d3-dag, Mermaid, Cytoscape, Viz.js, React Diagrams, JointJS, GoJS, elkjs), a decisão é:

> **Manter `@xyflow/react` como camada de renderização e adicionar `elkjs` como motor de layout automático.**

**Por quê:**

1. Custo de migração mínimo — preserva todos os 23 arquivos existentes (componentes, dados, hooks, config)
2. Resolve o problema raiz — ELK computa coordenadas ideais automaticamente
3. Preserva acessibilidade — NodeCard com ARIA, useReducedMotion, keyboard navigation mantidos
4. Bundle incremental aceitável — +~180 kB gzip (vs. alternativas de 250 kB a 2.8 MB)
5. Stack já validada — React 19 + Astro 6 + @xyflow/react 12.10.2 funciona no projeto

---

## Referência rápida

### Stack

| Tecnologia | Versão | Papel |
|---|---|---|
| Astro | 6.1.4 | Framework SSR/SSG |
| React | 19.2.4 | Runtime de componentes |
| @xyflow/react | 12.10.2 | Renderização de diagramas |
| **elkjs** (novo) | latest | Motor de layout automático |
| Tailwind CSS | 4.2.2 | Styling via CSS variables |
| GSAP | 3.14.2 | Animações |

### Arquivos-chave

| Categoria | Caminho | Quantidade |
|---|---|---|
| Componentes React | `src/components/diagrams/*.tsx` | 11 arquivos |
| Componentes Astro | `src/components/diagrams/*.astro` | 2 arquivos (não afetados) |
| Dados de diagramas | `src/lib/diagrams/*-diagram.ts` | 10 arquivos |
| Configuração | `src/lib/diagrams/shared-config.ts` | 1 arquivo |
| Hook responsivo | `src/lib/diagrams/use-responsive-flow.ts` | 1 arquivo |
| Hook de motion | `src/lib/diagrams/use-reduced-motion.ts` | 1 arquivo |
| Custom node | `src/components/diagrams/NodeCard.tsx` | 1 arquivo |

### Diagramas por complexidade

| Diagrama | Nodes | Edges | Tipo | Prioridade de migração |
|---|---|---|---|---|
| ThreeGapsDiagram | 3 | 2 | Linear horizontal | Fase 3a |
| ContextualSpecDiagram | 3 | 2 | Linear vertical | Fase 3a |
| ContextVoidDiagram | 4 | 3 | Linear horizontal | Fase 3a |
| CanonBuildingDiagram | 6 | 4 | Colunas paralelas | Fase 3a |
| CycleDiagram | 6 | 6 | Cíclico com loops | Fase 3a |
| CeremonyFlowDiagram | 8 | 7 | Sequencial com decisão | Fase 3b |
| DirectEditFlowDiagram | 8 | 6 | Iterativo com feedback | Fase 3b |
| GuardrailsDiagram | 9 | 10 | Radial/proteção | Fase 3b |
| ChangePlanEnvelopeDiagram | 11 | 13 | Hierárquico/envelope | Fase 3b |
| FeedbackDiagram | 7 | 8 | Híbrido (flow + HTML) | Fase 3c |

---

## Fases de implementação

### Dependências entre fases

```
Fase 1 (Infraestrutura)
  │
  ├──→ Fase 2 (Adaptação dos dados)
  │       │
  │       └──→ Fase 3a (Migrar diagramas simples)
  │               │
  │               └──→ Fase 3b (Migrar diagramas complexos)
  │                       │
  │                       └──→ Fase 3c (Migrar FeedbackDiagram)
  │
  └──→ Fase 4 (Correções complementares) — pode iniciar em paralelo com Fase 3
              │
              └──→ Fase 5 (Validação) — só após Fases 3c e 4
```

---

### Fase 1 — Infraestrutura

**Objetivo:** Instalar elkjs e criar o hook de layout reutilizável.

#### Tarefa 1.1 — Instalar elkjs

- **Descrição:** Adicionar `elkjs` como dependência do projeto.
- **Comando:** `npm install elkjs`
- **Arquivos afetados:**
  - `package.json`
  - `package-lock.json`
- **Definition of done:**
  - `elkjs` aparece em `dependencies` no `package.json`
  - `npm run build` executa sem erros
- **Dependências:** Nenhuma

#### Tarefa 1.2 — Criar hook `useElkLayout`

- **Descrição:** Criar um hook React que recebe nodes, edges e opções de layout, executa o ELK e retorna nodes com posições calculadas. O hook deve:
  - Aceitar `Node[]`, `Edge[]` e `ElkLayoutOptions` como parâmetros
  - Converter nodes/edges para o formato ELK (`ElkNode`, `ElkExtendedEdge`)
  - Chamar `elk.layout()` de forma assíncrona
  - Retornar `{ layoutedNodes, layoutedEdges, isLayouting }` (com estado de loading)
  - Usar dimensões padrão para nodes que não especifiquem width/height
  - Tratar erros do ELK com fallback para posições originais
- **Arquivo a criar:**
  - `src/lib/diagrams/use-elk-layout.ts`
- **Definition of done:**
  - Hook exportado e tipado com TypeScript
  - Funciona com os nodeTypes existentes (especialmente `nodeCard`)
  - Retorna nodes com `position.x` e `position.y` recalculados
  - Estado `isLayouting` reflete corretamente o ciclo de vida assíncrono
- **Dependências:** Tarefa 1.1

#### Tarefa 1.3 — Adicionar configurações padrão do ELK ao shared-config

- **Descrição:** Estender `shared-config.ts` com opções padrão do ELK para reutilização nos diagramas. Incluir presets para os padrões de layout mais usados no projeto:
  - `horizontalFlow` — `elk.algorithm: 'layered'`, `elk.direction: 'RIGHT'`
  - `verticalFlow` — `elk.algorithm: 'layered'`, `elk.direction: 'DOWN'`
  - `radialLayout` — `elk.algorithm: 'stress'` ou `force` (para GuardrailsDiagram)
  - `hierarchicalLayout` — `elk.algorithm: 'layered'`, `elk.direction: 'DOWN'`, com spacing vertical maior
- **Opções comuns a todos os presets:**
  - `elk.spacing.nodeNode: 60`
  - `elk.layered.spacing.edgeNodeBetweenLayers: 40`
  - `elk.layered.spacing.nodeNodeBetweenLayers: 80`
- **Arquivo afetado:**
  - `src/lib/diagrams/shared-config.ts`
- **Definition of done:**
  - Presets de layout exportados e tipados
  - Valores de spacing produzem separação visual adequada (sem sobreposição)
  - Compatível com o sistema de variantColors existente
- **Dependências:** Nenhuma (pode ser feita em paralelo com 1.2)

---

### Fase 2 — Adaptação dos dados

**Objetivo:** Preparar os arquivos de dados dos diagramas para layout automático.

#### Tarefa 2.1 — Adicionar dimensões aos nodes

- **Descrição:** Adicionar propriedades `width` e `height` a cada node nos 10 arquivos de dados. O ELK precisa dessas dimensões para calcular o layout sem sobreposição. Estimar dimensões baseadas no conteúdo de cada node (título + content).
- **Dimensões sugeridas:**
  - Node com 1 linha de conteúdo: `width: 260, height: 100`
  - Node com 2-3 linhas: `width: 280, height: 120`
  - Node com 4+ linhas ou tooltip: `width: 300, height: 140`
- **Arquivos afetados:**
  - `src/lib/diagrams/canon-building-diagram.ts`
  - `src/lib/diagrams/context-void-diagram.ts`
  - `src/lib/diagrams/contextual-spec-diagram.ts`
  - `src/lib/diagrams/three-gaps-diagram.ts`
  - `src/lib/diagrams/cycle-diagram.ts`
  - `src/lib/diagrams/ceremony-flow-diagram.ts`
  - `src/lib/diagrams/direct-edit-flow-diagram.ts`
  - `src/lib/diagrams/feedback-diagram.ts`
  - `src/lib/diagrams/guardrails-diagram.ts`
  - `src/lib/diagrams/change-plan-envelope-diagram.ts`
- **Definition of done:**
  - Todos os nodes possuem `width` e `height` definidos (via `data`, `measured`, ou campo customizado)
  - Nenhum node com dimensão `0` ou `undefined`
- **Dependências:** Nenhuma

#### Tarefa 2.2 — Remover posições hardcoded

- **Descrição:** Substituir `position: { x: N, y: N }` por `position: { x: 0, y: 0 }` em todos os nodes. As posições serão calculadas pelo ELK no runtime. Manter `position` como campo obrigatório do tipo `Node` do React Flow, mas com valores neutros.
- **Arquivos afetados:** Mesmos 10 arquivos da Tarefa 2.1
- **Definition of done:**
  - Nenhum node com coordenadas hardcoded (exceto `{ x: 0, y: 0 }`)
  - TypeScript compila sem erros
- **Dependências:** Tarefa 2.1 (fazer na mesma PR para evitar estado quebrado)

#### Tarefa 2.3 — Adicionar metadata de layout por diagrama

- **Descrição:** Exportar um objeto `layoutOptions` em cada arquivo de dados, indicando qual preset do ELK usar (definidos na Tarefa 1.3). Exemplos:
  - `ThreeGapsDiagram` → `horizontalFlow`
  - `ContextualSpecDiagram` → `verticalFlow`
  - `GuardrailsDiagram` → `radialLayout`
  - `ChangePlanEnvelopeDiagram` → `hierarchicalLayout`
- **Arquivos afetados:** Mesmos 10 arquivos da Tarefa 2.1
- **Definition of done:**
  - Cada arquivo exporta `layoutOptions` com o preset adequado
  - Presets referenciados existem em `shared-config.ts`
- **Dependências:** Tarefa 1.3

---

### Fase 3 — Migração dos componentes

**Objetivo:** Integrar o `useElkLayout` nos componentes de diagrama.

#### Tarefa 3a — Migrar diagramas simples (5 diagramas)

- **Descrição:** Atualizar os 5 componentes de diagramas lineares/simples para usar `useElkLayout`. Padrão de migração:
  1. Importar `useElkLayout` e `layoutOptions` do arquivo de dados
  2. Substituir `defaultNodes={nodes}` por `defaultNodes={layoutedNodes}`
  3. Substituir `defaultEdges={edges}` por `defaultEdges={layoutedEdges}`
  4. Adicionar tratamento de estado `isLayouting` (ex: skeleton ou opacity reduzida)
- **Componentes a migrar:**
  - `src/components/diagrams/ThreeGapsDiagram.tsx`
  - `src/components/diagrams/ContextualSpecDiagram.tsx`
  - `src/components/diagrams/ContextVoidDiagram.tsx`
  - `src/components/diagrams/CanonBuildingDiagram.tsx`
  - `src/components/diagrams/CycleDiagram.tsx`
- **Definition of done:**
  - Cada diagrama renderiza com layout automático (sem posições manuais)
  - Nenhum node sobreposto visualmente
  - fitView funciona corretamente com as novas posições
  - Diagramas visíveis e legíveis em viewports de 375px e 1440px
- **Dependências:** Tarefas 1.2, 2.1, 2.2, 2.3

#### Tarefa 3b — Migrar diagramas complexos (4 diagramas)

- **Descrição:** Migrar diagramas com loops, decisões e padrão radial. Estes exigem atenção especial:
  - **CeremonyFlowDiagram / DirectEditFlowDiagram:** Preservar `useReducedMotion` e `safeEdges` pattern
  - **GuardrailsDiagram:** Testar preset `radialLayout` ou `stress` para manter padrão proteção-central
  - **ChangePlanEnvelopeDiagram:** Testar `hierarchicalLayout` com spacing vertical amplo para 4 tiers
  - Pode ser necessário ajustar `elk.layered.crossingMinimization.strategy` para edges com `sourceHandle`/`targetHandle`
- **Componentes a migrar:**
  - `src/components/diagrams/CeremonyFlowDiagram.tsx`
  - `src/components/diagrams/DirectEditFlowDiagram.tsx`
  - `src/components/diagrams/GuardrailsDiagram.tsx`
  - `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx`
- **Definition of done:**
  - Layout automático sem sobreposição de nodes ou edges
  - Motion-aware pattern preservado (useReducedMotion + safeEdges)
  - GuardrailsDiagram mantém conceito visual de "proteção central"
  - ChangePlanEnvelopeDiagram mantém hierarquia envelope → fields → types → approval
  - Handles (sourceHandle/targetHandle) roteiam edges corretamente
- **Dependências:** Tarefa 3a (validar padrão nos simples antes)

#### Tarefa 3c — Migrar FeedbackDiagram (1 diagrama)

- **Descrição:** Migrar o diagrama híbrido que combina ReactFlow com visualização HTML de versionamento. Requer cuidado especial pois o layout do flow e do HTML são independentes mas coexistem no mesmo container com flexbox.
- **Componente a migrar:**
  - `src/components/diagrams/FeedbackDiagram.tsx`
- **Definition of done:**
  - Seção ReactFlow usa layout automático
  - Seção HTML de versionamento não é afetada
  - Layout flexbox entre as duas seções preservado
  - Sem quebra visual no gap de 2rem entre seções
- **Dependências:** Tarefa 3b

---

### Fase 4 — Correções complementares

**Objetivo:** Resolver problemas técnicos adjacentes identificados na análise.

> Esta fase pode ser executada em paralelo com a Fase 3 nas tarefas que não dependem de componentes migrados.

#### Tarefa 4.1 — Refatorar triple fitView

- **Descrição:** Substituir o padrão de 3 chamadas `fitView` com `setTimeout` em `use-responsive-flow.ts` por uma abordagem estável:
  - Usar `requestAnimationFrame` + single retry com timeout
  - Adicionar cleanup dos timeouts no retorno do useEffect (prevenir memory leak)
  - Considerar usar o callback `onInit` do React Flow que garante que o instance está pronto
- **Arquivo afetado:**
  - `src/lib/diagrams/use-responsive-flow.ts`
- **Definition of done:**
  - Máximo 2 chamadas fitView (1 imediata + 1 retry)
  - Todos os timeouts limpos no cleanup do useEffect
  - Diagramas renderizam corretamente no primeiro load (testar em throttled CPU 4x)
- **Dependências:** Nenhuma (pode começar antes da Fase 3)

#### Tarefa 4.2 — Container com altura responsiva

- **Descrição:** Substituir alturas fixas (`height: '380px'`, etc.) por alturas dinâmicas. Opções:
  - Calcular altura baseada no bounding box retornado pelo ELK (`layoutResult.height + padding`)
  - Usar `min-height` com `aspect-ratio` para manter proporção
  - Ou `min-height` + `max-height` com `overflow-y: auto` para diagramas muito altos
- **Arquivos afetados:** Todos os 11 componentes em `src/components/diagrams/*.tsx`
- **Definition of done:**
  - Nenhum container com altura fixa em pixels
  - Diagramas não são cortados em viewport 375px (mobile)
  - Diagramas não expandem desnecessariamente em viewport 1440px (desktop)
- **Dependências:** Tarefa 1.2 (precisa do bounding box do ELK para altura dinâmica)

#### Tarefa 4.3 — Habilitar pan/zoom para diagramas grandes

- **Descrição:** Habilitar `panOnDrag` e `zoomOnScroll` no desktop para diagramas com mais de 8 nodes. Manter interações desabilitadas para diagramas simples (3-6 nodes). Atualizar `shared-config.ts` ou criar um config adicional `interactiveFlowConfig`.
- **Arquivos afetados:**
  - `src/lib/diagrams/shared-config.ts`
  - Componentes com >8 nodes: CeremonyFlow, DirectEditFlow, Guardrails, ChangePlanEnvelope
- **Definition of done:**
  - Diagramas com >8 nodes permitem pan e zoom no desktop
  - Diagramas com <=6 nodes mantêm interações desabilitadas
  - Zoom mínimo e máximo definidos para evitar zoom excessivo
  - Pan não interfere com scroll da página (preventScrolling configurado)
- **Dependências:** Nenhuma

---

### Fase 5 — Validação

**Objetivo:** Garantir que a migração não introduziu regressões visuais, de acessibilidade ou de performance.

#### Tarefa 5.1 — Teste visual em breakpoints

- **Descrição:** Verificar cada um dos 11 diagramas nos seguintes breakpoints:
  - 375px (iPhone SE)
  - 768px (tablet)
  - 1024px (laptop)
  - 1440px (desktop)
- **Checklist por diagrama:**
  - [ ] Nodes não sobrepostos
  - [ ] Edges visíveis e não cruzam nodes
  - [ ] Labels de edges legíveis
  - [ ] Conteúdo não cortado pelo container
  - [ ] fitView enquadra todo o diagrama
- **Definition of done:** Todos os 11 diagramas passam no checklist em todos os 4 breakpoints
- **Dependências:** Fases 3 e 4 completas

#### Tarefa 5.2 — Teste de acessibilidade

- **Descrição:** Validar que a migração preservou todos os recursos de acessibilidade:
  - Tab navigation entre nodes (tabIndex="0")
  - ARIA labels em nodes e no container ReactFlow
  - Tooltips acessíveis via keyboard (Enter/Space)
  - `useReducedMotion` desabilita animações quando `prefers-reduced-motion: reduce`
  - role="group" no NodeCard, role="tooltip" nos tooltips
- **Ferramentas sugeridas:** axe DevTools, Lighthouse accessibility audit, teste manual com screen reader
- **Definition of done:**
  - Score Lighthouse accessibility >= 90 na página principal
  - Nenhum erro axe de severidade "critical" ou "serious"
  - Todos os tooltips acessíveis via keyboard
- **Dependências:** Fases 3 e 4 completas

#### Tarefa 5.3 — Medição de bundle size

- **Descrição:** Comparar o bundle size antes e depois da migração:
  1. Antes: rodar `npx astro build` e registrar o tamanho total do output
  2. Depois: rodar novamente e comparar
  3. Verificar o impacto do elkjs no chunk de JavaScript
- **Ferramentas sugeridas:** `npx astro build` output, `source-map-explorer`, `bundlephobia`
- **Definition of done:**
  - Delta de bundle documentado
  - elkjs carregado apenas nos chunks que contêm diagramas (code splitting via Astro islands)
  - Aumento total <= 200 kB gzip (threshold aceitável)
- **Dependências:** Fases 3 e 4 completas

#### Tarefa 5.4 — Teste de performance

- **Descrição:** Verificar que o layout assíncrono do ELK não causa:
  - Flash de conteúdo sem layout (FOUC) — nodes empilhados em (0,0) antes do ELK computar
  - Jank/stuttering durante o cálculo de layout
  - Reflow excessivo quando o layout completa
- **Mitigação esperada:** Estado `isLayouting` do hook exibe skeleton/placeholder até layout pronto
- **Definition of done:**
  - Nenhum flash visível de nodes em posição (0,0)
  - Layout completa em < 100ms para diagramas simples, < 300ms para complexos
  - Lighthouse Performance score >= 90 na página principal
- **Dependências:** Fases 3 e 4 completas

---

## Riscos e mitigações

| # | Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|---|
| R1 | **ELK produz layout esteticamente inferior ao manual** — o algoritmo pode posicionar nodes de forma tecnicamente correta mas visualmente menos intencional que o layout manual atual (ex: GuardrailsDiagram perde o conceito radial de "proteção") | Alta | Alto | Testar múltiplos algoritmos ELK (`layered`, `stress`, `force`, `mrtree`) por diagrama. Se necessário, usar constraints do ELK (`elk.position` para fixar nodes-chave) como meio-termo entre manual e automático. |
| R2 | **Flash de layout (FOUC)** — como ELK é assíncrono, nodes podem renderizar em (0,0) antes do layout completar, causando flash visual | Média | Médio | Implementar estado `isLayouting` no hook com skeleton/opacity:0 até layout pronto. Considerar computar layout no primeiro render com `useMemo` + Suspense. |
| R3 | **Bundle size excede threshold** — elkjs adiciona ~180 kB gzip que pode impactar LCP/FCP | Média | Médio | Verificar que Astro faz code splitting por island — elkjs deve carregar apenas quando diagrama entra no viewport (`client:visible`). Se necessário, usar `elkjs/lib/elk-worker.js` para carregamento via web worker. |
| R4 | **Incompatibilidade elkjs com Astro SSR/build** — elkjs usa Web Workers ou WASM que podem não funcionar no contexto de build do Astro | Baixa | Alto | Usar `elkjs/lib/elk.bundled.js` (versão JS pura, sem WASM/Worker). Testar `npx astro build` logo na Tarefa 1.1. Se falhar, configurar `vite.optimizeDeps` no `astro.config.mjs`. |
| R5 | **Regressão de acessibilidade** — mudanças no fluxo de renderização (assíncrono) podem quebrar tab order ou ARIA | Baixa | Alto | Manter NodeCard inalterado. Testar tab navigation após cada fase. Hook deve preservar a ordem dos nodes no array (ELK não deve reordenar o array, apenas atualizar posições). |
| R6 | **sourceHandle/targetHandle quebram com ELK** — edges com handles específicos dependem de posições relativas que o ELK pode alterar | Média | Médio | Mapear handles para ports do ELK (`elk.port.side`). Testar especificamente CeremonyFlowDiagram e ChangePlanEnvelopeDiagram que usam handles explícitos. |

---

## Métricas de sucesso

| Métrica | Valor atual | Meta | Como medir |
|---|---|---|---|
| Diagramas com auto-layout | 0/11 (0%) | 11/11 (100%) | Contagem de componentes usando `useElkLayout` |
| Nodes com posição hardcoded | ~73 nodes | 0 nodes | Grep por `position: { x:` com valor != 0 nos data files |
| Bundle size delta | baseline | <= +200 kB gzip | `npx astro build` antes/depois |
| Lighthouse Accessibility | baseline | >= 90 | Lighthouse audit na index page |
| Lighthouse Performance | baseline | >= 90 | Lighthouse audit na index page |
| Sobreposição de edges | Presente em 2+ diagramas | 0 diagramas | Inspeção visual nos 4 breakpoints |
| fitView hacks (setTimeout) | 3 chamadas | 0-1 chamada | Code review em `use-responsive-flow.ts` |
| Containers com altura fixa | 11 componentes | 0 componentes | Grep por `height: '.*px'` nos componentes |
| Flash de layout (FOUC) | N/A | 0 ocorrências | Teste manual com CPU 4x throttle |

---

## Checklist final de validação

Antes de considerar a migração completa, todos os itens abaixo devem estar marcados:

- [ ] `elkjs` instalado e build funcional (`npm run build` sem erros)
- [ ] Hook `useElkLayout` criado, tipado e testável
- [ ] Presets de layout definidos em `shared-config.ts`
- [ ] Todos os 10 arquivos de dados adaptados (dimensões, posições zeradas, layoutOptions)
- [ ] 5 diagramas simples migrados e validados visualmente
- [ ] 4 diagramas complexos migrados com motion-awareness preservada
- [ ] FeedbackDiagram migrado com seção HTML intacta
- [ ] Triple fitView substituído por abordagem estável
- [ ] Alturas de container responsivas
- [ ] Pan/zoom habilitado para diagramas grandes no desktop
- [ ] Teste visual em 375px, 768px, 1024px, 1440px — todos passam
- [ ] Acessibilidade: tab navigation, ARIA, tooltips, reduced motion — todos funcionam
- [ ] Bundle size delta <= 200 kB gzip
- [ ] Nenhum FOUC visível (nodes em 0,0)
- [ ] Performance: layout completa em < 300ms para todos os diagramas
- [ ] Lighthouse Accessibility >= 90
- [ ] Lighthouse Performance >= 90
