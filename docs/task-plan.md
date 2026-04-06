# Plano de Tarefas — Site Institucional ZionKit

**Versão:** 1.0
**Data:** Abril 2026
**Documentos de referência:**
- [`docs/website-content-plan.md`](./website-content-plan.md) — Roteiro de conteúdo e narrativa
- [`docs/implementation-plan.md`](./implementation-plan.md) — Plano técnico de implementação

---

## Fase 1 — Inicialização do Projeto
**Pré-requisitos:** Nenhum
**Tipo:** Sequencial

### Tarefa 1.1 — Inicializar projeto Astro com TypeScript e React
- [ ] **Status:** Pendente
- **Descrição:** Criar o projeto Astro 5.x com TypeScript habilitado, instalar e configurar a integração React (`@astrojs/react`) e Tailwind CSS v4 (`@astrojs/tailwind`). Configurar a estrutura de diretórios conforme especificado.
- **Arquivos:**
  - `package.json`
  - `astro.config.mjs`
  - `tsconfig.json`
  - `src/pages/index.astro` (placeholder)
  - Criar diretórios: `src/components/ui/`, `src/components/sections/`, `src/components/diagrams/`, `src/components/animations/`, `src/components/layout/`, `src/layouts/`, `src/styles/`, `src/lib/diagrams/`, `src/lib/`, `src/assets/icons/`, `src/assets/images/`
- **Referência:** `docs/implementation-plan.md` Seção 2 (Stack Tecnológico, Estrutura de diretórios)
- **Dependências:** Nenhuma
- **Critérios de conclusão:**
  - `npm run dev` executa sem erros
  - TypeScript configurado e funcional
  - React integration instalada e configurável em componentes `.tsx`
  - Tailwind CSS v4 processando classes utilitárias
  - Estrutura de diretórios criada conforme especificação

---

## Fase 2 — Design System e Layout Base
**Pré-requisitos:** Fase 1 concluída
**Tipo:** Paralelo

### Tarefa 2.1 — Criar Design Tokens (Borealis Theme)
- [ ] **Status:** Pendente
- **Descrição:** Criar o arquivo de design tokens com todas as CSS custom properties do Borealis Theme: cores base, cores de texto, cores aurora (gradientes), cores semânticas, bordas, tipografia, espaçamento, raios de borda, sombras, transições, z-index e layout.
- **Arquivos:**
  - `src/styles/tokens.css`
- **Referência:** `docs/implementation-plan.md` Seção 4.1 (Design Tokens)
- **Dependências:** Tarefa 1.1
- **Critérios de conclusão:**
  - Todas as variáveis CSS definidas na Seção 4.1 estão presentes
  - Gradientes aurora (`--gradient-aurora`, `--gradient-aurora-soft`, `--gradient-text`, `--gradient-glow`) definidos
  - Cores semânticas (`--color-problem`, `--color-solution`, `--color-warning`, `--color-info`) definidas
  - Tokens de tipografia para Inter e JetBrains Mono configurados
  - Tokens de layout (`--max-width-content`, `--max-width-narrow`, `--max-width-diagram`) definidos

### Tarefa 2.2 — Criar estilos base e animações CSS
- [ ] **Status:** Pendente
- **Descrição:** Criar o CSS base (reset, tipografia, utilitários globais) e o arquivo de keyframes/classes de animação, incluindo a animação da aurora boreal e `prefers-reduced-motion`.
- **Arquivos:**
  - `src/styles/base.css`
  - `src/styles/animations.css`
- **Referência:** `docs/implementation-plan.md` Seção 4 (Design System), Seção 7.1 (Aurora Boreal), Seção 7.4 (Acessibilidade de Animações)
- **Dependências:** Tarefa 1.1
- **Critérios de conclusão:**
  - Reset CSS aplicado
  - Tipografia base configurada (Inter body, JetBrains Mono code)
  - Classes utilitárias globais (gradient-text, sr-only, etc.) definidas
  - Keyframes `aurora-drift` definidos conforme Seção 7.1
  - Classes `.aurora-bg`, `.aurora-bg::before`, `.aurora-bg::after` implementadas
  - Media query `prefers-reduced-motion: reduce` implementada conforme Seção 7.4

### Tarefa 2.3 — Criar BaseLayout com SEO e meta tags
- [ ] **Status:** Pendente
- **Descrição:** Criar o layout base Astro com todas as meta tags (Open Graph, Twitter Card, JSON-LD), preload de fontes, canonical URL e configuração de idioma `pt-BR`.
- **Arquivos:**
  - `src/layouts/BaseLayout.astro`
- **Referência:** `docs/implementation-plan.md` Seção 8.3 (SEO e Meta Tags)
- **Dependências:** Tarefa 1.1
- **Critérios de conclusão:**
  - `<html lang="pt-BR">` definido
  - Meta tags de título, descrição, Open Graph, Twitter Card presentes
  - JSON-LD `SoftwareApplication` incluído
  - Preload de fontes Inter e JetBrains Mono configurado
  - Canonical URL definida
  - Slots para conteúdo da página funcional
  - Importa `tokens.css`, `base.css` e `animations.css`

---

## Fase 3 — Componentes de Layout e UI Base
**Pré-requisitos:** Fase 2 concluída
**Tipo:** Paralelo

### Tarefa 3.1 — Criar componente AuroraBackground
- [ ] **Status:** Pendente
- **Descrição:** Implementar o background animado com efeito aurora boreal usando CSS puro (gradientes radiais animados). Deve ser fixo, com opacidade baixa, e simplificado em mobile.
- **Arquivos:**
  - `src/components/animations/AuroraBackground.astro`
