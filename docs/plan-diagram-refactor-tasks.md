# Plano de Implementacao: Refatoracao dos Diagramas ZionKit

<!-- ============================================================
     PLANO ESTRUTURADO PARA AUTOMACAO COM CLAUDE CODE
     
     Gerado a partir de: docs/plan-diagram-refactor.md
     Execute com: ./run-plan.ps1 -PlanFile ./docs/plan-diagram-refactor-tasks.md
     
     Convencoes:
     - IDs seguem o formato: E{epico}.T{tarefa} (ex: E1.T2 = Epico 1, Tarefa 2)
     - Subtarefas: E{epico}.T{tarefa}.S{sub} (ex: E1.T2.S1)
     - Dependencias referenciam IDs (ex: depends_on: E1.T1)
     - Status: pending | running | done | failed | skipped
     ============================================================ -->

## Metadados

```yaml
plan_name: "Refatoracao dos Diagramas ZionKit"
objective: "Eliminar @xyflow/react e elkjs (~200KB), substituindo 10 diagramas React Flow por componentes CSS Grid/Flexbox, Timeline e SVG overlay leve, com responsividade mobile-first e texto legivel em todos os viewports."
scope: "DENTRO: Rewrite dos 10 diagramas React Flow, melhorias no RolesMatrixDiagram, remocao do BeforeAfterDiagram orfao, criacao de componentes base (FlowCard, SvgConnector, StepperFlow), extensao do ProcessTimeline, remocao de @xyflow/react e elkjs. FORA: Diagramas novos, mudancas em conteudo textual das secoes, alteracoes no tema Borealis, mudancas em outras paginas."
working_directory: "C:/Users/tvini/projects/personal/zion-kit"
model: "sonnet"
permission_mode: "bypassPermissions"
max_turns_per_task: 25
max_budget_per_task_usd: 1.00
created_at: "2026-04-09"
author: "Tuyoshi Vinicius"
```

## Pre-requisitos

- [ ] Branch `feat/diagram-refactor` criada a partir de main
- [ ] `npm install` executado sem erros
- [ ] Build atual passa: `npm run build`
- [ ] Node.js >= 18 instalado

---

## Epico 1 — Infraestrutura Base

> Criar componentes reutilizaveis que serao a fundacao dos novos diagramas: FlowCard, SvgConnector, StepperFlow, e extensao do ProcessTimeline.

### E1.T1 — Criar FlowCard.astro

```yaml
id: "E1.T1"
depends_on: []
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie o componente `src/components/ui/FlowCard.astro` — um card reutilizavel para nos de diagramas que substituira o NodeCard.tsx do ReactFlow.

## Props (interface TypeScript no frontmatter)

interface Props {
  variant?: 'default' | 'problem' | 'solution' | 'gate' | 'canon' | 'decision' | 'complementary';
  icon?: string;       // emoji ou caractere para exibir no header
  title: string;
  description?: string;
  badges?: string[];   // badges de texto exibidos abaixo do titulo
  class?: string;
}

## Mapeamento de cores por variante

Use as mesmas cores do `variantColors` em `src/lib/diagrams/shared-config.ts`:

- default: border cyan `rgba(34, 211, 238, 0.3)`, bg `rgba(34, 211, 238, 0.05)`
- problem: border red `rgba(248, 113, 113, 0.4)`, bg `rgba(248, 113, 113, 0.08)`
- solution: border green `rgba(74, 222, 128, 0.4)`, bg `rgba(74, 222, 128, 0.08)`
- gate: border yellow `rgba(250, 204, 21, 0.4)`, bg `rgba(250, 204, 21, 0.08)`
- canon: border violet `rgba(167, 139, 250, 0.4)`, bg `rgba(167, 139, 250, 0.08)`
- decision: border violet `rgba(196, 181, 253, 0.3)`, bg `rgba(139, 92, 246, 0.08)`
- complementary: border pink `rgba(244, 114, 182, 0.3)`, bg `rgba(244, 114, 182, 0.08)`

## Estrutura HTML

<div class="flow-card flow-card--{variant}" data-flow-card>
  <div class="flow-card__header">
    {icon && <span class="flow-card__icon">{icon}</span>}
    <h4 class="flow-card__title">{title}</h4>
  </div>
  {badges && badges.length > 0 && (
    <div class="flow-card__badges">
      {badges.map(b => <span class="flow-card__badge">{b}</span>)}
    </div>
  )}
  {description && <p class="flow-card__description">{description}</p>}
  <slot />  <!-- para conteudo custom como checklists -->
</div>

## Estilos

- Use <style> scoped no Astro (NAO Tailwind classes)
- `border-radius: var(--radius-lg, 12px)`
- `padding: var(--space-4, 1rem)`
- `font-size: 0.9375rem` (15px) para descricao, `1rem` para titulo
- Badges: `font-size: 0.75rem`, `padding: 2px 8px`, `border-radius: 9999px`, mesma cor da variante com opacidade
- O atributo `data-flow-card` sera usado pelo SvgConnector para medir posicoes

## Restricoes

- NAO use JavaScript runtime — Astro puro com zero JS no client
- NAO importe dependencias externas
- NAO adicione hover animations complexas — apenas `transition: border-color 0.2s`
- Siga o padrao de componentes Astro existentes no projeto (veja src/components/ui/ProcessCard.astro como referencia de estilo)
```

**Arquivos alvo:**

- `src/components/ui/FlowCard.astro`

**Criterios de aceite:**

- [ ] Componente renderiza corretamente com cada uma das 7 variantes
- [ ] Props `icon`, `title`, `description`, `badges` funcionam
- [ ] Slot permite conteudo custom (ex: listas, checklists)
- [ ] Atributo `data-flow-card` presente no elemento raiz
- [ ] Zero JavaScript no client-side bundle
- [ ] Cores consistentes com o `variantColors` do shared-config.ts

**Validacao pos-execucao:**

```bash
test -f src/components/ui/FlowCard.astro && npm run build
```

---

### E1.T2 — Criar SvgConnector.tsx

```yaml
id: "E1.T2"
depends_on: []
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie o componente React `src/components/ui/SvgConnector.tsx` — um overlay SVG leve que desenha paths (conectores) entre elementos HTML medidos via getBoundingClientRect.

## Interface

interface Connection {
  from: string;       // CSS selector ou data attribute do elemento de origem
  to: string;         // CSS selector ou data attribute do elemento de destino
  label?: string;     // texto exibido no midpoint do path
  animated?: boolean; // animacao stroke-dashoffset (default: false)
  dashed?: boolean;   // stroke-dasharray pontilhado (default: false)
  fromSide?: 'top' | 'bottom' | 'left' | 'right';  // default: auto (calcula mais proximo)
  toSide?: 'top' | 'bottom' | 'left' | 'right';    // default: auto
}

interface SvgConnectorProps {
  connections: Connection[];
  containerRef: React.RefObject<HTMLElement>;  // ref do container pai
  strokeColor?: string;    // default: 'rgba(34, 211, 238, 0.5)' (cyan Borealis)
  strokeWidth?: number;    // default: 2
  className?: string;
}

## Comportamento

1. Use `useLayoutEffect` para medir posicoes dos elementos `from` e `to` dentro do `containerRef`
2. Use `ResizeObserver` no `containerRef` para recalcular paths quando o container redimensiona
3. Para cada connection, calcule um path bezier cubic entre os pontos de borda dos elementos:
   - Se `fromSide`/`toSide` especificados, use essas bordas
   - Se nao, calcule automaticamente a borda mais proxima entre os dois elementos
   - Control points do bezier: offset de 40-60px perpendicular a direcao do path
4. Renderize um `<svg>` absolutamente posicionado sobre o container com `pointer-events: none`
5. O SVG deve ter `width: 100%`, `height: 100%`, `position: absolute`, `top: 0`, `left: 0`
6. Para cada path:
   - `<path>` com `fill: none`, `stroke: strokeColor`, `stroke-width: strokeWidth`
   - Se `dashed`: `stroke-dasharray: 8 4`
   - Se `animated`: animacao CSS `stroke-dashoffset` de 24 para 0, duracao 1.5s, linear, infinite
   - Arrowhead no final: marker SVG `<marker>` com triangulo
7. Para labels: posicione um `<div>` (NAO SVG text) no midpoint do path via `position: absolute`
   - Font size: 0.75rem, background semi-transparente, border-radius 4px
8. Respeite `prefers-reduced-motion`: se ativado, desabilite animacoes de stroke-dashoffset

## Estilo dos paths

- `filter: drop-shadow(0 0 4px rgba(34, 211, 238, 0.3))` para glow sutil
- Arrowhead: mesmo strokeColor, tamanho 8x6

## Restricoes

- NAO use bibliotecas externas (nem d3, nem ReactFlow, nem GSAP)
- NAO calcule paths no servidor — tudo client-side via useLayoutEffect
- NAO use SVG `<text>` para labels — use HTML divs posicionados absolutamente
- O componente deve funcionar com `client:visible` no Astro
- Mantenha o JS bundle < 5KB gzipped
- Use `useCallback` e `useMemo` para evitar recalculos desnecessarios
- Cleanup do ResizeObserver no return do useEffect

## Referencia de path calculation

Para bezier entre ponto A (borda do elemento from) e ponto B (borda do elemento to):
- Se vertical (A embaixo, B em cima): control points com offset horizontal
- Se horizontal: control points com offset vertical
- Funcao auxiliar: `getAnchorPoint(element: DOMRect, side: 'top'|'bottom'|'left'|'right'): {x, y}`
```

