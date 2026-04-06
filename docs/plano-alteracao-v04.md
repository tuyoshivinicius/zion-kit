# Plano de Alteração — ZionKit Model v0.4 → v0.5

**Data:** 2026-04-06  
**Tipo:** Diff conceitual (plano de alteração, não reescrita)  
**Documentos de origem:**
- `zionkit-model-v0.4.md` — documento-alvo das alterações
- `canon-building.md` — fonte das mudanças propostas
- `analise-canon-building.md` — análise de impacto e decisões de design (D1–D10)

---

## 1. Decisões Aplicadas (Premissas do Plano)

As 10 decisões de design já foram tomadas e registradas na seção 7 da análise de impacto. Este plano as aplica como diretrizes — não as rediscute.

| ID | Decisão | Opção Escolhida | Síntese |
|----|---------|-----------------|---------|
| D1 | Organização Interna da Product Canon | B | Estrutura mínima flat para prototipação; sem compromisso com hierarquia final |
| D2 | Schema dos Canonical Change Plans | B | Envelope comum (metadata) + payload tipado por cerimônia (`discovery-plan`, `constitution-plan`, `specification-plan`) |
| D3 | Modelo de Aprovação nos Gates | B | Aprovação primária por afinidade + secundária assíncrona com janela de veto |
| D4 | Nível de Formalidade do SBVR | B | SBVR mediado pela IA — autoria conversacional, artefato formal na Product Canon |
| D5 | Estrutura Interna das Cerimônias | C | Fases explícitas para Domain Discovery (Event Storming); diretrizes para as demais |
| D6 | Escopo da Technical Constitution Session | B | Foco em princípios constitucionais + distribuição das demais atividades pelos gates de aprovação |
| D7 | Decisão de Continuidade do Ciclo | A | Domain Builder decide com input da IA |
| D8 | Fronteira de Autonomia da IA | B | Princípio "sem autonomia decisória" mantido + lista indicativa de exemplos |
| D9 | Aprovação Residual na Etapa 2 | B | Condicional — só se houver impacto na canon, com roteamento por camada |
| D10 | Terminologia Bilíngue | B | Termos canônicos em inglês + glosa em português na primeira ocorrência |

---

## 2. Alterações por Seção do Documento v0.4

### 2.0 Cabeçalho e Metadados

**Natureza:** Modificação  
**Detalhamento:**
- Incrementar versão de 0.4 para 0.5
- Atualizar data do documento

**Justificativa:** Reflete a incorporação do Canon Building como evolução do modelo.  
**Decisões aplicadas:** —  
**Dependências:** Nenhuma (aplicar primeiro).

---

### 2.1 Resumo Executivo

**Natureza:** Modificação substancial  
**Detalhamento:**
- **Substituir** "golden source semântica" → "Product Canon (Cânone de Produto — fonte central de verdade)" em todas as ocorrências (N1, A1). Glosa em português na primeira ocorrência conforme D10.
- **Substituir** "usuários de negócio" → "Domain Builders (Construtores de Domínio)" (N7)
- **Substituir** "arquitetos" → "Architects" (N9)
- **Substituir** "especialistas de domínio" → "Domain Experts (Especialistas de Domínio)" (N8)
- **Substituir** referência a "plano de alteração conceitual" → "Canonical Change Plan (Plano de Mudança Canônico)" (N6)
- **Modificar** a descrição das três etapas no parágrafo de síntese para refletir:
  - Etapa 1: agora é "Canon Building" com três cerimônias formais (não "pipelines")
  - A aprovação do Canonical Change Plan ocorre dentro do Canon Building, não na Etapa 2 (F1)
  - A formalização de requisitos usa SBVR + SBE, não pipeline MARE (C2)
- **Adicionar** menção à cláusula "sem autonomia decisória" da IA (P4) — reforço no nível executivo

**Justificativa:** O resumo é a primeira exposição ao modelo; deve refletir a identidade terminológica e as mudanças estruturais do Canon Building. Ref: análise 3.1, 3.7, 3.8.  
**Decisões aplicadas:** D10 (terminologia bilíngue com glosa)  
**Dependências:** Nenhuma.

---

### 2.2 Seção 1 — Problema (1.1, 1.2, 1.3)

**Natureza:** Modificação terminológica pontual  
**Detalhamento:**
- **1.1:** Substituir "golden source" → "Product Canon" nas duas ocorrências do conceito (parágrafos de contexto). A seção descreve o problema, não a solução — a referência ao artefato é indireta.
- **1.2:** Substituir "usuário de negócio" → "Domain Builder" na descrição do papel excluído. Manter a descrição do perfil ("product owners, analistas de produto, gestores de operações") que agora é incorporada à definição do Domain Builder (P1).
- **1.3:** Sem alteração significativa. O cenário ilustrativo fala de "corpo de conhecimento do produto" — alinha-se naturalmente com Product Canon sem exigir reescrita.

**Justificativa:** A seção de problema é estável — descreve dores, não soluções. Apenas terminologia precisa ser harmonizada. Ref: análise 3.1, 3.7.  
**Decisões aplicadas:** D10 (glosa na primeira ocorrência de cada termo novo)  
**Dependências:** Depende de 2.0 (versão atualizada).

---

### 2.3 Seção 2.1 — A Golden Source Semântica

