# Plano de Correção — Aderência ao Tema Borealis

## Contexto

Auditoria completa de todas as 16 seções do site ZionKit contra a baseline visual definida em `tokens.css` e `base.css`. O objetivo é identificar e corrigir inconsistências de padding, cores, tipografia, espaçamento e uso de tokens, garantindo aderência total ao tema Borealis conforme os Princípios I (Token-Driven Theming) e IV (Borealis Visual Identity) da constituição.

## Baseline Visual (Referência)

### Tokens principais do Borealis

| Categoria | Tokens de referência |
|---|---|
| **Backgrounds** | `--color-bg-primary: #0a0e17`, `--color-bg-secondary: #111827`, `--color-bg-tertiary: #1a2332`, `--color-bg-elevated: #1e293b` |
| **Texto** | `--color-text-primary: #f1f5f9`, `--color-text-secondary: #94a3b8`, `--color-text-muted: #64748b`, `--color-text-accent: #67e8f9` |
| **Aurora** | `--color-aurora-green: #34d399`, `--color-aurora-cyan: #22d3ee`, `--color-aurora-blue: #60a5fa`, `--color-aurora-violet: #a78bfa`, `--color-aurora-pink: #f472b6` |
| **Semânticas** | `--color-problem: #f87171`, `--color-solution: #34d399`, `--color-warning: #fbbf24`, `--color-info: #60a5fa` |
| **Bordas** | `--color-border-default`, `--color-border-hover`, `--color-border-accent` |
| **Sombras glow** | `--shadow-glow-cyan`, `--shadow-glow-green`, `--shadow-glow-violet` |
| **Espaçamento** | `--space-1` a `--space-32` |
| **Raios** | `--radius-sm` a `--radius-full` |
| **Tipografia** | `--text-xs` a `--text-6xl`, `--leading-tight/normal/relaxed`, `--tracking-tight/normal/wide` |
| **Transições** | `--duration-fast/normal/slow/very-slow`, `--ease-out-expo`, `--ease-in-out-quart` |

### Padrões visuais esperados

- Seções alternam `section-odd` (bg-primary) e `section-even` (bg-secondary)
- Cards usam `--color-bg-tertiary` com `--color-border-default` e `--radius-lg`
- Hover em cards: `--color-border-accent` + `--shadow-glow-cyan`
- Padding de seção: `--space-24` vertical
- Container: `.max-width-content` (72rem) com `--space-6` inline padding
- Texto intro: `--text-lg`, `--leading-relaxed`, `--color-text-secondary`

---

## Inconsistências Encontradas

### 1. Valores hardcoded (violação do Princípio I)

| # | Arquivo | Linha/Região | Problema | Correção | Prioridade |
|---|---|---|---|---|---|
| 1.1 | `RiscosSection.astro` | `.risco-number` (L177-178) | `width: 28px; height: 28px` hardcoded | Usar `--space-8` (2rem = 32px) ou manter 28px mas documentar como exceção de alinhamento | Baixa |
| 1.2 | `GuardrailsSection.astro` | `.guardrail-icon` (L193-194) | `font-size: 1.25rem` hardcoded | Usar `var(--text-xl)` (1.25rem) — mesmo valor, mas via token | Alta |
| 1.3 | `GuardrailsSection.astro` | `.section-intro` (L163) | `max-width: 48rem` hardcoded | Usar `var(--max-width-narrow)` (48rem) — mesmo valor, via token | Alta |
| 1.4 | `ScenariosSection.astro` | `.timeline::before` (L165) | `left: 15px` hardcoded | Aproximar com token: `calc(var(--space-4) - 1px)` ou similar | Média |
| 1.5 | `ScenariosSection.astro` | `.timeline-dot` (L184) | `width: 24px; height: 24px` hardcoded | Usar `var(--space-6)` (1.5rem = 24px) | Baixa |
| 1.6 | `RolesSection.astro` | `.roles-stage-table` (L279) | `min-width: 700px` hardcoded | Aceitar como exceção de tabela responsiva (não há token para isso) | Baixa |
| 1.7 | `CanonBuildingSection.astro` | `.ceremony-number` (L275-276) | `width: 28px; height: 28px` hardcoded | Consistente com `.risco-number` — aceitar ou criar token `--size-badge` | Baixa |
| 1.8 | `CanonBuildingSection.astro` | `.path-label` (L513) | `margin-top: 2px` hardcoded | Substituir por `margin-top: var(--space-1)` (4px) ou remover se visual aceita | Baixa |
| 1.9 | `DirectEditSection.astro` | `.step-number` (L207-208) | `width: 32px; height: 32px` hardcoded | Usar `var(--space-8)` (2rem = 32px) | Baixa |
| 1.10 | `ChangePlanSection.astro` | `.risco-number` equivalente `.field-dot` (L302-303) | `width: 8px; height: 8px` hardcoded | Usar `var(--space-2)` (0.5rem = 8px) | Baixa |
| 1.11 | `ConsequenciasSection.astro` | `.problem-number` (L119-120) | `width: 28px; height: 28px` hardcoded | Igual ao padrão `.risco-number` — mesma recomendação | Baixa |
| 1.12 | `ScenariosSection.astro` | `.timeline::before` (L167) | `width: 2px` hardcoded | Sem token para border-width, aceitar | Baixa |
| 1.13 | `ChangePlanSection.astro` | `.pix-key` (L546) | `min-width: 120px` hardcoded | Sem token adequado, aceitar como exceção de layout | Baixa |
| 1.14 | `GlossarySection.astro` | `.glossary-search` (L249) | `max-width: 24rem` hardcoded | Sem token para esse breakpoint. Considerar adicionar `--max-width-xs` a tokens.css ou aceitar | Baixa |