**Arquivos alvo:**

- `src/components/ui/SvgConnector.tsx`

**Criterios de aceite:**

- [ ] Paths SVG sao desenhados corretamente entre elementos referenciados
- [ ] ResizeObserver recalcula paths ao redimensionar
- [ ] Labels posicionados no midpoint dos paths
- [ ] Animacao stroke-dashoffset funciona quando `animated: true`
- [ ] `prefers-reduced-motion` desabilita animacoes
- [ ] Arrowheads visiveis nos finais dos paths
- [ ] SVG overlay nao bloqueia interacao (pointer-events: none)

**Validacao pos-execucao:**

```bash
test -f src/components/ui/SvgConnector.tsx && npm run typecheck && npm run build
```

---

### E1.T3 — Estender ProcessTimeline.astro

```yaml
id: "E1.T3"
depends_on: []
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Estenda o componente `src/components/ui/ProcessTimeline.astro` para suportar novos tipos de marker alem do circulo padrao. Isso e necessario para os diagramas CeremonyFlowDiagram e DirectEditFlowDiagram que tem gates e decisoes.

## Leia primeiro

1. `src/components/ui/ProcessTimeline.astro` — componente atual
2. `src/components/ui/ProcessCard.astro` — card usado dentro do timeline

## Mudancas necessarias

### 1. Adicionar prop `markerType` ao ProcessCard

Modifique `src/components/ui/ProcessCard.astro` para aceitar uma nova prop opcional:

interface Props {
  // ... props existentes ...
  markerType?: 'default' | 'gate' | 'decision';  // default: 'default'
}

### 2. Estilos de marker por tipo

No CSS do ProcessCard (ou ProcessTimeline, onde o marker e renderizado):

- `default`: circulo preenchido (comportamento atual — NAO mude)
- `gate`: losango (quadrado rotacionado 45deg) com cor amarela `var(--color-semantic-warning, rgba(250, 204, 21, 0.8))`
- `decision`: losango com cor violeta `var(--color-aurora-violet, rgba(167, 139, 250, 0.8))`

Para o losango, use:
```css
.marker--gate,
.marker--decision {
  width: 12px;
  height: 12px;
  transform: rotate(45deg);
  border-radius: 2px;
}
```

### 3. Adicionar suporte para `annotation` no ProcessCard

Nova prop opcional para exibir anotacoes laterais (usado para feedback loops):

interface Props {
  // ... props existentes ...
  annotation?: string;  // texto exibido como badge ao lado do step
}

Renderize como: `<span class="process-card__annotation">{annotation}</span>`
Estilo: `font-size: 0.75rem`, `color: var(--color-text-muted)`, `font-style: italic`, posicionado abaixo da descricao.

### 4. Gradiente na linha do timeline

Adicione uma prop opcional ao ProcessTimeline para gradiente na linha:

interface Props {
  accentColor?: string;
  gradientTo?: string;  // se definido, a linha usa gradiente de accentColor para gradientTo
}

Se `gradientTo` fornecido, aplique:
```css
background: linear-gradient(to bottom, var(--timeline-accent), var(--timeline-gradient-to));
```

## Restricoes

- NAO quebre a API existente — todas as mudancas sao aditivas (props opcionais)
- NAO altere o comportamento padrao quando as novas props nao sao passadas
- NAO adicione JavaScript — tudo CSS puro
- Mantenha os 3 breakpoints responsivos existentes
- Teste que o componente continua funcionando sem as novas props
```

**Arquivos alvo:**

- `src/components/ui/ProcessTimeline.astro`
- `src/components/ui/ProcessCard.astro`

**Criterios de aceite:**

- [ ] Marker type `gate` renderiza losango amarelo
- [ ] Marker type `decision` renderiza losango violeta
- [ ] Marker type `default` (ou omitido) mantem comportamento atual
- [ ] Prop `annotation` exibe texto descritivo abaixo do step
- [ ] Prop `gradientTo` aplica gradiente na linha do timeline
- [ ] API existente nao quebra — componentes sem novas props funcionam identicamente
- [ ] Zero JavaScript adicionado

**Validacao pos-execucao:**

```bash
npm run build
```

---

### E1.T4 — Criar StepperFlow.astro

```yaml
id: "E1.T4"
depends_on: []
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie o componente `src/components/ui/StepperFlow.astro` — um stepper horizontal (desktop) / vertical (mobile) reutilizavel para fluxos sequenciais com gates.

## Leia primeiro

- `src/components/ui/ProcessTimeline.astro` — referencia de estilo e responsividade
- `src/components/ui/ProcessCard.astro` — referencia de padrao de card

## Props

interface StepItem {
  number: number;
  title: string;
  description?: string;
  type?: 'step' | 'gate';  // default: 'step'
  gateLabel?: string;       // ex: "Aprovacao" — exibido no badge do gate
}

interface Props {
  steps: StepItem[];
  accentColor?: string;    // default: 'var(--color-aurora-cyan)'
  class?: string;
}

## Estrutura HTML

<div class="stepper-flow {class}">
  {steps.map((step, i) => (
    <>
      <div class="stepper-flow__item stepper-flow__item--{step.type}">
        <div class="stepper-flow__marker">
          {step.type === 'gate' ? (
            <span class="stepper-flow__gate-icon">◇</span>
          ) : (
            <span class="stepper-flow__number">{step.number}</span>
          )}
        </div>
        <div class="stepper-flow__content">
          <h4 class="stepper-flow__title">{step.title}</h4>
          {step.gateLabel && <span class="stepper-flow__gate-badge">{step.gateLabel}</span>}
          {step.description && <p class="stepper-flow__description">{step.description}</p>}
        </div>
      </div>
      {i < steps.length - 1 && (
        <div class="stepper-flow__connector" />
      )}
    </>
  ))}
</div>

## Estilos

### Desktop (>= 768px)
- Container: `display: flex; flex-direction: row; align-items: flex-start`
- Items: `flex: 1; text-align: center`
- Markers: circulos numerados (40px) com borda cyan, fundo semi-transparente
- Gates: losango (rotated square) com cor amarela
- Connectors: linha horizontal `height: 2px` com gradiente cyan entre markers
- Gate badges: `background: rgba(250, 204, 21, 0.15)`, `color: rgba(250, 204, 21, 0.9)`, `font-size: 0.75rem`, `border-radius: 9999px`, `padding: 2px 10px`

### Mobile (< 768px)
- Container: `flex-direction: column`
- Items: `flex-direction: row; text-align: left`
- Markers: mesmos, a esquerda
- Connectors: linha vertical `width: 2px; height: 24px` alinhada ao centro do marker
- Content: a direita do marker

## Restricoes

- NAO use JavaScript — Astro puro com CSS
- NAO adicione dependencias externas
- Use variaveis CSS do tema Borealis quando disponiveis
- Mantenha consistencia visual com ProcessTimeline.astro
```

