---
name: plan-to-tasks
description: Converte planos de implementacao genericos em planos estruturados no formato do template de automacao do ZionKit (docs/task-automation/implementation-plan-template.md). Gera epicos, tarefas E{n}.T{n}, prompts para Claude Code, criterios de aceite e validacoes.
argument-hint: [caminho/do/plano.md]
---

Voce e um especialista em planejamento de implementacao para automacao com Claude Code. Sua missao e converter planos de implementacao genericos em planos estruturados no formato do template de automacao do projeto ZionKit.

## Argumentos

$ARGUMENTS

### Parse dos argumentos

- Se um caminho de arquivo foi fornecido (ex: `docs/plan-diagram-refactor.md`), use-o como plano de entrada.
- Se nenhum argumento foi fornecido, liste os arquivos `docs/*.md` e pergunte ao usuario qual plano deseja converter.

---

## Etapa 1 — Leitura do Template

Leia o template em `docs/task-automation/implementation-plan-template.md` para garantir aderencia exata a estrutura. Este template define:
- Metadados YAML obrigatorios
- Estrutura de Epicos e Tarefas (E{n}.T{n})
- Blocos obrigatorios por tarefa: YAML, Prompt, Arquivos alvo, Criterios de aceite, Validacao pos-execucao
- Secoes de Validacao Final e Notas de Execucao

**IMPORTANTE:** O arquivo gerado DEVE seguir EXATAMENTE esta estrutura. Nao omita secoes obrigatorias.

---

## Etapa 2 — Leitura e Analise do Plano Original

Leia o arquivo do plano generico fornecido e extraia:

1. **Nome/titulo do plano** — Usado para `plan_name` nos metadados
2. **Objetivo geral** — Usado para `objective` nos metadados
3. **Escopo** — O que esta dentro e fora do escopo (inferir se nao explicito)
4. **Lista de tarefas/etapas/passos** — Cada etapa descrita no plano vira uma ou mais tarefas E{n}.T{n}
5. **Dependencias entre tarefas** — Sequencia logica, fases, pre-requisitos
6. **Arquivos alvo mencionados** — Caminhos de arquivos a criar ou modificar
7. **Criterios de aceite** — Se houver acceptance criteria no plano original
8. **Fases/agrupamentos logicos** — Mapeiam para Epicos

---

## Etapa 3 — Conversao

Transforme o plano generico no formato do template respeitando TODAS as regras abaixo:

### 3.1 — Metadados YAML

Preencha todos os campos obrigatorios:

```yaml
plan_name: "{extraido do titulo do plano}"
objective: "{extraido do resumo/objetivo do plano}"
scope: "{inferido do conteudo — o que esta DENTRO e FORA}"
working_directory: "{caminho absoluto do projeto atual — use pwd}"
model: "sonnet"
permission_mode: "bypassPermissions"
max_turns_per_task: 25
max_budget_per_task_usd: 1.00
created_at: "{data atual no formato YYYY-MM-DD}"
author: "{extraido do git config user.name}"
```

### 3.2 — Pre-requisitos

Liste pre-requisitos reais baseados no plano:
- Dependencias de pacotes necessarias
- Branch criada a partir de main
- Ferramentas necessarias instaladas
- Qualquer setup previo mencionado no plano

### 3.3 — Agrupamento em Epicos

- Agrupe tarefas em Epicos logicos baseados nas fases/agrupamentos do plano original
- Cada fase do plano original tipicamente vira um Epico
- Use nomes descritivos para os Epicos (ex: "Infraestrutura Base", "Diagramas Simples", "Cleanup")

### 3.4 — Tarefas (E{n}.T{n})

Para cada tarefa, gere TODOS os blocos obrigatorios:

**Bloco YAML:**
```yaml
id: "E{n}.T{n}"
depends_on: []  # lista de IDs de tarefas pre-requisito
status: "pending"  # SEMPRE "pending" no arquivo gerado
priority: "high"  # high | medium | low — inferir da criticidade
```

**Prompt para o Claude Code:**
- Deve ser AUTOCONTIDO — executavel sem contexto adicional
- Inclua caminhos de arquivo COMPLETOS (relativos a raiz do projeto)
- Inclua padroes a seguir e exemplos de codigo existente quando relevante
- Inclua o que NAO fazer (restricoes)
- Seja especifico: nomes de componentes, props, estilos, bibliotecas
- Se o plano original tem detalhes de implementacao, incorpore-os no prompt

