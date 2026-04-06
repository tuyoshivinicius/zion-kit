# Tarefas — Plano de Alteração ZionKit v0.4 → v0.5

**Gerado em:** 2026-04-06
**Plano de origem:** `docs/plano-alteracao-v04.md`
**Documento-alvo:** `docs/zionkit-model-v0.4.md`
**Diagrama de referência:** `docs/canon-building.md`

---

## Fase 1 — Fundações (tarefas paralelizáveis)

As três tarefas desta fase não possuem dependências entre si e podem ser executadas em paralelo.

---

### TASK-001: Incrementar versão e data no cabeçalho do documento

- **Status:** [ ]
- **Bloco do plano:** 2.0
- **Dependências:** Nenhuma
- **Decisões aplicadas:** —
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, nas linhas 3–4 do cabeçalho:
  - Substituir `**Versão do documento**: 0.4 — Abril 2026` por `**Versão do documento**: 0.5 — Abril 2026`
  - Na última linha do documento (linha 501), substituir `*ZionKit — Versão 0.4 do modelo conceitual. Documento gerado como registro de insights para prototipação futura.*` atualizando para versão 0.5.
  - **Justificativa:** Reflete a incorporação do Canon Building como evolução do modelo.
- **Critério de conclusão:** O documento exibe versão 0.5 no cabeçalho e no rodapé. Nenhuma outra referência a "0.4" como versão do documento permanece.

---

### TASK-002: Renomear seção 2.1 — "A Golden Source Semântica" para "A Product Canon"

- **Status:** [ ]
- **Bloco do plano:** 2.3
- **Dependências:** Nenhuma
- **Decisões aplicadas:** D1, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.1 (linhas 50–69):
  1. **Renomear** o título `### 2.1 A Golden Source Semântica` → `### 2.1 A Product Canon (Cânone de Produto)`
  2. **Substituir** toda ocorrência de "golden source" por "Product Canon" no corpo da seção (linhas 52, 48, 69). Há ~5 ocorrências nesta seção.
  3. **Substituir** na Camada de Negócio (linha 58): `Requisitos de negócio (SRS)` → `Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example)`. Remover referência a "documentos SRS" como artefato nomeado.
  4. **Adicionar**, após o último parágrafo da seção (linha 69, que diz "É um artefato vivo..."), a seguinte frase: "A Product Canon é um artefato versionado que evolui a cada ciclo de Canon Building (Construção do Cânone)."
  5. **Preservar** a divisão em Camada de Negócio e Camada de Arquitetura e todos os itens listados em ambas as camadas.
  6. **Adicionar** nota ao final da seção: "A organização física/interna da Product Canon é deliberadamente mínima nesta fase de prototipação, sem compromisso com hierarquia final (ver seção 5 — Estrutura de Artefatos)."
  - **Justificativa:** Mudança de identidade central do modelo. A Product Canon substitui a Golden Source com semântica mais rica. Ref: análise 3.1, A1.
  - **Nota sobre D10:** A glosa em português "(Cânone de Produto)" deve aparecer apenas nesta primeira ocorrência de "Product Canon" no documento. Nas ocorrências subsequentes, usar apenas "Product Canon" sem glosa.
- **Critério de conclusão:** O título da seção é "A Product Canon (Cânone de Produto)". Não há ocorrências de "golden source" na seção. "SRS" não aparece como artefato nomeado. A nota sobre estrutura mínima (D1) está presente. A glosa em português aparece exatamente uma vez (no título).

---

### TASK-003: Atualizar terminologia na seção 1 — Problema (1.1, 1.2, 1.3)

- **Status:** [ ]
- **Bloco do plano:** 2.2
- **Dependências:** Nenhuma
- **Decisões aplicadas:** D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seções 1.1 a 1.3 (linhas 20–41):
  1. **Seção 1.1** (linhas 22–27): Substituir "golden source" por "Product Canon" nas duas ocorrências do conceito. Uma está no parágrafo principal (linha 24, "Não há mecanismo formal..."), e a outra pode ser indireta. A seção descreve o problema, não a solução — a referência é indireta.
  2. **Seção 1.2** (linhas 29–34): Substituir "Usuários de negócio" / "usuário de negócio" por "Domain Builder (Construtor de Domínio)" na primeira ocorrência, e "Domain Builder" nas seguintes. Manter a descrição do perfil ("product owners, analistas de produto, gestores de operações") pois agora é incorporada à definição do papel. Na linha 30, "O usuário de negócio" → "O Domain Builder". Na linha 31, "ou o usuário de negócio" → "ou o Domain Builder".
  3. **Seção 1.3** (linhas 36–41): Sem alteração significativa. Verificar que "corpo de conhecimento do produto" não precisa ser substituído (alinha-se naturalmente com Product Canon).
  - **Justificativa:** A seção de problema é estável — descreve dores, não soluções. Apenas terminologia precisa ser harmonizada.
  - **Nota sobre D10:** Se "Product Canon" já recebeu glosa na seção 2.1 (TASK-002) e a seção 1 vem antes da seção 2.1 no documento, a primeira ocorrência real de "Product Canon" no documento será na seção 1. Nesse caso, a glosa "(Cânone de Produto — fonte central de verdade)" deve ser colocada na **primeira** ocorrência de "Product Canon" na seção 1.1, e removida do título da seção 2.1 (que manteria apenas "A Product Canon"). Verificar a ordem final do documento para determinar onde fica a primeira ocorrência.
- **Critério de conclusão:** Nenhuma ocorrência de "golden source", "usuário de negócio" ou "usuários de negócio" permanece nas seções 1.1 a 1.3. Os termos foram substituídos por "Product Canon" e "Domain Builder" com glosas em português na primeira ocorrência de cada termo no documento.

---

## Fase 2 — Etapa 1 / Canon Building (sequencial)

As tarefas desta fase possuem dependências sequenciais internas. TASK-004 depende da Fase 1 (especificamente TASK-002). As subsequentes são sequenciais entre si. TASK-009 (Guardrails) depende apenas de TASK-002 e pode ser paralelizada com TASK-004 a TASK-008.

---

### TASK-004: Reescrever cabeçalho e introdução da Etapa 1 (seção 2.2)

- **Status:** [ ]
- **Bloco do plano:** 2.4.1
- **Dependências:** TASK-002
- **Decisões aplicadas:** D3, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2 (linhas 71–73):
  1. **Renomear** título: `### 2.2 Etapa 1 — Construção e Manutenção da Golden Source` → `### 2.2 Etapa 1 — Canon Building (Construção e Manutenção da Product Canon)`
  2. **Substituir** no parágrafo introdutório (linhas 72–73):
     - "O usuário de negócio" → "O Domain Builder"
     - "o arquiteto" → "o Architect"
     - "golden source" → "Product Canon"
     - "duas pipelines" → "três cerimônias formais"
  3. **Reescrever** o parágrafo introdutório para refletir o fluxo sequencial com gates:
     - Domain Discovery Session → (Canonical Change Plan aprovado) → Technical Constitution Session → (Canonical Change Plan aprovado) → Requirements Specification Session → (Canonical Change Plan aprovado) → Decisão de Continuidade do Ciclo
     - Referência: diagrama em `docs/canon-building.md` (linhas 35–57)
  4. **Adicionar** descrição do modelo de aprovação por afinidade (D3): "Cada Canonical Change Plan (Plano de Mudança Canônico) requer aprovação primária pelo papel com expertise na cerimônia correspondente, e aprovação secundária assíncrona com janela de veto pelo outro papel humano."
  - **Justificativa:** O Canon Building reformula completamente a Etapa 1. Ref: análise C4, F1.