### 2. Seções sem alternância section-odd/section-even (violação do Princípio IV)

| # | Arquivo | Problema | Correção | Prioridade |
|---|---|---|---|---|
| 2.1 | `GlossarySection.astro` (L202) | Usa `section-even` — **OK se posição no index for par** | Verificar ordem em index.astro | Média |

> **Resultado da verificação:** Todas as 16 seções declaram corretamente `section-odd` ou `section-even`. A alternância precisa ser confirmada contra a ordem real em `index.astro`.

### 3. Cards sem efeito hover Borealis (glow/border-accent)

| # | Arquivo | Componente | Problema | Correção | Prioridade |
|---|---|---|---|---|---|
| 3.1 | `ConsequenciasSection.astro` | `.problem-card` | Sem hover effect — card não tem background, border nem glow | Adicionar `background: var(--color-bg-tertiary); border: 1px solid var(--color-border-default); border-radius: var(--radius-lg); padding: var(--space-6);` + hover com `border-color: var(--color-border-accent); box-shadow: var(--shadow-glow-cyan)` | Alta |
| 3.2 | `GuardrailsSection.astro` | `.guardrail-card` (L169) | Usa `background: var(--color-bg-secondary)` — visualmente plano contra o fundo `section-even` (também bg-secondary) | Mudar para `background: var(--color-bg-tertiary)` para criar contraste | Alta |
| 3.3 | `CanonBuildingSection.astro` | `.ceremony-block` | Tem border e bg-tertiary mas sem hover glow | Adicionar `:hover { border-color: var(--color-border-accent); box-shadow: var(--shadow-glow-cyan); }` | Média |
| 3.4 | `DirectEditSection.astro` | `.step-card` | Tem border e bg-tertiary mas sem hover glow | Adicionar hover com `border-color: var(--color-border-accent)` | Média |
| 3.5 | `EnrichmentSection.astro` | `.mechanism-card` | Tem border e bg-tertiary mas sem hover glow | Adicionar hover com glow correspondente à cor da borda (green para primary, cyan para complementary) | Média |

### 4. Uso de `!important` (code smell)

| # | Arquivo | Linha/Região | Problema | Correção | Prioridade |
|---|---|---|---|---|---|
| 4.1 | `ConsequenciasSection.astro` | `.problem-conclusion` (L141) | `color: var(--color-text-muted) !important` | Aumentar especificidade do seletor: `.problem-card .problem-conclusion` | Média |
| 4.2 | `EnrichmentSection.astro` | `.mechanism-note` (L260-262) | `color !important` e `font-size !important` | Aumentar especificidade: `.mechanism-card .mechanism-note` | Média |
| 4.3 | `CanonBuildingSection.astro` | `.path-precondition` (L529-532) | 3x `!important` | Aumentar especificidade: `.decision-path .path-precondition` | Média |

### 5. Ausência de `transition` em cards/componentes interativos

| # | Arquivo | Componente | Problema | Correção | Prioridade |
|---|---|---|---|---|---|
| 5.1 | `ConsequenciasSection.astro` | `.problem-card` | Sem transition | Adicionar `transition: border-color var(--duration-normal) ease, box-shadow var(--duration-normal) ease` | Média |
| 5.2 | `EnrichmentSection.astro` | `.mechanism-card` | Sem transition para hover | Adicionar `transition: border-color var(--duration-normal) ease, box-shadow var(--duration-normal) ease` | Média |
| 5.3 | `DirectEditSection.astro` | `.step-card` | Sem transition | Adicionar transition | Média |
| 5.4 | `DirectEditSection.astro` | `.report-card` | Sem transition | Adicionar transition | Baixa |

### 6. Inconsistências de padding/espaçamento em cards

| # | Arquivo | Componente | Problema | Correção | Prioridade |
|---|---|---|---|---|---|
| 6.1 | `ConsequenciasSection.astro` | `.problem-card` | Sem padding — texto pode encostar nas bordas se card receber background | Adicionar `padding: var(--space-6)` ao aplicar background | Alta |
| 6.2 | `SolutionBridgeSection.astro` | `.solution-text` (L18) | `style="margin: 0 auto; text-align: center;"` inline | Mover para scoped style | Média |

### 7. Guardrails: card sem contraste visual contra fundo

| # | Arquivo | Problema | Correção | Prioridade |
|---|---|---|---|---|
| 7.1 | `GuardrailsSection.astro` | `.guardrail-card` usa `bg-secondary` mas seção é `section-even` (bg-secondary) — card se funde com o fundo | Mudar para `background: var(--color-bg-tertiary)` | Alta |

