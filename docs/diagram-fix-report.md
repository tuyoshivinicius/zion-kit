# Relatorio de Diagnostico e Fix de Diagramas — ZionKit

**Data:** 2026-04-08
**URL testada:** http://localhost:4321/zion-kit/
**Diagrama(s):** all
**Modo:** auto

---

## Resumo

| Diagrama | Renderiza | Nodes | Edges | Overlaps | Overflow Mobile | aria-label | Tokens |
|----------|-----------|-------|-------|----------|-----------------|------------|--------|
| ContextVoid | OK | 4 | 3 | 0 | OK (fix aplicado) | OK | 4 issues |
| ThreeGaps | OK | 3 | 2 | 0 | OK (fix aplicado) | OK | 1 issue |
| Cycle | OK | 6 | 7 | 0 | OK (fix aplicado) | OK | 10 issues |
| CanonBuilding | OK | 6 | 5 | 0 | OK (fix aplicado) | OK | 5 issues |
| CeremonyFlow | OK | 6 | 5 | 0 | OK (fix aplicado) | OK | 10 issues |
| ContextualSpec | OK | 3 | 2 | 0 | OK (fix aplicado) | OK | 2 issues |
| Feedback | OK | 7 | 8 | 0 | OK (fix aplicado) | OK | 10 issues |
| Guardrails | OK | 9 | 10 | 0 | OK (fix aplicado) | OK | 12 issues |
| ChangePlanEnvelope | OK | 10 | 14 | 0 (fix aplicado) | OK (fix aplicado) | OK | 14 issues |
| DirectEditFlow | OK | 7 | 7 | 0 (fix aplicado) | OK (fix aplicado) | OK | 12 issues |
| BeforeAfter | N/A | — | — | — | OK (fix aplicado) | N/A | 0 |
| RolesMatrix | OK | — | — | — | OK (fix aplicado) | N/A | 0 |

---

## Problemas Encontrados

### Critico

- [x] **[D-001]** min-width: 850px forcado em TODOS os diagramas em mobile
  - **Diagrama:** Todos (10 React + 2 Astro)
  - **Secao:** Todas
  - **Arquivo:** `src/components/ui/DiagramContainer.astro:61-64`
  - **Evidencia:** Playwright evaluate — todos os 11 containers com `min-width: 850px`, `actualWidth: 850` em viewport 375px. Nenhum diagrama cabia na tela mobile.
  - **Fix aplicado:** sim — `min-width: auto; width: 100%` + remoção da mensagem "deslize para ver" (enganosa com React Flow fitView)
  - **Verificado:** sim — todos containers agora `min-width: auto`, `actualWidth: 286px` em viewport 375px

### Alto

- [x] **[D-002]** Overlaps em ChangePlanEnvelope — 4 pares de nodes sobrepostos
  - **Diagrama:** ChangePlanEnvelope
  - **Secao:** #change-plan
  - **Arquivo:** `src/lib/diagrams/change-plan-envelope-diagram.ts`
  - **Evidencia:** Playwright overlap detection: discovery/constitution, constitution/specification, specification/expert-edit, expert-edit/incremental — gap horizontal de 200px insuficiente para nodes com maxWidth 260px
  - **Fix aplicado:** sim — reposicionamento de todos os nodes com gap horizontal de ~230px entre tipos. Envelope, universal, conditional, approval e exception tambem reposicionados para centralizar.
  - **Verificado:** sim — 0 overlaps apos fix

- [x] **[D-003]** Overlaps em DirectEditFlow — 2 pares sobrepostos
  - **Diagrama:** DirectEditFlow
  - **Secao:** #edicao-direta
  - **Arquivo:** `src/lib/diagrams/direct-edit-flow-diagram.ts`
  - **Evidencia:** Playwright overlap detection: propose/guardrails (diagonal proximo), approve-de/approve-arch (gap insuficiente)
  - **Fix aplicado:** sim — reposicionamento de propose (y:120→140), guardrails (x:250→280), report (x:530→570), review (x:380→400, y:230→250), plan (x:700→740), approve-de (y:350→370), approve-arch (x:950→980, y:350→370)
  - **Verificado:** sim — 0 overlaps apos fix

