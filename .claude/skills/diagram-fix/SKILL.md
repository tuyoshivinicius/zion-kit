---
name: diagram-fix
description: Diagnostica e corrige problemas visuais, de layout, responsividade, tokens e acessibilidade nos 12 diagramas do ZionKit (10 React + 2 Astro). Usa Playwright MCP para verificacao visual, aplica fixes no codigo fonte e verifica resultado.
argument-hint: [--url <url>] [--diagram <nome|all>] [--fix auto|report-only]
---

Voce e um especialista em diagramas React Flow, ELK layout e CSS responsivo. Sua missao e diagnosticar e CORRIGIR problemas nos 12 diagramas do ZionKit usando Playwright MCP para verificacao visual, seguido de edicao direta no codigo fonte.

## Argumentos

$ARGUMENTS

### Parse dos argumentos

- `--url` (opcional): URL do site. Padrao: `https://tuyoshivinicius.github.io/zion-kit`
- `--diagram` (opcional): Nome do diagrama ou `all`. Valores validos: `ThreeGaps`, `CanonBuilding`, `CeremonyFlow`, `Cycle`, `ContextVoid`, `ContextualSpec`, `Feedback`, `Guardrails`, `DirectEditFlow`, `ChangePlanEnvelope`, `BeforeAfter`, `RolesMatrix`. Padrao: `all`.
- `--fix` (opcional): `auto` aplica correcoes, `report-only` apenas gera relatorio. Padrao: `auto`.

Se nenhum argumento foi fornecido, use os valores padrao.

---

## Pre-requisitos — Verificacao do Playwright MCP

Antes de iniciar, verifique se o Playwright MCP esta disponivel tentando `browser_navigate`. Se falhar:

```
ERRO: Playwright MCP nao esta disponivel.

Para configurar:
1. Verifique que .mcp.json existe na raiz do projeto com a config do playwright
2. Reinicie o Claude Code para carregar o MCP server
3. Se necessario: npx playwright install chromium
```

---

## Inventario de Diagramas

### Diagramas React (10) — @xyflow/react + elkjs

| Nome | Componente | Dados | Secao | Layout |
|------|-----------|-------|-------|--------|
| ThreeGaps | `src/components/diagrams/ThreeGapsDiagram.tsx` | `src/lib/diagrams/three-gaps-diagram.ts` | #consequencias | horizontalFlow (ELK) |
| CanonBuilding | `src/components/diagrams/CanonBuildingDiagram.tsx` | `src/lib/diagrams/canon-building-diagram.ts` | #canon-building | verticalFlow (ELK) |
| CeremonyFlow | `src/components/diagrams/CeremonyFlowDiagram.tsx` | `src/lib/diagrams/ceremony-flow-diagram.ts` | #canon-building | verticalFlow (ELK) |
| Cycle | `src/components/diagrams/CycleDiagram.tsx` | `src/lib/diagrams/cycle-diagram.ts` | #ciclo | Manual (sem ELK) |
| ContextVoid | `src/components/diagrams/ContextVoidDiagram.tsx` | `src/lib/diagrams/context-void-diagram.ts` | #problema | ELK |
| ContextualSpec | `src/components/diagrams/ContextualSpecDiagram.tsx` | `src/lib/diagrams/contextual-spec-diagram.ts` | #spec-crafting | ELK |
| Feedback | `src/components/diagrams/FeedbackDiagram.tsx` | `src/lib/diagrams/feedback-diagram.ts` | #enrichment | cyclicFlow (ELK) |
| Guardrails | `src/components/diagrams/GuardrailsDiagram.tsx` | `src/lib/diagrams/guardrails-diagram.ts` | #guardrails | ELK |
| DirectEditFlow | `src/components/diagrams/DirectEditFlowDiagram.tsx` | `src/lib/diagrams/direct-edit-flow-diagram.ts` | #edicao-direta | ELK |
| ChangePlanEnvelope | `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx` | `src/lib/diagrams/change-plan-envelope-diagram.ts` | #change-plan | ELK |

### Diagramas Astro (2) — HTML/CSS puro

| Nome | Componente | Secao |
|------|-----------|-------|
| BeforeAfter | `src/components/diagrams/BeforeAfterDiagram.astro` | #comparacao |
| RolesMatrix | `src/components/diagrams/RolesMatrixDiagram.astro` | #papeis |

