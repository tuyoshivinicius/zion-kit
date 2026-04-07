# Relatorio de Auditoria QA — ZionKit

**Data:** 2026-04-06
**URL testada:** https://tuyoshivinicius.github.io/zion-kit/
**Viewports testados:** Desktop (1280x800), Tablet (768x1024), Mobile (375x812)

---

## Resumo Executivo

- **Total de problemas encontrados:** 10
- **Criticos:** 0 | **Altos:** 2 | **Medios:** 4 | **Baixos:** 4
- **Pontuacao geral:** 8/10

O site ZionKit apresenta excelente qualidade geral: hierarquia de headings perfeita, navegacao funcional, responsividade sem overflow, suporte a `prefers-reduced-motion`, skip link funcional, e todos os 6 diagramas React renderizando corretamente. Os principais problemas sao relacionados a paths incorretos (favicon, og:image) e acessibilidade em elementos interativos especificos.

---

## 1. Acessibilidade

### Alto
- [ ] **[A-001]** Input da newsletter remove outline no focus via CSS
  - **Localizacao:** Footer — formulario de newsletter
  - **Impacto:** Usuarios que navegam por teclado perdem o indicador visual de foco no campo de email. A regra `.newsletter-input:focus { outline: none }` tem especificidade maior que a regra global `:focus-visible`, anulando o anel de foco.
  - **Correcao sugerida:** Trocar `.newsletter-input:focus { outline: none; }` por `.newsletter-input:focus:not(:focus-visible) { outline: none; }` para preservar o outline em navegacao por teclado, ou remover o `outline: none` e usar apenas `border-color` como indicador adicional.
  - **Arquivo:** `src/components/layout/Footer.astro:91-94`

### Medio
- [ ] **[A-002]** DiagramContainer usa `role="img"` no `<figure>` que contem `role="application"` internamente
  - **Localizacao:** Todos os 6 diagramas React (ContextVoidDiagram, ThreeGapsDiagram, CycleDiagram, CanonBuildingDiagram, ContextualSpecDiagram, FeedbackDiagram)
  - **Impacto:** Roles aninhados conflitantes — `role="img"` indica conteudo estatico nao-interativo, mas contem `role="application"` do React Flow que indica conteudo interativo. Leitores de tela podem ignorar o conteudo interno ou confundir o usuario.
  - **Correcao sugerida:** Trocar `role="img"` no `<figure>` por `role="figure"` ou remover o role completamente (o elemento `<figure>` ja tem semantica implicita).
  - **Arquivo:** `src/components/ui/DiagramContainer.astro:13`

- [ ] **[A-003]** Diagramas React Flow nao oferecem navegacao por teclado para nodes individuais
  - **Localizacao:** Todos os 6 diagramas interativos
  - **Impacto:** Usuarios de teclado nao conseguem navegar entre os nodes dos diagramas. O `role="application"` captura o foco mas os nodes internos nao sao focaveis via Tab.
  - **Correcao sugerida:** Adicionar `tabIndex={0}` e `role="button"` ou `role="group"` nos nodes customizados, ou fornecer uma descricao textual alternativa completa dos diagramas para usuarios de tecnologias assistivas.
  - **Arquivo:** `src/components/diagrams/NodeCard.tsx`

### Baixo
- [ ] **[A-004]** Footer usa `role="contentinfo"` redundante com o elemento `<footer>`
  - **Localizacao:** Footer
  - **Impacto:** Redundancia semantica — o elemento `<footer>` ja implica `role="contentinfo"`. Nao causa problemas, mas e desnecessario.
  - **Correcao sugerida:** Remover `role="contentinfo"` do elemento `<footer>`.
  - **Arquivo:** `src/components/layout/Footer.astro:5`

---

## 2. Responsividade