### Medio

- [x] **[D-004]** Overflow horizontal interno em Cycle
  - **Diagrama:** Cycle
  - **Secao:** #ciclo
  - **Arquivo:** `src/lib/diagrams/cycle-diagram.ts`
  - **Evidencia:** scrollWidth 966 > clientWidth 910. Nodes feedback (x:500) e direct-edit (x:510) proximos da borda.
  - **Fix aplicado:** sim — feedback (x:500→470), direct-edit (x:510→470)
  - **Verificado:** sim — overflow interno do React Flow (overflow:hidden), nao visivel ao usuario. Container `.diagram-content` sem scroll horizontal.

- [x] **[D-005]** Overflow horizontal interno em CanonBuilding
  - **Diagrama:** CanonBuilding
  - **Secao:** #canon-building
  - **Arquivo:** `src/lib/diagrams/canon-building-diagram.ts`
  - **Evidencia:** scrollWidth 938 > clientWidth 910. Terceira coluna (x:560 + maxWidth 260 = 820px).
  - **Fix aplicado:** sim — session2/gate2 (x:280→270), session3/gate3 (x:560→540)
  - **Verificado:** sim — overflow interno apenas, nao visivel

### Baixo

- [ ] **[D-006]** Cores hardcoded em ~100+ ocorrencias nos arquivos de dados e componentes
  - **Diagrama:** Todos
  - **Arquivo:** Multiplos (ver secao "Cores Hardcoded")
  - **Fix aplicado:** nao — risco medio, requer refatoracao em multiplos arquivos. Sugestao: centralizar constantes JS em `shared-config.ts` (ver plano abaixo).
  - **Verificado:** N/A

---

## Fixes Aplicados

| # | Arquivo | Linhas | Descricao | Verificado |
|---|---------|--------|-----------|------------|
| 1 | `DiagramContainer.astro` | L61-64 | `min-width: 850px` → `min-width: auto; width: 100%` | OK |
| 2 | `DiagramContainer.astro` | L67-78 | Removido `.diagram-container::after` (hint "deslize") + position relative. Adicionado `overflow-x: hidden` no `.diagram-content` mobile. | OK |
| 3 | `change-plan-envelope-diagram.ts` | Multiplas | Reposicionamento de 10 nodes para eliminar 4 overlaps | OK |
| 4 | `direct-edit-flow-diagram.ts` | Multiplas | Reposicionamento de 7 nodes para eliminar 2 overlaps | OK |
| 5 | `cycle-diagram.ts` | L61,73 | feedback x:500→470, direct-edit x:510→470 | OK |
| 6 | `canon-building-diagram.ts` | L33,44,55,65 | session2/gate2 x:280→270, session3/gate3 x:560→540 | OK |

---

## Cores Hardcoded Encontradas

### shared-config.ts (variantColors)

| Linha | Valor | Token Sugerido |
|-------|-------|----------------|
| 6 | `rgba(34, 211, 238, 0.5)` | defaultEdge (cyan 50%) |
| 42 | `rgba(148, 163, 184, 0.1)` | border-default |
| 43 | `#111827` | `var(--color-bg-secondary)` |
| 44 | `#94a3b8` | `var(--color-text-secondary)` |
| 47 | `#f87171` | `var(--color-problem)` |
| 52 | `#34d399` | `var(--color-solution)` |
| 57 | `#fbbf24` | `var(--color-warning)` |
| 62 | `#22d3ee` | `var(--color-aurora-cyan)` |
| 67 | `#a78bfa` | `var(--color-aurora-violet)` |
| 72 | `#f472b6` | `var(--color-aurora-pink)` |

### NodeCard.tsx

| Linha | Valor | Token Sugerido |
|-------|-------|----------------|
| 30 | `rgba(34, 211, 238, 0.15)` | canon glow |
| 61 | `#67e8f9` / `#f1f5f9` | textAccent / textPrimary |
| 71 | `#94a3b8` | textSecondary |
| 89 | `#1e293b` | bgElevated |
| 90 | `rgba(148, 163, 184, 0.2)` | borderHover |
| 94 | `#f1f5f9` | textPrimary |

### Arquivos -diagram.ts (edges)