### 8. Falta de `depth` prop no GlossarySection

| # | Arquivo | Problema | Correção | Prioridade |
|---|---|---|---|---|
| 8.1 | `GlossarySection.astro` (L206) | `SectionHeader` sem prop `depth` | Adicionar `depth={1}` (glossário é referência acessível a todos) | Média |

### 9. Inline style

| # | Arquivo | Problema | Correção | Prioridade |
|---|---|---|---|---|
| 9.1 | `SolutionBridgeSection.astro` (L18) | `style="margin: 0 auto; text-align: center;"` inline no div | Já coberto por `.solution-content` que tem `text-align: center` e `.max-width-narrow` que tem `margin-inline: auto`. Remover o inline style | Média |

---

## Plano de Correção

### Lote 1 — Alta prioridade (contraste e aderência visual)

1. **GuardrailsSection.astro** — Corrigir `.guardrail-card` background de `bg-secondary` para `bg-tertiary` (issues 3.2 e 7.1)
2. **GuardrailsSection.astro** — Substituir `font-size: 1.25rem` por `var(--text-xl)` e `max-width: 48rem` por `var(--max-width-narrow)` (issues 1.2 e 1.3)
3. **ConsequenciasSection.astro** — Adicionar background, border, border-radius, padding e hover glow ao `.problem-card` (issues 3.1 e 6.1)

### Lote 2 — Média prioridade (hover effects e transitions)

4. **CanonBuildingSection.astro** — Adicionar hover glow ao `.ceremony-block` (issue 3.3)
5. **DirectEditSection.astro** — Adicionar hover glow e transition ao `.step-card` e `.report-card` (issues 3.4, 5.3, 5.4)
6. **EnrichmentSection.astro** — Adicionar hover glow e transition ao `.mechanism-card` (issues 3.5 e 5.2)

### Lote 3 — Média prioridade (code quality)

7. **ConsequenciasSection.astro** — Remover `!important` de `.problem-conclusion`, aumentar especificidade (issue 4.1)
8. **EnrichmentSection.astro** — Remover `!important` de `.mechanism-note`, aumentar especificidade (issue 4.2)
9. **CanonBuildingSection.astro** — Remover `!important` de `.path-precondition`, aumentar especificidade (issue 4.3)
10. **SolutionBridgeSection.astro** — Remover inline style (issue 9.1)
11. **GlossarySection.astro** — Adicionar `depth={1}` ao SectionHeader (issue 8.1)

### Lote 4 — Baixa prioridade (tokens hardcoded dimensionais)

12. Substituir valores dimensionais hardcoded (28px, 24px, 32px, 8px) por tokens de espaçamento onde possível (issues 1.1, 1.5, 1.7-1.11)
13. **ScenariosSection.astro** — Substituir `left: 15px` por expressão com token (issue 1.4)

---

## Seções Prioritárias — Diagnóstico Específico

### Riscos (RiscosSection.astro)
- **Status:** Boa aderência ao tema. Cards com bg-tertiary, border-default, hover com border-accent e glow-cyan. Tokens de espaçamento corretos.
- **Pendências:** Apenas dimensões hardcoded no `.risco-number` (28px) — baixa prioridade.

### Change Plan (ChangePlanSection.astro)
- **Status:** Excelente aderência. Uso extensivo de tokens, cards com hover effects, cores aurora nos borders de destaque.
- **Pendências:** Dimensões hardcoded nos dots (8px) e `.pix-key` min-width (120px) — baixa prioridade.

### Aprovação/Descobertas (EnrichmentSection.astro)
- **Status:** Boa estrutura. Cards com bg-tertiary e borders coloridos por tipo.
- **Pendências:** Falta de hover glow nos `.mechanism-card`, `!important` no `.mechanism-note`, falta de transition.

### Consequências (ConsequenciasSection.astro)
- **Status:** Problema mais significativo. `.problem-card` não tem background, border nem padding — visualmente inconsistente com o padrão de cards do restante do site.
- **Pendências:** Lote 1, prioridade alta.

---

## Verificação

Para cada correção aplicada:

1. **Visual check:** Abrir o site em localhost e verificar que:
   - Cards têm contraste visível contra o fundo da seção
   - Hover effects (glow + border-accent) funcionam
   - Ritmo visual section-odd/section-even está correto
2. **Token audit:** Buscar por valores hardcoded remanescentes:
   ```bash
   grep -rn "px\|rem\|#[0-9a-fA-F]" src/components/sections/ --include="*.astro" | grep -v "var(--" | grep -v "tokens.css"
   ```
3. **`!important` audit:**
   ```bash
   grep -rn "!important" src/components/sections/ --include="*.astro"
   ```
4. **Responsividade:** Verificar em viewport 375px, 768px e 1280px que cards, grids e texto mantêm legibilidade e padding adequado.
5. **Acessibilidade:** Confirmar que alterações de cor mantêm contraste WCAG AA (4.5:1 texto normal, 3:1 texto grande).
