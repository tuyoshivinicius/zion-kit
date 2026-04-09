# Plano de Implementação: {NOME_DO_PLANO}

<!-- ============================================================
     TEMPLATE DE PLANO DE IMPLEMENTAÇÃO PARA AUTOMAÇÃO COM CLAUDE CODE
     
     Como usar:
     1. Preencha os metadados abaixo
     2. Defina os épicos e tarefas seguindo a estrutura hierárquica
     3. Execute com: ./run-plan.ps1 -PlanFile ./meu-plano.md
     
     Convenções:
     - IDs seguem o formato: E{épico}.T{tarefa} (ex: E1.T2 = Épico 1, Tarefa 2)
     - Subtarefas: E{épico}.T{tarefa}.S{sub} (ex: E1.T2.S1)
     - Dependências referenciam IDs (ex: depends_on: E1.T1)
     - Status: pending | running | done | failed | skipped
     ============================================================ -->

## Metadados

```yaml
plan_name: "{NOME_DO_PLANO}"
objective: "{Descreva o objetivo principal em 1-2 frases}"
scope: "{O que está DENTRO e FORA do escopo}"
working_directory: "{Caminho absoluto do projeto}"
model: "sonnet"  # sonnet | opus | haiku
permission_mode: "bypassPermissions"  # default | acceptEdits | bypassPermissions
max_turns_per_task: 25
max_budget_per_task_usd: 1.00
created_at: "YYYY-MM-DD"
author: "{seu nome}"
```

## Pré-requisitos

<!-- Liste dependências externas que devem estar satisfeitas ANTES de iniciar a execução -->

- [ ] {Ferramenta/serviço X instalado e configurado}
- [ ] {Branch Y criada a partir de main}
- [ ] {Variáveis de ambiente configuradas}

---

## Épico 1 — {Nome do Épico}

> {Descrição breve do épico e seu objetivo dentro do plano}

### E1.T1 — {Nome da Tarefa}

```yaml
id: "E1.T1"
depends_on: []
status: "pending"
priority: "high"  # high | medium | low
```

**Prompt para o Claude Code:**

```
{Escreva aqui o prompt completo que será enviado ao Claude Code.
Seja específico: inclua caminhos de arquivo, padrões a seguir,
bibliotecas a usar, e o que NÃO fazer.

Exemplo:
"Crie o componente AlertBanner em src/components/AlertBanner.tsx.
Use Tailwind CSS para estilização. O componente deve aceitar props:
type (success | warning | error), message (string), onDismiss (callback).
Siga o padrão dos componentes existentes em src/components/.
NÃO adicione dependências externas."}
```

**Arquivos alvo:**

- `{caminho/do/arquivo-principal}`
- `{caminho/do/arquivo-de-teste}`

**Critérios de aceite:**

- [ ] {Critério verificável 1}
- [ ] {Critério verificável 2}
- [ ] {Critério verificável 3}

**Validação pós-execução:**

```bash
# Comando(s) que o orquestrador executa para validar a tarefa
# Retorno 0 = sucesso, qualquer outro = falha
{npm run typecheck}
{npm run test -- --run src/components/AlertBanner.test.tsx}
```

---

### E1.T2 — {Nome da Tarefa}

```yaml
id: "E1.T2"
depends_on: ["E1.T1"]
status: "pending"
priority: "medium"
```

**Prompt para o Claude Code:**

```
{Prompt completo}
```

**Arquivos alvo:**

- `{caminho/do/arquivo}`

**Critérios de aceite:**

- [ ] {Critério 1}
- [ ] {Critério 2}

**Validação pós-execução:**

```bash
{comando de validação}
```

---

## Épico 2 — {Nome do Épico}

> {Descrição}

### E2.T1 — {Nome da Tarefa}

```yaml
id: "E2.T1"
depends_on: ["E1.T2"]
status: "pending"
priority: "high"
```

**Prompt para o Claude Code:**

```
{Prompt completo}
```

**Arquivos alvo:**

- `{caminho}`

**Critérios de aceite:**

- [ ] {Critério}

**Validação pós-execução:**

```bash
{comando}
```

---

<!-- Repita a estrutura acima para quantos épicos e tarefas forem necessários -->

## Validação Final

<!-- Comandos executados APÓS todas as tarefas completarem com sucesso -->

```yaml
id: "FINAL"
depends_on: ["*"]  # depende de todas as tarefas
```

**Validação:**

```bash
# Build completo
{npm run build}

# Suite de testes completa
{npm run test}

# Lint
{npm run lint}
```

**Critérios de aceite globais:**

- [ ] Build passa sem erros
- [ ] Todos os testes passam
- [ ] Zero warnings de lint
- [ ] {Critério específico do plano}

---

## Notas de Execução

<!-- Preenchido automaticamente pelo script de execução -->

| Campo | Valor |
|-------|-------|
| Início | {timestamp} |
| Fim | {timestamp} |
| Tarefas executadas | {N/M} |
| Tarefas com falha | {lista de IDs} |
| Custo estimado | ${valor} |
