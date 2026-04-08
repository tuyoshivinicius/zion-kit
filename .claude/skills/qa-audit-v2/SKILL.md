---
name: qa-audit-v2
description: Auditoria QA visual e funcional do site ZionKit com prioridade em bugs CSS, interatividade, responsividade e aderencia ao tema Borealis. Usa Playwright MCP otimizado com batch evaluate e agrupamento por secao. Gera relatorio em docs/qa-audit-report.md.
argument-hint: [--url <url>] [--focus p0|p1|p2|p3|p4|all]
---

Voce e um especialista senior em QA visual, CSS debugging e UX. Sua missao e executar uma auditoria completa do site ZionKit usando Playwright MCP, priorizando bugs visuais e CSS, seguido de interatividade, responsividade, aderencia ao tema Borealis e padrao de componentes.

## Argumentos

$ARGUMENTS

### Parse dos argumentos

- `--url` (opcional): URL do site. Padrao: `https://tuyoshivinicius.github.io/zion-kit`
- `--focus` (opcional): Prioridade para focar. Valores: `p0` (bugs visuais/CSS), `p1` (interatividade), `p2` (responsividade), `p3` (tema Borealis), `p4` (padrao componentes), `all`. Padrao: `all`.

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

## Mapa do Site — 16 Secoes

Referencia obrigatoria para todas as verificacoes. Use SOMENTE estes nomes e IDs:

| # | ID | Nome | Depth | Componentes-chave |
|---|-----|------|-------|-------------------|
| 1 | problema | O Problema | 1 | SectionHeader, ExampleBlock, ContextVoidDiagram (React) |
| 2 | consequencias | Consequencias | 1 | SectionHeader, StatCard x3, ThreeGapsDiagram (React) |
| 3 | solucao | A Solucao | 1 | SectionHeader, ExampleBlock (analogy), canon-badge |
| 4 | ciclo | Visao Geral do Ciclo | 1 | SectionHeader, CycleDiagram (React), step-card x3 |
| 5 | canon-building | Canon Building | 2 | SectionHeader, ceremony-block x3, CeremonyFlowDiagram (React) |
| 6 | spec-crafting | Spec Crafting | 2 | SectionHeader, approval-flow x4, ContextualSpecDiagram (React) |
| 7 | enrichment | Retroalimentacao | 2 | SectionHeader, mechanism-card x2, FeedbackDiagram (React) |
| 8 | guardrails | Guardrails | 2 | SectionHeader, guardrail-card x5, GuardrailsDiagram (React) |
| 9 | papeis | Papeis | 2 | SectionHeader, role-card x4, RolesMatrixDiagram (Astro) |
| 10 | change-plan | Canonical Change Plan | 3 | SectionHeader, type-card x5, ChangePlanEnvelopeDiagram (React) |
| 11 | canon | Product Canon | 3 | SectionHeader, canon-column x2, canon-card x10 |
| 12 | edicao-direta | Edicao Direta | 3 | SectionHeader, step-card x5, DirectEditFlowDiagram (React) |
| 13 | comparacao | Antes/Depois | 1 | SectionHeader, ComparisonRow x9 |
| 14 | cenarios | Cenarios | 1 | SectionHeader, scenario-tab-btn x3, timeline |
| 15 | riscos | Riscos | 2 | SectionHeader, risco-card x10 |
| 16 | glossario | Glossario | 1 | SectionHeader, glossary-search, GlossaryItem x31 |

### Componentes globais (presentes em todas as secoes)
- AuroraBackground — fundo animado fixo
- ProgressBar — barra de progresso fixa no topo
- StickyNav — navegacao fixa com 16 links
- DepthFilter — filtro de profundidade (Essencial/Detalhado/Tecnico)
- Footer — rodape com links
- Skip-link — `<a href="#main-content" class="skip-link">`
- CTABanner x2 — entre secoes

### Diagramas React (client:visible — hydration lazy)
- ContextVoidDiagram.tsx (secao problema)
- ThreeGapsDiagram.tsx (secao consequencias)
- CycleDiagram.tsx (secao ciclo)
- CanonBuildingDiagram.tsx (secao canon-building)
- CeremonyFlowDiagram.tsx (secao canon-building)
- ContextualSpecDiagram.tsx (secao spec-crafting)
- FeedbackDiagram.tsx (secao enrichment)
- GuardrailsDiagram.tsx (secao guardrails)
- ChangePlanEnvelopeDiagram.tsx (secao change-plan)
- DirectEditFlowDiagram.tsx (secao edicao-direta)

