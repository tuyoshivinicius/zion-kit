# Relatorio de Auditoria QA v2 — ZionKit

**Data:** 2026-04-08
**URL testada:** http://localhost:4321/zion-kit
**Viewports:** 375x812, 768x1024, 1280x800, 1920x1080
**Foco:** all
**Total de chamadas MCP:** 18

---

## Resumo Executivo

| Prioridade | Descricao | Critico | Alto | Medio | Baixo | Total |
|------------|-----------|---------|------|-------|-------|-------|
| P0 | Bugs visuais/CSS | 0 | 0 | 1 | 1 | 2 |
| P1 | Interatividade quebrada | 0 | 0 | 1 | 0 | 1 |
| P2 | Responsividade | 1 | 2 | 1 | 0 | 4 |
| P3 | Tema Borealis | 0 | 0 | 1 | 1 | 2 |
| P4 | Padrao componentes | 0 | 1 | 1 | 0 | 2 |
| **Total** | | **1** | **3** | **5** | **2** | **11** |

**Pontuacao geral:** 7.5/10

---

## Matriz de Cobertura

| Secao | P0 CSS | P1 Interacao | P2 Responsivo | P3 Tema | P4 Padrao |
|-------|--------|-------------|---------------|---------|-----------|
| #problema | OK | OK | OK | OK | OK |
| #consequencias | OK | OK | 1 issue (overflow mobile) | OK | OK |
| #solucao | OK | OK | OK | OK | OK |
| #ciclo | OK | OK | OK | OK | OK |
| #canon-building | OK | OK | OK | OK | OK |
| #spec-crafting | OK | OK | 1 issue (overflow mobile) | OK | OK |
| #enrichment | OK | OK | 1 issue (overflow mobile) | 1 issue (cores hardcoded) | OK |
| #guardrails | OK | OK | OK | 1 issue (transition hardcoded) | OK |
| #papeis | OK | OK | 1 issue (overflow mobile) | OK | OK |
| #change-plan | 1 issue (texto <12px) | OK | OK | OK | 1 issue (cores hardcoded) |
| #canon | OK | OK | OK | OK | OK |
| #edicao-direta | OK | OK | OK | OK | 1 issue (cor hardcoded) |
| #comparacao | OK | OK | OK | OK | OK |
| #cenarios | OK | 1 issue (aria) | OK | OK | OK |
| #riscos | OK | OK | OK | OK | OK |
| #glossario | OK | OK | OK | OK | OK |
| **Globais** (Nav, Progress, Footer, Aurora, Diagramas) | OK | OK | 1 issue (diagramas 850px) | OK | OK |

---

## P0 — Bugs Visuais e CSS

### Critico

Nenhum problema encontrado nesta prioridade.

### Alto

Nenhum problema encontrado nesta prioridade.

### Medio

- [ ] **[P0-001]** Badges com texto abaixo de 12px podem ser ilegíveis em certos dispositivos
  - **Secao:** #change-plan
  - **Elemento:** `.field-type-badge` (11px), `.pix-badge` (10px)
  - **Evidencia:** evaluate retornou fontSize 10-11px em 9 elementos
  - **Arquivo:** `src/components/sections/ChangePlanSection.astro:339` (font-size: 0.6875rem) e `:615` (font-size: 0.625rem)
  - **Correcao sugerida:** Usar `font-size: var(--text-xs)` (0.75rem / 12px) como minimo

### Baixo

- [ ] **[P0-002]** Label `.sr-only` gera overflow tecnico no glossario (nao-visual)
  - **Secao:** #glossario
  - **Elemento:** `LABEL.sr-only` — scrollWidth 198 > clientWidth 1
  - **Evidencia:** evaluate detectou overflow, mas o elemento e visually-hidden por design
  - **Correcao sugerida:** Nenhuma correcao necessaria — comportamento esperado de `.sr-only`

---

## P1 — Interatividade Quebrada

### Critico

Nenhum problema encontrado nesta prioridade.

### Alto

Nenhum problema encontrado nesta prioridade.

### Medio

- [ ] **[P1-001]** Paineis de cenarios inativos nao usam `hidden` attribute — apenas `display: none` via CSS
  - **Secao:** #cenarios
  - **Componente:** ScenariosSection — tabpanels
  - **Comportamento esperado:** Paineis inativos devem ter atributo `hidden` para acessibilidade (screen readers podem anunciar conteudo oculto via CSS)
  - **Comportamento atual:** Ao clicar na tab "Produto Existente", o painel `#scenario-greenfield` fica com `display: none` mas `hidden=false`
  - **Arquivo:** `src/components/sections/ScenariosSection.astro`
  - **Correcao sugerida:** Adicionar `hidden` attribute ao trocar tabs, ou usar `aria-hidden="true"` nos paineis inativos

### Baixo

Nenhum problema encontrado nesta prioridade.

---

## P2 — Responsividade

### Critico