- **Referência:** `docs/implementation-plan.md` Seção 5 (Seção 1 — HeroSection), Seção 7.1 (Aurora Boreal)
- **Dependências:** Tarefa 2.2
- **Critérios de conclusão:**
  - Componente renderiza gradientes radiais animados
  - `position: fixed`, `z-index: var(--z-background)`, `pointer-events: none`
  - Dois pseudo-elementos com gradientes verde e violeta
  - Animação `aurora-drift` com ciclo de 60s/45s
  - Mobile: simplificado para 1 gradiente
  - `prefers-reduced-motion`: aurora estática

### Tarefa 3.2 — Criar componente StickyNav
- [ ] **Status:** Pendente
- **Descrição:** Implementar a navegação fixa com links para as 10 seções e indicador de seção ativa via IntersectionObserver.
- **Arquivos:**
  - `src/components/layout/StickyNav.astro`
- **Referência:** `docs/implementation-plan.md` Seção 3 (Componentes compartilhados — StickyNav), Seção 7.3 (Micro-interações — Navbar active section)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - Navegação fixa no topo com links para as 10 seções
  - IntersectionObserver detecta seção ativa e destaca no nav
  - Scroll suave ao clicar nos links
  - Responsivo (menu colapsável em mobile)
  - Acessível via teclado

### Tarefa 3.3 — Criar componente ProgressBar
- [ ] **Status:** Pendente
- **Descrição:** Implementar barra de progresso de leitura que mostra a porcentagem de scroll da página.
- **Arquivos:**
  - `src/components/layout/ProgressBar.astro`
- **Referência:** `docs/implementation-plan.md` Seção 3 (Componentes compartilhados — ProgressBar), Seção 7.3 (Micro-interações — Progress bar)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - Barra horizontal no topo da página (abaixo ou dentro do nav)
  - Largura proporcional ao scroll (0% no topo, 100% no final)
  - Visual com gradiente aurora
  - Performance: usa `requestAnimationFrame` ou scroll event throttled

### Tarefa 3.4 — Criar componente SectionHeader
- [ ] **Status:** Pendente
- **Descrição:** Implementar o header reutilizável para todas as seções, com título, subtítulo, badge de camada de profundidade (1/2/3) e número da seção.
- **Arquivos:**
  - `src/components/ui/SectionHeader.astro`
- **Referência:** `docs/implementation-plan.md` Seção 4.2 (Componentes Base — SectionHeader)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - Props: `title`, `subtitle` (opcional), `depth` (1|2|3), `sectionNumber`
  - Título: `text-5xl` mobile → `text-6xl` desktop, `font-bold`, `tracking-tight`
  - Palavras-chave com `gradient-text`
  - Badge de camada: pill com borda `--color-border-accent`
  - Número da seção: `text-sm`, `tracking-wide`, `text-muted`, com linha horizontal

### Tarefa 3.5 — Criar componentes UI reutilizáveis (ExampleBlock, StatCard, ComparisonRow, GlossaryItem)
- [ ] **Status:** Pendente
- **Descrição:** Implementar os 4 componentes UI reutilizáveis: blocos de exemplo prático, cards de estatísticas, linhas de comparação antes/depois, e itens de glossário com expand/collapse.
- **Arquivos:**
  - `src/components/ui/ExampleBlock.astro`
  - `src/components/ui/StatCard.astro`
  - `src/components/ui/ComparisonRow.astro`
  - `src/components/ui/GlossaryItem.astro`
- **Referência:** `docs/implementation-plan.md` Seção 4.2 (Componentes Base — ExampleBlock, StatCard, ComparisonRow, GlossaryItem)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - **ExampleBlock:** Fundo `--color-bg-tertiary`, borda esquerda ciano 3px, ícone de aspas, texto italic
  - **StatCard:** Número grande `text-4xl` com gradiente aurora, descrição `text-sm`, hover com `shadow-glow-cyan`
  - **ComparisonRow:** Duas colunas com ícones `✗` (vermelho) e `✓` (verde), separador central, hover destaca a row
  - **GlossaryItem:** Termo em `font-mono` e `text-accent`, expand/collapse com animação de height+opacity, badge "Analogia" + texto italic

### Tarefa 3.6 — Criar componentes ScrollReveal e DiagramContainer
- [ ] **Status:** Pendente
- **Descrição:** Implementar o wrapper de animação scroll-triggered (GSAP + ScrollTrigger) e o container padronizado para diagramas.
- **Arquivos:**
  - `src/components/animations/ScrollReveal.astro`
  - `src/components/ui/DiagramContainer.astro`
- **Referência:** `docs/implementation-plan.md` Seção 7.2 (Scroll-Triggered Animations), Seção 3 (Componentes compartilhados — DiagramContainer)
- **Dependências:** Tarefa 2.1, Tarefa 2.2
- **Critérios de conclusão:**
  - **ScrollReveal:** Props `animation` (fade-up, fade-in, slide-left, slide-right, scale-in, stagger, counter, draw-line) e `delay`
  - GSAP importado via dynamic import; ScrollTrigger com `start: "top 80%"`, `once: true`
  - Respeita `prefers-reduced-motion` (verifica em JS antes de inicializar GSAP)
  - **DiagramContainer:** Container com `max-width: var(--max-width-diagram)`, fundo e bordas padronizados, `aria-label` para acessibilidade

---

## Fase 4 — Página Principal e Seções Estáticas
**Pré-requisitos:** Fase 3 concluída
**Tipo:** Paralelo

### Tarefa 4.1 — Montar página index.astro com todas as seções
- [ ] **Status:** Pendente
- **Descrição:** Criar a página principal que importa o BaseLayout, AuroraBackground, StickyNav, ProgressBar e todas as seções na ordem do roteiro (1 a 10). Configurar alternância de fundos entre seções.
- **Arquivos:**
  - `src/pages/index.astro`