### Infra compartilhada

| Arquivo | Funcao |
|---------|--------|
| `src/lib/diagrams/shared-config.ts` | defaultEdgeOptions, flowConfig, mobileFlowConfig, desktopFlowConfig, variantColors |
| `src/lib/diagrams/elk-presets.ts` | horizontalFlow, verticalFlow, hierarchical, cyclicFlow |
| `src/lib/diagrams/use-elk-layout.ts` | Hook que executa ELK layout async, retorna nodes posicionados + boundingBox |
| `src/lib/diagrams/use-responsive-flow.ts` | Hook que alterna config mobile/desktop (breakpoint 768px), chama fitView |
| `src/lib/diagrams/use-reduced-motion.ts` | Hook para prefers-reduced-motion |
| `src/components/diagrams/NodeCard.tsx` | Componente de node compartilhado + nodeTypes export |
| `src/components/ui/DiagramContainer.astro` | Container wrapper (ATENCAO: min-width: 850px em mobile, linhas 61-64) |

### Tokens CSS relevantes (src/styles/tokens.css)

- Aurora: `--color-aurora-green` (#34d399), `--color-aurora-cyan` (#22d3ee), `--color-aurora-blue` (#60a5fa), `--color-aurora-violet` (#a78bfa), `--color-aurora-pink` (#f472b6)
- Semanticas: `--color-problem` (#f87171), `--color-solution` (#34d399), `--color-warning` (#fbbf24), `--color-info` (#60a5fa)
- Background: `--color-bg-primary` (#0a0e17), `--color-bg-secondary` (#111827), `--color-bg-tertiary` (#1a2332), `--color-bg-elevated` (#1e293b)
- Texto: `--color-text-primary` (#f1f5f9), `--color-text-secondary` (#94a3b8), `--color-text-muted` (#64748b), `--color-text-accent` (#67e8f9)
- Bordas: `--color-border-default` (rgba 0.1), `--color-border-hover` (0.2), `--color-border-accent` (0.3)

### Mapeamento hex → token (referencia para fixes)

| Hex | Token CSS |
|-----|-----------|
| `#f87171` | `var(--color-problem)` |
| `#34d399` | `var(--color-solution)` / `var(--color-aurora-green)` |
| `#22d3ee` | `var(--color-aurora-cyan)` |
| `#fbbf24` | `var(--color-warning)` |
| `#a78bfa` | `var(--color-aurora-violet)` |
| `#f472b6` | `var(--color-aurora-pink)` |
| `#60a5fa` | `var(--color-aurora-blue)` / `var(--color-info)` |
| `#94a3b8` | `var(--color-text-secondary)` |
| `#f1f5f9` | `var(--color-text-primary)` |
| `#67e8f9` | `var(--color-text-accent)` |
| `#111827` | `var(--color-bg-secondary)` |
| `#1e293b` | `var(--color-bg-elevated)` |

---

## Problemas Conhecidos

1. **min-width: 850px forcado em mobile** — `DiagramContainer.astro` linhas 61-64 aplica `min-width: 850px` em todos os diagramas React em mobile, causando overflow horizontal e scroll forcado.
2. **Cores hardcoded em shared-config.ts** — `variantColors` usa hex/rgba direto ao inves de constantes centralizadas.
3. **Cores hardcoded em NodeCard.tsx** — Inline styles com hex direto.
4. **Cores hardcoded em edges** — Cada arquivo `-diagram.ts` define edges com `stroke: 'rgba(...)'` direto.
5. **Potencial overlap de nodes** — ELK layout pode gerar sobreposicoes dependendo das dimensoes declaradas vs reais.

---

## Principios de Otimizacao (OBRIGATORIOS)

1. **browser_evaluate como ferramenta principal** — Use para verificar dimensoes, overflow, node/edge counts em batch.
2. **Forcar hydration antes de medir** — Diagramas usam `client:visible`. Scroll ate o final da pagina antes de avaliar.
3. **browser_wait_for para React Flow** — Use com seletor `.react-flow__node` apos scroll para garantir que o layout ELK completou.
4. **browser_screenshot APENAS para evidencias** — Capture somente quando encontrar bug visual.
5. **Um fix por vez** — Aplique, verifique via Playwright, depois prossiga para o proximo.
6. **Meta: < 35 chamadas MCP** para diagnostico completo. Distribuicao alvo:
   - 1 navigate + 1 scroll para hydration = 2
   - 1 evaluate batch global (todos os diagramas desktop) = 1
   - 1 resize + 1 evaluate batch (mobile) = 2
   - 1 evaluate acessibilidade = 1
   - ~6 screenshots evidencias = 6
   - ~5 verificacoes pos-fix = 5
   - Total alvo: ~17

---

## Protocolo de Execucao

### Fase 1: Diagnostico Visual (Playwright)

#### 1.1 Inicializacao e hydration (2-3 chamadas MCP)

1. `browser_navigate` para a URL do site
2. `browser_evaluate` — scroll completo para forcar hydration de todos os diagramas:

```javascript
await new Promise(resolve => {
  const step = () => {
    window.scrollBy(0, window.innerHeight);
    if (window.scrollY + window.innerHeight < document.body.scrollHeight) {
      setTimeout(step, 200);
    } else {
      window.scrollTo(0, 0);
      setTimeout(resolve, 500);
    }
  };
  step();
});
'hydration-scroll-complete'
```

3. `browser_evaluate` — verificacao batch de TODOS os diagramas:

```javascript
JSON.stringify((() => {
  const diagramData = [
    { name: 'ContextVoid', section: 'problema', selector: '#problema .react-flow' },
    { name: 'ThreeGaps', section: 'consequencias', selector: '#consequencias .react-flow' },
    { name: 'Cycle', section: 'ciclo', selector: '#ciclo .react-flow' },
    { name: 'CanonBuilding', section: 'canon-building', selector: '#canon-building .react-flow' },
    { name: 'CeremonyFlow', section: 'canon-building', selector: '#canon-building .react-flow:nth-of-type(2)' },
    { name: 'ContextualSpec', section: 'spec-crafting', selector: '#spec-crafting .react-flow' },
    { name: 'Feedback', section: 'enrichment', selector: '#enrichment .react-flow' },
    { name: 'Guardrails', section: 'guardrails', selector: '#guardrails .react-flow' },
    { name: 'ChangePlanEnvelope', section: 'change-plan', selector: '#change-plan .react-flow' },
    { name: 'DirectEditFlow', section: 'edicao-direta', selector: '#edicao-direta .react-flow' }
  ];

  return diagramData.map(d => {
    const section = document.querySelector(`#${d.section}`);
    const el = document.querySelector(d.selector);

    const result = {
      name: d.name,
      section: d.section,
      found: !!el,
    };

    if (el) {
      const r = el.getBoundingClientRect();
      result.dimensions = { width: Math.round(r.width), height: Math.round(r.height) };
      result.overflow = {
        horizontal: el.scrollWidth > el.clientWidth + 2,
        scrollW: el.scrollWidth,
        clientW: el.clientWidth
      };
      result.offscreen = r.right > window.innerWidth || r.left < 0;
      result.nodeCount = el.querySelectorAll('.react-flow__node').length;
      result.edgeCount = el.querySelectorAll('.react-flow__edge').length;
      result.hasViewport = !!el.querySelector('.react-flow__viewport');
      result.ariaLabel = el.getAttribute('aria-label');

      // Detectar overlap de nodes
      const nodes = Array.from(el.querySelectorAll('.react-flow__node'));
      const overlaps = [];
      for (let i = 0; i < nodes.length; i++) {
        for (let j = i + 1; j < nodes.length; j++) {
          const a = nodes[i].getBoundingClientRect();
          const b = nodes[j].getBoundingClientRect();
          if (a.left < b.right && a.right > b.left && a.top < b.bottom && a.bottom > b.top) {
            overlaps.push({
              nodeA: nodes[i].getAttribute('data-id'),
              nodeB: nodes[j].getAttribute('data-id')
            });
          }
        }
      }
      result.overlaps = overlaps;
    }

    return result;
  });
})())
```

NOTA: Se `.react-flow` nao for encontrado para algum diagrama, tente variantes: `[data-testid]`, `.react-flow__viewport`, ou inspecione via `browser_snapshot`.

#### 1.2 Verificacao mobile (2 chamadas MCP)

1. `browser_resize` para 375x812
2. `browser_evaluate` — mesma verificacao batch acima + deteccao de min-width forcado:

```javascript
JSON.stringify((() => {
  // Reusar avaliacao de diagramas React (mesma estrutura acima)
  // MAIS: verificacao de min-width forcado
  const containers = document.querySelectorAll('.diagram-content');
  const minWidthIssues = Array.from(containers).map(dc => {
    const child = dc.querySelector(':scope > astro-island > div, :scope > div');
    if (!child) return null;
    const minW = getComputedStyle(child).minWidth;
    return {
      parentSection: dc.closest('section')?.id,
      minWidth: minW,
      isForced: minW !== 'auto' && minW !== '0px' && parseInt(minW) > 375,
      actualWidth: Math.round(child.getBoundingClientRect().width),
      viewportWidth: window.innerWidth
    };
  }).filter(Boolean);

  return { minWidthIssues };
})())
```

#### 1.3 Verificacao de acessibilidade (1 chamada MCP)

```javascript
JSON.stringify((() => {
  const issues = [];

  // 1. Diagramas sem aria-label
  document.querySelectorAll('.react-flow').forEach(rf => {
    const label = rf.getAttribute('aria-label');
    const section = rf.closest('section')?.id;
    if (!label) issues.push({ type: 'missing-aria-label', section, element: 'ReactFlow' });
  });

  // 2. Nodes sem role ou aria-label
  document.querySelectorAll('.react-flow__node').forEach(node => {
    const inner = node.querySelector('[role="group"]');
    if (!inner) issues.push({
      type: 'node-missing-role',
      nodeId: node.getAttribute('data-id'),
      section: node.closest('section')?.id
    });
  });

  // 3. Contagem de nodes com tabIndex
  const focusableNodes = document.querySelectorAll('.react-flow__node [tabindex]');
  issues.push({ type: 'info', focusableNodes: focusableNodes.length });

  return issues;
})())
```

#### 1.4 Screenshots de evidencia

Para cada diagrama com problema detectado, scroll ate a secao e capture `browser_screenshot`. Anote o problema no relatorio.

---

### Fase 2: Diagnostico de Codigo Fonte

Use Read e Grep do Claude Code (NAO Playwright) para detectar:

#### 2.1 Cores hardcoded

```
Grep: pattern="(#[0-9a-fA-F]{3,8}|rgba?\()" path="src/lib/diagrams/" glob="*.ts"
Grep: pattern="(#[0-9a-fA-F]{3,8}|rgba?\()" path="src/components/diagrams/" glob="*.tsx"
Grep: pattern="(#[0-9a-fA-F]{3,8}|rgba?\()" path="src/components/diagrams/" glob="*.astro"
```

Para cada ocorrencia, mapear para o token CSS correto usando a tabela de mapeamento hex → token acima.

**IMPORTANTE sobre cores em React inline styles**: React NAO resolve `var()` em objetos de estilo JS (`style={{}}`). Para tokenizar cores em componentes React:
- Manter hex/rgba para inline styles (nao substitua por var())
- Centralizar constantes JS nomeadas em `shared-config.ts` com comentario do token CSS
- Para CSS em arquivos `.astro` e `<style>` blocks, usar `var()` normalmente

#### 2.2 Layout ELK — verificacao de spacing

Leia cada arquivo `*-diagram.ts` e verifique:
- `layoutOptions` referencia qual preset de `elk-presets.ts`
- Dimensoes declaradas (`width`/`height` no `data` dos nodes) sao compatíveis com o conteudo real
- Spacing entre nodes e suficiente (`nodeNodeBetweenLayers >= 60`, `nodeNode >= 30`)

#### 2.3 DiagramContainer.astro

Leia e confirme o problema da `min-width: 850px` nas linhas 61-64.

---

### Fase 3: Plano de Correcoes

Antes de aplicar qualquer fix, GERE O PLANO e liste todas as mudancas propostas. Se `--fix report-only`, PARE AQUI e gere apenas o relatorio.

O plano deve listar para cada fix:
1. **Arquivo** a ser alterado
2. **Linha(s)** afetada(s)
3. **Mudanca** proposta (antes → depois)
4. **Risco**: baixo/medio/alto
5. **Impacto**: quais diagramas sao afetados

---

### Fase 4: Aplicacao de Fixes (se --fix auto)

#### Guardrails obrigatorios ANTES de editar:

1. **Leia o arquivo COMPLETO antes de editar** — entenda o contexto
2. **Faca uma mudanca por vez** — nao altere multiplos arquivos simultaneamente
3. **Priorize fixes de baixo risco primeiro**:
   - Primeiro: DiagramContainer.astro (min-width fix)
   - Segundo: aria-labels ausentes
   - Terceiro: layout spacing em elk-presets ou dados
   - Quarto: cores hardcoded (mais invasivo, afeita multiplos arquivos)

#### Fix 1: Responsividade — DiagramContainer.astro

**Problema**: `min-width: 850px` em linhas 61-64 forca todos os diagramas a transbordar em mobile.

**Correcao**: Remover `min-width: 850px` e deixar ReactFlow gerenciar o dimensionamento via `fitView`. O hook `useResponsiveFlow` ja lida com mobile (padding menor, pinch/pan habilitados).

```css
/* ANTES (linhas 61-64) */
.diagram-content :global(> astro-island > div),
.diagram-content :global(> div) {
  min-width: 850px;
}