**Natureza:** Modificação significativa  
**Detalhamento:**
- **Renomear** título da seção: "A Golden Source Semântica" → "A Product Canon (Cânone de Produto)"
- **Substituir** toda referência a "golden source" → "Product Canon" no corpo da seção
- **Substituir** "Requisitos de negócio (SRS)" → "Requisitos formalizados via SBVR + SBE" na listagem da Camada de Negócio (A3, C2). Remover referência a "documentos SRS" como artefato nomeado.
- **Adicionar** descrição da Product Canon como "artefato versionado que evolui a cada ciclo de Canon Building" — reforçando a identidade do Canon Building (A1)
- **Preservar** a divisão em Camada de Negócio e Camada de Arquitetura — o Canon Building não elimina essa organização conceitual, apenas não detalha a física (D1)
- **Preservar** todos os itens listados em ambas as camadas (glossário, regras, fluxos, princípios, BCs, eventos, context maps, ADRs) — o Canon Building confirma seu conteúdo
- **Adicionar** nota de que a organização física/interna da Product Canon é deliberadamente mínima nesta fase, sem compromisso com hierarquia final (D1)

**Justificativa:** Mudança de identidade central do modelo. A Product Canon substitui a Golden Source com semântica mais rica ("corpo canônico de conhecimento" vs. "fonte de dados"). Ref: análise 3.1, A1.  
**Decisões aplicadas:** D1 (estrutura mínima flat), D10 (glosa)  
**Dependências:** Nenhuma. Esta seção define o artefato central — deve ser atualizada antes das seções que o referenciam.

---

### 2.4 Seção 2.2 — Etapa 1 (Construção e Manutenção)

Esta é a seção com maior volume de alterações. Detalhada por subseção.

#### 2.4.1 Seção 2.2 (cabeçalho e introdução)

**Natureza:** Modificação substancial  
**Detalhamento:**
- **Renomear** "Etapa 1 — Construção e Manutenção da Golden Source" → "Etapa 1 — Canon Building (Construção e Manutenção da Product Canon)" (N2)
- **Substituir** "usuário de negócio" → "Domain Builder" (N7)
- **Substituir** "arquiteto" → "Architect" (N9)
- **Substituir** "golden source" → "Product Canon"
- **Substituir** referência a "duas pipelines" → "três cerimônias formais" (C1, C2, C3)
- **Reescrever** parágrafo introdutório para refletir o fluxo sequencial com gates: Domain Discovery → (CCP aprovado) → Technical Constitution → (CCP aprovado) → Requirements Specification → (CCP aprovado) → Decisão de Continuidade (C4, C5)
- **Adicionar** descrição do modelo de aprovação por afinidade: aprovação primária pelo papel com expertise na cerimônia, secundária assíncrona com veto (D3)

**Justificativa:** O Canon Building reformula completamente a Etapa 1. Ref: análise C4, F1.  
**Decisões aplicadas:** D3 (aprovação por afinidade), D10 (glosa)  
**Dependências:** Depende de 2.3 (Product Canon já definida).

#### 2.4.2 Seção 2.2.1 — Pipeline de Event Storming Conversacional

**Natureza:** Modificação significativa (reframing)  
**Detalhamento:**
- **Renomear** "Pipeline de Event Storming Conversacional" → "Domain Discovery Session (Sessão de Descoberta de Domínio)" (N3, C1)
- **Substituir** linguagem de "pipeline com fases" → "cerimônia conversacional"
- **Preservar** as 4 fases do Event Storming (descoberta de eventos, identificação de comandos/atores, mapeamento de agregados/BCs, decomposição de casos de uso) — D5 determina manter fases explícitas para Domain Discovery
- **Modificar** a saída: de "artefatos escritos na golden source" → "Canonical Change Plan tipado como `discovery-plan`" (D2)
- **Adicionar** que o Canonical Change Plan produzido requer aprovação primária do Domain Expert (fidelidade semântica) e secundária do Architect (viabilidade técnica, incluindo validação de BCs e context map — D6) antes de habilitar a próxima cerimônia (D3)
- **Preservar** os dois exemplos (perspectiva do usuário de negócio e perspectiva do arquiteto), atualizando terminologia: "usuário de negócio" → "Domain Builder", "golden source" → "Product Canon"
- **Remover** referência ao arquiteto como descrito "conforme detalhado na seção 2.2.4" — a validação técnica agora é parte do gate de aprovação (D6)

**Justificativa:** Reframing de "pipeline" para "cerimônia" com saída formal e governança. Ref: análise 3.2, C1.  
**Decisões aplicadas:** D2 (schema tipado), D3 (aprovação por afinidade), D5 (fases preservadas), D6 (validação de BCs pelo Architect no gate)  
**Dependências:** Depende de 2.4.1 (introdução da Etapa 1 já reformulada).

#### 2.4.3 Seção 2.2.2 — Pipeline MARE

**Natureza:** Substituição completa  
**Detalhamento:**
- **Remover** toda a seção 2.2.2 (Pipeline MARE)
- **Criar** nova seção: "Technical Constitution Session (Sessão de Constituição Técnica)" (N5, C3)
  - Cerimônia conduzida pelo Architect
  - Foco: princípios técnicos constitucionais e ADRs estratégicos (D6 — escopo focado)
  - Sem fases rígidas — diretrizes de condução (D5)
  - Saída: Canonical Change Plan tipado como `constitution-plan` (D2)
  - Aprovação primária pelo Architect, secundária pelo Domain Expert (D3)
  - Habilitada pela aprovação do Change Plan de Domain Discovery (C4)
  - Habilita a Requirements Specification Session (C4)