- **Referência:** `docs/implementation-plan.md` Seção 3 (Arquitetura de Componentes), Seção 4.3 (Variantes de Seção)
- **Dependências:** Tarefas 3.1, 3.2, 3.3, 2.3
- **Critérios de conclusão:**
  - Layout base aplicado com AuroraBackground, StickyNav e ProgressBar
  - Slots/placeholders para as 10 seções na ordem correta
  - Alternância de fundo: seções ímpares (1,3,5,7,9) com `--color-bg-primary` + aurora glow, seções pares (2,4,6,8,10) com `--color-bg-secondary`
  - Skip link "Pular para o conteúdo" como primeiro elemento do DOM
  - `content-visibility: auto` em seções abaixo do fold

### Tarefa 4.2 — Implementar Seção 1 — HeroSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de abertura (hero) com o título "O conhecimento do seu produto morre a cada sprint", texto narrativo do problema, exemplo prático do reembolso e seta de scroll.
- **Arquivos:**
  - `src/components/sections/HeroSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 1 (O Problema); `docs/implementation-plan.md` Seção 5 (Seção 1 — O Problema)
- **Dependências:** Tarefas 3.4, 3.5 (ExampleBlock), 3.6 (ScrollReveal)
- **Critérios de conclusão:**
  - Full viewport height
  - Título com palavras-chave em `gradient-text`
  - Texto narrativo com `max-width-narrow`
  - Exemplo prático do reembolso em ExampleBlock
  - Seta indicativa de scroll no bottom
  - Animações: título fade-in + slide-up (GSAP, 0.8s), texto stagger (0.15s)
  - Placeholder para Diagrama 1 (será integrado na Fase 6)

### Tarefa 4.3 — Implementar Seção 3 — SolutionBridgeSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de transição (ponte PAS → Progressive Disclosure) com o título "E se todo o conhecimento do seu produto tivesse uma casa?", texto centralizado e analogia da constituição.
- **Arquivos:**
  - `src/components/sections/SolutionBridgeSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 3 (A Solução em Uma Frase); `docs/implementation-plan.md` Seção 5 (Seção 3)
- **Dependências:** Tarefas 3.4, 3.5 (ExampleBlock), 3.6 (ScrollReveal)
- **Critérios de conclusão:**
  - Seção curta ("respiro narrativo")
  - Título grande centralizado
  - 2-3 parágrafos, `max-width-narrow`, centralizado
  - "Product Canon" com badge e glow pulse (CSS `@keyframes`, 3s cycle)
  - Analogia da constituição em ExampleBlock diferenciado (ícone de analogia)
  - Animações: título fade-in + scale (0.98→1)

### Tarefa 4.4 — Implementar Seção 7 — ComparisonSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de comparação antes/depois com 7 linhas de comparação usando ComparisonRow, layout de duas colunas com headers "SEM ZionKit" (vermelho) e "COM ZionKit" (verde).
- **Arquivos:**
  - `src/components/sections/ComparisonSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 7 (Antes e Depois); `docs/implementation-plan.md` Seção 5 (Seção 7)
- **Dependências:** Tarefas 3.4, 3.5 (ComparisonRow), 3.6 (ScrollReveal)
- **Critérios de conclusão:**
  - Layout de duas colunas com headers coloridos
  - 7 ComparisonRows com os itens do roteiro
  - Separador central com gradiente aurora
  - Mobile: stack vertical, cada item mostra antes→depois
  - Animações: rows com reveal alternado, ícones com bounce, linha central com draw animation
  - Placeholder para Diagrama 8 (será implementado como HTML/CSS nesta mesma tarefa — não precisa de React Flow)

### Tarefa 4.5 — Implementar Seção 8 — CanonDeepDiveSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de deep dive na Product Canon com duas colunas: Camada de Negócio (4 artefatos) e Camada de Arquitetura (5 artefatos). Badge "Camada 3".
- **Arquivos:**
  - `src/components/sections/CanonDeepDiveSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 8 (O Que É a Product Canon); `docs/implementation-plan.md` Seção 5 (Seção 8)
- **Dependências:** Tarefas 3.4, 3.6 (ScrollReveal)
- **Critérios de conclusão:**
  - Badge "Camada 3" no SectionHeader
  - Duas colunas: esquerda "Camada de Negócio" (borda `--color-aurora-green`), direita "Camada de Arquitetura" (borda `--color-aurora-violet`)
  - Cada artefato em card compacto com nome + descrição 1-2 linhas
  - Camada de Negócio: Glossário de linguagem ubíqua, Regras de negócio, Requisitos formalizados, Fluxos de domínio
  - Camada de Arquitetura: Princípios técnicos, Bounded contexts, Eventos de domínio, Context maps, ADRs
  - Nota de rodapé sobre versionamento em Git
  - Animações: colunas com slide-in simultâneo, cards com stagger (150ms)