/* DEPOIS */
.diagram-content :global(> astro-island > div),
.diagram-content :global(> div) {
  min-width: auto;
  width: 100%;
}
```

Avaliar se a mensagem "deslize para ver" (linhas 70-78) deve ser removida ou mantida condicionalmente para diagramas Astro que tenham tabelas largas.

#### Fix 2: Acessibilidade — aria-labels

Para cada diagrama React que NAO tenha `aria-label` no `<ReactFlow>`, adicionar. O padrao ja existente nos diagramas que tem deve ser replicado:

```tsx
<ReactFlow
  aria-label="Descricao do diagrama em portugues"
  // ... demais props
>
```

#### Fix 3: Layout — Ajuste de spacing ELK

Se overlaps detectados na Fase 1.1, ajustar no arquivo `-diagram.ts` correspondente:
- Aumentar `width`/`height` no `data` dos nodes que se sobrepoem
- OU criar preset customizado com maior spacing em `elk-presets.ts`
- OU ajustar `elk.padding` no layoutOptions do diagrama

#### Fix 4: Cores — Centralizacao em constantes JS

**Estrategia para React inline styles** (NAO usar var() — React nao suporta):

Centralizar em `shared-config.ts` com mapeamento nomeado:

```typescript
export const tokenColors = {
  problem: '#f87171',      // var(--color-problem)
  solution: '#34d399',     // var(--color-solution)
  warning: '#fbbf24',      // var(--color-warning)
  cyan: '#22d3ee',         // var(--color-aurora-cyan)
  violet: '#a78bfa',       // var(--color-aurora-violet)
  pink: '#f472b6',         // var(--color-aurora-pink)
  textPrimary: '#f1f5f9',  // var(--color-text-primary)
  textSecondary: '#94a3b8',// var(--color-text-secondary)
  textAccent: '#67e8f9',   // var(--color-text-accent)
  bgSecondary: '#111827',  // var(--color-bg-secondary)
  bgElevated: '#1e293b',   // var(--color-bg-elevated)
} as const;
```

Depois refatorar `variantColors` e demais arquivos para usar `tokenColors.xxx` ao inves de hex direto. Para CSS em `.astro`, usar `var()` diretamente.

---

### Fase 5: Verificacao Pos-Fix (Playwright)

Apos aplicar cada fix:

1. Se o dev server estiver rodando, verificar imediatamente
2. Se nao, instruir o usuario a rodar `npm run dev`
3. Repetir verificacao da Fase 1.1 para confirmar:

```javascript
// Verificacao rapida pos-fix
JSON.stringify((() => {
  const checks = [];
  document.querySelectorAll('.react-flow').forEach(rf => {
    const section = rf.closest('section')?.id;
    const nodes = rf.querySelectorAll('.react-flow__node').length;
    const edges = rf.querySelectorAll('.react-flow__edge').length;
    const r = rf.getBoundingClientRect();
    checks.push({
      section,
      nodes,
      edges,
      width: Math.round(r.width),
      height: Math.round(r.height),
      ariaLabel: rf.getAttribute('aria-label'),
      ok: nodes > 0 && edges >= 0 && r.width > 0 && r.height > 0
    });
  });
  return { allOk: checks.every(c => c.ok), diagrams: checks };
})())
```

Se algo quebrou, **reverter o fix imediatamente** e registrar no relatorio como "fix revertido — causa: [motivo]".

---

## Template do Relatorio

Gere o relatorio em `docs/diagram-fix-report.md` usando Write. Use EXATAMENTE esta estrutura:

```markdown
# Relatorio de Diagnostico e Fix de Diagramas — ZionKit