- **Preservar** o exemplo de princípios técnicos constitucionais que estava na seção 2.2.4 do v0.4 — mover para cá como exemplo de saída da cerimônia

**Justificativa:** A MARE é eliminada e substituída. A Technical Constitution Session ocupa essa posição na sequência e é a cerimônia nova de maior impacto. Ref: análise 3.3, 3.4, C2, C3.  
**Decisões aplicadas:** D2, D3, D5 (diretrizes, não fases), D6 (escopo focado)  
**Dependências:** Depende de 2.4.2 (Domain Discovery já definida como antecessora).

#### 2.4.4 Seção 2.2.3 — Combinação das Pipelines

**Natureza:** Substituição completa  
**Detalhamento:**
- **Remover** a seção sobre combinação de pipelines
- **Criar** nova seção: "Requirements Specification Session (Sessão de Especificação de Requisitos)" (N4, C2)
  - Cerimônia conversacional de formalização semântica usando SBVR + SBE
  - Domain Builder descreve requisitos em linguagem natural; IA traduz para SBVR controlado e apresenta para validação (D4 — SBVR mediado)
  - Sem fases rígidas — diretrizes de condução (D5)
  - Saída: Canonical Change Plan tipado como `specification-plan` (D2), contendo regras de negócio em SBVR e critérios de aceitação em SBE
  - Aprovação primária pelo Domain Expert, secundária pelo Architect (D3). Na aprovação secundária, o Architect realiza avaliação técnica de requisitos (D6)
  - Habilitada pela aprovação do Change Plan de Technical Constitution (C4)
  - Habilita a Decisão de Continuidade do Ciclo (C5)

**Justificativa:** A Requirements Specification Session substitui a MARE com ancoragem em padrões reconhecidos (SBVR + SBE). Ref: análise 3.3, C2.  
**Decisões aplicadas:** D2, D3, D4 (SBVR mediado pela IA), D5 (diretrizes), D6 (avaliação técnica no gate)  
**Dependências:** Depende de 2.4.3 (Technical Constitution já definida como antecessora).

#### 2.4.5 Seção 2.2.4 — Atuação do Arquiteto na Etapa 1

**Natureza:** Substituição completa  
**Detalhamento:**
- **Remover** a seção 2.2.4 inteira. As 5 atividades do Architect são redistribuídas conforme D6:
  - Princípios constitucionais e ADRs estratégicos → Technical Constitution Session (2.4.3)
  - Validação técnica de BCs e definição de context map → gate de aprovação do Change Plan de Domain Discovery (2.4.2)
  - Avaliação técnica de requisitos → gate de aprovação do Change Plan de Requirements Specification (2.4.4)
- **Criar** nova seção: "Decisão de Continuidade do Ciclo" (C5)
  - Ponto de decisão explícito ao final do fluxo de Canon Building
  - Três caminhos: mapear mais fluxos (→ Domain Discovery), formalizar mais requisitos (→ Requirements Specification), encerrar ciclo
  - Autoridade: Domain Builder decide, com input da IA sobre cobertura (D7)
  - A IA pode sinalizar áreas não mapeadas ou requisitos pendentes, mas não decide (D7, D8)

**Justificativa:** A seção narrativa do Architect é promovida a cerimônia formal (Technical Constitution) e suas atividades distribuídas pelos gates. O espaço é ocupado pela Decisão de Continuidade, que é um conceito novo sem "casa" no v0.4. Ref: análise 3.4, 3.11, C3, C5.  
**Decisões aplicadas:** D6 (distribuição de atividades), D7 (Domain Builder decide continuidade), D8 (IA sinaliza, não decide)  
**Dependências:** Depende de 2.4.2, 2.4.3, 2.4.4 (cerimônias e gates já definidos).

#### 2.4.6 Seção 2.2.5 — Guardrails da Golden Source

**Natureza:** Modificação  
**Detalhamento:**
- **Renomear** título: "Guardrails da Golden Source" → "Guardrails da Product Canon"
- **Substituir** "Clarificação semântica" → "Clarificação de Conformidade (Compliance Clarification)" (N10, G1)
  - Ampliar escopo: de "divergência com glossário de linguagem ubíqua" para "divergência com vocabulário formalizado na Product Canon" (inclui princípios técnicos)
  - Explicitar atuação: nas sessões de Domain Discovery e Technical Constitution
- **Preservar** "Validação de Consistência" — nome e mecânica mantidos (G2). Atualizar referência: "golden source" → "Product Canon"
- **Modificar** "Versionamento gradual de alterações radicais" → "Versionamento Gradual por Estrangulamento (Strangler Fig)" (N11, G3)
  - Nomear explicitamente o padrão Strangler Fig de Martin Fowler
  - Preservar a mecânica de duas faces (current/next)
  - Atualizar referência: "golden source" → "Product Canon"
  - Adicionar: Canonical Change Plans aprovados são integrados à Product Canon via este mecanismo
- **Preservar** o exemplo da divisão de Faturamento em Cobrança e Receita, atualizando terminologia