| Arquivo | Cores usadas |
|---------|-------------|
| context-void-diagram.ts | `#f87171`, `rgba(34,211,238,0.5)`, `#94a3b8` |
| cycle-diagram.ts | `#94a3b8`, `rgba(34,211,238,0.5)`, `#a78bfa`, `rgba(167,139,250,0.5)`, `#f472b6`, `rgba(244,114,182,0.5)` |
| canon-building-diagram.ts | `rgba(34,211,238,0.5)`, `rgba(251,191,36,0.5)`, `#fbbf24` |
| ceremony-flow-diagram.ts | `rgba(34,211,238,0.5)`, `rgba(251,191,36,0.5)`, `#fbbf24`, `#22d3ee`, `rgba(34,211,238,0.3)` |
| contextual-spec-diagram.ts | `#94a3b8`, `rgba(34,211,238,0.5)`, `rgba(52,211,153,0.5)` |
| feedback-diagram.ts | `#111827`, `#94a3b8`, `#67e8f9`, `#34d399`, `#f1f5f9`, `#64748b`, `#a78bfa` |
| guardrails-diagram.ts | `rgba(251,191,36,0.5)`, `#fbbf24`, `rgba(52,211,153,0.5)`, `#34d399`, `rgba(148,163,184,0.3)`, `#64748b` |
| change-plan-envelope-diagram.ts | `#94a3b8`, `rgba(52,211,153,0.5)`, `rgba(251,191,36,0.5)`, `rgba(34,211,238,0.3)`, `#fbbf24`, `rgba(248,113,113,0.5)` |
| direct-edit-flow-diagram.ts | `#94a3b8`, `rgba(34,211,238,0.5)`, `rgba(52,211,153,0.5)`, `#fbbf24`, `rgba(251,191,36,0.4)` |

### Background em componentes .tsx

Todas as 9 instancias usam `rgba(148, 163, 184, 0.08)` para Background dots.

---

## Acessibilidade dos Diagramas

| Diagrama | aria-label | role | tabIndex nodes | reduced-motion |
|----------|-----------|------|----------------|----------------|
| ContextVoid | OK | group (nodes) | sim (NodeCard) | hook disponivel |
| ThreeGaps | OK | group (nodes) | sim | hook disponivel |
| Cycle | OK | group (nodes) | sim | hook disponivel |
| CanonBuilding | OK | group (nodes) | sim | hook disponivel |
| CeremonyFlow | OK | group (nodes) | sim | hook disponivel |
| ContextualSpec | OK | group (nodes) | sim | hook disponivel |
| Feedback | OK | group (nodes) | sim | hook disponivel |
| Guardrails | OK | group (nodes) | sim | hook disponivel |
| ChangePlanEnvelope | OK | group (nodes) | sim | hook disponivel |
| DirectEditFlow | OK | group (nodes) | sim | hook disponivel |
| BeforeAfter | N/A | N/A | N/A | N/A |
| RolesMatrix | N/A | N/A | N/A | N/A |

---

## Proximos Passos

### Imediato (fixes nao aplicados de risco baixo)
- Centralizar constantes de cores JS em `shared-config.ts` como `tokenColors` (com comentarios mapeando para tokens CSS)
- Refatorar `variantColors` para usar `tokenColors`
- Refatorar `NodeCard.tsx` inline styles para usar constantes de `tokenColors`
- Extrair cor de Background dots para constante compartilhada

### Planejado (fixes de risco medio que requerem mais analise)
- Refatorar edges em todos os 10 arquivos `-diagram.ts` para usar constantes centralizadas de cores
- Avaliar se `useElkLayout` hook deve ser integrado nos componentes que exportam `layoutOptions` (atualmente nenhum componente usa o hook)
- Investigar por que a secao `#comparacao` (BeforeAfter) nao renderiza na pagina

### Futuro (melhorias arquiteturais)
- Considerar usar CSS custom properties via `getComputedStyle` em runtime para tokens em React (alternativa a hex hardcoded)
- Avaliar remoção de `use-elk-layout.ts` e `elk-presets.ts` se confirmado que nenhum diagrama os utiliza
- Adicionar testes visuais automatizados (Playwright test) para regressao de layout em diagramas