**Data:** YYYY-MM-DD
**URL testada:** [url]
**Diagrama(s):** [all | nome especifico]
**Modo:** [auto | report-only]

---

## Resumo

| Diagrama | Renderiza | Nodes | Edges | Overlaps | Overflow Mobile | aria-label | Tokens |
|----------|-----------|-------|-------|----------|-----------------|------------|--------|
| ContextVoid | OK/FALHA | N | N | 0/N | OK/FALHA | OK/FALHA | N issues |
| ThreeGaps | ... | ... | ... | ... | ... | ... | ... |
| Cycle | ... | ... | ... | ... | ... | ... | ... |
| CanonBuilding | ... | ... | ... | ... | ... | ... | ... |
| CeremonyFlow | ... | ... | ... | ... | ... | ... | ... |
| ContextualSpec | ... | ... | ... | ... | ... | ... | ... |
| Feedback | ... | ... | ... | ... | ... | ... | ... |
| Guardrails | ... | ... | ... | ... | ... | ... | ... |
| ChangePlanEnvelope | ... | ... | ... | ... | ... | ... | ... |
| DirectEditFlow | ... | ... | ... | ... | ... | ... | ... |
| BeforeAfter | ... | — | — | — | ... | ... | ... |
| RolesMatrix | ... | — | — | — | ... | ... | ... |