### Tarefa 4.6 — Implementar Seção 10 — GlossarySection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção do glossário com 15 termos expansíveis (GlossaryItem), busca/filtro no topo e âncoras por item.
- **Arquivos:**
  - `src/components/sections/GlossarySection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 10 (Glossário Acessível); `docs/implementation-plan.md` Seção 5 (Seção 10)
- **Dependências:** Tarefas 3.4, 3.5 (GlossaryItem)
- **Critérios de conclusão:**
  - 15 termos do roteiro implementados (Product Canon, Canon Building, Canonical Change Plan, Domain Builder, Architect, Domain Expert, Bounded Context, Linguagem Ubíqua, Event Storming, SBVR, SBE, ADR, Strangler Fig, Guardrails de Conformidade, Injeção Seletiva de Contexto, Retroalimentação)
  - Cada termo com definição + analogia, inicialmente colapsado
  - Campo de busca/filtro no topo (JavaScript vanilla)
  - Âncoras (hash links) para referência direta
  - Animações: expand/collapse com height transition (300ms) + opacity, filtragem com fade

---

## Fase 5 — Diagramas React Flow e Componente Base
**Pré-requisitos:** Fase 3 concluída (Tarefa 3.6 — DiagramContainer)
**Tipo:** Sequencial para 5.1, depois Paralelo para 5.2–5.7

### Tarefa 5.1 — Instalar React Flow e criar componente NodeCard
- [ ] **Status:** Pendente
- **Descrição:** Instalar `@xyflow/react`, criar o componente de nó customizado `NodeCard` com 5 variantes visuais (default, problem, solution, gate, canon), e configurar os estilos padrão compartilhados de todos os diagramas React Flow.
- **Arquivos:**
  - `src/components/diagrams/NodeCard.tsx`
  - `src/lib/diagrams/shared-config.ts` (configurações compartilhadas: fitView, zoom, pan, estilos de edge)
- **Referência:** `docs/implementation-plan.md` Seção 6 (Estratégia de Diagramas — Nós customizados, Configuração padrão React Flow)
- **Dependências:** Tarefa 1.1 (React integration)
- **Critérios de conclusão:**
  - `@xyflow/react` instalado
  - `NodeCard` implementa interface `NodeCardData` com `title`, `content`, `variant`, `icon`
  - 5 variantes visuais com cores corretas: default, problem (`--color-problem`), solution (`--color-solution`), gate (`--color-warning`), canon (`--color-aurora-cyan` + glow)
  - Configuração compartilhada: `fitView` habilitado, zoom desabilitado mobile / habilitado desktop, pan desabilitado, edge estilo `smoothstep`
  - Edge styling: `--color-aurora-cyan` com opacidade 0.5, `stroke-dasharray` para animação

### Tarefa 5.2 — Implementar Diagrama 1 — "O Vazio de Contexto"
- [ ] **Status:** Pendente
- **Descrição:** Criar o diagrama que mostra o fluxo atual de desenvolvimento com o "vazio" entre conhecimento disperso e código gerado. Fluxo com "quebra" visual entre nós.
- **Arquivos:**
  - `src/lib/diagrams/context-void-diagram.ts` (dados de nós e edges)
  - `src/components/diagrams/ContextVoidDiagram.tsx`
- **Referência:** `docs/website-content-plan.md` Seção 1 (Diagrama 1 — "O Vazio de Contexto"); `docs/implementation-plan.md` Seção 6 (D1)
- **Dependências:** Tarefa 5.1
- **Critérios de conclusão:**
  - 3 nós: "Conhecimento do produto" (disperso), "Especificação" (sem contexto), "Código gerado" (decisões silenciosas)
  - Nó final leva a "Bugs de lógica de negócio"
  - Seta entre conhecimento e especificação visualmente "quebrada"
  - Variante `problem` nos nós de bug
  - `client:visible` para hydration

### Tarefa 5.3 — Implementar Diagrama 2 — "Os Três Gaps"
- [ ] **Status:** Pendente
- **Descrição:** Criar o diagrama com três colunas paralelas representando os três gaps: IA sem contexto, Negócio excluído, Conhecimento descartável.
- **Arquivos:**
  - `src/lib/diagrams/three-gaps-diagram.ts`
  - `src/components/diagrams/ThreeGapsDiagram.tsx`
- **Referência:** `docs/website-content-plan.md` Seção 2 (Diagrama 2 — "Os Três Gaps"); `docs/implementation-plan.md` Seção 6 (D2)
- **Dependências:** Tarefa 5.1
- **Critérios de conclusão:**
  - 3 nós paralelos com conteúdo rico
  - Cada nó com variante `problem` e ícone vermelho
  - Comunicação visual de problemas distintos mas conectados

### Tarefa 5.4 — Implementar Diagrama 3 — "O Ciclo ZionKit"
- [ ] **Status:** Pendente
- **Descrição:** Criar o diagrama central mostrando o ciclo de 3 etapas com Product Canon no centro. Edges animados mostrando bidirecionalidade.
- **Arquivos:**
  - `src/lib/diagrams/cycle-diagram.ts`
  - `src/components/diagrams/CycleDiagram.tsx`
- **Referência:** `docs/website-content-plan.md` Seção 4 (Diagrama 3 — "O Ciclo ZionKit"); `docs/implementation-plan.md` Seção 6 (D3, incluindo exemplo de dados)
- **Dependências:** Tarefa 5.1
- **Critérios de conclusão:**
  - 4 nós: Product Canon (variante `canon`, central), Construir, Usar, Devolver
  - Edges animados (`animated: true`) entre Canon→Construir e Devolver→Canon
  - Labels nos edges: "contexto injetado", "descobertas"
  - Caráter cíclico e bidirecional visualmente claro

### Tarefa 5.5 — Implementar Diagramas 4, 5 e 6 (Três Pilares)
- [ ] **Status:** Pendente
- **Descrição:** Criar os 3 diagramas da Seção 5: Diagrama 4 (As Três Sessões — fluxo sequencial com gates), Diagrama 5 (Especificação Contextualizada — fluxo top-down), Diagrama 6 (Retroalimentação — fluxo + árvore de versionamento).
- **Arquivos:**
  - `src/lib/diagrams/canon-building-diagram.ts`
  - `src/components/diagrams/CanonBuildingDiagram.tsx`
  - `src/lib/diagrams/contextual-spec-diagram.ts`
  - `src/components/diagrams/ContextualSpecDiagram.tsx`
  - `src/lib/diagrams/feedback-diagram.ts`
  - `src/components/diagrams/FeedbackDiagram.tsx`
- **Referência:** `docs/website-content-plan.md` Seção 5 (Diagramas 4, 5 e 6); `docs/implementation-plan.md` Seção 5 (Seção 5) e Seção 6 (D4, D5, D6)
- **Dependências:** Tarefa 5.1
- **Critérios de conclusão:**
  - **D4:** 3 nós de sessão (Descoberta, Constituição, Especificação) + 3 nós de gate (variante `gate`, cor `--color-warning`) conectados linearmente. Participantes indicados em cada sessão.
  - **D5:** Fluxo top-down: Product Canon → Especificação (com checklist visual: vocabulário, regras, decisões) → Plano de Mudanças Incremental. Nós com conteúdo rico.
  - **D6:** Parte A em React Flow (implementação → descobertas → Canon atualizada). Parte B em HTML (árvore de versionamento: versão vigente vs. em transição).

### Tarefa 5.6 — Implementar Diagrama 7 — "Papéis por Etapa" (Tabela HTML)
- [ ] **Status:** Pendente
- **Descrição:** Criar a tabela interativa de papéis por etapa. Não usa React Flow — é uma tabela HTML estilizada com hover por célula e linha.
- **Arquivos:**
  - `src/components/diagrams/RolesMatrixDiagram.astro` (ou `.tsx` se interatividade for necessária)
- **Referência:** `docs/website-content-plan.md` Seção 6 (Diagrama 7 — "Quem Faz O Quê em Cada Etapa"); `docs/implementation-plan.md` Seção 5 (Seção 6) e Seção 6 (D7)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - Tabela com 4 linhas (Domain Builder, Architect, Domain Expert, IA) × 3 colunas (Construir, Especificar, Retroalimentar)
  - Conteúdo de cada célula conforme roteiro
  - Hover destaca a linha inteira do papel
  - Células com ícone de ação
  - Responsivo em mobile

### Tarefa 5.7 — Implementar Diagrama 8 — "Antes/Depois" (HTML/CSS)
- [ ] **Status:** Pendente
- **Descrição:** Criar o diagrama visual de comparação antes/depois. Não usa React Flow — é HTML/CSS puro.
- **Arquivos:**
  - `src/components/diagrams/BeforeAfterDiagram.astro`
- **Referência:** `docs/website-content-plan.md` Seção 7 (Diagrama 8 — "Antes / Depois"); `docs/implementation-plan.md` Seção 5 (Seção 7) e Seção 6 (D8)
- **Dependências:** Tarefa 2.1
- **Critérios de conclusão:**
  - Duas colunas lado a lado com ícones contrastantes (vermelho/verde)
  - 6 linhas de comparação conforme roteiro
  - Ícones visuais diferenciando problemas e soluções

---

## Fase 6 — Seções com Diagramas Integrados
**Pré-requisitos:** Fases 4 e 5 concluídas
**Tipo:** Paralelo

### Tarefa 6.1 — Implementar Seção 2 — AgitationSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de agitação com os 3 problemas, StatCards com dados de apoio, exemplos práticos e integração dos Diagramas 2 (ThreeGapsDiagram).
- **Arquivos:**
  - `src/components/sections/AgitationSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 2 (A Agitação); `docs/implementation-plan.md` Seção 5 (Seção 2)
