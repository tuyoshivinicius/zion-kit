---
name: qa-audit
description: Executa auditoria QA completa do site ZionKit usando Playwright MCP, testando acessibilidade, responsividade, navegacao, animacoes, interatividade e performance. Gera relatorio estruturado em docs/qa-report.md.
argument-hint: [--url <url>] [--focus <categoria>]
---

Voce e um especialista em QA e experiencia do usuario. Sua tarefa e executar uma auditoria completa do site ZionKit usando as ferramentas do Playwright MCP, identificar problemas e gerar um relatorio detalhado e acionavel.

## Argumentos

$ARGUMENTS

### Parse dos argumentos

- `--url` (opcional): URL do site a testar. Padrao: `https://tuyoshivinicius.github.io/zion-kit`
- `--focus` (opcional): Categoria unica para focar. Valores: `acessibilidade`, `responsividade`, `navegacao`, `interatividade`, `visual`, `performance`. Padrao: todas.

Se nenhum argumento foi fornecido, use os valores padrao.

---

## Pre-requisitos — Verificacao do Playwright MCP

Antes de iniciar os testes, verifique se as ferramentas do Playwright MCP estao disponiveis tentando usar `browser_navigate`. Se falhar:

```
❌ Erro: Playwright MCP nao esta disponivel.

Para configurar:
1. Verifique que .mcp.json existe na raiz do projeto com a config do playwright
2. Reinicie o Claude Code para carregar o MCP server
3. Se necessario, instale os browsers: npx playwright install chromium
```

---

## Protocolo de Testes

Execute os testes na ordem abaixo. Use `browser_snapshot` (accessibility tree) como ferramenta principal de analise e `browser_screenshot` para evidencias visuais. Aguarde 2-3 segundos apos navegacao e scroll para animacoes estabilizarem antes de capturar snapshots.

### Fase 1: Carga Inicial e Verificacoes Globais

1. Use `browser_navigate` para abrir a URL do site
2. Aguarde a pagina carregar completamente
3. Use `browser_snapshot` para capturar a arvore de acessibilidade completa
4. Use `browser_screenshot` para captura visual em desktop (1280x800)
5. Verifique:
   - Titulo da pagina presente e descritivo
   - Atributo `lang="pt-BR"` no HTML
   - Meta viewport configurada
   - Presenca do skip-link para pular navegacao
   - Elemento `<main>` com role apropriado

### Fase 2: Navegacao e Sticky Nav

1. Identifique todos os links da navegacao sticky no topo
2. Para cada link do nav:
   - Use `browser_click` no link
   - Use `browser_snapshot` para verificar se a secao correta esta visivel
3. Use `browser_scroll_down` varias vezes e verifique:
   - Progress bar atualiza conforme o scroll
   - Sticky nav permanece visivel e funcional
   - Depth filter e depth indicator estao presentes
4. Verifique que todos os links internos (href="#...") levam a secoes existentes

### Fase 3: Auditoria por Secao

O site tem 10 secoes principais. Para cada secao:

1. Navegue ate a secao (via nav ou scroll)
2. Use `browser_snapshot` para analisar a estrutura
3. Verifique:
   - **Hierarquia de headings**: h1 > h2 > h3, sem pulos de nivel
   - **ARIA landmarks**: roles e aria-labels apropriados
   - **Alt text**: todas as imagens tem texto alternativo descritivo
   - **Links**: nenhum href vazio, sem `javascript:void(0)`
   - **Conteudo renderizado**: sem containers vazios, sem texto "undefined" ou "null"
   - **Semantica HTML**: uso correto de article, section, nav, etc.

Secoes a testar:
- HeroSection (O Problema)
- AgitationSection (Agitacao)
- SolutionBridgeSection (Solucao)
- CycleOverviewSection (O Ciclo)
- PillarsSection (Pilares)
- RolesSection (Papeis)
- ComparisonSection (Antes/Depois)
- CanonDeepDiveSection (Product Canon)
- ScenariosSection (Cenarios)
- GlossarySection (Glossario)

### Fase 4: Elementos Interativos (Diagramas React)

O site usa 6 diagramas React com `@xyflow/react`. Para cada diagrama:

1. Navegue ate a secao que contem o diagrama
2. **Aguarde 3 segundos** para hydration do React completar
3. Use `browser_snapshot` para verificar se o diagrama renderizou (nao deve ser um div vazio)
4. Tente `browser_click` em nodes visiveis do diagrama
5. Verifique acessibilidade por teclado (Tab navigation)

Diagramas a testar:
- `CanonBuildingDiagram` — secao Product Canon
- `ContextualSpecDiagram` — secao Product Canon
- `ContextVoidDiagram` — secao O Problema
- `CycleDiagram` — secao O Ciclo
- `FeedbackDiagram` — secao O Ciclo
- `ThreeGapsDiagram` — secao Pilares

Arquivos fonte dos diagramas: `src/components/diagrams/`

### Fase 5: Responsividade

Teste em 3 breakpoints usando `browser_resize`:

1. **Desktop** (1280x800):
   - `browser_screenshot` da hero section
   - `browser_screenshot` de uma secao com diagrama
   - Verificar layout em grid funcional

2. **Tablet** (768x1024):
   - `browser_resize` para 768x1024
   - `browser_screenshot` da hero section
   - `browser_snapshot` da navegacao (verificar se adaptou)
   - Verificar que grids se ajustam

3. **Mobile** (375x812):
   - `browser_resize` para 375x812
   - `browser_screenshot` da hero section
   - `browser_snapshot` da navegacao
   - Verificar:
     - Sem overflow horizontal
     - Texto legivel (sem truncamento indevido)
     - Navegacao adaptada para mobile
     - Diagramas acessiveis ou com fallback

Ao final, restaure para 1280x800.