- **Critério de conclusão:** O título da seção é "Etapa 1 — Canon Building (Construção e Manutenção da Product Canon)". O parágrafo introdutório descreve o fluxo sequencial de três cerimônias com gates. O modelo de aprovação por afinidade (D3) está descrito. Não há referência a "pipelines", "golden source", "usuário de negócio" ou "arquiteto" (em português, como nome de papel).

---

### TASK-005: Transformar seção 2.2.1 — Pipeline de Event Storming em Domain Discovery Session

- **Status:** [ ]
- **Bloco do plano:** 2.4.2
- **Dependências:** TASK-004
- **Decisões aplicadas:** D2, D3, D5, D6, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2.1 (linhas 75–88):
  1. **Renomear** título: `#### 2.2.1 Pipeline de Event Storming Conversacional` → `#### 2.2.1 Domain Discovery Session (Sessão de Descoberta de Domínio)`
  2. **Substituir** linguagem de "pipeline com fases" → "cerimônia conversacional" no parágrafo introdutório (linhas 77–78).
  3. **Preservar** as 4 fases do Event Storming (linhas 80–84) conforme D5 — manter fases explícitas para Domain Discovery:
     - Descoberta de eventos de domínio
     - Identificação de comandos e atores
     - Mapeamento de agregados e bounded contexts
     - Decomposição de casos de uso
  4. **Modificar** a saída (implícita na fase 4, linhas 83–84): de "artefatos escritos na golden source" → "Canonical Change Plan tipado como `discovery-plan`" (D2).
  5. **Adicionar** parágrafo após as 4 fases: "O Canonical Change Plan produzido requer aprovação primária do Domain Expert (Especialista de Domínio) — que valida a fidelidade semântica ao domínio — e aprovação secundária do Architect — que valida a viabilidade técnica, incluindo a validação de bounded contexts e context map (D6). Somente após a aprovação a próxima cerimônia (Technical Constitution Session) é habilitada."
  6. **Preservar** os dois exemplos (linhas 86–88):
     - Exemplo "perspectiva do usuário de negócio" → renomear para "perspectiva do Domain Builder". Substituir "golden source" → "Product Canon".
     - Exemplo "perspectiva do arquiteto" → renomear para "perspectiva do Architect". Substituir "golden source" → "Product Canon".
  7. **Remover** a referência na fase 3 (linha 83) a "conforme detalhado na seção 2.2.4" — a validação técnica agora é parte do gate de aprovação.
  - **Justificativa:** Reframing de "pipeline" para "cerimônia" com saída formal e governança. Ref: análise 3.2, C1.
- **Critério de conclusão:** Título é "Domain Discovery Session (Sessão de Descoberta de Domínio)". As 4 fases do Event Storming estão preservadas. A saída é um Canonical Change Plan `discovery-plan`. O gate de aprovação (Domain Expert primário, Architect secundário) está descrito. Os dois exemplos estão preservados com terminologia atualizada. Não há referências a "pipeline", "golden source", "usuário de negócio", "arquiteto" (como papel) ou "seção 2.2.4".

---

### TASK-006: Substituir Pipeline MARE por Technical Constitution Session (seção 2.2.2)

- **Status:** [ ]
- **Bloco do plano:** 2.4.3
- **Dependências:** TASK-005
- **Decisões aplicadas:** D2, D3, D5, D6, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2.2 (linhas 90–101):
  1. **Remover** toda a seção 2.2.2 (Pipeline MARE) — linhas 90 a 101.
  2. **Criar** nova seção no mesmo local: `#### 2.2.2 Technical Constitution Session (Sessão de Constituição Técnica)`
  3. A nova seção deve conter:
     - Cerimônia conduzida pelo Architect (Arquiteto)
     - Foco: princípios técnicos constitucionais e ADRs estratégicos (D6 — escopo focado em princípios, não em todas as atividades de arquitetura)
     - Sem fases rígidas — apenas diretrizes de condução (D5). Diferente da Domain Discovery, que mantém fases explícitas.
     - Saída: Canonical Change Plan tipado como `constitution-plan` (D2)
     - Aprovação primária pelo Architect, aprovação secundária pelo Domain Expert (D3 — inversão de afinidade em relação à Domain Discovery)
     - Habilitada pela aprovação do Canonical Change Plan de Domain Discovery (sequência do fluxo)
     - Habilita a Requirements Specification Session (próxima cerimônia na sequência)
  4. **Mover** o exemplo de princípios técnicos constitucionais que está na seção 2.2.4 (linhas 119–149 do v0.4) para esta nova seção, como exemplo de saída da cerimônia. O bloco de código com `PRINCÍPIOS TÉCNICOS CONSTITUCIONAIS` deve ser preservado integralmente, incluindo as seções STACK, COMUNICAÇÃO ENTRE CONTEXTOS, PERSISTÊNCIA, SEGURANÇA e OBSERVABILIDADE.
  5. **Adicionar** parágrafo contextualizador do exemplo, indicando que esses princípios são o tipo de artefato produzido pela Technical Constitution Session.
  6. **Preservar** o parágrafo explicativo após o bloco de código (linhas 151–152) que compara princípios técnicos ao glossário de linguagem ubíqua, atualizando terminologia.
  - **Justificativa:** A MARE é eliminada e substituída pela Technical Constitution Session, que ocupa essa posição na sequência. Ref: análise 3.3, 3.4, C2, C3.
  - **Referência para conceitos:** `docs/canon-building.md`, linhas 79 (definição da Technical Constitution Session) e 11 (nó no diagrama).
- **Critério de conclusão:** A seção "Pipeline MARE" não existe mais. Em seu lugar há "Technical Constitution Session (Sessão de Constituição Técnica)" com descrição completa. O exemplo de princípios técnicos constitucionais (bloco de código) está presente nesta seção. A cerimônia é descrita como conduzida pelo Architect, com aprovação primária do Architect e secundária do Domain Expert. A saída é um `constitution-plan`. Não há referência a "MARE", "SRS", "multi-agente" ou "pipeline".

---

### TASK-007: Substituir seção "Combinação das Pipelines" por Requirements Specification Session (seção 2.2.3)

- **Status:** [ ]
- **Bloco do plano:** 2.4.4
- **Dependências:** TASK-006
- **Decisões aplicadas:** D2, D3, D4, D5, D6, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2.3 (linhas 103–107):
  1. **Remover** toda a seção 2.2.3 (Combinação das Pipelines) — linhas 103 a 107.
  2. **Criar** nova seção: `#### 2.2.3 Requirements Specification Session (Sessão de Especificação de Requisitos)`
  3. A nova seção deve conter:
     - Cerimônia conversacional de formalização semântica usando SBVR + SBE
     - O Domain Builder descreve requisitos em linguagem natural; a IA traduz para SBVR controlado e apresenta para validação do Domain Builder (D4 — SBVR mediado pela IA, autoria conversacional)
     - Sem fases rígidas — diretrizes de condução (D5)
     - Saída: Canonical Change Plan tipado como `specification-plan` (D2), contendo regras de negócio em SBVR e critérios de aceitação em SBE
     - Aprovação primária pelo Domain Expert, aprovação secundária pelo Architect (D3). Na aprovação secundária, o Architect realiza avaliação técnica de requisitos (D6)
     - Habilitada pela aprovação do Canonical Change Plan de Technical Constitution (sequência do fluxo)
     - Habilita a Decisão de Continuidade do Ciclo
  4. **Adicionar** exemplo ilustrativo de como funciona a mediação SBVR: o Domain Builder fala "O cliente deve poder cancelar um pedido antes do faturamento", e a IA traduz para SBVR controlado, apresenta a formalização e o Domain Builder valida. Pode reutilizar/adaptar o exemplo da antiga seção MARE (linhas 100–101).
  - **Justificativa:** A Requirements Specification Session substitui a MARE com ancoragem em padrões reconhecidos (SBVR + SBE). Ref: análise 3.3, C2.
  - **Referência para conceitos:** `docs/canon-building.md`, linhas 81 (definição da Requirements Specification Session).