---

## Problemas Encontrados

### Critico
- [ ] **[D-001]** Descricao
  - **Diagrama:** NomeDoDiagrama
  - **Secao:** #id
  - **Arquivo:** `caminho/arquivo.ts:L42`
  - **Evidencia:** resultado evaluate ou screenshot
  - **Fix aplicado:** sim/nao — descricao do fix
  - **Verificado:** sim/nao

### Alto
(mesma estrutura)

### Medio
(mesma estrutura)

### Baixo
(mesma estrutura)

---

## Fixes Aplicados

| # | Arquivo | Linhas | Descricao | Verificado |
|---|---------|--------|-----------|------------|
| 1 | ... | L61-64 | ... | OK/FALHA |

---

## Cores Hardcoded Encontradas

| Arquivo | Linha | Valor | Token Sugerido |
|---------|-------|-------|----------------|
| shared-config.ts | L42 | #f87171 | var(--color-problem) |

---

## Acessibilidade dos Diagramas

| Diagrama | aria-label | role | tabIndex nodes | reduced-motion |
|----------|-----------|------|----------------|----------------|
| ... | OK/ausente | ... | N | OK/ausente |

---

## Proximos Passos

### Imediato (fixes nao aplicados de risco baixo)
- Lista

### Planejado (fixes de risco medio que requerem mais analise)
- Lista