**Arquivos alvo:**

- `src/components/ui/StepperFlow.astro`

**Criterios de aceite:**

- [ ] Stepper renderiza horizontal em desktop (>= 768px)
- [ ] Stepper renderiza vertical em mobile (< 768px)
- [ ] Steps exibem numero, titulo e descricao
- [ ] Gates exibem losango amarelo com badge de label
- [ ] Conectores visiveis entre steps
- [ ] Zero JavaScript no client-side

**Validacao pos-execucao:**

```bash
test -f src/components/ui/StepperFlow.astro && npm run build
```

---

## Epico 2 — Diagramas Simples: Infographic Cards

> Substituir os 3 diagramas mais simples (ThreeGaps, ContextVoid, ContextualSpec) por componentes Astro puros com CSS Grid. Valida a abordagem antes de avançar para os mais complexos.

### E2.T1 — ThreeGapsDiagram V2

```yaml
id: "E2.T1"
depends_on: ["E1.T1"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/ThreeGapsDiagramV2.astro` para substituir o ThreeGapsDiagram.tsx baseado em ReactFlow. Depois, atualize a section para usar o novo componente.

## Leia primeiro

1. `src/lib/diagrams/three-gaps-diagram.ts` — dados atuais (nos e edges)
2. `src/components/diagrams/ThreeGapsDiagram.tsx` — componente atual
3. `src/components/sections/ConsequenciasSection.astro` — section que importa o diagrama
4. `src/components/ui/FlowCard.astro` — card base que voce deve usar
5. `src/components/ui/DiagramContainer.astro` — wrapper que voce deve usar

## Design

Tres cards lado a lado (desktop) / empilhados (mobile), cada um representando um gap. Sem conectores — os cards comunicam "tres problemas independentes". Dashed border reforça o tema de "desconexao".

## Implementacao

1. Crie `src/components/diagrams/ThreeGapsDiagramV2.astro`:
   - Wrapper: use `DiagramContainer` com `label="Os Tres Gaps que fragmentam o desenvolvimento"`
   - Layout: CSS Grid `grid-template-columns: repeat(3, 1fr); gap: var(--space-6, 1.5rem)`
   - Mobile (< 768px): `grid-template-columns: 1fr`
   - Cada card: use `FlowCard` com `variant="problem"` e adicione `border-style: dashed` via classe extra
   - Dados dos 3 gaps (extraia do arquivo de dados atual):
     - Gap 1: "IA sem Contexto" — IA gera codigo sem entender o negocio
     - Gap 2: "Negocio Excluido" — Stakeholders de negocio nao participam do processo tecnico
     - Gap 3: "Conhecimento Descartavel" — Decisoes e contexto se perdem entre conversas
   - Cada card deve ter: icone, titulo, descricao completa (extraia textos do arquivo de dados)
   - NAO use JavaScript — componente Astro puro

2. Modifique `src/components/sections/ConsequenciasSection.astro`:
   - Troque o import de `ThreeGapsDiagram` (React) para `ThreeGapsDiagramV2` (Astro)
   - Remova qualquer `client:` directive associada ao diagrama antigo
   - Mantenha todo o resto da section intacto

## Estilos adicionais (no <style> scoped do componente)

- Cards com `border: 2px dashed` (a cor vem da variante `problem` do FlowCard)
- `border-radius: var(--radius-lg, 12px)`
- Gap entre cards: `var(--space-6, 1.5rem)`

## Restricoes

- NAO modifique o FlowCard.astro
- NAO adicione JavaScript
- NAO altere outros componentes ou sections
- Mantenha o texto/conteudo semanticamente identico ao diagrama atual
```

**Arquivos alvo:**

- `src/components/diagrams/ThreeGapsDiagramV2.astro`
- `src/components/sections/ConsequenciasSection.astro`

**Criterios de aceite:**

- [ ] 3 cards visiveis em 375px (empilhados verticalmente)
- [ ] 3 cards lado a lado em 1440px
- [ ] Dashed border vermelha em cada card
- [ ] Icones e textos completos (sem truncamento)
- [ ] Zero JavaScript no client-side bundle para este diagrama
- [ ] Section atualizada para importar V2

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/ThreeGapsDiagramV2.astro && npm run build
```

---

### E2.T2 — ContextVoidDiagram V2

```yaml
id: "E2.T2"
depends_on: ["E1.T1"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/ContextVoidDiagramV2.astro` para substituir o ContextVoidDiagram.tsx baseado em ReactFlow. Depois, atualize a section.

## Leia primeiro

1. `src/lib/diagrams/context-void-diagram.ts` — dados atuais (nos e edges)
2. `src/components/diagrams/ContextVoidDiagram.tsx` — componente atual
3. `src/components/sections/HeroSection.astro` — section que importa o diagrama
4. `src/components/ui/FlowCard.astro` — card base
5. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Pipeline `Conhecimento -> [GAP] -> Especificacao -> Codigo gerado -> Bugs de logica de negocio`. O gap entre Conhecimento e Especificacao e representado por um icone visual de ruptura (nao um edge).

### Layout Desktop
```
[Conhecimento] ---X--- [Especificacao] -----> [Codigo gerado]
                gap                              |
                                                 v
                                   [Bugs de logica de negocio]
```

### Layout Mobile (empilhado)
```
[Conhecimento]
     X (gap visual)
[Especificacao]
     ↓
[Codigo gerado]
     ↓
[Bugs de logica de negocio]
```

## Implementacao

1. Crie `src/components/diagrams/ContextVoidDiagramV2.astro`:
   - Wrapper: `DiagramContainer` com `label="O Vazio de Contexto no desenvolvimento com IA"`
   - Layout desktop: CSS Grid com colunas para o fluxo horizontal principal
     - Linha 1: [Conhecimento] [gap-icon] [Especificacao] [seta] [Codigo gerado]
     - Linha 2 (abaixo de Codigo): [Bugs]
   - Use `FlowCard` para cada no:
     - "Conhecimento tacito": variant `default`, icon adequado
     - "Especificacao": variant `default`
     - "Codigo gerado": variant `default`
     - "Bugs de logica de negocio": variant `problem`
   - Gap visual: elemento com icone de ruptura (use ⚡ ou ✕) com animacao pulse vermelha via CSS
   - Setas entre cards: pseudo-elements `::after` com border CSS formando triangulo, ou caractere → estilizado
   - Mobile (< 768px): `grid-template-columns: 1fr`, tudo empilhado verticalmente, setas apontam para baixo

2. Modifique `src/components/sections/HeroSection.astro`:
   - Troque import de `ContextVoidDiagram` para `ContextVoidDiagramV2`
   - Remova `client:` directive do diagrama antigo

## Estilos

- Gap icon: `color: var(--color-semantic-problem, #f87171)`, `font-size: 1.5rem`, animacao `pulse` CSS
- Setas: `color: rgba(34, 211, 238, 0.5)`, `font-size: 1.25rem`
- Card de bugs: adicione `border-left: 3px solid var(--color-semantic-problem, #f87171)` via classe extra