- **Critério de conclusão:** A seção "Combinação das Pipelines" não existe mais. Em seu lugar há "Requirements Specification Session (Sessão de Especificação de Requisitos)" com descrição completa. SBVR + SBE estão descritos como mecanismo de formalização mediado pela IA (D4). A saída é um `specification-plan`. O gate de aprovação está descrito (Domain Expert primário, Architect secundário com avaliação técnica). Não há referência a "pipeline", "MARE", "combinação" ou "top-down/bottom-up".

---

### TASK-008: Substituir "Atuação do Arquiteto" por "Decisão de Continuidade do Ciclo" (seção 2.2.4)

- **Status:** [ ]
- **Bloco do plano:** 2.4.5
- **Dependências:** TASK-005, TASK-006, TASK-007
- **Decisões aplicadas:** D6, D7, D8, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2.4 (linhas 109–152):
  1. **Remover** toda a seção 2.2.4 (Atuação do Arquiteto na Etapa 1) — linhas 109 a 152. As 5 atividades do Architect já foram redistribuídas:
     - Princípios constitucionais e ADRs estratégicos → Technical Constitution Session (TASK-006)
     - Validação técnica de BCs e definição de context map → gate de aprovação do Change Plan de Domain Discovery (TASK-005)
     - Avaliação técnica de requisitos → gate de aprovação do Change Plan de Requirements Specification (TASK-007)
  2. **Nota importante:** O exemplo de princípios técnicos constitucionais (bloco de código, linhas 119–149) já foi movido para a Technical Constitution Session na TASK-006. Confirmar que não há duplicação.
  3. **Criar** nova seção: `#### 2.2.4 Decisão de Continuidade do Ciclo`
  4. A nova seção deve conter:
     - Ponto de decisão explícito ao final do fluxo de Canon Building
     - Três caminhos possíveis:
       a) Mapear mais fluxos e contextos → volta para Domain Discovery Session
       b) Formalizar mais requisitos → volta para Requirements Specification Session
       c) Encerrar ciclo → prosseguir para Etapa 2
     - Autoridade: o Domain Builder decide, com input da IA sobre cobertura (D7)
     - A IA pode sinalizar áreas não mapeadas ou requisitos pendentes, mas **não decide** (D7, D8)
  - **Justificativa:** A seção narrativa do Architect é promovida a cerimônia formal (Technical Constitution) e suas atividades distribuídas pelos gates. O espaço é ocupado pela Decisão de Continuidade, conceito novo sem "casa" no v0.4. Ref: análise 3.4, 3.11, C3, C5.
  - **Referência para conceitos:** `docs/canon-building.md`, linhas 14 (nó de decisão), 47–49 (caminhos de continuidade).
- **Critério de conclusão:** A seção "Atuação do Arquiteto na Etapa 1" não existe mais. Em seu lugar há "Decisão de Continuidade do Ciclo" com os três caminhos descritos. A autoridade do Domain Builder está explícita (D7). O princípio de "sem autonomia decisória" da IA está reforçado (D8). O bloco de código de princípios técnicos não está duplicado (já está na Technical Constitution Session).

---

### TASK-009: Atualizar Guardrails da Product Canon (seção 2.2.5)

- **Status:** [ ]
- **Bloco do plano:** 2.4.6
- **Dependências:** TASK-002
- **Decisões aplicadas:** D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.2.5 (linhas 153–163):
  1. **Renomear** título: `#### 2.2.5 Guardrails da Golden Source` → `#### 2.2.5 Guardrails da Product Canon`
  2. **Guardrail 1 — Clarificação semântica** (linha 157):
     - Renomear: "Clarificação semântica" → "**Clarificação de Conformidade (Compliance Clarification)**"
     - Ampliar escopo: de "divergência com glossário de linguagem ubíqua" para "divergência com vocabulário formalizado na Product Canon" (inclui princípios técnicos, não apenas glossário)
     - Explicitar atuação: atua nas sessões de Domain Discovery e Technical Constitution
     - Substituir "golden source" → "Product Canon"
  3. **Guardrail 2 — Validação de consistência** (linha 159):
     - Preservar nome e mecânica
     - Apenas substituir "golden source" → "Product Canon"
  4. **Guardrail 3 — Versionamento** (linhas 161–163):
     - Renomear: "Versionamento gradual de alterações radicais" → "**Versionamento Gradual por Estrangulamento (Strangler Fig)**"
     - Nomear explicitamente o padrão Strangler Fig de Martin Fowler como inspiração
     - Preservar a mecânica de duas faces (current/next)
     - Substituir "golden source" → "Product Canon"
     - Adicionar: "Canonical Change Plans aprovados são integrados à Product Canon via este mecanismo"
  5. **Preservar** o exemplo da divisão de Faturamento em Cobrança e Receita (linhas 163), atualizando "golden source" → "Product Canon".
  - **Justificativa:** Guardrails evoluem em escopo e ancoragem, sem mudança de mecânica fundamental. Ref: análise 3.9, 3.10, G1, G2, G3.
  - **Referência para conceitos:** `docs/canon-building.md`, linhas 99–105 (definições dos guardrails).
- **Critério de conclusão:** O título é "Guardrails da Product Canon". O primeiro guardrail chama-se "Clarificação de Conformidade" com escopo ampliado. O terceiro guardrail chama-se "Versionamento Gradual por Estrangulamento (Strangler Fig)". Não há ocorrência de "golden source", "Clarificação semântica" (como nome de guardrail) ou "alterações radicais" (como nome do terceiro guardrail). O exemplo de Faturamento → Cobrança/Receita está preservado.

---

## Fase 3 — Etapas 2 e 3 (dependem do Canon Building)

TASK-010 e TASK-011 são sequenciais entre si (TASK-011 depende de TASK-010).

---

### TASK-010: Atualizar Etapa 2 — Especificação Contextualizada (seção 2.3)