- [ ] **[P2-001]** Diagramas React (react-flow) renderizam com largura fixa de 850px em todos os viewports, ultrapassando mobile e tablet
  - **Viewport:** 375px e 768px
  - **Secao:** Todas as secoes com diagramas React (10 diagramas)
  - **Evidencia:** evaluate retornou `.react-flow` com width=850px em viewport 375px (2.27x o viewport)
  - **Arquivo:** `src/components/ui/DiagramContainer.astro` (container) + cada diagrama `.tsx`
  - **Correcao sugerida:** Adicionar `max-width: 100%; overflow-x: auto;` no `.diagram-container` ou configurar `fitView` nos diagramas React Flow. Alternativamente, usar `transform: scale()` proporcional ao viewport.

### Alto

- [ ] **[P2-002]** Overflow horizontal em 4 secoes no mobile (375px)
  - **Viewport:** 375px
  - **Secao:** #consequencias (414px), #enrichment (422px), #papeis (406px), #spec-crafting (393px)
  - **Evidencia:** evaluate `section.scrollWidth > viewport` confirmado
  - **Arquivo:** Componentes de cada secao respectiva
  - **Correcao sugerida:** Revisar grids e cards dessas secoes — provavelmente padding/gap excessivo ou min-width em cards que impede quebra. Verificar `grid-template-columns` e adicionar `min-width: 0` nos grid items.

- [ ] **[P2-003]** Touch targets abaixo de 44x44px em elementos interativos mobile
  - **Viewport:** 375px
  - **Secao:** Global
  - **Evidencia:** evaluate retornou:
    - `.nav-toggle`: 36x18px
    - `.depth-btn`: ~115x27px (altura insuficiente)
    - `.nav-logo`: 64x29px
    - `.footer-docs-link`: 234x22px
  - **Arquivo:** `src/components/layout/StickyNav.astro`, `src/components/layout/DepthFilter.astro`, `src/components/layout/Footer.astro`
  - **Correcao sugerida:** Aumentar `min-height: 44px` e `min-width: 44px` (ou padding equivalente) em todos os elementos interativos para cumprir WCAG 2.5.8 (Target Size)

### Medio