**Justificativa:** Guardrails evoluem em escopo (conformidade) e ancoragem (Strangler Fig), sem mudança de mecânica fundamental. Ref: análise 3.9, 3.10, G1, G2, G3.  
**Decisões aplicadas:** D10 (glosa em inglês + português)  
**Dependências:** Depende de 2.3 (Product Canon já definida).

---

### 2.5 Seção 2.3 — Etapa 2 (Especificação Contextualizada)

**Natureza:** Modificação significativa com simplificação  
**Detalhamento:**
- **Substituir** todas as referências: "golden source" → "Product Canon", "plano de alteração conceitual" → "Canonical Change Plan", "usuário de negócio" → "Domain Builder", "arquiteto" → "Architect", "especialista de domínio" → "Domain Expert" (N1, N6, N7, N8, N9)
- **2.3.1 (Injeção de Contexto):** Preservar integralmente. Substituir "golden source" → "Product Canon".
- **2.3.2 (Clarificação e Validação):** Preservar integralmente. Atualizar terminologia.
- **2.3.3 (Plano de Alteração Conceitual):** Recontextualizar:
  - O artefato agora se chama Canonical Change Plan e já existe no Canon Building
  - O Change Plan da Etapa 2 é *incremental* — captura impactos emergentes que só se tornam visíveis quando uma especificação concreta é escrita contra a Product Canon
  - Mudanças fundamentais (novos termos, novas regras, novos BCs) já foram tratadas no Canon Building
  - Preservar o exemplo de "PIX no Checkout" atualizando terminologia
- **2.3.4 (Aprovação Dual):** Modificar substancialmente conforme D9:
  - Aprovação na Etapa 2 é *condicional*: só se o Canonical Change Plan incremental contiver impactos na Product Canon
  - Se o Change Plan for vazio (spec não altera a canon), aprovação é dispensada
  - Se houver impacto, aprovação roteada por camada afetada (retoma mecanismo do v0.4): Domain Expert para negócio, Architect para arquitetura
  - Remover a descrição da aprovação dual como gate principal do modelo — esse papel agora é do Canon Building (F1)
  - Preservar menção a organizações com múltiplos BCs e aprovadores por contexto

**Justificativa:** A antecipação das aprovações para o Canon Building simplifica a Etapa 2. O Change Plan incremental cobre apenas impactos emergentes. Ref: análise 4.1, F1, F2.  
**Decisões aplicadas:** D9 (aprovação condicional com roteamento por camada)  
**Dependências:** Depende de 2.4 (Canon Building já definido com seus gates).

---

### 2.6 Seção 2.4 — Etapa 3 (Retroalimentação)

**Natureza:** Modificação com refinamento de escopo  
**Detalhamento:**
- **Substituir** todas as referências terminológicas (golden source → Product Canon, plano de alteração conceitual → Canonical Change Plan, etc.)
- **Refinar** o escopo da retroalimentação:
  - Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento — essa integração é parcialmente antecipada
  - A Etapa 3 concentra-se em *descobertas emergentes da implementação*: conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código, decisões técnicas não previstas
  - Preservar o parágrafo sobre segurança mecânica ("não há ambiguidade sobre o que atualizar") — fortalecer com referência aos múltiplos Canonical Change Plans aprovados
- **Preservar** a listagem de tipos de atualização (glossário, eventos, regras, ADRs, princípios)

**Justificativa:** A retroalimentação é parcialmente antecipada pelo Canon Building. O escopo residual é mais focado em aprendizados emergentes. Ref: análise 4.2.  
**Decisões aplicadas:** —  
**Dependências:** Depende de 2.4 (Canon Building com integração via Strangler Fig) e 2.5 (Etapa 2 com Change Plans incrementais).

---

### 2.7 Seção 3 — O Ciclo Completo

**Natureza:** Modificação substancial (diagrama e descrição)  
**Detalhamento:**
- **Reescrever** o diagrama ASCII da Etapa 1 para refletir:
  - Três cerimônias nomeadas (Domain Discovery, Technical Constitution, Requirements Specification) com Canonical Change Plans entre elas
  - Gates de aprovação por afinidade (D3) entre cerimônias
  - Decisão de Continuidade do Ciclo (C5) ao final
  - Guardrails atualizados (Clarificação de Conformidade, Validação de Consistência, Versionamento por Estrangulamento)
  - Novos nomes de papéis (Domain Builder, Architect, Domain Expert)
  - Remoção de referências a MARE e SRS
- **Atualizar** o bloco da Etapa 2: remoção de "plano de alteração conceitual gerado automaticamente" como evento central — recontextualizar como Change Plan incremental. Remoção de referência a aprovação dual como gate principal.
- **Atualizar** o bloco da Etapa 3: adicionar distinção entre integração de Change Plans do Canon Building e retroalimentação de descobertas emergentes.
- **Preservar** o parágrafo final sobre enriquecimento cumulativo, atualizando "golden source" → "Product Canon"

**Justificativa:** O diagrama é a representação visual central do modelo — deve refletir fielmente a nova estrutura. Ref: análise completa.  
**Decisões aplicadas:** D3 (gates por afinidade visíveis no diagrama), D10 (termos em inglês)  
**Dependências:** Depende de 2.4, 2.5, 2.6 (todas as etapas já redefinidas).

---