- **Status:** [ ]
- **Bloco do plano:** 2.5
- **Dependências:** TASK-004, TASK-005, TASK-006, TASK-007, TASK-008
- **Decisões aplicadas:** D9, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.3 (linhas 165–244):
  1. **Substituir** em toda a seção 2.3 e subseções (2.3.1 a 2.3.4):
     - "golden source" → "Product Canon" (múltiplas ocorrências)
     - "plano de alteração conceitual" → "Canonical Change Plan" (múltiplas ocorrências)
     - "usuário de negócio" → "Domain Builder"
     - "arquiteto" → "Architect" (quando se referir ao papel)
     - "especialista de domínio" / "domain expert" (em minúsculas) → "Domain Expert"
  2. **Seção 2.3.1 (Injeção de Contexto)** (linhas 169–173): Preservar integralmente. Apenas substituir "golden source" → "Product Canon".
  3. **Seção 2.3.2 (Clarificação e Validação)** (linhas 175–179): Preservar integralmente. Atualizar terminologia.
  4. **Seção 2.3.3 (Plano de Alteração Conceitual)** (linhas 181–230): Recontextualizar:
     - O artefato agora se chama Canonical Change Plan e já existe no Canon Building
     - O Change Plan da Etapa 2 é **incremental** — captura apenas impactos emergentes que só se tornam visíveis quando uma especificação concreta é escrita contra a Product Canon
     - Mudanças fundamentais (novos termos, novas regras, novos BCs) já foram tratadas no Canon Building
     - Preservar o exemplo de "PIX no Checkout" (linhas 189–230), atualizando terminologia
  5. **Seção 2.3.4 (Aprovação Dual)** (linhas 232–244): Modificar substancialmente conforme D9:
     - Aprovação na Etapa 2 é **condicional**: só se o Canonical Change Plan incremental contiver impactos na Product Canon
     - Se o Change Plan for vazio (spec não altera a canon), aprovação é dispensada
     - Se houver impacto, aprovação roteada por camada afetada: Domain Expert para negócio, Architect para arquitetura
     - **Remover** a descrição da aprovação dual como gate principal do modelo — esse papel agora é do Canon Building
     - Preservar menção a organizações com múltiplos BCs e aprovadores por contexto
  - **Justificativa:** A antecipação das aprovações para o Canon Building simplifica a Etapa 2. Ref: análise 4.1, F1, F2.
- **Critério de conclusão:** Toda a seção 2.3 usa terminologia atualizada. A seção 2.3.3 descreve o Canonical Change Plan como incremental. A seção 2.3.4 descreve aprovação condicional (D9) e não é mais posicionada como gate principal do modelo. O exemplo de "PIX no Checkout" está preservado. Não há referência a "plano de alteração conceitual", "golden source", "usuário de negócio" ou "especialista de domínio" (em português como papel).

---

### TASK-011: Atualizar Etapa 3 — Retroalimentação (seção 2.4)

- **Status:** [ ]
- **Bloco do plano:** 2.6
- **Dependências:** TASK-010
- **Decisões aplicadas:** —
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 2.4 (linhas 246–253):
  1. **Renomear** título: `### 2.4 Etapa 3 — Retroalimentação da Golden Source` → `### 2.4 Etapa 3 — Retroalimentação da Product Canon`
  2. **Substituir** todas as referências terminológicas:
     - "golden source" → "Product Canon"
     - "plano de alteração conceitual" → "Canonical Change Plan"
     - "domain expert" → "Domain Expert" (se houver)
     - "arquiteto" → "Architect" (se houver, como papel)
  3. **Refinar** o escopo da retroalimentação (linhas 248–252):
     - Adicionar parágrafo: "Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento — essa integração é parcialmente antecipada. A Etapa 3 concentra-se em **descobertas emergentes da implementação**: conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código, decisões técnicas não previstas."
     - Fortalecer o parágrafo sobre segurança mecânica (linha 250, "não há ambiguidade sobre o que atualizar") com referência aos múltiplos Canonical Change Plans aprovados no Canon Building
  4. **Preservar** a listagem de tipos de atualização (glossário, eventos, regras, ADRs, princípios) — linhas 252–253.
  - **Justificativa:** A retroalimentação é parcialmente antecipada pelo Canon Building. O escopo residual é mais focado. Ref: análise 4.2.
- **Critério de conclusão:** O título menciona "Product Canon" em vez de "Golden Source". O escopo de retroalimentação distingue entre integração de Change Plans (antecipada) e descobertas emergentes (foco da Etapa 3). A listagem de tipos de atualização está preservada. Não há referência a "golden source" ou "plano de alteração conceitual".

---

## Fase 4 — Seções transversais (dependem de tudo anterior)

TASK-012, TASK-013 e TASK-014 podem ser executadas em paralelo (todas dependem das fases anteriores, mas não entre si).

---

### TASK-012: Reescrever diagrama do Ciclo Completo (seção 3)

- **Status:** [ ]
- **Bloco do plano:** 2.7
- **Dependências:** TASK-004 a TASK-011
- **Decisões aplicadas:** D3, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 3 (linhas 256–313):
  1. **Reescrever** o diagrama ASCII da Etapa 1 (linhas 261–274) para refletir:
     - Três cerimônias nomeadas: Domain Discovery Session, Technical Constitution Session, Requirements Specification Session
     - Canonical Change Plans entre cerimônias (como gates)
     - Gates de aprovação por afinidade (D3) entre cerimônias
     - Decisão de Continuidade do Ciclo ao final
     - Guardrails atualizados: Clarificação de Conformidade, Validação de Consistência, Versionamento por Estrangulamento
     - Papéis: Domain Builder, Architect, Domain Expert, IA
     - Nenhuma referência a MARE, SRS, pipelines
  2. **Atualizar** o bloco da Etapa 2 (linhas 280–291):
     - Remover "plano de alteração conceitual gerado automaticamente" como evento central
     - Recontextualizar como "Canonical Change Plan incremental (condicional)"
     - Remover referência a aprovação dual como gate principal
     - Domain Builder / Architect + IA + Product Canon
  3. **Atualizar** o bloco da Etapa 3 (linhas 296–308):
     - Adicionar distinção entre integração de Change Plans do Canon Building e retroalimentação de descobertas emergentes
     - "golden source" → "Product Canon"
  4. **Preservar** o parágrafo final (linhas 312–313) sobre enriquecimento cumulativo, atualizando "golden source" → "Product Canon".
  - **Referência para estrutura:** Usar `docs/canon-building.md` como referência para nomes e fluxos do Canon Building no diagrama.
  - **Justificativa:** O diagrama é a representação visual central do modelo — deve refletir fielmente a nova estrutura.
- **Critério de conclusão:** O diagrama ASCII reflete as três cerimônias do Canon Building com gates, a Decisão de Continuidade, os guardrails atualizados e a terminologia nova. As Etapas 2 e 3 estão atualizadas. Não há referência a "golden source", "MARE", "SRS", "pipeline", "usuário de negócio", "arquiteto" (como papel), "especialista de domínio" ou "plano de alteração conceitual".

---

### TASK-013: Atualizar Papéis no Modelo (seção 4)