### Fase 6: Animacoes e Transicoes

1. Recarregue a pagina com `browser_navigate`
2. Faca scroll gradual com `browser_scroll_down` (3-5 vezes)
3. Entre cada scroll, use `browser_snapshot` para verificar:
   - Sem layout shifts significativos apos animacoes
   - Conteudo nao fica permanentemente oculto
   - Animacoes completam (elementos visíveis apos scroll)
4. Verifique se ha suporte a `prefers-reduced-motion` nos estilos
   - Isso requer verificar o codigo fonte: `src/styles/animations.css` e componentes em `src/components/animations/`

### Fase 7: Performance e Carregamento

1. Observe o tempo entre `browser_navigate` e o snapshot estar pronto
2. Verifique via `browser_snapshot`:
   - Imagens grandes sem `loading="lazy"`
   - Fontes que bloqueiam renderizacao
   - Scripts que bloqueiam renderizacao
3. Conte o total de elementos interativos na pagina
4. Identifique secoes que falharam ao renderizar (containers vazios)

### Fase 8: Acessibilidade Profunda

1. Teste o skip-link:
   - Use `browser_click` no skip-link
   - Verifique se o foco vai para o conteudo principal
2. Verifique no snapshot:
   - `role="main"` no elemento principal
   - `role="navigation"` e `aria-label` no nav
   - Todos os botoes e elementos interativos tem nomes acessiveis
   - Contraste de cores (inferir do snapshot quando possivel)
3. Teste navegacao por teclado:
   - Use `browser_press_key` com Tab para navegar entre elementos
   - Verifique que o foco e visivel e segue uma ordem logica
   - Verifique que diagramas interativos sao alcancaveis por teclado

---

## Geracao do Relatorio

Apos completar todos os testes, gere o relatorio em `docs/qa-report.md` usando a ferramenta Write com a seguinte estrutura:

```markdown
# Relatorio de Auditoria QA — ZionKit

**Data:** [data atual YYYY-MM-DD]
**URL testada:** [url]
**Viewports testados:** Desktop (1280x800), Tablet (768x1024), Mobile (375x812)

---

## Resumo Executivo

- **Total de problemas encontrados:** N
- **Criticos:** N | **Altos:** N | **Medios:** N | **Baixos:** N
- **Pontuacao geral:** X/10

---

## 1. Acessibilidade

### Critico
- [ ] **[A-001]** Descricao do problema
  - **Localizacao:** Componente/secao afetada
  - **Impacto:** Como isso afeta o usuario
  - **Correcao sugerida:** Instrucoes especificas de como corrigir
  - **Arquivo:** `src/components/...`

### Alto
(mesma estrutura)

### Medio
(mesma estrutura)

### Baixo
(mesma estrutura)

---

## 2. Responsividade
(mesma estrutura com IDs R-001, R-002, ...)

## 3. Navegacao e Links
(mesma estrutura com IDs N-001, N-002, ...)

## 4. Elementos Interativos (Diagramas)
(mesma estrutura com IDs I-001, I-002, ...)

## 5. Animacoes e Transicoes
(mesma estrutura com IDs T-001, T-002, ...)

## 6. Consistencia Visual
(mesma estrutura com IDs V-001, V-002, ...)

## 7. Performance
(mesma estrutura com IDs P-001, P-002, ...)

---

## Checklist de Conformidade

| Criterio | Status | Notas |
|----------|--------|-------|
| lang="pt-BR" definido | ✅/❌ | |
| Skip link funcional | ✅/❌ | |
| Hierarquia de headings correta | ✅/❌ | |
| Navegacao por teclado | ✅/❌ | |
| Textos alt em imagens | ✅/❌ | |
| Contraste de cores adequado | ✅/❌ | |
| Responsivo em 3 breakpoints | ✅/❌ | |
| Diagramas interativos funcionais | ✅/❌ | |
| Progress bar funcional | ✅/❌ | |
| Sticky nav funcional | ✅/❌ | |
| Animacoes respeitam prefers-reduced-motion | ✅/❌ | |
| Links internos funcionais | ✅/❌ | |

---

## Proximos Passos

### Correcoes Rapidas (< 30 min cada)
- Lista de issues de baixo esforco

### Correcoes Medias (30 min - 2h)
- Lista de issues de medio esforco

### Correcoes Complexas (> 2h)
- Lista de issues de alto esforco
```

### Regras do Relatorio

- Cada issue tem um **ID unico** (ex: A-001, R-002) para referencia em correcoes
- O campo **Arquivo** aponta para o arquivo fonte exato para facilitar correcao pelo Claude Code
- A **Correcao sugerida** deve ser especifica o suficiente para que o Claude Code possa implementar diretamente
- **Severidades**:
  - **Critico**: Quebra funcionalidade ou bloqueia usuarios
  - **Alto**: Degradacao significativa da experiencia
  - **Medio**: Perceptivel mas nao bloqueante
  - **Baixo**: Polimento/melhoria
- Use checkboxes `- [ ]` para tracking de correcoes
- Se uma categoria nao tem issues, escreva "Nenhum problema encontrado nesta categoria."
- Todo o conteudo do relatorio deve estar em **portugues**

---

## Guardrails

1. **Somente leitura**: Voce NAO deve modificar nenhum arquivo fonte do projeto durante a auditoria. Apenas leia e analise.
2. **Unica saida**: O unico arquivo que voce deve criar/escrever e `docs/qa-report.md`.
3. **Sem suposicoes**: Se nao conseguir verificar algo via Playwright, registre como "Nao verificado — requer inspecao manual" no relatorio.
4. **Evidencias**: Base cada issue em observacoes concretas dos snapshots e screenshots, nao em suposicoes.
5. **Idioma**: Todo output em portugues.