## Restricoes

- NAO use JavaScript — Astro puro
- NAO modifique FlowCard.astro
- Extraia textos dos nos do arquivo de dados atual para manter conteudo identico
```

**Arquivos alvo:**

- `src/components/diagrams/ContextVoidDiagramV2.astro`
- `src/components/sections/HeroSection.astro`

**Criterios de aceite:**

- [ ] Todos os 4 nos visiveis e legiveis em 375px
- [ ] Gap visual entre "Conhecimento" e "Especificacao" e claro
- [ ] Fluxo direcional perceptivel (setas ou indicadores visuais)
- [ ] Variantes de cor (problem, default) aplicadas corretamente
- [ ] Zero JavaScript carregado para este diagrama
- [ ] Section atualizada para importar V2

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/ContextVoidDiagramV2.astro && npm run build
```

---

### E2.T3 — ContextualSpecDiagram V2

```yaml
id: "E2.T3"
depends_on: ["E1.T1"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/ContextualSpecDiagramV2.astro` para substituir o ContextualSpecDiagram.tsx baseado em ReactFlow. Depois, atualize a section.

## Leia primeiro

1. `src/lib/diagrams/contextual-spec-diagram.ts` — dados atuais
2. `src/components/diagrams/ContextualSpecDiagram.tsx` — componente atual
3. `src/components/sections/SpecCraftingSection.astro` — section que importa o diagrama
4. `src/components/ui/FlowCard.astro` — card base
5. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Tres cards verticais: `Product Canon -> Especificacao -> Plano de Implementacao`. Setas decorativas com labels entre os cards.

### Layout (desktop e mobile — sempre vertical)
```
[Product Canon]
    ↓ contexto relevante injetado
[Especificacao]
    - Validacao de conformidade
    - Clarificacao contextualizada
    - Rastreabilidade
    ↓ impactos rastreados
[Plano de Implementacao]
    - Impactos em negocio
    - Impactos em arquitetura
```

## Implementacao

1. Crie `src/components/diagrams/ContextualSpecDiagramV2.astro`:
   - Wrapper: `DiagramContainer` com `label="Especificacao Contextualizada pelo Product Canon"`
   - Layout: `display: flex; flex-direction: column; align-items: center; gap: var(--space-4, 1rem)`
   - Card 1 "Product Canon": `FlowCard` variant `canon`, icon adequado
   - Seta 1: div estilizado com icone ↓ + label "contexto relevante injetado"
   - Card 2 "Especificacao": `FlowCard` variant `solution`, com slot contendo checklist:
     - ✓ Validacao de conformidade
     - ✓ Clarificacao contextualizada
     - ✓ Rastreabilidade
   - Seta 2: div com icone ↓ + label "impactos rastreados"
   - Card 3 "Plano de Implementacao": `FlowCard` variant `default`, com slot contendo lista de impactos

2. Setas entre cards:
   - Container: `display: flex; flex-direction: column; align-items: center; gap: 0.25rem`
   - Icone: `↓` em `font-size: 1.25rem; color: rgba(34, 211, 238, 0.6)`
   - Label: `font-size: 0.8rem; color: var(--color-text-muted); font-style: italic`

3. Modifique `src/components/sections/SpecCraftingSection.astro`:
   - Troque import para `ContextualSpecDiagramV2`
   - Remova `client:` directive

## Restricoes

- NAO use JavaScript
- NAO modifique FlowCard.astro
- Cards devem ter `max-width: 480px` para nao ficarem demasiado largos em desktop
- Extraia textos do arquivo de dados atual
```

**Arquivos alvo:**

- `src/components/diagrams/ContextualSpecDiagramV2.astro`
- `src/components/sections/SpecCraftingSection.astro`

**Criterios de aceite:**

- [ ] 3 cards verticais com setas entre eles
- [ ] Checklists/bullets visiveis dentro dos cards
- [ ] Fluxo top-down claro
- [ ] Zero JavaScript
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/ContextualSpecDiagramV2.astro && npm run build
```

---

## Epico 3 — Diagramas Timeline

> Substituir CeremonyFlowDiagram e DirectEditFlowDiagram por versoes baseadas no ProcessTimeline estendido.

### E3.T1 — CeremonyFlowDiagram V2

```yaml
id: "E3.T1"
depends_on: ["E1.T3"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/CeremonyFlowDiagramV2.astro` usando o ProcessTimeline estendido para substituir o CeremonyFlowDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/ceremony-flow-diagram.ts` — dados atuais (nos e edges)
2. `src/components/diagrams/CeremonyFlowDiagram.tsx` — componente atual
3. `src/components/sections/CanonBuildingSection.astro` — section que importa
4. `src/components/ui/ProcessTimeline.astro` — timeline base (ja estendido com markerType, annotation, gradientTo)
5. `src/components/ui/ProcessCard.astro` — card do timeline (ja estendido)
6. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Timeline vertical com 7 steps: 3 sessoes (cyan), 3 gates (amarelo), 1 decisao (violeta). Feedback loops indicados textualmente como annotations.

### Steps

1. **Domain Discovery Session** (type: default/session)
   - Descricao: "Baseada em Event Storming. Saida: discovery-plan"
2. **Gate — Aprovacao** (markerType: gate)
   - Descricao: "Domain Expert (primaria) + Architect"
3. **Technical Constitution Session** (type: default)
   - Descricao: "Architect define principios tecnicos. Saida: constitution-plan"
4. **Gate — Aprovacao** (markerType: gate)
   - Descricao: "Architect (primaria) + Domain Expert"
5. **Requirements Specification Session** (type: default)
   - Descricao: "Clarificacao iterativa (8 passos). Saida: specification-plan"
6. **Gate — Aprovacao** (markerType: gate)
   - Descricao: "Domain Expert (primaria) + Architect"
7. **Decisao do Canon** (markerType: decision)
   - Descricao: "Variante do canon-type"
   - Annotation: "(a) Mais fluxos → volta para Discovery | (b) Mais requisitos → volta para Specification | (c) Encerrar → Spec Crafting"

## Implementacao

1. Crie `src/components/diagrams/CeremonyFlowDiagramV2.astro`:
   - Use `DiagramContainer` com label="Fluxo de Cerimonia do Canon Building" e title="Fluxo de Cerimonia"
   - Use `ProcessTimeline` com `gradientTo="var(--color-aurora-violet, rgba(167, 139, 250, 0.8))"`
   - Dentro: 7 `ProcessCard` com os dados acima, usando `markerType` e `annotation` conforme descrito
   - Extraia os textos completos dos nos do arquivo de dados atual

2. Modifique `src/components/sections/CanonBuildingSection.astro`:
   - Troque import de `CeremonyFlowDiagram` para `CeremonyFlowDiagramV2`
   - Remova `client:` directive
   - ATENCAO: esta section pode ter DOIS diagramas (CeremonyFlow E CanonBuilding). So troque o CeremonyFlow.

## Restricoes

- NAO modifique ProcessTimeline.astro ou ProcessCard.astro
- NAO use JavaScript
- Titulo deve ser "Fluxo de Cerimonia" (NAO "CEREMONYFLOWDIAGRAM")
```

**Arquivos alvo:**

- `src/components/diagrams/CeremonyFlowDiagramV2.astro`
- `src/components/sections/CanonBuildingSection.astro`

**Criterios de aceite:**