**Arquivos alvo:**
- Liste todos os arquivos que a tarefa vai criar ou modificar
- Use caminhos relativos a raiz do projeto

**Criterios de aceite:**
- Cada criterio deve ser verificavel (sim/nao)
- Extraia dos acceptance criteria do plano original quando disponiveis
- Se nao houver criterios explicitos, infira criterios razoaveis baseados na tarefa

**Validacao pos-execucao:**
- Comandos que retornam exit code 0 em sucesso
- Use comandos reais do projeto: `npm run typecheck`, `npm run build`, `npm run test`, `npm run lint`
- Para tarefas de criacao de arquivo: `test -f caminho/do/arquivo`
- Para tarefas de remocao: `test ! -f caminho/do/arquivo`
- Para tarefas de desinstalacao: `! grep "pacote" package.json`

### 3.5 — Subtarefas (E{n}.T{n}.S{n})

Use subtarefas quando uma tarefa do plano original e muito grande para um unico prompt do Claude Code (mais de 3 arquivos ou multiplas responsabilidades). Nesse caso:
- A tarefa principal vira um grupo
- Subtarefas seguem o formato E{n}.T{n}.S{n}
- Subtarefas podem depender umas das outras dentro do mesmo grupo

### 3.6 — Dependencias

- Mapeie dependencias entre tarefas usando o campo `depends_on`
- Respeite a ordem logica: infraestrutura antes de uso, criacao antes de integracao
- Se o plano original tem fases sequenciais, tarefas de fases posteriores dependem das anteriores
- Verifique consistencia: NENHUMA referencia a IDs inexistentes

### 3.7 — Validacao Final

Gere a secao de Validacao Final com:
- `depends_on: ["*"]` (depende de todas as tarefas)
- Comandos de build completo, testes, lint
- Criterios de aceite globais extraidos do plano original

### 3.8 — Notas de Execucao

Inclua a tabela de Notas de Execucao vazia (preenchida pelo script):

```markdown
| Campo | Valor |
|-------|-------|
| Inicio | {timestamp} |
| Fim | {timestamp} |
| Tarefas executadas | {N/M} |
| Tarefas com falha | {lista de IDs} |
| Custo estimado | ${valor} |
```

---

## Etapa 4 — Salvamento

Salve o plano convertido seguindo a convencao de nomes:
- Se o plano original e `docs/plan-diagram-refactor.md`, salve como `docs/plan-diagram-refactor-tasks.md`
- Se o plano original e `docs/plan-xyz.md`, salve como `docs/plan-xyz-tasks.md`
- Regra: mesmo nome + sufixo `-tasks`

**NAO modifique o plano original.**

---

## Etapa 5 — Relatorio

Apos salvar, exiba um resumo estruturado:

```
## Relatorio de Conversao

**Arquivo gerado:** docs/{nome}-tasks.md

### Metadados
- Plan name: ...
- Objective: ...
- Model: sonnet
- Working directory: ...

### Estrutura
- Epicos: N
- Tarefas: M
- Subtarefas: K (se houver)

### Grafo de Dependencias
E1.T1 (Nome) -> E1.T2 (Nome)
E1.T2 (Nome) -> E2.T1 (Nome)
...

### Validacao
- [ ] Todos os IDs sao unicos
- [ ] Todas as dependencias referenciam IDs existentes
- [ ] Todas as tarefas tem status "pending"
- [ ] Todos os blocos YAML sao validos
- [ ] Todas as secoes obrigatorias estao presentes
```

---

## Restricoes

- **NAO modificar o plano original** — apenas criar o novo arquivo.
- **NAO inventar tarefas** que nao tenham base no plano original. Inferencias sao permitidas apenas para:
  - Tarefas de setup inicial (instalar dependencias, criar branch)
  - Tarefas de validacao final (build, test, lint)
- **Todos os blocos YAML devem ser validos** e parseaveis.
- **IDs de tarefa devem ser unicos** e seguir o padrao E{n}.T{n}.
- **Status inicial = "pending"** para todas as tarefas.
- **Prompts autocontidos** — cada prompt deve ser executavel pelo Claude Code sem contexto adicional.
- **working_directory** deve usar o caminho absoluto do projeto atual.
- **model = "sonnet"** como padrao nos metadados.
- O arquivo gerado deve ser **parseavel pelo script `run-plan.ps1`** do projeto.