### Futuro (melhorias arquiteturais)
- Lista
```

---

## Guardrails

1. **Leia antes de editar**: Leia o arquivo COMPLETO antes de qualquer edicao. Se precisar reverter, saiba exatamente o que restaurar.
2. **Um fix por vez**: Aplique, verifique via Playwright, depois prossiga. NAO acumule fixes sem verificacao.
3. **Nao quebrar outros diagramas**: Ao alterar `shared-config.ts`, `elk-presets.ts`, `NodeCard.tsx` ou `DiagramContainer.astro`, TODOS os diagramas sao afetados. Verifique TODOS apos o fix.
4. **Cores em inline styles**: React NAO resolve `var()` em objetos de estilo JS. NAO substitua hex por var() em props `style={{}}`. Use constantes JS nomeadas.
5. **ELK e async**: O hook `useElkLayout` e assincrono. Ao verificar via Playwright, aguarde layout completo (opacity 1 no container div) antes de medir posicoes.
6. **client:visible**: Diagramas React so hidratam quando visiveis. Scroll ate a secao e use `browser_wait_for` com seletor `.react-flow__node` antes de avaliar.
7. **Saida unica**: Alem dos fixes no codigo, o unico arquivo novo e `docs/diagram-fix-report.md`.
8. **Idioma**: Todo output em portugues.
9. **Evidencias**: Cada issue deve ter evidencia concreta (evaluate result, screenshot, ou grep com arquivo:linha).
10. **Se --fix report-only**: NAO edite NENHUM arquivo fonte. Apenas gere o relatorio com sugestoes de fix.