- **Dependências:** Tarefas 3.4, 3.5, 3.6, 5.3
- **Critérios de conclusão:**
  - 3 StatCards no topo: "35% defeitos", "40% retrabalho", "56% falha comunicação"
  - Grid de 3 colunas para os problemas (stack em mobile)
  - Exemplos do PO e notificações em ExampleBlock
  - Diagrama 2 integrado via DiagramContainer
  - Animações: StatCards com counter animation, cards com stagger, diagrama com scale-in

### Tarefa 6.2 — Implementar Seção 4 — CycleOverviewSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de visão geral do ciclo com Diagrama 3 como peça central e 3 cards descrevendo cada etapa. Badge "Camada 1".
- **Arquivos:**
  - `src/components/sections/CycleOverviewSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 4 (Como Funciona: Visão Geral); `docs/implementation-plan.md` Seção 5 (Seção 4)
- **Dependências:** Tarefas 3.4, 3.6, 5.4
- **Critérios de conclusão:**
  - Badge "Camada 1" no SectionHeader
  - Diagrama 3 (CycleDiagram) como peça central
  - 3 cards lado a lado abaixo: Construir, Usar, Devolver — cada um com ícone, título e resumo
  - Animações: nós aparecem sequencialmente, edges com dash-offset animado, cards com stagger

### Tarefa 6.3 — Implementar Seção 5 — PillarsSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção dos três pilares com navegação interna (tabs ou accordion), integrando Diagramas 4, 5 e 6, e múltiplos exemplos práticos. Badge "Camada 2".
- **Arquivos:**
  - `src/components/sections/PillarsSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 5 (Os Três Pilares em Detalhe); `docs/implementation-plan.md` Seção 5 (Seção 5)
- **Dependências:** Tarefas 3.4, 3.5 (ExampleBlock), 3.6, 5.5
- **Critérios de conclusão:**
  - Badge "Camada 2" no SectionHeader
  - 3 sub-seções com navegação interna (tabs ou accordion)
  - **Sub-seção 5.1** (Canon Building): texto + exemplo fintech + Diagrama 4
  - **Sub-seção 5.2** (Especificação Contextualizada): texto + exemplo saúde + Diagrama 5
  - **Sub-seção 5.3** (Retroalimentação): texto + exemplo Faturamento + Diagrama 6
  - Gates de aprovação explicados
  - Transição entre tabs: crossfade (300ms)
  - Mobile: accordion em vez de tabs