### 2.8 Seção 4 — Papéis no Modelo

**Natureza:** Modificação substancial  
**Detalhamento:**
- **Substituir** "Usuário de Negócio" → "Domain Builder (Construtor de Domínio — analista de negócio, product owner ou gestor de operações)" (P1, N7)
  - Reescrever descrição para refletir participação em cerimônias nomeadas (Domain Discovery, Requirements Specification), não em "pipelines"
  - Adicionar papel na Decisão de Continuidade do Ciclo (D7)
- **Substituir** "Arquiteto" → "Architect (Arquiteto — especialista técnico)" (P3, N9)
  - Reescrever para refletir: conduz Technical Constitution Session (cerimônia formal, não atividades narrativas); aprovador secundário nos gates de Domain Discovery e Requirements Specification; atividades distribuídas pelos gates (D6)
- **Substituir** "IA (Agente de Inteligência Artificial)" → "IA (Agentes LLM — mediadores de cerimônias e guardrails)" (P4)
  - Adicionar cláusula explícita: "sem autonomia decisória" como princípio
  - Adicionar lista indicativa de atos operacionais vs. decisórios (D8): operacional = formatar, sugerir, reorganizar, sinalizar inconsistência, traduzir linguagem natural para SBVR; decisório = incluir/excluir da canon, aprovar Change Plan, resolver ambiguidade de domínio
  - Pluralizar "agentes"
- **Substituir** "Especialista de Domínio" → "Domain Expert (Especialista de Domínio)" (P2, N8)
  - Reescrever para refletir: aprovação antecipada no Canon Building (não apenas na Etapa 2); aprovador primário nos gates de Domain Discovery e Requirements Specification (D3)
- **Atualizar** tabela "Resumo de atuação por etapa":
  - Etapa 1 renomeada para "Canon Building"
  - Domain Builder: participa de Domain Discovery e Requirements Specification; decide continuidade do ciclo
  - Architect: conduz Technical Constitution Session; aprova secundariamente Discovery e Specification; aprova primariamente Constitution
  - Domain Expert: aprova primariamente Discovery e Specification; aprova secundariamente Constitution
  - IA: conduz sessões, gera Canonical Change Plans, opera guardrails; sem autonomia decisória
  - Remover referências a "Event Storming e MARE" → usar nomes das cerimônias
  - Remover referências a "plano de alteração conceitual" → "Canonical Change Plan"

**Justificativa:** Papéis ganham identidade e posicionamento mais preciso. Ref: análise 3.7, 3.8, 4.3, P1–P4.  
**Decisões aplicadas:** D3 (aprovação por afinidade refletida na tabela), D6 (distribuição de atividades do Architect), D7 (Domain Builder decide continuidade), D8 (lista de autonomia operacional vs. decisória), D10 (glosa bilíngue)  
**Dependências:** Depende de 2.4 (cerimônias e gates já definidos).

---

### 2.9 Seção 5 — Estrutura de Artefatos

**Natureza:** Modificação significativa  
**Detalhamento:**
- **Renomear** diretório raiz: `/golden-source/` → estrutura mínima flat sem hierarquia rígida (D1)
- **Substituir** a árvore de diretórios detalhada por uma descrição de seções essenciais da Product Canon:
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
- **Remover** referências a "SRS" como artefatos nomeados (`srs-onboarding.md`, etc.) (A3)
- **Adicionar** nota explícita: a estrutura física é deliberadamente mínima nesta fase de prototipação; a hierarquia final deve emergir da experimentação (D1)
- **Preservar** princípio de que artefatos são markdown versionado em Git

**Justificativa:** A estrutura detalhada do v0.4 era prematura para a fase de prototipação. A Product Canon como conceito unificado foca em identidade e ciclo de vida, não em organização de diretórios. Ref: análise 4.4, A1, A3.  
**Decisões aplicadas:** D1 (estrutura mínima flat), D2 (schema tipado dos Change Plans), D4 (SBVR nos requisitos)  
**Dependências:** Depende de 2.3 (Product Canon já definida) e 2.4 (Canonical Change Plans já definidos).

---

### 2.10 Seção 6 — Cenários de Aplicação

**Natureza:** Modificação terminológica com ajustes pontuais de conteúdo  
**Detalhamento:**
- **6.1 (Greenfield):**
  - Passo 1: "pipeline de Event Storming conversacional" → "Domain Discovery Session"
  - Passo 2: "golden source" → "Product Canon"; "arquiteto" → "Architect"
  - Passo 3: "Via pipeline MARE" → "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA" (D4). Ajustar exemplo para refletir formalização via linguagem natural controlada em vez de framework multi-agente. O agente traduz a linguagem do Domain Builder para SBVR.
  - Passos 4–5: "plano de alteração conceitual" → "Canonical Change Plan incremental (Etapa 2)"; "domain expert" → "Domain Expert"; "golden source" → "Product Canon"
  - Adicionar referência à aprovação no Canon Building que precede os passos 4–5

- **6.2 (Brownfield):**
  - "golden source do produto já existe" → "Product Canon do produto já existe"
  - "plano de alteração conceitual" → "Canonical Change Plan incremental"
  - Recontextualizar: a base conceitual já foi aprovada no Canon Building; o Change Plan da Etapa 2 captura apenas impactos emergentes (D9)
  - "especialistas de domínio" → "Domain Experts"; "arquiteto" → "Architect"