- [ ] 7 steps em timeline vertical legivel em qualquer viewport
- [ ] Markers diferenciados: sessoes (cyan), gates (amarelo), decisao (violeta)
- [ ] Feedback loops (a), (b), (c) indicados com texto descritivo
- [ ] Titulo corrigido (nao "CEREMONYFLOWDIAGRAM")
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/CeremonyFlowDiagramV2.astro && npm run build
```

---

### E3.T2 — DirectEditFlowDiagram V2

```yaml
id: "E3.T2"
depends_on: ["E1.T3"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/DirectEditFlowDiagramV2.astro` usando o ProcessTimeline estendido para substituir o DirectEditFlowDiagram.tsx.

## Leia primeiro

1. `src/lib/diagrams/direct-edit-flow-diagram.ts` — dados atuais
2. `src/components/diagrams/DirectEditFlowDiagram.tsx` — componente atual
3. `src/components/sections/DirectEditSection.astro` — section que importa
4. `src/components/ui/ProcessTimeline.astro` — timeline base
5. `src/components/ui/ProcessCard.astro` — card do timeline
6. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Timeline vertical com 7 steps mostrando o fluxo de Edicao Direta. Loop iterativo (Revisao -> Guardrails) representado como annotation textual.

### Steps

1. **Proposta do Domain Expert** (type: default)
   - Descricao: "Sugestao em linguagem natural"
2. **Guardrails Automaticos** (type: default)
   - Descricao: "Validacao imediata contra camadas de protecao"
3. **Relatorio de Conformidade** (type: default)
   - Descricao: "Resultado da validacao automatica"
4. **Revisao Humana** (markerType: decision)
   - Descricao: "Revisao por aprovadores relevantes"
   - Annotation: "Se rejeitado: volta para Guardrails (loop iterativo)"
5. **Plano de Mudancas** (type: default)
   - Descricao: "expert-edit-plan gerado automaticamente"
6. **Aprovacao Tacita** (markerType: gate)
   - Descricao: "Nao-aprovacao dentro de 48h = aceitacao automatica"
7. **Aprovacao Sequencial** (type: default)
   - Descricao: "Camadas relevantes de guardrails aplicadas"

## Implementacao

1. Crie `src/components/diagrams/DirectEditFlowDiagramV2.astro`:
   - Use `DiagramContainer` com label="Fluxo de Edicao Direta do Product Canon"
   - Use `ProcessTimeline` com accent color padrao (cyan)
   - 7 `ProcessCard` conforme dados acima
   - Extraia textos completos do arquivo de dados atual

2. Modifique `src/components/sections/DirectEditSection.astro`:
   - Troque import para `DirectEditFlowDiagramV2`
   - Remova `client:` directive

## Restricoes

- NAO modifique ProcessTimeline.astro ou ProcessCard.astro
- NAO use JavaScript
```

**Arquivos alvo:**

- `src/components/diagrams/DirectEditFlowDiagramV2.astro`
- `src/components/sections/DirectEditSection.astro`

**Criterios de aceite:**

- [ ] Timeline vertical com 7 steps legivel em qualquer viewport
- [ ] Loop iterativo (Revisao -> Guardrails) indicado textualmente
- [ ] Aprovacao tacita e sequencial diferenciadas visualmente
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/DirectEditFlowDiagramV2.astro && npm run build
```

---

## Epico 4 — Diagramas Stepper

> Substituir CanonBuildingDiagram e ChangePlanEnvelopeDiagram por versoes baseadas no StepperFlow e cards hierarquicos.

### E4.T1 — CanonBuildingDiagram V2

```yaml
id: "E4.T1"
depends_on: ["E1.T4"]
status: "done"
priority: "medium"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/CanonBuildingDiagramV2.astro` usando StepperFlow para substituir o CanonBuildingDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/canon-building-diagram.ts` — dados atuais
2. `src/components/diagrams/CanonBuildingDiagram.tsx` — componente atual
3. `src/components/sections/CanonBuildingSection.astro` — section (ATENCAO: ja foi modificada na E3.T1 para o CeremonyFlowDiagram. Agora troque o CanonBuildingDiagram)
4. `src/components/ui/StepperFlow.astro` — stepper base
5. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Processo sequencial: 3 sessoes, cada uma seguida por um gate de aprovacao. Stepper horizontal (desktop) / vertical (mobile).

### Steps (extraia detalhes do arquivo de dados)

1. Discovery Session (type: step)
2. Gate 1 — Aprovacao (type: gate, gateLabel: "Aprovacao")
3. Technical Constitution Session (type: step)
4. Gate 2 — Aprovacao (type: gate, gateLabel: "Aprovacao")
5. Requirements Specification Session (type: step)
6. Gate 3 — Aprovacao (type: gate, gateLabel: "Aprovacao")

## Implementacao

1. Crie `src/components/diagrams/CanonBuildingDiagramV2.astro`:
   - Use `DiagramContainer` com label="Visao Geral do Canon Building"
   - Use `StepperFlow` com os 6 steps acima
   - Abaixo do stepper, adicione cards de detalhe para cada sessao (usando FlowCard):
     - Discovery: o que acontece, quem participa, saida
     - Constitution: idem
     - Specification: idem
   - Cards de detalhe em CSS Grid `repeat(3, 1fr)` desktop / `1fr` mobile

2. Modifique `src/components/sections/CanonBuildingSection.astro`:
   - Troque import de `CanonBuildingDiagram` para `CanonBuildingDiagramV2`
   - Remova `client:` directive deste diagrama

## Restricoes

- NAO modifique StepperFlow.astro ou FlowCard.astro
- NAO use JavaScript
- NAO altere o import do CeremonyFlowDiagramV2 (ja trocado na E3.T1)
```

**Arquivos alvo:**

- `src/components/diagrams/CanonBuildingDiagramV2.astro`
- `src/components/sections/CanonBuildingSection.astro`

**Criterios de aceite:**

- [ ] 3 sessoes + 3 gates claramente sequenciais
- [ ] Stepper horizontal em desktop, vertical em mobile
- [ ] Gates com cor amarela diferenciada e label "Aprovacao"
- [ ] Cards de detalhe abaixo do stepper
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/CanonBuildingDiagramV2.astro && npm run build
```

---

### E4.T2 — ChangePlanEnvelopeDiagram V2

```yaml
id: "E4.T2"
depends_on: ["E1.T1"]
status: "done"
priority: "medium"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro` para substituir o ChangePlanEnvelopeDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/change-plan-envelope-diagram.ts` — dados atuais
2. `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx` — componente atual
3. `src/components/sections/ChangePlanSection.astro` — section que importa
4. `src/components/ui/FlowCard.astro` — card base
5. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Card de envelope com campos, grid de 5 tipos de change plan, e secao de aprovacao. Tres partes visuais distintas.

### Layout Desktop
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

### Layout Mobile
- Envelope: card com lista de campos
- Tipos: grid 2 colunas com wrap
- Aprovacao: cards empilhados

## Implementacao

1. Crie `src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro`:
   - Use `DiagramContainer` com label="Estrutura do Canonical Change Plan"

   **Parte 1 — Envelope Card:**
   - `FlowCard` variant `canon` com titulo "Canonical Change Plan"
   - Slot com duas listas:
     - "Campos Universais": `<ul>` com items origin, scope, business-impact, technical-impact, rollback-strategy
     - "Campos Condicionais": `<ul>` com items session-artifacts, expert-justification
   - Badges para categorias: `universal`, `condicional`

   **Parte 2 — Grid de Tipos:**
   - Titulo "Tipos de Change Plan" como `<h4>`
   - CSS Grid: `repeat(auto-fit, minmax(160px, 1fr)); gap: var(--space-4)`
   - 5 mini-cards (FlowCard variant `default`) para cada tipo:
     - discovery-plan, constitution-plan, specification-plan, expert-edit-plan, incremental-plan
   - Cada mini-card com titulo e 1 linha de descricao

   **Parte 3 — Aprovacao:**
   - Dois cards lado a lado (desktop) / empilhados (mobile):
     - "Aprovacao Tacita (48h)": FlowCard variant `gate`, lista dos tipos que usam
     - "Aprovacao Nao-Tacita": FlowCard variant `decision`, menciona expert-edit-plan

2. Modifique `src/components/sections/ChangePlanSection.astro`:
   - Troque import para `ChangePlanEnvelopeDiagramV2`
   - Remova `client:` directive

## Restricoes

- NAO use JavaScript
- NAO modifique FlowCard.astro
- Extraia nomes de campos e tipos do arquivo de dados atual
```

**Arquivos alvo:**

- `src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro`
- `src/components/sections/ChangePlanSection.astro`

**Criterios de aceite:**

- [ ] Envelope com campos universais e condicionais listados
- [ ] 5 tipos em grid responsivo (5 colunas desktop, 2 mobile)
- [ ] Fluxo de aprovacao claro (tacita vs nao-tacita)
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro && npm run build
```

---

## Epico 5 — Diagramas Hibridos (SVG + Cards)

> Os 3 diagramas mais complexos que requerem conectores SVG: CycleDiagram, FeedbackDiagram, GuardrailsDiagram.

### E5.T1 — CycleDiagram V2

```yaml
id: "E5.T1"
depends_on: ["E1.T1", "E1.T2"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/CycleDiagramV2.tsx` — o diagrama mais complexo do site — usando CSS Grid + SvgConnector para substituir o CycleDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/cycle-diagram.ts` — dados atuais (nos, edges, posicoes)
2. `src/components/diagrams/CycleDiagram.tsx` — componente atual
3. `src/components/sections/CycleOverviewSection.astro` — section que importa
4. `src/components/ui/SvgConnector.tsx` — overlay SVG para conectores
5. `src/components/ui/FlowCard.astro` — card base (mas aqui usaremos JSX equivalente)
6. `src/components/ui/DiagramContainer.astro` — wrapper

## Design

Topologia ciclica com 6 nos e 7 edges. Product Canon no topo, 3 etapas + decisao + canal complementar.

### Layout Desktop (CSS Grid com areas nomeadas)
```
grid-template-areas:
  ".        canon      ."
  "etapa1   .          etapa3"
  "decisao  .          edicao"
  ".        etapa2     ."
```

### Layout Mobile (coluna unica)
Empilhado: Canon -> Etapa1 -> Decisao -> Etapa2 -> Etapa3 -> Edicao Direta

## Implementacao

1. Crie `src/components/diagrams/CycleDiagramV2.tsx` como componente React:

   ```tsx
   // O componente precisa ser React porque usa SvgConnector (que precisa de useLayoutEffect)
   import { useRef } from 'react';
   import SvgConnector from './ui/SvgConnector';
   ```

   **Grid container:**
   - `position: relative` (para SVG overlay)
   - Desktop: CSS Grid com `grid-template-areas` conforme acima
   - Grid cells: `gap: var(--space-8, 2rem)`
   - Cada no e um div com `data-flow-card` e id unico (ex: `data-node="canon"`, `data-node="etapa1"`)

   **Nos (cards inline — replique o estilo do FlowCard em JSX):**
   - Product Canon: variant `canon`, icon "📋"
   - Etapa 1 — Construir Canon: variant `default`, icon "🏗️"
   - Decisao de Continuidade: variant `decision`, icon "◇"
   - Etapa 2 — Especificar: variant `solution`, icon "📝"
   - Etapa 3 — Devolver ao Canon: variant `default`, icon "🔄"
   - Edicao Direta: variant `complementary`, icon "✏️"
   - Extraia textos completos (title, content) do arquivo de dados `cycle-diagram.ts`

   **Conexoes (SvgConnector):**
   ```tsx
   connections={[
     { from: '[data-node="canon"]', to: '[data-node="etapa1"]', label: 'contexto injetado', fromSide: 'bottom', toSide: 'top' },
     { from: '[data-node="etapa1"]', to: '[data-node="decisao"]', fromSide: 'bottom', toSide: 'top' },
     { from: '[data-node="decisao"]', to: '[data-node="etapa2"]', label: 'encerrar ciclo', fromSide: 'bottom', toSide: 'top' },
     { from: '[data-node="etapa2"]', to: '[data-node="etapa3"]', label: 'descobertas', fromSide: 'right', toSide: 'left' },
     { from: '[data-node="etapa3"]', to: '[data-node="canon"]', label: 'atualiza canon', fromSide: 'top', toSide: 'right', animated: true },
     { from: '[data-node="etapa3"]', to: '[data-node="edicao"]', fromSide: 'bottom', toSide: 'top' },
     { from: '[data-node="edicao"]', to: '[data-node="canon"]', label: 'feedback', dashed: true, animated: true, fromSide: 'left', toSide: 'left' },
   ]}
   ```

   **Mobile (< 768px):**
   - CSS media query: `grid-template-columns: 1fr; grid-template-areas: none`
   - Nos em sequencia vertical natural
   - SvgConnector recalcula paths automaticamente via ResizeObserver

   **Estilos inline ou CSS module:**
   - Cards: replique o estilo do FlowCard (border, bg, padding, border-radius) usando as cores do variantColors
   - Canal complementar (Edicao Direta): `border-color: rgba(244, 114, 182, 0.3)` (pink)

2. Modifique `src/components/sections/CycleOverviewSection.astro`:
   - Troque import de `CycleDiagram` para `CycleDiagramV2`
   - Mantenha `client:visible` (necessario para o React component)

## Restricoes

- NAO importe @xyflow/react
- NAO importe elkjs
- NAO use bibliotecas externas alem de React
- Use APENAS SvgConnector para conectores
- Respeite `prefers-reduced-motion` (SvgConnector ja faz isso)
- Mantenha bundle < 5KB para este componente (excluindo React que ja e shared)
```

**Arquivos alvo:**

- `src/components/diagrams/CycleDiagramV2.tsx`
- `src/components/sections/CycleOverviewSection.astro`

**Criterios de aceite:**

- [ ] Todos os 6 nos visiveis e legiveis em 375px
- [ ] Conectores visiveis indicando ciclo em desktop
- [ ] Edge labels legiveis ("contexto injetado", "descobertas", etc.)
- [ ] Canal complementar (Edicao Direta) visualmente diferenciado (pink)
- [ ] Animacao de edges respeita `prefers-reduced-motion`
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/CycleDiagramV2.tsx && npm run typecheck && npm run build
```

---

### E5.T2 — FeedbackDiagram V2

```yaml
id: "E5.T2"
depends_on: ["E1.T1", "E1.T2"]
status: "done"
priority: "medium"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/FeedbackDiagramV2.tsx` usando CSS Grid + SvgConnector para substituir o FeedbackDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/feedback-diagram.ts` — dados atuais
2. `src/components/diagrams/FeedbackDiagram.tsx` — componente atual
3. `src/components/sections/EnrichmentSection.astro` — section que importa
4. `src/components/ui/SvgConnector.tsx` — overlay SVG
5. `src/lib/diagrams/shared-config.ts` — variantColors

## Design

Diagrama de bifurcacao/merge: Implementacao -> (Sinalizacao | Deteccao) -> Guardrails -> (Review | Escalacao) -> Canon Atualizado. Mais secao de versionamento (Part B).

### Layout Desktop (CSS Grid areas)
```
grid-template-areas:
  ".           impl        ."
  "sinal       .           deteccao"
  ".           guardrails  ."
  "review      .           escalacao"
  ".           canon-upd   ."
```

### Layout Mobile
Coluna unica. Pares paralelos (Sinalizacao/Deteccao e Review/Escalacao) em sub-grid `repeat(2, 1fr)`.

## Implementacao

1. Crie `src/components/diagrams/FeedbackDiagramV2.tsx`:

   **Part A — Fluxo de Enrichment:**
   - React component com `useRef` para container
   - CSS Grid com areas nomeadas (desktop)
   - 7 nos como divs estilizados (replique FlowCard styles):
     - Implementacao concluida (default)
     - Sinalizacao explicita (solution)
     - Deteccao IA (solution)
     - Guardrails (gate)
     - Review Assincrono (default)
     - Escalacao (decision)
     - Canon Atualizado (canon)
   - SvgConnector com 8 connections (bifurcacoes e merges)
   - Mobile: grid muda para coluna unica, pares paralelos em sub-grid 2 colunas

   **Part B — Versionamento:**
   - Secao HTML separada abaixo do diagrama
   - Dois cards lado a lado: "current" e "next" (FlowCard variant default)
   - Explica o modelo de versionamento do canon
   - Extraia conteudo do arquivo de dados atual

2. Modifique `src/components/sections/EnrichmentSection.astro`:
   - Troque import para `FeedbackDiagramV2`
   - Mantenha `client:visible`

## Restricoes

- NAO importe @xyflow/react ou elkjs
- Extraia textos do arquivo de dados atual
```

**Arquivos alvo:**

- `src/components/diagrams/FeedbackDiagramV2.tsx`
- `src/components/sections/EnrichmentSection.astro`

**Criterios de aceite:**

- [ ] Bifurcacao (Sinalizacao/Deteccao) visivel em desktop
- [ ] Em mobile: pares lado a lado com grouping visual
- [ ] Secao de versionamento (Part B) preservada
- [ ] Merge de caminhos indicado visualmente
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/FeedbackDiagramV2.tsx && npm run typecheck && npm run build
```

---

### E5.T3 — GuardrailsDiagram V2

```yaml
id: "E5.T3"
depends_on: ["E1.T1", "E1.T2"]
status: "done"
priority: "medium"
```

**Prompt para o Claude Code:**

```
Crie `src/components/diagrams/GuardrailsDiagramV2.tsx` usando CSS Grid + SvgConnector para substituir o GuardrailsDiagram.tsx baseado em ReactFlow.

## Leia primeiro

1. `src/lib/diagrams/guardrails-diagram.ts` — dados atuais
2. `src/components/diagrams/GuardrailsDiagram.tsx` — componente atual
3. `src/components/sections/GuardrailsSection.astro` — section que importa
4. `src/components/ui/SvgConnector.tsx` — overlay SVG
5. `src/lib/diagrams/shared-config.ts` — variantColors

## Design

Hub-spoke: Product Canon no centro com 5 guardrails ao redor. Em mobile, transforma para lista vertical.

### Layout Desktop (CSS Grid 3x3)
```
grid-template-areas:
  "conform    enrichment  consist"
  ".          canon       ."
  "semantica  building    format"
  ".          version     ."
```

### Layout Mobile
Product Canon como card hero no topo, seguido por lista vertical de 5 guardrails com stage badges.

## Implementacao

1. Crie `src/components/diagrams/GuardrailsDiagramV2.tsx`:
   - React component com useRef para container
   
   **Desktop:**
   - CSS Grid com areas nomeadas 3x3
   - Product Canon central: variant `canon`, `box-shadow: 0 0 20px rgba(34, 211, 238, 0.3)` (glow)
   - 5 guardrails ao redor: variant `gate`
     - Conformidade (Etapa 1, 3)
     - Consistencia (Etapa 1, 3)
     - Semantica Interna (Etapa 1)
     - Formatacao (Etapa 1, 3)
     - Versionamento Strangler (Mudancas estruturais)
   - SvgConnector: linhas radiais do canon central para cada guardrail
   - Stage badges dentro de cada guardrail card: `<span>` com background sutil

   **Mobile (< 768px):**
   - Esconda o SVG overlay
   - Product Canon como card hero largo no topo
   - 5 guardrails em lista vertical, cada um com stage badges inline
   - Use media query para trocar layout

2. Modifique `src/components/sections/GuardrailsSection.astro`:
   - Troque import para `GuardrailsDiagramV2`
   - Mantenha `client:visible`

## Restricoes

- NAO importe @xyflow/react ou elkjs
- Labels completos sem truncamento em todos os viewports
- Extraia textos do arquivo de dados atual
```

**Arquivos alvo:**

- `src/components/diagrams/GuardrailsDiagramV2.tsx`
- `src/components/sections/GuardrailsSection.astro`

**Criterios de aceite:**

- [ ] Product Canon central com glow em desktop
- [ ] 5 guardrails ao redor com badges de stage
- [ ] Em mobile: lista vertical com Product Canon como header
- [ ] Todas as labels completas (sem truncamento)
- [ ] Section atualizada

**Validacao pos-execucao:**

```bash
test -f src/components/diagrams/GuardrailsDiagramV2.tsx && npm run typecheck && npm run build
```

---

## Epico 6 — Melhorias e Cleanup

> Melhorar RolesMatrixDiagram, remover BeforeAfterDiagram orfao, desinstalar @xyflow/react e elkjs, e limpar arquivos obsoletos.

### E6.T1 — Melhorar RolesMatrixDiagram para mobile

```yaml
id: "E6.T1"
depends_on: []
status: "pending"
priority: "low"
```

**Prompt para o Claude Code:**

```
Melhore a responsividade do `src/components/diagrams/RolesMatrixDiagram.astro` para mobile.

## Leia primeiro

1. `src/components/diagrams/RolesMatrixDiagram.astro` — componente atual

## Melhorias

1. **Sticky first column:** Adicione `position: sticky; left: 0; z-index: 1; background: var(--color-bg-surface, #0a0e17)` na primeira coluna (nome do papel) para manter visivel durante scroll horizontal.

2. **Hover highlight:** Melhore o contraste da linha em hover: `background: rgba(34, 211, 238, 0.05)` com `transition: background 0.2s`.

3. **Mobile < 480px (opcional):** Se viavel sem grande refatoracao, adicione um wrapper com `overflow-x: auto` e fade mask nas bordas:
   ```css
   .matrix-wrapper {
     overflow-x: auto;
     -webkit-overflow-scrolling: touch;
     mask-image: linear-gradient(to right, transparent, black 2%, black 98%, transparent);
   }
   ```

## Restricoes

- NAO reescreva o componente inteiro — apenas adicione CSS
- NAO adicione JavaScript
- NAO mude a estrutura HTML existente a menos que estritamente necessario
- Mantenha compatibilidade com o conteudo atual
```

**Arquivos alvo:**

- `src/components/diagrams/RolesMatrixDiagram.astro`

**Criterios de aceite:**

- [ ] Primeira coluna sticky durante scroll horizontal
- [ ] Hover highlight visivel nas linhas
- [ ] Tabela funcional em todos os viewports

**Validacao pos-execucao:**

```bash
npm run build
```

---

### E6.T2 — Remover BeforeAfterDiagram orfao

```yaml
id: "E6.T2"
depends_on: []
status: "pending"
priority: "low"
```

**Prompt para o Claude Code:**

```
Remova o componente orfao `src/components/diagrams/BeforeAfterDiagram.astro`.

## Verificacao pre-remocao

1. Busque no codebase inteiro por referencias a "BeforeAfterDiagram":
   - grep -r "BeforeAfterDiagram" src/
   - Se houver QUALQUER import ou referencia ativa, NAO remova e reporte o que encontrou

2. Se confirmado que e orfao (nenhum import ativo), delete o arquivo:
   - `src/components/diagrams/BeforeAfterDiagram.astro`

## Restricoes

- NAO remova se houver qualquer referencia ativa no codebase
- NAO remova outros arquivos
```

**Arquivos alvo:**

- `src/components/diagrams/BeforeAfterDiagram.astro` (deletar)

**Criterios de aceite:**

- [ ] Arquivo removido do codebase
- [ ] Nenhuma referencia quebrada (grep retorna vazio)

**Validacao pos-execucao:**

```bash
test ! -f src/components/diagrams/BeforeAfterDiagram.astro && npm run build
```

---

### E6.T3 — Remover dependencias ReactFlow/ELK e cleanup de arquivos obsoletos

```yaml
id: "E6.T3"
depends_on: ["E2.T1", "E2.T2", "E2.T3", "E3.T1", "E3.T2", "E4.T1", "E4.T2", "E5.T1", "E5.T2", "E5.T3"]
status: "done"
priority: "high"
```

**Prompt para o Claude Code:**

```
Remova @xyflow/react, elkjs, e todos os arquivos obsoletos dos diagramas V1 que foram substituidos.

## Etapa 1 — Verificacao

Antes de remover, verifique que NENHUM arquivo V2 importa @xyflow/react ou elkjs:
```bash
grep -r "@xyflow/react" src/components/diagrams/ src/components/sections/
grep -r "elkjs" src/components/diagrams/ src/components/sections/
```
Se encontrar alguma referencia nos arquivos V2, PARE e reporte.

## Etapa 2 — Desinstalar pacotes

```bash
npm uninstall @xyflow/react elkjs
```

## Etapa 3 — Deletar arquivos de diagramas V1

Deletar os componentes React Flow antigos (apenas os que tem versao V2 criada):
- `src/components/diagrams/ContextVoidDiagram.tsx`
- `src/components/diagrams/ThreeGapsDiagram.tsx`
- `src/components/diagrams/CycleDiagram.tsx`
- `src/components/diagrams/CanonBuildingDiagram.tsx`
- `src/components/diagrams/CeremonyFlowDiagram.tsx`
- `src/components/diagrams/ContextualSpecDiagram.tsx`
- `src/components/diagrams/FeedbackDiagram.tsx`
- `src/components/diagrams/GuardrailsDiagram.tsx`
- `src/components/diagrams/DirectEditFlowDiagram.tsx`
- `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx`

## Etapa 4 — Deletar arquivos de dados V1

- `src/lib/diagrams/context-void-diagram.ts`
- `src/lib/diagrams/three-gaps-diagram.ts`
- `src/lib/diagrams/cycle-diagram.ts`
- `src/lib/diagrams/canon-building-diagram.ts`
- `src/lib/diagrams/ceremony-flow-diagram.ts`
- `src/lib/diagrams/contextual-spec-diagram.ts`
- `src/lib/diagrams/feedback-diagram.ts`
- `src/lib/diagrams/guardrails-diagram.ts`
- `src/lib/diagrams/direct-edit-flow-diagram.ts`
- `src/lib/diagrams/change-plan-envelope-diagram.ts`

## Etapa 5 — Deletar arquivos compartilhados do ReactFlow

- `src/lib/diagrams/shared-config.ts`
- `src/lib/diagrams/use-elk-layout.ts`
- `src/lib/diagrams/use-responsive-flow.ts`
- `src/lib/diagrams/elk-presets.ts`

MANTER:
- `src/lib/diagrams/use-reduced-motion.ts` — pode ser usado por outros componentes

## Etapa 6 — Deletar NodeCard.tsx (se orfao)

Verifique se `src/components/diagrams/NodeCard.tsx` e importado por algum arquivo V2:
```bash
grep -r "NodeCard" src/components/diagrams/*V2* src/components/sections/
```
Se orfao, delete. Se ainda usado, mantenha.

## Etapa 7 — Limpar CSS

Busque e remova estilos relacionados ao ReactFlow:
```bash
grep -r "react-flow\|reactflow\|edge-flow" src/styles/
```
Se encontrar, remova as regras CSS especificas. NAO remova o arquivo inteiro se tiver outros estilos.

## Etapa 8 — Verificacao final

```bash
grep -r "@xyflow" src/
grep -r "elkjs" src/
grep -r "from.*react-flow" src/
```
Nenhum resultado deve ser encontrado.

## Restricoes

- NAO delete arquivos que ainda sao importados
- NAO delete use-reduced-motion.ts
- Verifique CADA arquivo antes de deletar
- Se alguma verificacao falhar, PARE e reporte ao inves de continuar
```

**Arquivos alvo:**

- `package.json` (remover deps)
- `src/components/diagrams/*.tsx` (V1 — deletar)
- `src/lib/diagrams/*-diagram.ts` (dados V1 — deletar)
- `src/lib/diagrams/shared-config.ts` (deletar)
- `src/lib/diagrams/use-elk-layout.ts` (deletar)
- `src/lib/diagrams/use-responsive-flow.ts` (deletar)
- `src/lib/diagrams/elk-presets.ts` (deletar)
- `src/components/diagrams/NodeCard.tsx` (deletar se orfao)
- CSS files (limpar regras ReactFlow)

**Criterios de aceite:**

- [ ] `@xyflow/react` e `elkjs` removidos do package.json
- [ ] Nenhum import de @xyflow/react restante no codebase
- [ ] Nenhum import de elkjs restante no codebase
- [ ] Arquivos V1 de diagramas deletados
- [ ] Arquivos de dados V1 deletados
- [ ] Arquivos compartilhados do ReactFlow deletados
- [ ] CSS de ReactFlow limpo
- [ ] `use-reduced-motion.ts` MANTIDO

**Validacao pos-execucao:**

```bash
npm install && npm run typecheck && npm run build && ! grep -r "@xyflow" src/ && ! grep -r "elkjs" src/
```

---

## Validacao Final

```yaml
id: "FINAL"
depends_on: ["*"]
```

**Validacao:**

```bash
# Build completo
npm run build

# Typecheck
npm run typecheck

# Lint
npm run lint

# Verificar que ReactFlow foi removido
! grep -r "@xyflow/react" src/
! grep -r "elkjs" src/

# Verificar que todos os V2 existem
test -f src/components/diagrams/ThreeGapsDiagramV2.astro
test -f src/components/diagrams/ContextVoidDiagramV2.astro
test -f src/components/diagrams/ContextualSpecDiagramV2.astro
test -f src/components/diagrams/CeremonyFlowDiagramV2.astro
test -f src/components/diagrams/DirectEditFlowDiagramV2.astro
test -f src/components/diagrams/CanonBuildingDiagramV2.astro
test -f src/components/diagrams/ChangePlanEnvelopeDiagramV2.astro
test -f src/components/diagrams/CycleDiagramV2.tsx
test -f src/components/diagrams/FeedbackDiagramV2.tsx
test -f src/components/diagrams/GuardrailsDiagramV2.tsx

# Verificar que componentes base existem
test -f src/components/ui/FlowCard.astro
test -f src/components/ui/SvgConnector.tsx
test -f src/components/ui/StepperFlow.astro
```

**Criterios de aceite globais:**

- [ ] Build do Astro completa sem erros
- [ ] Typecheck passa
- [ ] Zero warnings de lint
- [ ] `@xyflow/react` e `elkjs` removidos do `package.json`
- [ ] Nenhum import de ReactFlow restante no codebase
- [ ] Todos os 10 diagramas V2 criados e integrados nas sections
- [ ] Componentes base (FlowCard, SvgConnector, StepperFlow) existem
- [ ] ProcessTimeline estendido com markerType, annotation, gradientTo
- [ ] Texto legivel (>= 14px) em viewport 375px para todos os diagramas
- [ ] `prefers-reduced-motion` respeitado em diagramas com animacao
- [ ] Todos os diagramas possuem `aria-label` descritivo via DiagramContainer
- [ ] BeforeAfterDiagram removido
- [ ] RolesMatrixDiagram com melhorias de responsividade

---

## Notas de Execucao

<!-- Preenchido automaticamente pelo script de execucao -->

| Campo | Valor |
|-------|-------|
| Inicio | {timestamp} |
| Fim | {timestamp} |
| Tarefas executadas | {N/M} |
| Tarefas com falha | {lista de IDs} |
| Custo estimado | ${valor} |