### Baixo
- [ ] **[R-001]** Diagramas em mobile exigem scroll horizontal com largura minima de 850px
  - **Localizacao:** Todos os diagramas em viewport mobile (375px)
  - **Impacto:** Baixo — o site ja exibe uma mensagem "deslize para ver" como hint visual. E uma decisao de design valida dado a complexidade dos diagramas, mas a experiencia poderia ser melhorada com versoes simplificadas dos diagramas em mobile.
  - **Correcao sugerida:** Considerar versoes simplificadas ou imagens estaticas dos diagramas para mobile, ou manter como esta (comportamento aceitavel).
  - **Arquivo:** `src/components/ui/DiagramContainer.astro:62-65`

Nenhum problema critico de responsividade encontrado. Navegacao adapta corretamente com menu hamburger em tablet e mobile. Sem overflow horizontal no viewport.

---

## 3. Navegacao e Links

Nenhum problema encontrado nesta categoria.

Todos os 10 links internos da navegacao sticky funcionam corretamente e levam as secoes correspondentes. O skip link "Pular para o conteudo" funciona e foca no `<main>`. A progress bar e os depth filters estao presentes e funcionais.

---

## 4. Elementos Interativos (Diagramas)

### Medio
- [ ] **[I-001]** Tabs do secao "Por dentro de cada etapa" — conteudo dos paineis ocultos (Especificacao Contextualizada e Retroalimentacao) so renderiza apos clique
  - **Localizacao:** Secao 05 — Por dentro de cada etapa
  - **Impacto:** Diagramas dentro de tabs ocultas (ContextualSpecDiagram e FeedbackDiagram) so carregam quando o usuario clica na tab, o que e comportamento esperado, mas pode causar delay visual.
  - **Correcao sugerida:** Verificar que a experiencia de carregamento e suave. O comportamento atual e aceitavel — apenas documentando para visibilidade.
  - **Arquivo:** `src/components/sections/PillarsSection.astro`

Pontos positivos:
- Todos os 6 diagramas React (`@xyflow/react`) renderizaram com sucesso
- Diagramas possuem `aria-label` descritivos
- Tabs utilizam ARIA correto (`role="tablist"`, `role="tab"`, `role="tabpanel"`, `aria-selected`)
- Glossario com botoes expansiveis e `region` para cada definicao funciona corretamente
- Searchbox do glossario com label acessivel

---

## 5. Animacoes e Transicoes

Nenhum problema encontrado nesta categoria.

- Suporte a `prefers-reduced-motion: reduce` implementado em CSS (`src/styles/animations.css:70-85`) e JavaScript (`src/components/animations/ScrollReveal.astro:29`)
- CSS: todas as animacoes/transicoes sao reduzidas a `0.01ms` e aurora e desabilitada
- JS: GSAP/ScrollTrigger nao inicializa quando `prefers-reduced-motion` esta ativo; elementos ficam visiveis imediatamente
- Scroll suave via `scroll-behavior: smooth` e desabilitado para reduced motion
- Nenhum layout shift significativo observado durante scroll

---

## 6. Consistencia Visual

### Baixo
- [ ] **[V-001]** Terceiro StatCard (56%) sem fonte/atribuicao
  - **Localizacao:** Secao 02 — Agitacao, terceiro card de estatistica
  - **Impacto:** Os dois primeiros StatCards citam fontes ("Accenture" e "ScopeMaster"), mas o terceiro (56% das falhas por comunicacao) nao tem atribuicao, quebrando consistencia visual.
  - **Correcao sugerida:** Adicionar o atributo `source` ao terceiro StatCard com a fonte da estatistica.
  - **Arquivo:** `src/components/sections/AgitationSection.astro:26`

---

## 7. Performance

### Alto
- [ ] **[P-001]** Favicon retorna erro 404
  - **Localizacao:** `<link rel="icon" href="/favicon.svg" />` no `<head>`
  - **Impacto:** Console exibe erro `Failed to load resource: 404` para `https://tuyoshivinicius.github.io/favicon.svg`. O path nao inclui o base path `/zion-kit/` configurado em `astro.config.mjs`. O arquivo existe em `public/favicon.svg` mas e servido em `/zion-kit/favicon.svg`.
  - **Correcao sugerida:** Usar o helper do Astro para base path. Trocar `href="/favicon.svg"` por `href={`${import.meta.env.BASE_URL}favicon.svg`}` ou a diretiva de importacao do Astro.
  - **Arquivo:** `src/layouts/BaseLayout.astro:55`