- **Status:** [ ]
- **Bloco do plano:** 2.8
- **Dependências:** TASK-004 a TASK-008
- **Decisões aplicadas:** D3, D6, D7, D8, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 4 (linhas 316–337):
  1. **Papel "Usuário de Negócio"** (linhas 320–321) → **"Domain Builder (Construtor de Domínio)"**:
     - Adicionar na definição: "analista de negócio, product owner ou gestor de operações"
     - Reescrever para refletir participação em cerimônias nomeadas (Domain Discovery, Requirements Specification), não em "pipelines"
     - Adicionar papel na Decisão de Continuidade do Ciclo (D7): "decide se o ciclo continua com mais cerimônias ou encerra"
  2. **Papel "Arquiteto"** (linhas 322–323) → **"Architect (Arquiteto)"**:
     - Reescrever para refletir: conduz Technical Constitution Session (cerimônia formal, não atividades narrativas)
     - É aprovador secundário nos gates de Domain Discovery e Requirements Specification
     - Atividades distribuídas pelos gates (D6), não concentradas em uma seção narrativa
  3. **Papel "IA"** (linhas 324–325) → **"IA (Agentes LLM — mediadores de cerimônias e guardrails)"**:
     - Pluralizar "agentes"
     - Adicionar cláusula explícita: **"sem autonomia decisória"** como princípio
     - Adicionar lista indicativa de atos (D8):
       - **Operacional** (permitido): formatar, sugerir, reorganizar, sinalizar inconsistência, traduzir linguagem natural para SBVR
       - **Decisório** (requer humano): incluir/excluir da canon, aprovar Change Plan, resolver ambiguidade de domínio
  4. **Papel "Especialista de Domínio"** (linhas 326–327) → **"Domain Expert (Especialista de Domínio)"**:
     - Reescrever para refletir: aprovação antecipada no Canon Building (não apenas na Etapa 2)
     - É aprovador primário nos gates de Domain Discovery e Requirements Specification (D3)
  5. **Tabela "Resumo de atuação por etapa"** (linhas 330–337):
     - Renomear coluna "Etapa 1 — Golden Source" → "Etapa 1 — Canon Building"
     - Domain Builder: participa de Domain Discovery e Requirements Specification; decide continuidade do ciclo
     - Architect: conduz Technical Constitution Session; aprova secundariamente Discovery e Specification; aprova primariamente Constitution
     - Domain Expert: aprova primariamente Discovery e Specification; aprova secundariamente Constitution
     - IA: conduz sessões, gera Canonical Change Plans, opera guardrails; sem autonomia decisória
     - Remover todas as referências a "Event Storming e MARE", "pipelines", "plano de alteração conceitual"
  - **Justificativa:** Papéis ganham identidade e posicionamento mais preciso. Ref: análise 3.7, 3.8, 4.3, P1–P4.
- **Critério de conclusão:** Os quatro papéis usam nomes canônicos em inglês com glosa em português. A lista de atos operacionais vs. decisórios da IA (D8) está presente. A tabela reflete cerimônias nomeadas e gates por afinidade. Não há referência a "pipeline", "MARE", "usuário de negócio", "arquiteto" (como nome de papel em português), "especialista de domínio" (como nome de papel) ou "plano de alteração conceitual".

---

### TASK-014: Reformular Estrutura de Artefatos (seção 5)

- **Status:** [ ]
- **Bloco do plano:** 2.9
- **Dependências:** TASK-002, TASK-004 a TASK-008
- **Decisões aplicadas:** D1, D2, D4
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 5 (linhas 341–377):
  1. **Substituir** o parágrafo introdutório (linha 343): "golden source" → "Product Canon". Remover referência a `/golden-source/` como diretório raiz.
  2. **Substituir** a árvore de diretórios detalhada (linhas 345–375) por uma **descrição de seções essenciais** da Product Canon, em formato de lista:
     - Glossário de linguagem ubíqua
     - Regras de negócio (formalizadas em SBVR quando mediadas pela IA — D4)
     - Requisitos com critérios de aceitação (SBE)
     - Fluxos de domínio (eventos, comandos, atores, agregados)
     - Bounded contexts com seus artefatos
     - Princípios técnicos constitucionais
     - Context maps
     - ADRs
     - Canonical Change Plans (com envelope tipado — D2): `discovery-plan`, `constitution-plan`, `specification-plan`
     - Changelog / histórico de transições
  3. **Remover** referências a "SRS" como artefatos nomeados (`srs-onboarding.md`, `srs-payments.md`, `srs-notifications.md`).
  4. **Adicionar** nota explícita: "A estrutura física é deliberadamente mínima nesta fase de prototipação. A hierarquia final deve emergir da experimentação prática com o modelo (D1)."
  5. **Preservar** o princípio de que artefatos são markdown versionado em Git (linha 377).
  - **Justificativa:** A estrutura detalhada do v0.4 era prematura para a fase de prototipação. Ref: análise 4.4, A1, A3.
- **Critério de conclusão:** A árvore de diretórios detalhada foi substituída por uma lista de seções essenciais. Não há referência a `/golden-source/`, "SRS" como artefato, ou estrutura de diretórios hierárquica. Os Canonical Change Plans tipados (D2) e a formalização SBVR (D4) estão mencionados. A nota sobre estrutura mínima (D1) está presente. O princípio de markdown versionado em Git está preservado.

---

## Fase 5 — Seções derivadas (dependem de tudo anterior)

As tarefas TASK-015 a TASK-019 podem ser executadas em paralelo (dependem das fases anteriores, mas não entre si), **exceto** TASK-019 que depende de todas as outras tarefas.

---

### TASK-015: Atualizar Cenários de Aplicação (seção 6)

- **Status:** [ ]
- **Bloco do plano:** 2.10
- **Dependências:** TASK-004 a TASK-011
- **Decisões aplicadas:** D4, D9, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 6 (linhas 381–425):
  1. **Seção 6.1 — Greenfield** (linhas 383–397):
     - Passo 1 (linha 389): "pipeline de Event Storming conversacional" → "Domain Discovery Session"
     - Passo 2 (linhas 391–392): "golden source" → "Product Canon"; "arquiteto" → "Architect"; "O arquiteto (neste caso, o CTO)" → "O Architect (neste caso, o CTO)"
     - Passo 3 (linhas 393–394): "Via pipeline MARE" → "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA (D4)". Ajustar exemplo para refletir formalização via linguagem natural controlada: "O Domain Builder descreve os requisitos em linguagem natural, e a IA traduz para SBVR controlado, apresentando a formalização para validação."
     - Passos 4–5 (linhas 395–397): "plano de alteração conceitual" → "Canonical Change Plan incremental (Etapa 2)"; "domain expert" → "Domain Expert"; "golden source" → "Product Canon"
     - Adicionar referência à aprovação no Canon Building que precede os passos 4–5
  2. **Seção 6.2 — Brownfield** (linhas 399–411):
     - "golden source do produto já existe" → "Product Canon do produto já existe"
     - "plano de alteração conceitual" → "Canonical Change Plan incremental"
     - Recontextualizar: a base conceitual já foi aprovada no Canon Building; o Change Plan da Etapa 2 captura apenas impactos emergentes (D9)
     - "especialistas de domínio" → "Domain Experts"; "arquiteto" → "Architect"
  3. **Seção 6.3 — Migração Gradual** (linhas 413–425):
     - "sessão de Event Storming" → "Domain Discovery Session"
     - "guardrails de versionamento" → "Versionamento Gradual por Estrangulamento (Strangler Fig)"
     - "golden source" → "Product Canon"
     - "versão next / versão current" → preservar, com referência explícita ao Strangler Fig
  - **Justificativa:** Cenários são veículos de comunicação do modelo e devem refletir terminologia e fluxos atualizados. Ref: análise 4.5.
- **Critério de conclusão:** Os três cenários usam terminologia atualizada. O cenário greenfield menciona Domain Discovery Session, Technical Constitution Session (se referenciada), Requirements Specification Session com SBVR+SBE mediado. O cenário brownfield descreve o Change Plan como incremental (D9). O cenário de migração referencia Strangler Fig. Não há referência a "pipeline", "MARE", "golden source", "plano de alteração conceitual", "usuário de negócio" ou "arquiteto" (como papel em português).