### Tokens do tema Borealis (src/styles/tokens.css)
- Cores bg: --color-bg-primary (#0a0e17), secondary (#111827), tertiary (#1a2332), elevated (#1e293b)
- Cores texto: --color-text-primary (#f1f5f9), secondary (#94a3b8), muted (#64748b), accent (#67e8f9)
- Aurora: --color-aurora-green (#34d399), cyan (#22d3ee), blue (#60a5fa), violet (#a78bfa), pink (#f472b6)
- Semanticas: --color-problem (#f87171), solution (#34d399), warning (#fbbf24), info (#60a5fa)
- Bordas: --color-border-default (rgba 0.1), hover (0.2), accent (0.3)
- Fontes: --font-sans (Inter), --font-mono (JetBrains Mono)
- Scale tipografico: xs (0.75rem) a 6xl (3.75rem) — 10 passos
- Espacamento: --space-1 (0.25rem) a --space-32 (8rem)
- Raios: --radius-sm (0.375rem) a --radius-full (9999px)
- Sombras: sm, md, lg, glow-cyan, glow-green, glow-violet
- Duracoes: fast (150ms), normal (300ms), slow (500ms), very-slow (800ms)
- Easing: --ease-out-expo, --ease-in-out-quart
- Z-index: background (-1), default (0), elevated (10), sticky (50), overlay (100)
- Gradientes: --gradient-aurora (135deg green>cyan>violet), --gradient-text (cyan>violet)

### Breakpoints reais
- 768px (max-width) — stack grids, padding mobile
- 1024px (max-width) — nav mobile, depth filter hidden
- 1024px (min-width) — heading scale aumento

---

## Principios de Otimizacao (OBRIGATORIOS)

1. **browser_evaluate como ferramenta principal** — Use para verificar CSS computed styles, overflow, dimensoes, cores e propriedades em batch. Uma unica chamada pode verificar dezenas de elementos.

2. **Agrupar por secao** — Navegue uma vez ate a secao, execute TODAS as verificacoes daquela secao (P0+P1+P2+P3+P4), depois avance para a proxima.

3. **browser_snapshot para estrutura** — Use para verificar acessibilidade, ARIA, hierarquia de headings, texto renderizado. NAO use para CSS.

4. **browser_screenshot APENAS para evidencias** — Capture screenshots SOMENTE quando encontrar um bug visual que precisa ser documentado no relatorio.

5. **browser_wait_for ao inves de delays** — Para diagramas React, use `browser_wait_for` com seletor do container do diagrama (`.react-flow`) ao inves de delays fixos.

6. **Batch evaluate pattern** — Sempre agrupe verificacoes em um unico browser_evaluate:

```javascript
// EXEMPLO: Verificacao batch de uma secao inteira
JSON.stringify({
  overflow: (() => {
    const section = document.querySelector('#secao-id');
    return {
      hasHorizontalOverflow: section.scrollWidth > section.clientWidth,
      hasVerticalOverflow: section.scrollHeight > section.clientHeight
    };
  })(),
  styles: (() => {
    const els = section.querySelectorAll('h2, h3, p, .card, .btn');
    return Array.from(els).map(el => {
      const s = getComputedStyle(el);
      return {
        tag: el.tagName,
        class: el.className.slice(0, 50),
        color: s.color,
        fontSize: s.fontSize,
        fontFamily: s.fontFamily,
        zIndex: s.zIndex,
        overflow: s.overflow,
        position: s.position
      };
    });
  })(),
  hardcodedColors: (() => {
    // Detecta cores que nao usam var()
    const sheets = Array.from(document.styleSheets);
    // ... verificacao de cores hardcoded
  })()
})
```

7. **Meta: < 50 chamadas MCP** para auditoria completa. Distribuicao alvo:
   - 1 navigate + 1 resize inicial = 2
   - 16 secoes x 2 chamadas medias (1 evaluate batch + 1 snapshot) = 32
   - 4 resizes para responsividade = 4
   - ~6 screenshots de evidencias = 6
   - ~4 interacoes (click, hover, press_key) = 4
   - Total alvo: ~48

---

## Protocolo de Execucao

### Fase 0: Inicializacao (2 chamadas MCP)

1. `browser_navigate` para a URL do site
2. `browser_evaluate` — verificacao global batch:

```javascript
JSON.stringify({
  meta: {
    title: document.title,
    lang: document.documentElement.lang,
    hasViewport: !!document.querySelector('meta[name="viewport"]'),
    hasMain: !!document.querySelector('main#main-content'),
    hasSkipLink: !!document.querySelector('.skip-link'),
    hasProgressBar: !!document.querySelector('[role="progressbar"]'),
    hasNav: !!document.querySelector('nav[role="navigation"]'),
    totalSections: document.querySelectorAll('main > section').length,
    totalInteractiveElements: document.querySelectorAll('button, a, input, [role="tab"]').length
  },
  bodyOverflow: {
    docWidth: document.documentElement.scrollWidth,
    viewportWidth: window.innerWidth,
    hasHorizontalOverflow: document.documentElement.scrollWidth > window.innerWidth
  },
  globalZIndex: (() => {
    const fixed = document.querySelectorAll('[style*="position: fixed"], nav, .progress-bar');
    return Array.from(fixed).map(el => ({
      tag: el.tagName,
      class: el.className?.slice?.(0, 40) || '',
      zIndex: getComputedStyle(el).zIndex,
      position: getComputedStyle(el).position
    }));
  })(),
  sectionIds: Array.from(document.querySelectorAll('main > section')).map(s => s.id)
})
```

---

### Fase 1: P0 — Bugs Visuais e CSS (prioridade maxima)

Para CADA secao (itere pelo mapa de 16 secoes), execute um `browser_evaluate` batch que verifica:

**Scroll ate a secao primeiro** — use `browser_evaluate` com `document.querySelector('#secao-id').scrollIntoView({behavior:'instant'})` dentro do mesmo evaluate quando possivel, ou use um evaluate separado se necessario.

```javascript
// Template P0 — adapte o seletor #SECTION_ID para cada secao
JSON.stringify((() => {
  const section = document.querySelector('#SECTION_ID');
  if (!section) return { error: 'Secao nao encontrada' };
  section.scrollIntoView({ behavior: 'instant' });

  const rect = section.getBoundingClientRect();
  const allEls = section.querySelectorAll('*');

  // 1. Overflow
  const overflowIssues = [];
  allEls.forEach(el => {
    if (el.scrollWidth > el.clientWidth + 2) {
      overflowIssues.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 60),
        scrollW: el.scrollWidth,
        clientW: el.clientWidth
      });
    }
  });

  // 2. Elementos cortados ou fora do viewport
  const clippedEls = [];
  allEls.forEach(el => {
    const r = el.getBoundingClientRect();
    if (r.width > 0 && r.height > 0) {
      if (r.right > window.innerWidth || r.left < 0) {
        clippedEls.push({
          tag: el.tagName,
          class: el.className?.toString().slice(0, 60),
          left: Math.round(r.left),
          right: Math.round(r.right)
        });
      }
    }
  });

  // 3. Textos com tamanho < 12px (potencial ilegibilidade)
  const smallText = [];
  section.querySelectorAll('p, span, li, a, td, th, label, dt, dd').forEach(el => {
    const size = parseFloat(getComputedStyle(el).fontSize);
    if (size < 12 && el.textContent.trim().length > 0) {
      smallText.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        fontSize: size + 'px',
        text: el.textContent.trim().slice(0, 30)
      });
    }
  });

  // 4. Z-index de elementos posicionados
  const zIndexIssues = [];
  section.querySelectorAll('*').forEach(el => {
    const s = getComputedStyle(el);
    if (s.position !== 'static' && s.zIndex !== 'auto') {
      const z = parseInt(s.zIndex);
      if (z > 10) {
        zIndexIssues.push({
          tag: el.tagName,
          class: el.className?.toString().slice(0, 40),
          zIndex: z,
          position: s.position
        });
      }
    }
  });

  // 5. Espacamentos (padding/margin em elementos-chave)
  const spacingCheck = [];
  section.querySelectorAll('h2, h3, h4, .card, .step-card, .role-card, .guardrail-card, .risco-card, .type-card').forEach(el => {
    const s = getComputedStyle(el);
    spacingCheck.push({
      tag: el.tagName,
      class: el.className?.toString().slice(0, 40),
      padding: s.padding,
      margin: s.margin,
      gap: s.gap
    });
  });

  // 6. backdrop-filter usage
  const backdropEls = [];
  allEls.forEach(el => {
    const bf = getComputedStyle(el).backdropFilter;
    if (bf && bf !== 'none') {
      backdropEls.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        backdropFilter: bf
      });
    }
  });

  return {
    sectionId: '#SECTION_ID',
    dimensions: { width: Math.round(rect.width), height: Math.round(rect.height) },
    overflowIssues,
    clippedEls,
    smallText,
    zIndexIssues,
    spacingCheck: spacingCheck.slice(0, 20),
    backdropEls,
    childCount: allEls.length
  };
})())
```

**Apos o evaluate batch**, use `browser_snapshot` para capturar a arvore de acessibilidade da secao visivel — isso serve para P1 (interatividade) e verificacoes de estrutura.

**Se encontrar bug visual**, capture `browser_screenshot` como evidencia e anote no relatorio.

#### Verificacoes P0 especificas por secao:

- **HeroSection (#problema)**: Scroll indicator float animation, 100vh nao cortando conteudo, gradiente do titulo
- **ConsequenciasSection (#consequencias)**: Grid de 3 colunas alinhada, StatCards sem overflow, gradiente de texto nos valores
- **SolucaoSection (#solucao)**: Canon-badge com glow-pulse, ExampleBlock alinhado
- **CicloSection (#ciclo)**: Step-cards hover effects, CycleDiagram sem overflow
- **CanonBuildingSection (#canon-building)**: Ceremony-blocks grid, IEEE grid, CeremonyFlowDiagram
- **SpecCraftingSection (#spec-crafting)**: Approval-flow cards alinhadas, ContextualSpecDiagram
- **EnrichmentSection (#enrichment)**: Mechanism-cards grid, FeedbackDiagram
- **GuardrailsSection (#guardrails)**: 5 guardrail-cards grid, version-face layout, GuardrailsDiagram
- **PapeisSection (#papeis)**: 2x2 role grid, roles-stage-table horizontal scroll, RolesMatrixDiagram
- **ChangePlanSection (#change-plan)**: Field-columns layout, 5 type-cards grid, approval-grid, ChangePlanEnvelopeDiagram, pix-example
- **CanonDeepDiveSection (#canon)**: 2 canon-columns lado a lado, 10 canon-cards
- **EdicaoDiretaSection (#edicao-direta)**: 5 step-cards, DirectEditFlowDiagram, 4 report-cards
- **ComparacaoSection (#comparacao)**: 9 ComparisonRows alinhados, headers antes/depois
- **CenariosSection (#cenarios)**: Tabs funcionais, timeline gradient, panels
- **RiscosSection (#riscos)**: 10 risco-cards em grid 2-col desktop
- **GlossarioSection (#glossario)**: Search input funcional, 31 GlossaryItems colapsaveis

---

### Fase 2: P1 — Botoes e Interatividade Quebrada

Use os snapshots ja capturados na Fase 1 para verificar estrutura. Adicione estas verificacoes interativas:

#### 2.1 Navegacao (2-3 chamadas MCP)

```javascript
// Verificar todos os links da nav
JSON.stringify((() => {
  const navLinks = document.querySelectorAll('nav a, nav button');
  return Array.from(navLinks).map(el => ({
    text: el.textContent.trim().slice(0, 30),
    href: el.getAttribute('href'),
    targetExists: el.getAttribute('href')?.startsWith('#')
      ? !!document.querySelector(el.getAttribute('href'))
      : true,
    ariaLabel: el.getAttribute('aria-label'),
    role: el.getAttribute('role')
  }));
})())
```

- Use `browser_click` no hamburger menu (em viewport mobile) e verifique se abre/fecha
- Use `browser_click` em 2-3 nav links e verifique scroll (via evaluate: `document.querySelector('#target').getBoundingClientRect().top`)

#### 2.2 CTABanner Links (1 chamada MCP)

```javascript
JSON.stringify((() => {
  const ctas = document.querySelectorAll('.cta-banner a, [class*="cta"] a');
  return Array.from(ctas).map(el => ({
    text: el.textContent.trim(),
    href: el.getAttribute('href'),
    target: el.getAttribute('target'),
    isExternal: el.getAttribute('href')?.startsWith('http'),
    hasRelNoopener: el.getAttribute('rel')?.includes('noopener')
  }));
})())
```

#### 2.3 DepthFilter (1-2 chamadas MCP)

- Use `browser_click` nos botoes do DepthFilter
- Verifique via evaluate se secoes com depth > selecionado ficam ocultas

#### 2.4 Diagramas React — Hydration (1 chamada MCP batch)

```javascript
JSON.stringify((() => {
  const diagrams = [
    { name: 'ContextVoidDiagram', section: 'problema', selector: '#problema .react-flow' },
    { name: 'ThreeGapsDiagram', section: 'consequencias', selector: '#consequencias .react-flow' },
    { name: 'CycleDiagram', section: 'ciclo', selector: '#ciclo .react-flow' },
    { name: 'CanonBuildingDiagram', section: 'canon-building', selector: '#canon-building .react-flow' },
    { name: 'CeremonyFlowDiagram', section: 'canon-building', selector: '#canon-building .react-flow:last-of-type' },
    { name: 'ContextualSpecDiagram', section: 'spec-crafting', selector: '#spec-crafting .react-flow' },
    { name: 'FeedbackDiagram', section: 'enrichment', selector: '#enrichment .react-flow' },
    { name: 'GuardrailsDiagram', section: 'guardrails', selector: '#guardrails .react-flow' },
    { name: 'ChangePlanEnvelopeDiagram', section: 'change-plan', selector: '#change-plan .react-flow' },
    { name: 'DirectEditFlowDiagram', section: 'edicao-direta', selector: '#edicao-direta .react-flow' }
  ];
  return diagrams.map(d => {
    const el = document.querySelector(d.selector);
    const container = document.querySelector(`#${d.section} [data-diagram], #${d.section} .diagram-container`);
    return {
      name: d.name,
      section: d.section,
      reactFlowFound: !!el,
      containerFound: !!container,
      containerEmpty: container ? container.children.length === 0 : null,
      hasNodes: el ? el.querySelectorAll('.react-flow__node').length : 0,
      hasEdges: el ? el.querySelectorAll('.react-flow__edge').length : 0,
      dimensions: el ? {
        width: el.getBoundingClientRect().width,
        height: el.getBoundingClientRect().height
      } : null
    };
  });
})())
```

NOTA: Os seletores acima sao aproximados. Se `.react-flow` nao for encontrado, tente variantes como `[data-testid]`, `.react-flow__viewport`, ou inspecione o container do diagrama via snapshot.

#### 2.5 Scenario Tabs (#cenarios) (1 chamada MCP)

- Use `browser_click` em cada tab e verifique se o painel correto aparece

#### 2.6 Glossario (#glossario) (1-2 chamadas MCP)

- Use `browser_fill_form` no campo de busca e verifique se items sao filtrados
- Use `browser_click` em um GlossaryItem e verifique se expande (aria-expanded)

#### 2.7 Skip-link (1 chamada MCP)

- Use `browser_press_key` com Tab para focar o skip-link
- Use `browser_press_key` com Enter para ativa-lo
- Verifique se o foco vai para `#main-content`

---

### Fase 3: P2 — Responsividade (4 breakpoints)

Teste em 4 viewports: **375x812** (mobile), **768x1024** (tablet), **1024x768** (laptop), **1440x900** (desktop).

Para cada viewport:

1. `browser_resize` para o tamanho
2. `browser_evaluate` batch:

```javascript
JSON.stringify((() => {
  const vw = window.innerWidth;
  const vh = window.innerHeight;

  // Overflow horizontal global
  const hasOverflow = document.documentElement.scrollWidth > vw;

  // Touch targets em mobile (< 768px)
  const smallTargets = [];
  if (vw < 768) {
    document.querySelectorAll('button, a, input, [role="tab"], [role="button"]').forEach(el => {
      const r = el.getBoundingClientRect();
      if (r.width > 0 && r.height > 0 && (r.width < 44 || r.height < 44)) {
        smallTargets.push({
          tag: el.tagName,
          text: el.textContent.trim().slice(0, 20),
          class: el.className?.toString().slice(0, 40),
          width: Math.round(r.width),
          height: Math.round(r.height)
        });
      }
    });
  }

  // Textos com font-size fixo (nao responsivo) — verificar se mudou vs desktop
  const headingSizes = [];
  document.querySelectorAll('h1, h2, h3').forEach(el => {
    headingSizes.push({
      tag: el.tagName,
      section: el.closest('section')?.id || 'global',
      fontSize: getComputedStyle(el).fontSize,
      text: el.textContent.trim().slice(0, 30)
    });
  });

  // Imagens/diagramas que extrapolam viewport
  const oversizedMedia = [];
  document.querySelectorAll('img, svg, .react-flow, canvas, .diagram-container').forEach(el => {
    const r = el.getBoundingClientRect();
    if (r.width > vw) {
      oversizedMedia.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        width: Math.round(r.width),
        viewport: vw
      });
    }
  });

  // Nav mobile: verificar se hamburger esta visivel
  const navToggle = document.querySelector('.nav-toggle, [aria-label*="menu"]');
  const navMobile = {
    hamburgerVisible: navToggle ? getComputedStyle(navToggle).display !== 'none' : false,
    navLinksHidden: (() => {
      const navList = document.querySelector('.nav-links, nav ul');
      return navList ? getComputedStyle(navList).display === 'none' || getComputedStyle(navList).visibility === 'hidden' : null;
    })()
  };

  return {
    viewport: { width: vw, height: vh },
    hasOverflow,
    overflowWidth: document.documentElement.scrollWidth,
    smallTargets: smallTargets.slice(0, 20),
    headingSizes: headingSizes.slice(0, 20),
    oversizedMedia,
    navMobile,
    depthFilterVisible: (() => {
      const df = document.querySelector('.depth-filter, [role="group"]');
      return df ? getComputedStyle(df).display !== 'none' : null;
    })()
  };
})())
```

3. Em mobile (375px), capture `browser_screenshot` como referencia
4. Em mobile, teste `browser_click` no hamburger menu

Ao final, restaure para 1280x800 com `browser_resize`.

---

### Fase 4: P3 — Aderencia ao Tema Borealis

Execute um unico `browser_evaluate` global que verifica aderencia aos tokens:

```javascript
JSON.stringify((() => {
  // Tokens esperados (cores Borealis)
  const expectedBgColors = ['rgb(10, 14, 23)', 'rgb(17, 24, 39)', 'rgb(26, 35, 50)', 'rgb(30, 41, 59)'];
  const expectedTextColors = ['rgb(241, 245, 249)', 'rgb(148, 163, 184)', 'rgb(100, 116, 139)', 'rgb(103, 232, 249)'];

  // 1. Cores fora do sistema de tokens
  const colorIssues = [];
  document.querySelectorAll('section, .card, h2, h3, p, a, button').forEach(el => {
    const s = getComputedStyle(el);
    const bg = s.backgroundColor;
    const color = s.color;

    // Verificar se usa cores do tema (aproximacao — cores hex convertidas para rgb)
    if (bg !== 'rgba(0, 0, 0, 0)' && bg !== 'transparent' && !expectedBgColors.some(c => bg.startsWith(c.slice(0, -1)))) {
      // Pode ser cor customizada — registrar para analise
      colorIssues.push({
        type: 'background',
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        section: el.closest('section')?.id,
        value: bg
      });
    }
  });

  // 2. Tipografia inconsistente
  const fontIssues = [];
  document.querySelectorAll('h1, h2, h3, h4, p, span, a, li, button').forEach(el => {
    const s = getComputedStyle(el);
    const family = s.fontFamily;
    if (!family.includes('Inter') && !family.includes('JetBrains') && !family.includes('system-ui')) {
      fontIssues.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        fontFamily: family.slice(0, 60),
        section: el.closest('section')?.id
      });
    }
  });

  // 3. Bordas e raios fora do padrao
  const borderIssues = [];
  document.querySelectorAll('.card, .step-card, .role-card, .guardrail-card, .type-card, .risco-card, button').forEach(el => {
    const s = getComputedStyle(el);
    const radius = s.borderRadius;
    const validRadii = ['0px', '6px', '8px', '12px', '16px', '24px', '9999px'];
    if (radius && !validRadii.includes(radius)) {
      borderIssues.push({
        tag: el.tagName,
        class: el.className?.toString().slice(0, 40),
        borderRadius: radius,
        section: el.closest('section')?.id
      });
    }
  });

  // 4. Transicoes que nao usam duracoes do tema
  const transitionIssues = [];
  document.querySelectorAll('a, button, .card, [class*="card"]').forEach(el => {
    const t = getComputedStyle(el).transition;
    if (t && t !== 'all 0s ease 0s' && t !== 'none') {
      const validDurations = ['0.15s', '150ms', '0.3s', '300ms', '0.5s', '500ms', '0.8s', '800ms'];
      const hasValidDuration = validDurations.some(d => t.includes(d));
      if (!hasValidDuration) {
        transitionIssues.push({
          tag: el.tagName,
          class: el.className?.toString().slice(0, 40),
          transition: t.slice(0, 80)
        });
      }
    }
  });

  return {
    colorIssues: colorIssues.slice(0, 30),
    fontIssues: fontIssues.slice(0, 15),
    borderIssues: borderIssues.slice(0, 15),
    transitionIssues: transitionIssues.slice(0, 15)
  };
})())
```

---

### Fase 5: P4 — Padrao de Componentes (analise de codigo fonte)

Esta fase NAO usa Playwright. Use as ferramentas Read e Grep do Claude Code para analisar o codigo fonte:

1. **Leia `src/styles/tokens.css`** e **`src/styles/base.css`** para confirmar tokens e utilidades

2. **Para cada componente em `src/components/sections/`**, verifique:
   - Usa `<style>` scoped (nao global)
   - Props declaradas com tipos Astro
   - Nao duplica estilos que ja existem em base.css
   - Usa tokens CSS (var()) ao inves de valores hardcoded

3. **Verifique vazamento de estilos**:
   - Grep por estilos sem escopo em componentes (`:global()` deve ser minimo)
   - Grep por cores hardcoded (#hex ou rgb() direto ao inves de var())
   - Grep por font-size sem usar tokens

```
Grep: pattern="#[0-9a-fA-F]{3,8}" path="src/components/" glob="*.astro"
Grep: pattern="font-size:\s*\d" path="src/components/" glob="*.astro"
Grep: pattern=":global\(" path="src/components/" glob="*.astro"
```

4. **Registre** issues de padrao no relatorio com arquivo:linha exatos

---

## Template do Relatorio

Gere o relatorio em `docs/qa-audit-report.md` usando Write. Use EXATAMENTE esta estrutura:

```markdown
# Relatorio de Auditoria QA v2 — ZionKit

**Data:** YYYY-MM-DD
**URL testada:** [url]
**Viewports:** 375x812, 768x1024, 1024x768, 1440x900
**Foco:** [all | p0 | p1 | p2 | p3 | p4]
**Total de chamadas MCP:** N

---

## Resumo Executivo

| Prioridade | Descricao | Critico | Alto | Medio | Baixo | Total |
|------------|-----------|---------|------|-------|-------|-------|
| P0 | Bugs visuais/CSS | N | N | N | N | N |
| P1 | Interatividade quebrada | N | N | N | N | N |
| P2 | Responsividade | N | N | N | N | N |
| P3 | Tema Borealis | N | N | N | N | N |
| P4 | Padrao componentes | N | N | N | N | N |
| **Total** | | **N** | **N** | **N** | **N** | **N** |

**Pontuacao geral:** X/10

---

## Matriz de Cobertura

| Secao | P0 CSS | P1 Interacao | P2 Responsivo | P3 Tema | P4 Padrao |
|-------|--------|-------------|---------------|---------|-----------|
| #problema | OK/N issues | OK/N issues | OK/N issues | OK/N issues | OK/N issues |
| #consequencias | ... | ... | ... | ... | ... |
| #solucao | ... | ... | ... | ... | ... |
| #ciclo | ... | ... | ... | ... | ... |
| #canon-building | ... | ... | ... | ... | ... |
| #spec-crafting | ... | ... | ... | ... | ... |
| #enrichment | ... | ... | ... | ... | ... |
| #guardrails | ... | ... | ... | ... | ... |
| #papeis | ... | ... | ... | ... | ... |
| #change-plan | ... | ... | ... | ... | ... |
| #canon | ... | ... | ... | ... | ... |
| #edicao-direta | ... | ... | ... | ... | ... |
| #comparacao | ... | ... | ... | ... | ... |
| #cenarios | ... | ... | ... | ... | ... |
| #riscos | ... | ... | ... | ... | ... |
| #glossario | ... | ... | ... | ... | ... |
| **Globais** (Nav, Progress, Footer, Aurora) | ... | ... | ... | ... | ... |

---

## P0 — Bugs Visuais e CSS

### Critico
- [ ] **[P0-001]** Descricao do bug
  - **Secao:** #id-da-secao
  - **Elemento:** seletor CSS ou descricao
  - **Evidencia:** [screenshot se capturada, ou resultado do evaluate]
  - **Arquivo:** `src/components/.../Componente.astro:L42`
  - **Correcao sugerida:** Codigo ou instrucao especifica

### Alto
(mesma estrutura)

### Medio
(mesma estrutura)

### Baixo
(mesma estrutura)

Se nenhum problema: "Nenhum problema encontrado nesta prioridade."

---

## P1 — Interatividade Quebrada

### Critico
- [ ] **[P1-001]** Descricao
  - **Secao:** #id
  - **Componente:** nome do componente
  - **Comportamento esperado:** o que deveria acontecer
  - **Comportamento atual:** o que acontece
  - **Arquivo:** `src/components/.../Componente.astro:L42`
  - **Correcao sugerida:** ...

(mesma estrutura para Alto/Medio/Baixo)

---

## P2 — Responsividade

### Critico
- [ ] **[P2-001]** Descricao
  - **Viewport:** 375px | 768px | 1024px | 1440px
  - **Secao:** #id
  - **Evidencia:** [screenshot ou evaluate result]
  - **Arquivo:** `src/components/.../Componente.astro:L42`
  - **Correcao sugerida:** ...

(mesma estrutura para Alto/Medio/Baixo)

---

## P3 — Aderencia ao Tema Borealis

### Alto
- [ ] **[P3-001]** Descricao
  - **Secao:** #id
  - **Token esperado:** var(--color-xxx)
  - **Valor encontrado:** #hardcoded ou valor
  - **Arquivo:** `src/components/.../Componente.astro:L42`
  - **Correcao sugerida:** Substituir por var(--token)

(mesma estrutura para Medio/Baixo)

---

## P4 — Padrao de Componentes

### Medio
- [ ] **[P4-001]** Descricao
  - **Componente:** NomeDoComponente
  - **Arquivo:** `src/components/.../Componente.astro:L42`
  - **Problema:** descricao do desvio de padrao
  - **Correcao sugerida:** ...

(mesma estrutura para Baixo)

---

## Checklist de Conformidade

| # | Criterio | Status | Notas |
|---|----------|--------|-------|
| 1 | lang="pt-BR" definido | OK/FALHA | |
| 2 | Skip-link funcional | OK/FALHA | |
| 3 | Hierarquia de headings correta | OK/FALHA | |
| 4 | Navegacao por teclado | OK/FALHA | |
| 5 | ARIA landmarks corretos | OK/FALHA | |
| 6 | Focus visible em interativos | OK/FALHA | |
| 7 | prefers-reduced-motion respeitado | OK/FALHA | |
| 8 | Sem overflow horizontal (desktop) | OK/FALHA | |
| 9 | Sem overflow horizontal (mobile) | OK/FALHA | |
| 10 | Touch targets >= 44x44 (mobile) | OK/FALHA | |
| 11 | Diagramas React renderizados | OK/FALHA | |
| 12 | Nav links funcionais | OK/FALHA | |
| 13 | DepthFilter funcional | OK/FALHA | |
| 14 | Progress bar funcional | OK/FALHA | |
| 15 | Scenario tabs funcionais | OK/FALHA | |
| 16 | Glossary search funcional | OK/FALHA | |
| 17 | CTABanner links funcionais | OK/FALHA | |
| 18 | Todas 16 secoes renderizadas | OK/FALHA | |
| 19 | Cores usam tokens (var()) | OK/FALHA | |
| 20 | Tipografia segue scale | OK/FALHA | |

---

## Proximos Passos Priorizados

### Correcoes Imediatas (P0 Critico + P1 Critico)
- Lista com IDs das issues

### Correcoes Prioritarias (P0 Alto + P1 Alto + P2 Critico)
- Lista com IDs das issues

### Melhorias (P2 Alto + P3 + P4)
- Lista com IDs das issues

### Polimento (Medio + Baixo restantes)
- Lista com IDs das issues
```

---

## Guardrails

1. **Somente leitura**: NAO modifique nenhum arquivo fonte do projeto. Apenas leia e analise.
2. **Unica saida**: O unico arquivo que voce pode criar/escrever e `docs/qa-audit-report.md`.
3. **Sem suposicoes**: Se nao conseguir verificar algo via Playwright ou leitura de codigo, registre como "Nao verificado — requer inspecao manual".
4. **Evidencias obrigatorias**: Cada issue deve ser baseada em dados concretos de evaluate, snapshot ou screenshot. NUNCA registre uma issue baseada em suposicao.
5. **Arquivo + linha**: Cada issue deve referenciar o arquivo fonte exato com numero de linha quando possivel.
6. **Idioma**: Todo output em portugues.
7. **Seletores adaptativos**: Se um seletor CSS nao funcionar no evaluate, adapte-o baseado no que o snapshot mostra. Nao desista na primeira tentativa.
8. **Contagem de chamadas**: Mantenha um contador mental de chamadas MCP. Se ultrapassar 40, priorize e pule verificacoes de menor prioridade.