### Tarefa 6.4 — Implementar Seção 6 — RolesSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de papéis com 4 cards (Domain Builder, Architect, Domain Expert, IA) e integração do Diagrama 7 (tabela de papéis por etapa).
- **Arquivos:**
  - `src/components/sections/RolesSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 6 (Quem Faz O Quê); `docs/implementation-plan.md` Seção 5 (Seção 6)
- **Dependências:** Tarefas 3.4, 3.6, 5.6
- **Critérios de conclusão:**
  - 4 cards em grid (2×2 desktop, stack mobile): ícone, nome, "quem é", "o que faz", analogia em italic
  - Diagrama 7 (RolesMatrixDiagram) integrado abaixo dos cards
  - Animações: cards com stagger diagonal, tabela com fade-in por linha

### Tarefa 6.5 — Implementar Seção 9 — ScenariosSection
- [ ] **Status:** Pendente
- **Descrição:** Implementar a seção de cenários de aplicação com 3 tabs (Greenfield, Brownfield, Mudança Grande), cada um com timeline visual de passos numerados.
- **Arquivos:**
  - `src/components/sections/ScenariosSection.astro`
- **Referência:** `docs/website-content-plan.md` Seção 9 (Cenários de Aplicação); `docs/implementation-plan.md` Seção 5 (Seção 9)
- **Dependências:** Tarefas 3.4, 3.5 (ExampleBlock), 3.6
- **Critérios de conclusão:**
  - 3 tabs horizontais: "Produto Novo", "Produto Existente", "Mudança Grande"
  - Cada tab: título, contexto, passos numerados com timeline visual (linha vertical + dots)
  - Conteúdo de cada cenário conforme roteiro (Seção 9)
  - Mobile: accordion em vez de tabs
  - Animações: crossfade entre tabs (250ms), dots com stagger (200ms)

### Tarefa 6.6 — Integrar Diagrama 1 na HeroSection
- [ ] **Status:** Pendente
- **Descrição:** Integrar o Diagrama 1 (ContextVoidDiagram) na HeroSection criada na Fase 4, posicionado abaixo do texto e revelado com scroll.
- **Arquivos:**
  - `src/components/sections/HeroSection.astro` (modificar)
- **Referência:** `docs/implementation-plan.md` Seção 5 (Seção 1 — Diagrama 1)
- **Dependências:** Tarefas 4.2, 5.2
- **Critérios de conclusão:**
  - Diagrama 1 renderizado em DiagramContainer abaixo do texto narrativo
  - `client:visible` para hydration
  - Animação: reveal on scroll com ScrollTrigger

---

## Fase 7 — Animações Avançadas e Polish
**Pré-requisitos:** Fase 6 concluída
**Tipo:** Paralelo

### Tarefa 7.1 — Aplicar ScrollReveal em todas as seções
- [ ] **Status:** Pendente
- **Descrição:** Revisar todas as 10 seções e garantir que todos os elementos (títulos, textos, cards, blocos) têm ScrollReveal aplicado com as animações corretas conforme especificação.
- **Arquivos:**
  - Todos os arquivos em `src/components/sections/` (modificar)
- **Referência:** `docs/implementation-plan.md` Seção 7.2 (Scroll-Triggered Animations), Seção 5 (animações por seção)
- **Dependências:** Todas as tarefas da Fase 6
- **Critérios de conclusão:**
  - Cada seção tem animações scroll-triggered conforme especificadas na Seção 5 do plano técnico
  - Stagger aplicado em listas e grids
  - Counter animation nos StatCards da Seção 2
  - Todos os diagramas com reveal on scroll

### Tarefa 7.2 — Implementar animações de edges nos diagramas React Flow
- [ ] **Status:** Pendente
- **Descrição:** Adicionar animação de fluxo (dash-offset animado) em todos os edges dos diagramas React Flow, e pulse animation nos gates do Diagrama 4.
- **Arquivos:**
  - CSS: `src/styles/animations.css` (adicionar keyframes de edge)
  - Componentes de diagramas em `src/components/diagrams/` (modificar se necessário)
- **Referência:** `docs/implementation-plan.md` Seção 6 (edge styling com `stroke-dasharray`), Seção 7.3 (Diagrama edges)
- **Dependências:** Tarefas 5.2–5.5
- **Critérios de conclusão:**
  - Edges com `stroke-dasharray` e `stroke-dashoffset` animados via CSS
  - Gates no Diagrama 4 com pulse animation ao entrar em viewport
  - Animação respeitando `prefers-reduced-motion`

### Tarefa 7.3 — Implementar intensificação da aurora por seção
- [ ] **Status:** Pendente
- **Descrição:** Usar ScrollTrigger para intensificar sutilmente o efeito aurora nas Seções 3 e 4, conforme especificado.
- **Arquivos:**
  - `src/components/animations/AuroraBackground.astro` (modificar)
- **Referência:** `docs/implementation-plan.md` Seção 7.1 (Aurora — "Intensifica levemente na Seção 3 e Seção 4 via ScrollTrigger")
- **Dependências:** Tarefas 3.1, 3.6
- **Critérios de conclusão:**
  - Opacidade da aurora aumenta ao scrollar para Seções 3 e 4
  - Transição suave via ScrollTrigger
  - Volta ao normal ao sair dessas seções

### Tarefa 7.4 — Implementar DepthIndicator
- [ ] **Status:** Pendente
- **Descrição:** Criar o indicador de camada de profundidade (Camada 1/2/3) que mostra qual camada do Progressive Disclosure o leitor está visualizando no momento.
- **Arquivos:**
  - `src/components/layout/DepthIndicator.astro`
  - `src/pages/index.astro` (modificar para incluir)
- **Referência:** `docs/implementation-plan.md` Seção 3 (Componentes compartilhados — DepthIndicator)
- **Dependências:** Tarefa 3.2 (StickyNav)
- **Critérios de conclusão:**
  - Indicador visível no nav mostrando camada atual (1, 2 ou 3)
  - Atualiza dinamicamente conforme scroll (Seções 1-4,7: Camada 1; Seções 5-6: Camada 2; Seção 8: Camada 3)

---

## Fase 8 — Melhorias Documentadas
**Pré-requisitos:** Fase 7 concluída
**Tipo:** Paralelo

### Tarefa 8.1 — Implementar navegação por camadas de profundidade
- [ ] **Status:** Pendente
- **Descrição:** Criar o sistema de filtro visual no header com 3 opções (Essencial, Detalhado, Técnico) que controla quais seções são visíveis. Seções ocultas são colapsadas com indicador, não removidas do DOM.
- **Arquivos:**
  - `src/components/layout/DepthFilter.astro` (ou `.tsx`)
  - `src/components/layout/StickyNav.astro` (modificar para incluir toggle)
  - `src/pages/index.astro` (modificar para suportar collapso de seções)
- **Referência:** `docs/implementation-plan.md` Seção 9.1 (Navegação por Camadas de Profundidade); `docs/website-content-plan.md` Notas de Implementação, item 2
- **Dependências:** Todas as seções implementadas (Fases 4 e 6)
- **Critérios de conclusão:**
  - Toggle persistente no header com 3 opções
  - **Essencial (Camada 1):** Seções 1-4, 7, 9, 10 visíveis (~5 min leitura)
  - **Detalhado (Camada 2):** Adiciona Seções 5, 6 (~12 min leitura)
  - **Técnico (Camada 3):** Tudo visível (~20 min leitura)
  - Seções ocultas colapsadas com "Expandir para mais detalhes"
  - Não remove do DOM (SEO e acessibilidade preservados)
  - Estado persiste durante a sessão

### Tarefa 8.2 — Implementar tooltips nos diagramas React Flow
- [ ] **Status:** Pendente
- **Descrição:** Adicionar tooltips contextuais nos nós dos diagramas React Flow que exibem informações adicionais ao hover (exemplos, analogias, dados do roteiro).
- **Arquivos:**
  - `src/components/diagrams/NodeCard.tsx` (modificar para suportar tooltip)
  - `src/lib/diagrams/*.ts` (adicionar dados de tooltip nos nós)
- **Referência:** `docs/implementation-plan.md` Seção 9.2 (Diagramas com Tooltips Contextuais)
- **Dependências:** Tarefa 5.1 e todos os diagramas (5.2–5.5)
- **Critérios de conclusão:**
  - `onMouseEnter` em nós exibe tooltip posicionado
  - Exemplo: hover sobre "Etapa 1 — Construir" no Diagrama 3 mostra "3 sessões guiadas por IA: Descoberta, Constituição Técnica e Especificação"
  - Tooltip com fundo `--color-bg-elevated`
  - Mobile: tooltip via tap (toggle)
  - Acessível (aria-describedby)

### Tarefa 8.3 — Implementar indicador de tempo de leitura
- [ ] **Status:** Pendente
- **Descrição:** Adicionar badge de tempo de leitura estimado no SectionHeader, calculado em build time com base no word count (~200 palavras/minuto).
- **Arquivos:**
  - `src/components/ui/SectionHeader.astro` (modificar para incluir badge de tempo)
- **Referência:** `docs/implementation-plan.md` Seção 9.3 (Indicador de Tempo de Leitura por Seção)
- **Dependências:** Tarefa 3.4
- **Critérios de conclusão:**
  - Badge "~N min" ao lado do badge de camada no SectionHeader
  - Cálculo: `Math.ceil(wordCount / 200)`
  - Estilo discreto, não compete visualmente com título

### Tarefa 8.4 — Implementar animação de enriquecimento da Product Canon
- [ ] **Status:** Pendente
- **Descrição:** Criar ícone fixo no canto inferior direito que pulsa e incrementa um counter quando o usuário scrollar por seções de retroalimentação (Seções 4 e 5.3).
- **Arquivos:**
  - `src/components/animations/CanonEnrichment.astro` (ou `.tsx`)
  - `src/pages/index.astro` (modificar para incluir)
- **Referência:** `docs/implementation-plan.md` Seção 9.4 (Animação de "Enriquecimento" na Product Canon)
- **Dependências:** Tarefa 3.6 (ScrollReveal/GSAP)
- **Critérios de conclusão:**
  - Ícone fixo discreto no canto inferior direito
  - ScrollTrigger em Seções 4 e 5.3: ícone pulsa e exibe "+1"
  - Counter visual incrementa conforme o usuário avança
  - Não obstrui conteúdo
  - Respeitando `prefers-reduced-motion`

### Tarefa 8.5 — Implementar CTAs estratégicos
- [ ] **Status:** Pendente
- **Descrição:** Adicionar calls-to-action nos pontos estratégicos: após Seção 4 (link para GitHub/documentação), ao final da Seção 9 (formulário/link de early access) e newsletter no footer.
- **Arquivos:**
  - `src/components/ui/CTABanner.astro` (novo componente)
  - `src/components/sections/CycleOverviewSection.astro` (modificar para incluir CTA)
  - `src/components/sections/ScenariosSection.astro` (modificar para incluir CTA)
  - `src/components/layout/Footer.astro` (novo — incluir newsletter)
- **Referência:** `docs/implementation-plan.md` Seção 9.5 (CTA Estratégico)
- **Dependências:** Tarefas 6.2, 6.5
- **Critérios de conclusão:**
  - CTA após Seção 4: "Quer saber como implementar?" com link
  - CTA após Seção 9: "Experimente com seu produto" com link/formulário
  - Footer com campo de email para newsletter
  - CTAs estilizados com gradiente aurora e hover glow

---

## Fase 9 — Qualidade, Acessibilidade e Deploy
**Pré-requisitos:** Fase 8 concluída
**Tipo:** Paralelo (9.1–9.4), depois Sequencial (9.5)

### Tarefa 9.1 — Testar e corrigir acessibilidade (WCAG 2.1 AA)
- [ ] **Status:** Pendente
- **Descrição:** Auditar o site com axe-core e Lighthouse para acessibilidade. Verificar contraste, estrutura semântica, landmarks, navegação por teclado, diagramas com `aria-label`, e skip link.
- **Arquivos:**
  - Todos os componentes (corrigir conforme necessário)
- **Referência:** `docs/implementation-plan.md` Seção 8.2 (Acessibilidade)
- **Dependências:** Todas as tarefas anteriores
- **Critérios de conclusão:**
  - Score Lighthouse acessibilidade >= 95
  - Todos os pares de cor passam WCAG 2.1 AA (4.5:1 texto, 3:1 UI)
  - Headings hierárquicos (h1→h2→h3) corretos
  - Landmarks (`banner`, `main`, `navigation`, `contentinfo`) presentes
  - Skip link funcional
  - Todos os interativos acessíveis via Tab/Enter/Escape
  - Diagramas com `aria-label` descritivo
  - `:focus-visible` com outline `--color-aurora-cyan`

### Tarefa 9.2 — Otimizar Core Web Vitals
- [ ] **Status:** Pendente
- **Descrição:** Auditar e otimizar performance com Lighthouse. Garantir metas de LCP < 2.5s, CLS < 0.1, INP < 200ms. Verificar hydration seletiva, lazy loading e code splitting.
- **Arquivos:**
  - Componentes e configurações (ajustar conforme necessário)
- **Referência:** `docs/implementation-plan.md` Seção 8.1 (Performance)
- **Dependências:** Todas as tarefas anteriores
- **Critérios de conclusão:**
  - LCP < 2.5s, CLS < 0.1, INP < 200ms em Lighthouse
  - Todos os diagramas React Flow com `client:visible`
  - GSAP com `client:idle` ou dynamic import
  - `content-visibility: auto` em seções abaixo do fold
  - Fontes com `font-display: swap` e preload
  - Zero JS em seções sem interatividade

### Tarefa 9.3 — Testar responsividade
- [ ] **Status:** Pendente
- **Descrição:** Testar e corrigir o layout em 4 breakpoints: 320px (mobile pequeno), 768px (tablet), 1024px (desktop), 1440px (desktop grande). Verificar empilhamento de grids, tabs→accordion, e diagramas em telas pequenas.
- **Arquivos:**
  - Todos os componentes (corrigir conforme necessário)
- **Referência:** `docs/implementation-plan.md` Seção 5 (notas de mobile em cada seção)
- **Dependências:** Todas as tarefas anteriores
- **Critérios de conclusão:**
  - Grids de 2-3 colunas empilham em mobile
  - Tabs viram accordion em mobile (Seções 5 e 9)
  - ComparisonSection: stack vertical em mobile
  - Diagramas React Flow: zoom desabilitado em mobile
  - Aurora simplificada em mobile (1 gradiente)
  - Textos legíveis e espaçamento adequado em todos os breakpoints

### Tarefa 9.4 — Gerar OG image e configurar sitemap
- [ ] **Status:** Pendente
- **Descrição:** Criar a imagem Open Graph (1200×630) para compartilhamento social e configurar `@astrojs/sitemap` para geração automática.
- **Arquivos:**
  - `src/assets/images/og-image.png` (criar)
  - `astro.config.mjs` (adicionar `@astrojs/sitemap`)
- **Referência:** `docs/implementation-plan.md` Seção 8.3 (SEO)
- **Dependências:** Tarefa 1.1
- **Critérios de conclusão:**
  - OG image 1200×630 com branding ZionKit e Borealis Theme
  - Sitemap gerado automaticamente via `@astrojs/sitemap`
  - Referenciado corretamente nas meta tags

### Tarefa 9.5 — Configurar deploy Vercel
- [ ] **Status:** Pendente
- **Descrição:** Configurar o deploy na Vercel com SSG, domínio e analytics.
- **Arquivos:**
  - `vercel.json` (se necessário)
  - `astro.config.mjs` (ajustar output e adapter se necessário)
- **Referência:** `docs/implementation-plan.md` Seção 2 (Vercel), Seção 10 (Deploy)
- **Dependências:** Tarefas 9.1, 9.2, 9.3, 9.4
- **Critérios de conclusão:**
  - Build SSG funcional (`npm run build` sem erros)
  - Deploy na Vercel funcionando
  - CDN servindo assets estáticos
  - Domínio configurado (se disponível)

---

## Resumo

### Totais
- **Fases:** 9
- **Tarefas:** 37
- **Tarefas paralelas por fase:**
  - Fase 1: 1 tarefa (sequencial)
  - Fase 2: 3 tarefas (paralelas)
  - Fase 3: 6 tarefas (paralelas)
  - Fase 4: 6 tarefas (paralelas)
  - Fase 5: 7 tarefas (5.1 sequencial, depois 5.2–5.7 paralelas)
  - Fase 6: 6 tarefas (paralelas)
  - Fase 7: 4 tarefas (paralelas)
  - Fase 8: 5 tarefas (paralelas)
  - Fase 9: 5 tarefas (9.1–9.4 paralelas, 9.5 sequencial)

### Grafo de Dependências entre Fases

```
Fase 1 (Inicialização)
  │
  ▼
Fase 2 (Design System + Layout Base)
  │
  ├────────────────────────────┐
  ▼                            ▼
Fase 3 (Componentes UI)    Fase 5.1 (React Flow + NodeCard)
  │                            │
  ├──────────────┐             ▼
  ▼              ▼         Fase 5.2–5.7 (Diagramas)
Fase 4          Fase 5.6–5.7      │
(Seções         (D7, D8           │
 Estáticas)     HTML/CSS)         │
  │              │                │
  └──────┬───────┘────────────────┘
         ▼
Fase 6 (Seções com Diagramas)
         │
         ▼
Fase 7 (Animações Avançadas)
         │
         ▼
Fase 8 (Melhorias)
         │
         ▼
Fase 9 (Qualidade + Deploy)
```

### Caminho Crítico
`Fase 1 → Fase 2 → Fase 3 → Fase 5.1 → Fase 5.2–5.5 → Fase 6 → Fase 7 → Fase 8 → Fase 9`

---

*Plano de tarefas gerado para o site institucional do ZionKit. Versão 1.0 — Abril 2026.*