---

### TASK-016: Atualizar Dores Endereçadas (seção 7)

- **Status:** [ ]
- **Bloco do plano:** 2.11
- **Dependências:** TASK-004 a TASK-011
- **Decisões aplicadas:** D3, D4, D8, D9, D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 7 (linhas 429–442):
  1. **Substituir** "golden source" → "Product Canon" em **todas** as linhas da tabela.
  2. **Linha "Usuários de negócio excluídos"** (linha 435):
     - Substituir: "As pipelines de Event Storming e MARE permitem que pessoas não-técnicas participem descrevendo o negócio em linguagem natural, com a IA corrigindo inconsistências"
     - Por: "As cerimônias de Domain Discovery e Requirements Specification permitem que Domain Builders participem, descrevendo o negócio em linguagem natural. Na Requirements Specification, a IA traduz para SBVR controlado (D4)."
  3. **Linha "Decisões conceituais tomadas silenciosamente pela IA"** (linha 437):
     - "plano de alteração conceitual" → "Canonical Change Plan"
     - Adicionar menção: "A IA opera sem autonomia decisória — propõe e sinaliza, mas não decide (D8)."
  4. **Linha "Revisão de código como único momento de validação"** (linha 441):
     - "aprovação dual (especialista de domínio + arquiteto)" → "aprovação por afinidade (Domain Expert + Architect) nos gates do Canon Building e, condicionalmente, na Etapa 2 (D3, D9)"
  5. **Demais linhas:** Apenas atualização terminológica ("golden source" → "Product Canon").
  - **Justificativa:** A tabela é um resumo de valor — deve refletir terminologia atualizada e mecanismos revisados. Ref: análise 4.5.
- **Critério de conclusão:** Todas as linhas da tabela usam "Product Canon". As três linhas especificamente mencionadas foram reescritas com terminologia e conceitos atualizados. Não há referência a "pipeline", "MARE", "golden source", "plano de alteração conceitual", "especialista de domínio" (como papel em português) ou "aprovação dual" como mecanismo principal.

---

### TASK-017: Atualizar Princípios de Design (seção 8)

- **Status:** [ ]
- **Bloco do plano:** 2.12
- **Dependências:** TASK-004 a TASK-008
- **Decisões aplicadas:** D3, D8
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 8 (linhas 445–458):
  1. **Princípio 1** (linha 447): "A golden source é viva, não estática" → "**A Product Canon é viva, não estática.**" Substituir "golden source" → "Product Canon" no corpo. Preservar conteúdo.
  2. **Princípio 2** (linha 449): "O ciclo é bidirecional" → Preservar integralmente. Substituir "golden source" → "Product Canon".
  3. **Princípio 3** (linha 451): "Prevenção sobre detecção" → Fortalecer: adicionar que com o Canon Building, a prevenção ocorre *ainda mais cedo* — o Canonical Change Plan é revisado antes de qualquer especificação de feature, não apenas antes do código. Adicionar referência à aprovação nos gates cerimoniais.
  4. **Princípio 4** (linha 453): "Separação de autoridade" → Atualizar nomes dos papéis (Domain Builder, Architect, Domain Expert). Adicionar: "A IA tem capacidade de processamento e consistência, mas sem autonomia decisória (D8) — propõe, humanos decidem."
  5. **Princípio 5** (linha 455): "Alterações radicais são graduais" → Adicionar referência ao padrão Strangler Fig. Preservar exemplo.
  6. **Princípio 6** (linha 457): "Injeção seletiva de contexto" → Substituir "golden source" → "Product Canon". Preservar integralmente.
  7. **Adicionar** novo princípio 7: **"Governança por cerimônia."** O conhecimento da Product Canon é construído e modificado exclusivamente através de cerimônias formais (Domain Discovery, Technical Constitution, Requirements Specification), cada uma com saída padronizada (Canonical Change Plan), gate de aprovação e rastreabilidade. Este princípio estava implícito no Canon Building mas não declarado.
  - **Justificativa:** Princípios de design são a fundação filosófica do modelo. O Canon Building fortalece vários deles e introduz um novo. Ref: análise 5 (síntese).
- **Critério de conclusão:** Todos os princípios usam "Product Canon". O princípio de prevenção referencia os gates do Canon Building. O princípio de separação de autoridade menciona "sem autonomia decisória" da IA (D8). O princípio de alterações graduais referencia Strangler Fig. O novo princípio "Governança por cerimônia" está presente. Não há referência a "golden source", "usuário de negócio" ou "arquiteto" (como nome de papel em português).

---

### TASK-018: Atualizar Riscos e Limitações (seção 9)

- **Status:** [ ]
- **Bloco do plano:** 2.13
- **Dependências:** TASK-004 a TASK-008
- **Decisões aplicadas:** D1, D3, D4, D5, D9
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 9 (linhas 461–482):
  1. **9.1** (linhas 463–465): Renomear título para "Qualidade do guardrail de conformidade". Escopo ampliado: não apenas semântica do glossário, mas conformidade com toda a Product Canon. Substituir "golden source" → "Product Canon".
  2. **9.2** (linhas 467–469): Substituir "golden source" → "Product Canon", "plano de alteração conceitual" → "Canonical Change Plan". Preservar integralmente.
  3. **9.3** (linhas 471–473): Ajustar: o Canon Building é mais estruturado (três cerimônias com gates vs. duas pipelines). O investimento inicial pode ser maior, mas o retorno é mais previsível. Substituir "pipelines de Event Storming e MARE" → "cerimônias do Canon Building". Substituir "golden source" → "Product Canon".
  4. **9.4** (linhas 475–478): Recontextualizar: parcialmente mitigado pelo Canon Building. Se Canonical Change Plans já são integrados à Product Canon, a Etapa 3 é um incremento menor. O risco residual é sobre descobertas emergentes. Substituir "golden source" → "Product Canon".
  5. **9.5** (linhas 479–482): Agravamento explícito. Três gates no Canon Building + gate condicional na Etapa 2. Adicionar mitigações: aprovação por afinidade (D3), aprovação secundária assíncrona com veto, roteamento por camada na Etapa 2 (D9). Substituir terminologia.
  6. **Adicionar 9.6 — Curva de aprendizado SBVR** (novo): Se a notação SBVR for percebida como técnica ou burocrática pelos Domain Builders, o modelo perde seu diferencial de inclusão. Mitigação: SBVR mediado pela IA (D4) — o Domain Builder fala em linguagem natural, a IA traduz. Risco residual: Domain Builder validando algo que não escreveu diretamente (rubber stamp).
  7. **Adicionar 9.7 — Perda de detalhamento estrutural** (novo): O Canon Building não detalha fases internas de todas as cerimônias nem a organização física da Product Canon. D5 e D1 mitigam parcialmente. Risco gerenciável — detalhamento deve emergir da prototipação.
  - **Justificativa:** O perfil de riscos se redistribui com a reformulação. Dois novos riscos são introduzidos. Ref: análise 4.6.
- **Critério de conclusão:** Os riscos 9.1 a 9.5 estão atualizados com terminologia e escopo corretos. Os novos riscos 9.6 (SBVR) e 9.7 (detalhamento estrutural) estão presentes. As mitigações de D3, D4, D5, D9 estão referenciadas nos riscos correspondentes. Não há referência a "golden source", "pipeline", "MARE" ou "plano de alteração conceitual".