- **6.3 (Migração Gradual):**
  - "sessão de Event Storming" → "Domain Discovery Session"
  - "guardrails de versionamento" → "Versionamento Gradual por Estrangulamento (Strangler Fig)" — nomear o padrão (G3)
  - "golden source" → "Product Canon"
  - "versão next / versão current" → preservar, agora com referência explícita ao Strangler Fig

**Justificativa:** Cenários são veículos de comunicação do modelo. Devem refletir a terminologia e os fluxos atualizados sem perder a narrativa. Ref: análise 4.5.  
**Decisões aplicadas:** D4 (SBVR mediado no cenário greenfield), D9 (Change Plan incremental no brownfield), D10 (glosa bilíngue)  
**Dependências:** Depende de 2.4, 2.5 (etapas já redefinidas).

---

### 2.11 Seção 7 — Dores Endereçadas

**Natureza:** Modificação terminológica + ajuste de conteúdo em 3 linhas  
**Detalhamento:**
- **Substituir** "golden source" → "Product Canon" em todas as linhas da tabela
- **Linha "Usuários de negócio excluídos":** "As pipelines de Event Storming e MARE permitem que pessoas não-técnicas participem" → "As cerimônias de Domain Discovery e Requirements Specification permitem que Domain Builders participem, descrevendo o negócio em linguagem natural. Na Requirements Specification, a IA traduz para SBVR controlado (D4)."
- **Linha "Decisões conceituais tomadas silenciosamente pela IA":** "plano de alteração conceitual" → "Canonical Change Plan". Adicionar menção à cláusula "sem autonomia decisória" (D8).
- **Linha "Revisão de código como único momento de validação":** "aprovação dual (especialista de domínio + arquiteto)" → "aprovação por afinidade (Domain Expert + Architect) nos gates do Canon Building e, condicionalmente, na Etapa 2 (D3, D9)"
- **Preservar** todas as demais linhas com atualização terminológica apenas

**Justificativa:** A tabela é um resumo de valor — deve refletir a terminologia atualizada e os mecanismos revisados. Ref: análise 4.5.  
**Decisões aplicadas:** D3, D4, D8, D9, D10  
**Dependências:** Depende de 2.4, 2.5 (mecanismos já definidos).

---

### 2.12 Seção 8 — Princípios de Design

**Natureza:** Modificação + adição  
**Detalhamento:**
- **"A golden source é viva, não estática"** → **"A Product Canon é viva, não estática."** Substituição terminológica. Preservar conteúdo.
- **"O ciclo é bidirecional"** → Preservar integralmente. Substituir "golden source" → "Product Canon".
- **"Prevenção sobre detecção"** → Fortalecer: com o Canon Building, a prevenção ocorre *ainda mais cedo* — o Canonical Change Plan é revisado antes de qualquer especificação de feature, não apenas antes do código. Adicionar referência à aprovação nos gates cerimoniais (F1).
- **"Separação de autoridade"** → Atualizar nomes dos papéis. Adicionar menção explícita: "A IA tem capacidade de processamento e consistência, mas sem autonomia decisória (D8) — propõe, humanos decidem."
- **"Alterações radicais são graduais"** → Adicionar referência ao padrão Strangler Fig (G3). Preservar exemplo.
- **"Injeção seletiva de contexto"** → Substituir "golden source" → "Product Canon". Preservar integralmente.
- **Adicionar** novo princípio: **"Governança por cerimônia."** O conhecimento da Product Canon é construído e modificado exclusivamente através de cerimônias formais (Domain Discovery, Technical Constitution, Requirements Specification), cada uma com saída padronizada (Canonical Change Plan), gate de aprovação e rastreabilidade. Justificativa: este princípio estava implícito no Canon Building mas não declarado no v0.4.

**Justificativa:** Princípios de design são a fundação filosófica do modelo. O Canon Building fortalece vários deles e introduz um novo (governança por cerimônia). Ref: análise 5 (síntese).  
**Decisões aplicadas:** D3 (refletido em governança por cerimônia), D8 (autonomia da IA em separação de autoridade)  
**Dependências:** Depende de 2.4 (cerimônias já definidas).

---

### 2.13 Seção 9 — Riscos e Limitações Conhecidas

**Natureza:** Modificação + adição  
**Detalhamento:**
- **9.1 (Qualidade do guardrail semântico):** Renomear para "Qualidade do guardrail de conformidade". Escopo ampliado: não apenas semântica do glossário, mas conformidade com toda a Product Canon (G1). O risco é maior porque o escopo de verificação é mais amplo.
- **9.2 (Injeção seletiva de contexto):** Substituir "golden source" → "Product Canon". Preservar integralmente.
- **9.3 (Custo de bootstrap):** Ajustar: o Canon Building é mais estruturado (três cerimônias com gates vs. duas pipelines com combinação livre). O investimento inicial pode ser maior, mas o retorno é mais previsível. Remover referência a "pipelines de Event Storming e MARE" → "cerimônias do Canon Building".
- **9.4 (Disciplina de retroalimentação):** Recontextualizar: parcialmente mitigado pelo Canon Building. Se Canonical Change Plans já são integrados à Product Canon, a Etapa 3 é um incremento menor. O risco residual é sobre descobertas emergentes da implementação.
- **9.5 (Disponibilidade de aprovadores):** Agravamento explícito. Três gates no Canon Building + gate condicional na Etapa 2. Adicionar mitigações do D3: aprovação por afinidade (não dual em todos os gates), aprovação secundária assíncrona com veto, roteamento por camada na Etapa 2 (D9).
- **Adicionar 9.6 (Curva de aprendizado SBVR):** Novo risco. Se a notação SBVR for percebida como técnica ou burocrática pelos Domain Builders, o modelo perde seu diferencial de inclusão. Mitigação: SBVR mediado pela IA (D4) — o Domain Builder fala em linguagem natural, a IA traduz. Risco residual: Domain Builder validando algo que não escreveu diretamente (rubber stamp).
- **Adicionar 9.7 (Perda de detalhamento estrutural):** Novo risco temporário. O Canon Building não detalha fases internas de todas as cerimônias nem a organização física da Product Canon. D5 e D1 mitigam parcialmente. Risco gerenciável — detalhamento deve emergir da prototipação.

