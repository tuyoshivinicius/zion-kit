# Análise de Metodologia: Task-Driven Development com Claude Code

## Pesquisa Realizada

Foram avaliadas as seguintes abordagens para decomposição e execução automatizada de tarefas com agentes de IA:

1. **Plan-and-Execute (LangChain/LangGraph)** — Padrão onde um planner gera um plano completo e um executor realiza cada etapa. Usado em frameworks de agentes como LangGraph. Vantagem: separação clara entre planejamento e execução. Desvantagem: acoplamento ao framework LangChain, overhead de infraestrutura.

2. **ReAct (Reasoning + Acting)** — O agente alterna entre raciocínio e ação a cada passo, ajustando o plano dinamicamente. Vantagem: adaptativo. Desvantagem: sem plano explícito persistente, difícil de auditar ou retomar.

3. **Tree of Thought** — Explora múltiplos caminhos de raciocínio em paralelo. Vantagem: ótimo para problemas com soluções ambíguas. Desvantagem: custo computacional alto, complexidade desnecessária para tarefas de engenharia bem definidas.

4. **SDLC Task Breakdown (Épico → Story → Subtask)** — Decomposição hierárquica clássica de engenharia de software (Agile/Scrum). Vantagem: universalmente compreendida, rastreável, compatível com qualquer ferramenta. Desvantagem: requer disciplina no preenchimento.

5. **Anthropic's Headless/Print Mode** — Documentação oficial do Claude Code para uso programático via `--print`, com `--allowedTools`, `--max-turns`, `--output-format json`. Projetado exatamente para automação em scripts.

## Metodologia Escolhida

**SDLC Task Breakdown + Plan-and-Execute com Claude Code Headless Mode.**

A combinação adotada funciona assim:

- **Planejamento**: Usa decomposição hierárquica SDLC (Épico → Tarefa → Subtarefa) para estruturar o trabalho. Cada tarefa contém um prompt autocontido, critérios de aceite verificáveis e dependências explícitas.

- **Execução**: Segue o padrão Plan-and-Execute — o plano é estático (documento Markdown), e a execução é sequencial via Claude Code CLI em `--print` mode. O script PowerShell atua como orquestrador (executor), processando cada tarefa na ordem definida pelo grafo de dependências.

- **Verificação**: Cada tarefa inclui um comando de validação pós-execução (testes, lint, type-check) que o orquestrador roda automaticamente.

## Justificativa

1. **Rastreabilidade**: O plano Markdown é legível, versionável (git), e auditável. Qualquer desenvolvedor entende a estrutura sem documentação adicional.

2. **Compatibilidade nativa**: Claude Code CLI já oferece `--print`, `--output-format json`, `--max-turns`, e `--allowedTools` — tudo que o padrão Plan-and-Execute precisa. Não há necessidade de frameworks externos.

3. **Resiliência**: Tarefas com IDs explícitos e checkpoints permitem retomar execução a partir de qualquer ponto. Cada tarefa é idempotente por design.

4. **Simplicidade operacional**: Um arquivo Markdown + um script PowerShell. Sem banco de dados, sem serviço web, sem dependências além do Claude Code CLI e PowerShell 7+.

5. **Precedente na indústria**: O padrão de orquestração por script com agente LLM headless é usado em produção por equipes que integram Claude Code em CI/CD (GitHub Actions, GitLab CI) conforme documentado pela Anthropic.

## Fontes

- Anthropic — [Claude Code CLI Reference: Headless Mode](https://docs.anthropic.com/en/docs/claude-code/cli-usage)
- Yao et al. (2023) — "ReAct: Synergizing Reasoning and Acting in Language Models"
- Wang et al. (2024) — "Plan-and-Execute Agents" (LangGraph documentation)
- Agile Alliance — Task Decomposition patterns em SDLC