---

### TASK-019: Atualizar Direções para Prototipação (seção 10)

- **Status:** [ ]
- **Bloco do plano:** 2.14
- **Dependências:** TASK-001 a TASK-018 (depende de todas as seções anteriores)
- **Decisões aplicadas:** D2, D3, D4, D7
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, seção 10 (linhas 485–498):
  1. **Item 1** (linha 489): "Pipeline de Event Storming Conversacional" → "**Domain Discovery Session.**" Preservar objetivo de validação. Adicionar: "a sessão deve produzir um Canonical Change Plan tipado como `discovery-plan` (D2)."
  2. **Item 2** (linha 491): "Guardrail semântico com golden source existente" → "**Guardrail de Conformidade com Product Canon existente.**" "Golden source mínima" → "Product Canon mínima". Escopo ampliado: testar conformidade contra glossário *e* princípios técnicos.
  3. **Item 3** (linha 493): "Geração automática do plano de alteração conceitual" → "**Geração de Canonical Change Plans em cada cerimônia.**" Validar se a IA gera Change Plans corretos com envelope + payload tipado (D2) em cada cerimônia, não apenas na Etapa 2.
  4. **Item 4** (linha 495): "Validação por aprovadores reais" → Ajustar: testar aprovação por afinidade (D3). Domain Expert aprova primariamente Change Plans de Discovery e Specification; Architect aprova primariamente Constitution. Avaliar se aprovação secundária assíncrona agrega valor.
  5. **Item 5** (linha 497): "Ciclo completo em escopo reduzido" → Ajustar: o ciclo mínimo agora inclui três cerimônias do Canon Building + Decisão de Continuidade + Etapa 2 + Etapa 3.
  6. **Adicionar Item 6:** "**Formalização SBVR + SBE mediada pela IA.**" (novo) Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade (D4); (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis.
  7. **Adicionar Item 7:** "**Fluxo sequencial com gates entre cerimônias.**" (novo) Testar se: (a) habilitação sequencial funciona na prática; (b) aprovadores lidam com múltiplos Change Plans sem gargalo (D3); (c) Decisão de Continuidade é exercida naturalmente pelo Domain Builder (D7).
  - **Justificativa:** Direções de prototipação devem refletir os novos componentes e riscos. Ref: análise 4.7.
- **Critério de conclusão:** Os 5 itens originais estão atualizados com terminologia e escopo corretos. Os 2 novos itens (SBVR+SBE e fluxo com gates) estão presentes. Total: 7 itens de prototipação. Não há referência a "pipeline", "MARE", "golden source", "plano de alteração conceitual" ou "SRS".

---

## Fase 6 — Verificação Final

Todas as tarefas de verificação dependem da conclusão de **todas** as tarefas anteriores (TASK-001 a TASK-019). As tarefas TASK-020 a TASK-024 podem ser executadas em paralelo.

---

### TASK-020: Verificação — Busca por termos deprecados

- **Status:** [ ]
- **Bloco do plano:** Seção 5.1 do plano (Risco: Inconsistência terminológica residual)
- **Dependências:** TASK-001 a TASK-019
- **Decisões aplicadas:** D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, após todas as alterações concluídas:
  1. Realizar busca textual (case-insensitive) pelos seguintes termos deprecados e verificar que **nenhum** aparece no documento:
     - `golden source` (todas as variações: "Golden Source", "golden source", "a golden source")
     - `usuário de negócio` / `usuários de negócio` (como nome de papel)
     - `especialista de domínio` / `especialistas de domínio` (como nome de papel em português, fora de glosas)
     - `arquiteto` (quando usado como **nome de papel**, não como palavra genérica. Atenção: "Architect (Arquiteto)" é válido como glosa D10)
     - `pipeline MARE` / `Pipeline MARE` / `MARE`
     - `plano de alteração conceitual` / `Plano de Alteração Conceitual`
     - `clarificação semântica` (como nome de guardrail)
     - `SRS` (como artefato nomeado. "SBVR" é válido)
  2. Para cada ocorrência encontrada, registrar a linha e o contexto, e indicar a tarefa que deveria tê-la removido.
  - **Justificativa:** Com ~60+ ocorrências de "golden source" e dezenas de referências a papéis e artefatos pelo nome antigo, substituições incompletas são prováveis.
- **Critério de conclusão:** Nenhum dos termos deprecados listados aparece no documento `zionkit-model-v0.4.md`, exceto em glosas D10 válidas (ex: "Architect (Arquiteto)").

---

### TASK-021: Verificação — Preservação de exemplos e blocos de código

- **Status:** [ ]
- **Bloco do plano:** Seção 5.2 do plano (Risco: Perda de exemplos)
- **Dependências:** TASK-001 a TASK-019
- **Decisões aplicadas:** —
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, verificar a presença dos seguintes exemplos e blocos de código do v0.4 (com terminologia atualizada):
  1. **Bloco de código — Princípios técnicos constitucionais** (originalmente linhas 122–149): deve estar na seção da Technical Constitution Session (movido por TASK-006). Verificar presença de STACK, COMUNICAÇÃO ENTRE CONTEXTOS, PERSISTÊNCIA, SEGURANÇA, OBSERVABILIDADE.
  2. **Bloco de código — Plano de alteração conceitual (PIX no Checkout)** (originalmente linhas 189–230): deve estar na seção 2.3.3 (atualizado por TASK-010). Verificar presença das seções CAMADA DE NEGÓCIO e CAMADA DE ARQUITETURA.
  3. **Exemplo — Domain Discovery (perspectiva do Domain Builder)** — fintech/saque (originalmente linha 86): verificar presença com terminologia atualizada.
  4. **Exemplo — Domain Discovery (perspectiva do Architect)** — comunicação síncrona/assíncrona (originalmente linha 88): verificar presença com terminologia atualizada.
  5. **Exemplo — Requirements Specification (cancelamento de pedido)** — exemplo de mediação SBVR (adaptado da antiga MARE, linha 101): verificar presença.
  6. **Exemplo — Guardrails (Faturamento → Cobrança/Receita)** (originalmente linhas 163): verificar presença com terminologia atualizada.
  7. **Cenário 6.1 — Greenfield (logística)**: verificar presença completa.
  8. **Cenário 6.2 — Brownfield (saúde/telemedicina)**: verificar presença completa.
  9. **Cenário 6.3 — Migração gradual (Faturamento)**: verificar presença completa.
  - **Justificativa:** Exemplos e blocos de código são essenciais para a comunicação do modelo. Perda acidental é um risco alto.
- **Critério de conclusão:** Todos os 9 itens listados estão presentes no documento, com terminologia atualizada e conteúdo preservado.

---

### TASK-022: Verificação — Glosas em português (D10)

- **Status:** [ ]
- **Bloco do plano:** Seção 5.5 do plano (Risco: Glosas inconsistentes)
- **Dependências:** TASK-001 a TASK-019
- **Decisões aplicadas:** D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, verificar que cada um dos seguintes termos canônicos em inglês possui glosa em português **exatamente uma vez**, na sua **primeira ocorrência** no documento final:
  1. **Product Canon** → glosa: "(Cânone de Produto)" ou "(Cânone de Produto — fonte central de verdade)"
  2. **Domain Builder** → glosa: "(Construtor de Domínio)" ou "(Construtor de Domínio — analista de negócio, product owner ou gestor de operações)"
  3. **Domain Expert** → glosa: "(Especialista de Domínio)"
  4. **Architect** → glosa: "(Arquiteto)" ou "(Arquiteto — especialista técnico)"
  5. **Canonical Change Plan** → glosa: "(Plano de Mudança Canônico)"
  6. **Domain Discovery Session** → glosa: "(Sessão de Descoberta de Domínio)"
  7. **Technical Constitution Session** → glosa: "(Sessão de Constituição Técnica)"
  8. **Requirements Specification Session** → glosa: "(Sessão de Especificação de Requisitos)"
  9. **Clarificação de Conformidade** → glosa: "(Compliance Clarification)" (inversão: nome em português, glosa em inglês)
  10. **Versionamento Gradual por Estrangulamento** → glosa: "(Strangler Fig)"

  Para cada termo:
  - Localizar **todas** as ocorrências no documento
  - Verificar que a glosa aparece **exatamente na primeira** ocorrência
  - Verificar que **nenhuma** ocorrência subsequente repete a glosa
  - Se a glosa estiver no lugar errado (não na primeira ocorrência), registrar o erro
  - **Justificativa:** Com reordenação de seções, a "primeira ocorrência" pode ter mudado de posição. Glosas duplicadas ou no lugar errado comprometem a leitura.
- **Critério de conclusão:** Cada um dos 10 termos tem glosa exatamente uma vez, na primeira ocorrência no documento. Nenhuma glosa está duplicada ou ausente.

---

### TASK-023: Verificação — Alinhamento entre diagrama e texto

- **Status:** [ ]
- **Bloco do plano:** Seção 5.4 do plano (Risco: Desalinhamento diagrama/texto)
- **Dependências:** TASK-001 a TASK-019
- **Decisões aplicadas:** —
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, comparar o diagrama ASCII da seção 3 (O Ciclo Completo) com o texto das seções correspondentes:
  1. **Etapa 1 no diagrama vs. seção 2.2:** Verificar que o diagrama menciona as mesmas três cerimônias (Domain Discovery, Technical Constitution, Requirements Specification), os mesmos guardrails (Clarificação de Conformidade, Validação de Consistência, Versionamento por Estrangulamento), e os mesmos papéis (Domain Builder, Architect, Domain Expert, IA) que o texto.
  2. **Etapa 2 no diagrama vs. seção 2.3:** Verificar que o diagrama reflete o Canonical Change Plan incremental (condicional) e não descreve aprovação dual como gate principal.
  3. **Etapa 3 no diagrama vs. seção 2.4:** Verificar que o diagrama distingue entre integração de Change Plans e descobertas emergentes.
  4. **Gates de aprovação:** Verificar que o diagrama reflete aprovação por afinidade (não aprovação dual simétrica). Conferir com a tabela de papéis (seção 4) e com `docs/canon-building.md`.
  5. **Decisão de Continuidade:** Verificar que o diagrama inclui a Decisão de Continuidade ao final do Canon Building, com os três caminhos descritos na seção 2.2.4.
  - **Justificativa:** O diagrama é a representação visual central do modelo. Divergência com o texto gera confusão.
- **Critério de conclusão:** Todos os 5 pontos de verificação estão alinhados entre diagrama e texto. Nenhuma divergência encontrada.

---

### TASK-024: Verificação — Cobertura das decisões D1–D10

- **Status:** [ ]
- **Bloco do plano:** Seção 3 do plano (tabela de cobertura D1–D10)
- **Dependências:** TASK-001 a TASK-019
- **Decisões aplicadas:** D1–D10
- **Descrição:**
  No arquivo `docs/zionkit-model-v0.4.md`, verificar que cada decisão de design (D1–D10) está refletida concretamente no texto do documento, conforme a tabela de cobertura do plano (seção 3 de `docs/plano-alteracao-v04.md`, linhas 434–445):
  1. **D1** — Estrutura mínima flat: verificar presença em seção 2.1 (nota) e seção 5 (estrutura de artefatos)
  2. **D2** — Schema tipado dos Change Plans: verificar menção a `discovery-plan`, `constitution-plan`, `specification-plan` nas cerimônias e na seção 5
  3. **D3** — Aprovação por afinidade: verificar nos gates das três cerimônias, no diagrama, na tabela de papéis e no princípio de governança
  4. **D4** — SBVR mediado: verificar na Requirements Specification Session, na seção 5, no cenário greenfield e nas dores endereçadas
  5. **D5** — Fases explícitas para Discovery, diretrizes para as demais: verificar nas três cerimônias
  6. **D6** — Distribuição de atividades do Architect: verificar nos gates (Discovery, Specification) e na Technical Constitution
  7. **D7** — Domain Builder decide continuidade: verificar na seção 2.2.4, na tabela de papéis e no item 7 de prototipação
  8. **D8** — Lista operacional/decisório da IA: verificar na seção 4 (Papéis), no resumo executivo e no princípio de separação de autoridade
  9. **D9** — Aprovação condicional na Etapa 2: verificar na seção 2.3.4, no cenário brownfield e nas dores endereçadas
  10. **D10** — Terminologia bilíngue: verificar que é transversal (coberta por TASK-022)
  - **Justificativa:** Garantir que nenhuma decisão de design ficou sem implementação no documento.
- **Critério de conclusão:** Cada uma das 10 decisões de design tem pelo menos uma manifestação concreta no texto do documento v0.5, conforme os pontos de verificação listados.

---

## Resumo de Dependências

```
Fase 1 (paralelas): TASK-001, TASK-002, TASK-003
    │
Fase 2 (sequencial + paralela):
    ├── TASK-004 ← TASK-002
    │   └── TASK-005 ← TASK-004
    │       └── TASK-006 ← TASK-005
    │           └── TASK-007 ← TASK-006
    │               └── TASK-008 ← TASK-005, TASK-006, TASK-007
    └── TASK-009 ← TASK-002 (paralela com TASK-004–008)
    │
Fase 3 (sequencial):
    ├── TASK-010 ← TASK-004 a TASK-008
    └── TASK-011 ← TASK-010
    │
Fase 4 (paralelas): TASK-012, TASK-013, TASK-014 ← Fases 1–3
    │
Fase 5 (paralelas + 1 final):
    ├── TASK-015, TASK-016, TASK-017, TASK-018 ← Fases 1–3
    └── TASK-019 ← TASK-001 a TASK-018
    │
Fase 6 — Verificação (paralelas): TASK-020 a TASK-024 ← TASK-001 a TASK-019
```

## Contagem Final

- **Total de tarefas de alteração:** 19 (TASK-001 a TASK-019)
- **Total de tarefas de verificação:** 5 (TASK-020 a TASK-024)
- **Total geral:** 24 tarefas
- **Blocos do plano cobertos:** 2.0, 2.1, 2.2, 2.3, 2.4.1, 2.4.2, 2.4.3, 2.4.4, 2.4.5, 2.4.6, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11, 2.12, 2.13, 2.14 (todos os 15 blocos)
- **Decisões referenciadas:** D1, D2, D3, D4, D5, D6, D7, D8, D9, D10 (todas as 10)
- **Riscos de execução cobertos:** 5.1, 5.2, 5.3 (implícito na concisão das tarefas), 5.4, 5.5 (todos os 5)