### Medio
- [ ] **[P-002]** og:image referencia path e extensao incorretos
  - **Localizacao:** Meta tags Open Graph no `<head>`
  - **Impacto:** `<meta property="og:image" content="/og-image.png" />` tem dois problemas: (1) extensao `.png` mas arquivo real e `og-image.svg`, (2) path nao inclui base `/zion-kit/`. Previews de compartilhamento em redes sociais nao exibirão a imagem.
  - **Correcao sugerida:** Corrigir para URL absoluta com path e extensao corretos: `content="https://tuyoshivinicius.github.io/zion-kit/og-image.svg"` ou converter o SVG para PNG (preferivel para compatibilidade com redes sociais).
  - **Arquivo:** `src/layouts/BaseLayout.astro:36`

### Baixo
- [ ] **[P-003]** Formulario de newsletter sem backend conectado
  - **Localizacao:** Footer — formulario de newsletter
  - **Impacto:** O form tem `action="#"` — ao submeter, a pagina apenas recarrega sem feedback ao usuario. Nao ha endpoint real para coleta de emails.
  - **Correcao sugerida:** Conectar a um servico de newsletter (Mailchimp, ConvertKit, Resend, etc.) ou adicionar feedback visual de que a funcionalidade ainda nao esta disponivel.
  - **Arquivo:** `src/components/layout/Footer.astro:13`

---

## Checklist de Conformidade

| Criterio | Status | Notas |
|----------|--------|-------|
| lang="pt-BR" definido | ✅ | Correto em `<html lang="pt-BR">` |
| Skip link funcional | ✅ | "Pular para o conteudo" aponta para `#main-content`, foco correto |
| Hierarquia de headings correta | ✅ | h1 → h2 → h3 → h4, sem pulos de nivel |
| Navegacao por teclado | ⚠️ | Skip link e nav funcionam; diagramas nao sao navegaveis por teclado |
| Textos alt em imagens | ✅ | Nao ha elementos `<img>` HTML — diagramas usam SVG com aria-label |
| Contraste de cores adequado | ✅ | Tema escuro com texto claro; gradientes com contraste suficiente |
| Responsivo em 3 breakpoints | ✅ | Desktop, tablet e mobile sem overflow horizontal |
| Diagramas interativos funcionais | ✅ | Todos os 6 diagramas React renderizam corretamente |
| Progress bar funcional | ✅ | Atualiza conforme scroll |
| Sticky nav funcional | ✅ | Permanece visivel; adapta para hamburger em mobile/tablet |
| Animacoes respeitam prefers-reduced-motion | ✅ | Suporte em CSS e JavaScript |
| Links internos funcionais | ✅ | Todos os 10 links do nav levam as secoes corretas |

---

## Proximos Passos

### Correcoes Rapidas (< 30 min cada)
- **[P-001]** Corrigir path do favicon com base URL do Astro
- **[P-002]** Corrigir path e extensao do og:image
- **[V-001]** Adicionar fonte ao terceiro StatCard
- **[A-004]** Remover `role="contentinfo"` redundante do footer

### Correcoes Medias (30 min - 2h)
- **[A-001]** Corrigir focus ring no input da newsletter
- **[A-002]** Ajustar role do DiagramContainer de `img` para `figure`
- **[P-003]** Implementar feedback visual no formulario de newsletter

### Correcoes Complexas (> 2h)
- **[A-003]** Adicionar suporte a navegacao por teclado nos nodes dos diagramas React Flow
- **[I-001]** Otimizar carregamento de diagramas em tabs (pre-render ou skeleton)
- **[R-001]** Criar versoes simplificadas dos diagramas para mobile (opcional)