**Justificativa:** O perfil de riscos se redistribui com a reformulação. Dois novos riscos são introduzidos. Ref: análise 4.6.  
**Decisões aplicadas:** D1 (risco 9.7), D3 (mitigação 9.5), D4 (risco 9.6), D5 (risco 9.7), D9 (mitigação 9.5)  
**Dependências:** Depende de 2.4 (Canon Building e seus gates já definidos).

---

### 2.14 Seção 10 — Direções para Prototipação

**Natureza:** Modificação + adição  
**Detalhamento:**
- **Item 1:** "Pipeline de Event Storming Conversacional" → "Domain Discovery Session". Preservar objetivo de validação. Adicionar: a sessão deve produzir um Canonical Change Plan tipado como `discovery-plan` (D2).
- **Item 2:** "Guardrail semântico com golden source existente" → "Guardrail de Conformidade com Product Canon existente". "Golden source mínima" → "Product Canon mínima". Escopo ampliado: testar conformidade contra glossário *e* princípios técnicos (G1).
- **Item 3:** "Geração automática do plano de alteração conceitual" → "Geração de Canonical Change Plans em cada cerimônia". O teste deve validar se a IA gera Change Plans corretos com envelope + payload tipado em cada cerimônia (D2), não apenas na Etapa 2.
- **Item 4:** "Validação por aprovadores reais" → Preservar, mas ajustar: testar aprovação por afinidade (D3). Domain Expert aprova primariamente Change Plans de Discovery e Specification; Architect aprova primariamente Constitution. Avaliar se a aprovação secundária assíncrona agrega valor real.
- **Item 5:** "Ciclo completo em escopo reduzido" → Ajustar: o ciclo mínimo agora inclui as três cerimônias do Canon Building + Decisão de Continuidade + Etapa 2 + Etapa 3. Complexidade do protótipo aumenta.
- **Adicionar Item 6:** "Formalização SBVR + SBE mediada pela IA" (novo). Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade (D4); (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis a partir de exemplos concretos. Referência: análise 4.7.
- **Adicionar Item 7:** "Fluxo sequencial com gates entre cerimônias" (novo). Testar se: (a) a habilitação sequencial (aprovação do Change Plan N habilita cerimônia N+1) funciona na prática; (b) aprovadores conseguem lidar com múltiplos Change Plans por ciclo sem gargalo (D3); (c) a Decisão de Continuidade é exercida de forma natural pelo Domain Builder (D7).

**Justificativa:** Direções de prototipação devem refletir os novos componentes e riscos. Ref: análise 4.7.  
**Decisões aplicadas:** D2, D3, D4, D7  
**Dependências:** Depende de todas as seções anteriores.

---

## 3. Cobertura das Decisões D1–D10

Verificação de que cada decisão é aplicada concretamente em pelo menos uma alteração:

| Decisão | Seções onde é aplicada |
|---------|----------------------|
| D1 | 2.3 (nota sobre estrutura mínima), 2.9 (estrutura de artefatos reformulada), 2.13 (risco 9.7) |
| D2 | 2.4.2 (discovery-plan), 2.4.3 (constitution-plan), 2.4.4 (specification-plan), 2.9, 2.14 (itens 1, 3) |
| D3 | 2.4.1 (modelo de aprovação), 2.4.2–2.4.4 (gates), 2.7 (diagrama), 2.8 (papéis/tabela), 2.12 (princípio), 2.13 (risco 9.5), 2.14 (itens 4, 7) |
| D4 | 2.4.4 (Requirements Specification com SBVR mediado), 2.9, 2.10 (cenário greenfield), 2.11, 2.13 (risco 9.6), 2.14 (item 6) |
| D5 | 2.4.2 (fases preservadas na Domain Discovery), 2.4.3 (diretrizes na Technical Constitution), 2.4.4 (diretrizes na Requirements Specification), 2.13 (risco 9.7) |
| D6 | 2.4.2 (Architect valida BCs no gate), 2.4.3 (escopo focado), 2.4.4 (avaliação técnica no gate), 2.4.5 (redistribuição), 2.8 (tabela de papéis) |
| D7 | 2.4.5 (Decisão de Continuidade), 2.8 (Domain Builder na tabela), 2.14 (item 7) |
| D8 | 2.1 (resumo), 2.4.5 (IA sinaliza, não decide), 2.8 (lista operacional/decisório), 2.11, 2.12 (separação de autoridade) |
| D9 | 2.5 (aprovação condicional na Etapa 2), 2.10 (cenário brownfield), 2.11, 2.13 (risco 9.5) |
| D10 | 2.1 (glosa), 2.2, 2.3, 2.4.1–2.4.6, 2.8, 2.10, 2.11 — transversal a todas as seções com termos em inglês |

---

## 4. Ordem de Aplicação Recomendada

As alterações devem ser aplicadas na seguinte ordem para evitar referências a conceitos ainda não definidos:

```
Fase 1 — Fundações (sem dependências entre si)
├── 2.0  Cabeçalho e metadados (versão)
├── 2.3  Seção 2.1 — Product Canon (define o artefato central)
└── 2.2  Seção 1 — Problema (terminologia, sem dependência conceitual)

Fase 2 — Etapa 1 / Canon Building (sequencial por dependência)
├── 2.4.1  Introdução da Etapa 1 (depende de 2.3: Product Canon)
├── 2.4.2  Domain Discovery Session (depende de 2.4.1)
├── 2.4.3  Technical Constitution Session (depende de 2.4.2)
├── 2.4.4  Requirements Specification Session (depende de 2.4.3)
├── 2.4.5  Decisão de Continuidade (depende de 2.4.2–2.4.4)
└── 2.4.6  Guardrails (depende de 2.3: Product Canon)

Fase 3 — Etapas 2 e 3 (dependem do Canon Building)
├── 2.5  Etapa 2 — Especificação (depende de Fase 2)
└── 2.6  Etapa 3 — Retroalimentação (depende de Fase 2 + 2.5)

Fase 4 — Seções transversais (dependem de tudo anterior)
├── 2.7  Ciclo Completo (diagrama — depende de Fases 2 e 3)
├── 2.8  Papéis (depende de Fase 2 para cerimônias e gates)
└── 2.9  Estrutura de Artefatos (depende de 2.3 + Fase 2)

Fase 5 — Seções derivadas (dependem de Fase 4)
├── 2.10 Cenários de Aplicação
├── 2.11 Dores Endereçadas
├── 2.12 Princípios de Design
├── 2.13 Riscos e Limitações
└── 2.14 Direções para Prototipação (última — depende de tudo)
```

**Nota:** Dentro de cada fase, itens listados em paralelo podem ser aplicados em qualquer ordem. A numeração reflete o endereçamento no plano (seção 2.X), não a ordem de aplicação.

---

## 5. Riscos de Execução do Plano

Riscos relativos ao *ato de alterar o documento*, não ao modelo em si.

### 5.1 Inconsistência terminológica residual
**Risco:** Com ~60+ ocorrências de "golden source" e dezenas de referências a papéis e artefatos pelo nome antigo, substituições incompletas podem deixar terminologia mista no documento.  
**Mitigação:** Após aplicar todas as alterações, realizar busca textual por termos deprecados: "golden source", "usuário de negócio", "especialista de domínio", "arquiteto" (em contexto de papel), "pipeline MARE", "plano de alteração conceitual", "clarificação semântica", "SRS".

### 5.2 Perda de exemplos e detalhamento prático
**Risco:** O v0.4 contém exemplos detalhados (fintech, saúde, logística) e blocos de código (princípios técnicos, plano de alteração). Na reescrita, esses elementos podem ser acidentalmente omitidos ou descaracterizados.  
**Mitigação:** Marcar explicitamente cada exemplo e bloco de código como "preservar com atualização terminológica" antes de iniciar a reescrita. Verificar presença de todos os exemplos após conclusão.

### 5.3 Inflação do documento
**Risco:** As adições (nova cerimônia Technical Constitution, Decisão de Continuidade, novos riscos, novos itens de prototipação, lista de autonomia operacional/decisória, novo princípio de design) podem expandir significativamente o tamanho do documento.  
**Mitigação:** A eliminação da MARE (seção inteira), da Combinação de Pipelines (seção inteira) e da Atuação do Arquiteto (seção inteira) libera espaço. Manter descrições concisas para os elementos novos. Alvo: documento v0.5 com tamanho similar ao v0.4 (±15%).

### 5.4 Desalinhamento entre diagrama e texto
**Risco:** O diagrama do Ciclo Completo (seção 3) é uma representação condensada. Se o texto das seções 2.X for alterado sem atualizar o diagrama simultaneamente, haverá divergência.  
**Mitigação:** A ordem de aplicação coloca o diagrama na Fase 4 (após todas as etapas serem redefinidas). Não alterar o diagrama isoladamente.

### 5.5 Glosas em português inconsistentes
**Risco:** A decisão D10 exige glosa em português na primeira ocorrência de cada termo em inglês. Se a "primeira ocorrência" mudar por reordenação de seções, a glosa pode aparecer no lugar errado ou ser duplicada.  
**Mitigação:** Após aplicar todas as alterações, verificar que cada termo canônico (Product Canon, Domain Builder, Domain Expert, Architect, Canonical Change Plan, Domain Discovery Session, Technical Constitution Session, Requirements Specification Session, Clarificação de Conformidade, Versionamento Gradual por Estrangulamento) tem glosa em português exatamente uma vez, na sua primeira ocorrência no documento final.