- [ ] **[P2-004]** H1 e H2 com 48px em viewports mobile (375px) — texto grande para tela pequena
  - **Viewport:** 375px, 768px
  - **Secao:** Todas (H1 em #problema, H2 em todas)
  - **Evidencia:** evaluate retornou `fontSize: 48px` para H1 e H2 em viewport 375px
  - **Arquivo:** `src/styles/base.css` ou componentes de secao
  - **Correcao sugerida:** Usar `clamp()` ou media query para reduzir headings em mobile. Exemplo: `font-size: clamp(1.75rem, 5vw, 3rem)`

---

## P3 — Aderencia ao Tema Borealis

### Critico

Nenhum problema encontrado nesta prioridade.

### Alto

Nenhum problema encontrado nesta prioridade.

### Medio

- [ ] **[P3-001]** Cores hardcoded em CSS ao inves de usar tokens `var()`
  - **Secao:** Multiplas
  - **Token esperado:** `var(--color-warning)`, `var(--color-solution)`, `var(--color-text-accent)`, etc.
  - **Valores encontrados:**
    - `#fbbf24` (warning) em: `ChangePlanSection.astro:309,340,631`, `DirectEditSection.astro:322`, `EnrichmentSection.astro:283`, `GuardrailsSection.astro:234`
    - `#34d399` (solution/green) em: `EnrichmentSection.astro:224,279`, `GuardrailsSection.astro:269`
    - `#22d3ee` (cyan) em: `EnrichmentSection.astro:230`
    - `#67e8f9` (accent) em: `EnrichmentSection.astro:252,313`, `GuardrailsSection.astro:309`
    - `#f87171` (problem/red) em: `ChangePlanSection.astro:475`
    - `#a78bfa` (violet) em: `GuardrailsSection.astro:273`
    - `#0f172a` em: `EnrichmentSection.astro:242`
  - **Correcao sugerida:** Substituir todas as ocorrencias por tokens semanticos correspondentes. Exemplo: `#fbbf24` → `var(--color-warning)`, `#34d399` → `var(--color-solution)`, `#67e8f9` → `var(--color-text-accent)`, `#f87171` → `var(--color-problem)`, `#a78bfa` → `var(--color-aurora-violet)`, `#22d3ee` → `var(--color-aurora-cyan)`, `#0f172a` → `var(--color-bg-primary)` ou similar

### Baixo

- [ ] **[P3-002]** Duracoes de transicao hardcoded fora dos tokens do tema
  - **Secao:** Global
  - **Valores encontrados:**
    - `transition: all 0.4s ease` em `src/components/animations/CanonEnrichment.astro:61` (0.4s nao e token)
    - `transition: border-color 0.2s ease` em `src/components/sections/GuardrailsSection.astro:173` (0.2s nao e token)
    - `transition: width 50ms linear` em `src/components/layout/ProgressBar.astro:27` (50ms nao e token, mas e deliberado para smoothness)
  - **Correcao sugerida:** Usar `var(--duration-normal)` (300ms) ou `var(--duration-fast)` (150ms) conforme a intencao

---

## P4 — Padrao de Componentes

### Critico

Nenhum problema encontrado nesta prioridade.

### Alto

- [ ] **[P4-001]** Cores hardcoded (#hex) em estilos de componentes ao inves de tokens CSS
  - **Componente:** ChangePlanSection, DirectEditSection, EnrichmentSection, GuardrailsSection
  - **Arquivos:**
    - `src/components/sections/ChangePlanSection.astro:309,340,475,631`
    - `src/components/sections/DirectEditSection.astro:322`
    - `src/components/sections/EnrichmentSection.astro:224,230,242,252,279,283,313`
    - `src/components/sections/GuardrailsSection.astro:234,269,273,309`
  - **Problema:** 17+ ocorrencias de cores hex hardcoded que ja possuem tokens semanticos equivalentes em `tokens.css`. Isso dificulta manutencao do tema e impede troca de paleta.
  - **Correcao sugerida:** Substituir por `var(--color-*)` correspondentes (ver P3-001 para mapeamento)

### Medio

- [ ] **[P4-002]** Font-size hardcoded sem usar tokens tipograficos
  - **Componente:** ChangePlanSection, DepthFilter
  - **Arquivos:**
    - `src/components/sections/ChangePlanSection.astro:339` — `font-size: 0.6875rem` (nao e token)
    - `src/components/sections/ChangePlanSection.astro:615` — `font-size: 0.625rem` (nao e token)
    - `src/components/layout/DepthFilter.astro:77` — `font-size: 0.625rem` (nao e token)
  - **Problema:** Valores como 0.6875rem e 0.625rem nao correspondem a nenhum passo do scale tipografico (xs=0.75rem, sm=0.875rem)
  - **Correcao sugerida:** Usar `var(--text-xs)` (0.75rem) como tamanho minimo ou criar token `--text-2xs` se necessario

### Baixo

Nenhum problema encontrado nesta prioridade.

---

## Checklist de Conformidade

| # | Criterio | Status | Notas |
|---|----------|--------|-------|
| 1 | lang="pt-BR" definido | OK | `<html lang="pt-BR">` |
| 2 | Skip-link funcional | OK | `.skip-link` aponta para `#main-content` |
| 3 | Hierarquia de headings correta | OK | H1 > H2 > H3 > H4 sem saltos |
| 4 | Navegacao por teclado | OK | Nav links com href funcional |
| 5 | ARIA landmarks corretos | OK | `main`, `nav[role=navigation]`, `contentinfo`, `region` em secoes |
| 6 | Focus visible em interativos | OK | Verificado via snapshot |
| 7 | prefers-reduced-motion respeitado | OK | `CanonEnrichment.astro:79` e `RolesMatrixDiagram.astro:176` desativam transicoes |
| 8 | Sem overflow horizontal (desktop) | OK | docWidth (1905) < viewportWidth (1920) |
| 9 | Sem overflow horizontal (mobile) | FALHA | 4 secoes com overflow em 375px (P2-002) |
| 10 | Touch targets >= 44x44 (mobile) | FALHA | nav-toggle, depth-btns, footer-link (P2-003) |
| 11 | Diagramas React renderizados | OK | 10 astro-island com conteudo |
| 12 | Nav links funcionais | OK | 16 links, todos com target existente |
| 13 | DepthFilter funcional | OK | 3 botoes com aria-pressed, toggle funciona |
| 14 | Progress bar funcional | OK | aria-valuenow=95 ao final da pagina |
| 15 | Scenario tabs funcionais | OK | 3 tabs com aria-selected alternando corretamente |
| 16 | Glossary search funcional | OK | Filtra 32 → 14 items para "canon" |
| 17 | CTABanner links funcionais | OK | 2 CTAs com href correto, externo com rel=noopener |
| 18 | Todas 16 secoes renderizadas | OK | IDs verificados: problema → glossario |
| 19 | Cores usam tokens (var()) | FALHA | 17+ ocorrencias de cores hardcoded (P3-001/P4-001) |
| 20 | Tipografia segue scale | FALHA | 3 ocorrencias de font-size fora do scale (P4-002) |

---

## Proximos Passos Priorizados

### Correcoes Imediatas (P0 Critico + P1 Critico)
- Nenhuma issue critica em P0 ou P1

### Correcoes Prioritarias (P2 Critico + P2 Alto)
- **[P2-001]** Diagramas React com largura fixa 850px — nao responsivos (critico)
- **[P2-002]** Overflow horizontal em 4 secoes no mobile
- **[P2-003]** Touch targets insuficientes em mobile

### Melhorias (P2 Medio + P3 + P4 Alto)
- **[P2-004]** Headings com 48px em mobile
- **[P3-001]** / **[P4-001]** Cores hardcoded → migrar para tokens var()
- **[P4-002]** Font-size hardcoded → migrar para tokens tipograficos

### Polimento (P0 Medio/Baixo + P1 Medio + P3 Baixo)
- **[P0-001]** Badges com texto < 12px
- **[P1-001]** Paineis de cenarios sem atributo `hidden`
- **[P3-002]** Transicoes com duracoes fora do sistema de tokens
