# Plano de Atualização do Site ZionKit — v0.6

**Data**: 2026-04-08
**Base**: Documento do modelo v0.6 (2026-04-07) vs. site atual (10 seções)

---

## 1. Análise de Delta (Documento v0.6 vs. Site Atual)

### 1.1 Por seção existente

#### Seção 1 — HeroSection (`#problema`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Narrativa sobre conhecimento fragmentado, exemplo do e-commerce/reembolso, diagrama ContextVoid | §1.1 |
| Mantém | Três parágrafos explicativos sobre o vazio de contexto | §1.1 |
| **Altera** | Título "morre a cada sprint" — tom marketeiro, precisa reescrita | — |
| Adiciona | Menção explícita de que o modelo é protótipo conceitual (transparência) | §Resumo Executivo |

#### Seção 2 — ConsequenciasSection (`#consequencias`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Três problemas (IA no escuro, exclusão não-técnico, conhecimento perdido) | §1.1, §1.2, §1.3 |
| Mantém | Exemplos ilustrativos (cliente inativo, notificações) | §1.2, §1.3 |
| Mantém | Diagrama ThreeGaps | — |
| **Altera** | Título "ninguém resolveu" — tom sensacionalista | — |
| **⚠️ Verificar fonte** | **Todos os 5 dados estatísticos são adições do site, ausentes no v0.6**: "35% dos defeitos de produção" (Accenture), "40% do esforço é retrabalho" (ScopeMaster), "56% das falhas por comunicação" (PMI), "75% mais problemas em áreas críticas" (sem fonte), "65% dos desenvolvedores reportam perda de contexto" (sem fonte). Os 3 primeiros citam fonte, os 2 últimos não. Verificar todas as fontes e remover dados não verificáveis |

#### Seção 3 — SolutionBridgeSection (`#solucao`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Introdução da Product Canon, analogia com constituição | §2, §2.1 |
| Mantém | Descrição do ciclo de três etapas | §2 |
| **Altera** | Título "tivesse uma casa?" — tom marketeiro (menos grave, mas questionável) | — |
| **Adiciona** | Menção à tríade de padrões oficiais (SBVR, IEEE 29148, SBE) — ausente no site | §2 (Tríade) |
| **Adiciona** | Nota de que a IA opera sem autonomia decisória | §2 |

#### Seção 4 — CycleOverviewSection (`#ciclo`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Três etapas do ciclo, diagrama CycleDiagram | §3 |
| **Altera** | Step cards simplificam demais as etapas — "Construir o Conhecimento" não menciona as 3 cerimônias | §2.2 |
| **Altera** | "Usar para Especificar" não menciona o Canonical Change Plan incremental | §2.3 |
| **Altera** | "Devolver o Aprendizado" não menciona sinalização explícita nem detecção assistida | §2.4 |
| **Adiciona** | Menção à Decisão de Continuidade do Ciclo | §2.2.4 |
| **Adiciona** | Edição Direta do Domain Expert como canal complementar | §2.2.6 |

#### Seção 5 — PillarsSection (`#pilares`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Estrutura de 3 tabs (Canon Building, Spec Contextualizada, Retroalimentação) | §2.2, §2.3, §2.4 |
| Mantém | Exemplos (fintech, saúde, faturamento/cobrança) | §2.2.1, §2.3, §2.4 |
| Mantém | 3 sessões do Canon Building, gates de aprovação | §2.2 |
| **Altera** | Sessão 1 não menciona Event Storming explicitamente como metodologia | §2.2.1 |
| **Altera** | Sessão 2 é genérica — v0.6 detalha princípios técnicos constitucionais, níveis de aderência IEEE 29148 | §2.2.2 |
| **Altera** | Sessão 3 não menciona validação semântica interna (SBVR), ciclo iterativo de clarificação, formato IEEE 29148 + SBE | §2.2.3 |
| **Altera** | Tab "Retroalimentação" não menciona sinalização explícita (`CANON-DISCOVERY`), detecção assistida, mecanismo de aprovação leve com escalação | §2.4 |
| **Altera** | Tab "Especificação Contextualizada" não menciona injeção seletiva de contexto, aprovação condicional, Change Plan tipado como `incremental-plan` | §2.3 |
| **Adiciona** | Detalhamento das metodologias por sessão (Event Storming, IEEE 29148, SBE) | §2.2.1–2.2.3 |
| **Adiciona** | Conceito de Canonical Change Plan com envelope de metadados | §5.1 |
| **Adiciona** | Aprovação por afinidade (primária + secundária assíncrona com janela de veto) | §2.2 |

#### Seção 6 — RolesSection (`#papeis`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | 4 papéis (Domain Builder, Architect, Domain Expert, IA) | §4 |
| Mantém | Descrições básicas e analogias | §4 |
| Mantém | Diagrama RolesMatrix | — |
| **Altera** | Domain Expert: falta menção a anotações contextuais, hotspots de domínio, edição direta | §4 |
| **Altera** | IA: falta distinção explícita entre atos operacionais vs. decisórios | §4 |
| **Adiciona** | Protocolo de Perspectiva Assistida (acúmulo de papéis) | §4 |
| **Adiciona** | Tabela resumo de atuação por etapa (presente no v0.6 §4) | §4 |

#### Seção 7 — ComparisonSection (`#comparacao`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | 7 comparações antes/depois | §7 (Dores) |
| **Adiciona** | Item sobre conhecimento tácito preso na cabeça de indivíduos → Product Canon formaliza e versiona (v0.6 §7 item 1, ausente no site) | §7 |
| **Adiciona** | Item sobre revisão de código como único momento de validação → gates de aprovação operam antes da implementação (v0.6 §7 item 9, ausente no site) | §7 |

**Nota:** O site já contém o item sobre decisões técnicas dispersas (item #6 na lista existente), que o plano anterior propunha como adição. A adição correta é o item sobre conhecimento tácito (v0.6 §7 #1).

#### Seção 8 — CanonDeepDiveSection (`#canon`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | Duas camadas (Negócio e Arquitetura) | §2.1 |
| Mantém | Itens principais de cada camada | §2.1 |
| **Altera** | Camada de Negócio: falta menção a formato IEEE 29148 + SBE nos requisitos | §2.1 |
| **Altera** | Camada de Negócio: falta conceito de hotspots de domínio como metadados | §2.1, §4 |
| **Adiciona** | Menção aos níveis de aderência IEEE 29148 nos princípios técnicos | §2.2.2 |
| **Adiciona** | Menção ao envelope do Canonical Change Plan como artefato da Canon | §5.1 |

#### Seção 9 — ScenariosSection (`#cenarios`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | 3 cenários (Greenfield, Brownfield, Mudança Grande) | §6.1, §6.2, §6.3 |
| **Altera** | Cenário 1: v0.6 é mais detalhado — menciona CTO na Technical Constitution, nível Mínimo de aderência, gaps identificados, Canonical Change Plans tipados | §6.1 |
| **Altera** | Cenário 2: v0.6 detalha roteamento de aprovação por bounded context, Domain Expert de Faturamento identificando conflito | §6.2 |
| **Altera** | Cenário 3: v0.6 detalha conclusão formal pelo Architect, faces current/next | §6.3 |

#### Seção 10 — GlossarySection (`#glossario`)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| Mantém | 15 termos com definição e analogia | — |
| **Adiciona** | Termos novos do v0.6 (ver §4.2) | — |

#### CTA Banner (entre seções 9 e 10)
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| **Altera** | "Experimente com seu produto" + "veja a diferença no primeiro ciclo" — tom marketeiro/CTA de conversão | — |

#### Footer
| Status | Conteúdo | Referência v0.6 |
|--------|----------|-----------------|
| **Altera** | Tagline "O conhecimento do seu produto, formalizado e versionado" — tom de slogan | — |
| **Altera** | Newsletter "Receba atualizações" + "Inscrever" — funcionalidade fake (exibe "Funcionalidade em breve! Obrigado pelo interesse."). Remover ou substituir por links reais | — |

---

### 1.2 Conceitos sem representação no site

| Conceito do v0.6 | Seção no documento | Proposta de inclusão |
|---|---|---|
| **Tríade de padrões oficiais (SBVR, IEEE 29148, SBE)** | §2 | SolutionBridgeSection (depth 1, explicação acessível) + CanonBuildingSection (depth 2, como cada padrão atua) |
| **Níveis de aderência IEEE 29148** (Mínimo, Moderado, Completo) | §2.2.2 | CanonBuildingSection (dentro da Technical Constitution Session) |
| **Envelope do Canonical Change Plan** (campos obrigatórios, tipagem) | §5.1 | ChangePlanSection (depth 3, seção dedicada nova) |
| **5 tipos de Change Plan** | §2.2, §2.3, §5.1 | ChangePlanSection (depth 3) |
| **Aprovação por afinidade** (primária + secundária assíncrona + janela de veto) | §2.2 | CanonBuildingSection (depth 2) + ChangePlanSection (depth 3, mecânica detalhada) |
| **Edição Direta do Domain Expert** | §2.2.6 | DirectEditSection (depth 3, seção dedicada nova) |
| **Relatório de Conformidade** | §2.2.6 | DirectEditSection (depth 3) |
| **`expert-edit-plan`** e aprovação sequencial obrigatória | §2.2.6 | DirectEditSection (depth 3) |
| **Protocolo de Perspectiva Assistida** | §4 | RolesSection (depth 2) |
| **Hotspots de domínio** | §4 | GuardrailsSection (depth 2, dentro de Clarificação de Conformidade) |
| **Anotações contextuais** (ciclo de vida: formalizar/descartar/adiar) | §4 | EnrichmentSection (depth 2, como insumos para cerimônias futuras) + RolesSection (ação do Domain Expert) |
| **Injeção seletiva de contexto** (como conceito detalhado) | §2.3.1 | SpecCraftingSection (depth 2) |
| **Sinalização explícita** (`CANON-DISCOVERY`) e detecção assistida | §2.4 | EnrichmentSection (depth 2) |
| **Mecanismo de aprovação leve com escalação condicional** (Etapa 3) | §2.4 | EnrichmentSection (depth 2) |
| **Aprovação condicional** na Etapa 2 (Change Plan vazio = sem gate) | §2.3.4 | SpecCraftingSection (depth 2) |
| **Decisão de Continuidade do Ciclo** com 3 caminhos | §2.2.4 | CanonBuildingSection (depth 2) |
| **Checkpoint de nível de aderência IEEE 29148** na Decisão de Continuidade | §2.2.4 | CanonBuildingSection (depth 2) |
| **Pré-condição do caminho (b)** na Decisão de Continuidade | §2.2.4 | CanonBuildingSection (depth 2) |
| **Princípios de Design** (7 princípios formais) | §8 | Distribuídos nas seções temáticas (ver §3.3) |
| **Riscos e Limitações** (10 riscos documentados) | §9 | RiscosSection (depth 2, seção dedicada nova) |
| **Direções para Prototipação** | §10 | Fora do escopo do site explicativo |
| **Clarificação de Conformidade** (guardrail nomeado) | §2.2.5 | GuardrailsSection (depth 2, seção dedicada nova) |
| **Validação de Consistência** (guardrail nomeado) | §2.2.5 | GuardrailsSection (depth 2) |
| **Validação Semântica Interna** (guardrail nomeado) | §2.2.5 | GuardrailsSection (depth 2) |
| **Padronização Canônica** (guardrail nomeado) | §2.2.5 | GuardrailsSection (depth 2) |
| **Versionamento por Estrangulamento** — detalhes completos | §2.2.5 | GuardrailsSection (depth 2, com detalhes de escopo, conclusão, cancelamento) |
| **Governança por cerimônia com canal de exceção** (princípio §8) | §8 | CanonBuildingSection (depth 2, como princípio orientador) |

---

## 2. Análise de Tom e Linguagem

### 2.1 Trechos marketeiros identificados

#### 1. Título da HeroSection
**Original:**
> O conhecimento do seu produto <span class="gradient-text">morre a cada sprint</span>

**Problema:** Frase de impacto sensacionalista. "Morre" é dramatização.

**Reescrita proposta:**
> O conhecimento do seu produto <span class="gradient-text">está espalhado em lugares que a IA não alcança</span>

---

#### 2. Título da ConsequenciasSection
**Original:**
> Três problemas que <span class="gradient-text">ninguém resolveu</span>

**Problema:** "Ninguém resolveu" é absolutismo sensacionalista.

**Reescrita proposta:**
> Três problemas que <span class="gradient-text">persistem no desenvolvimento com IA</span>

---

#### 3. Título da SolutionBridgeSection
**Original:**
> E se todo o conhecimento do seu produto <span class="gradient-text">tivesse uma casa?</span>

**Problema:** Questionamento retórico com apelo emocional (menor gravidade, mas padrão de marketing).

**Reescrita proposta:**
> Um repositório central para <span class="gradient-text">todo o conhecimento do produto</span>

---

#### 4. Título da CycleOverviewSection
**Original:**
> O ciclo que faz o <span class="gradient-text">conhecimento crescer</span>

**Problema:** Menor gravidade, mas "faz o conhecimento crescer" é promessa implícita.

**Reescrita proposta:**
> Como o ciclo de <span class="gradient-text">três etapas funciona</span>

---

#### 5. CTA Banner — título
**Original:**
> Experimente com seu produto

**Problema:** CTA de conversão explícito. O site é explicativo, não comercial.

**Reescrita proposta:**
> Quer reler desde o início?

---

#### 6. CTA Banner — descrição
**Original:**
> Aplique o modelo ZionKit ao seu produto e veja a diferença no primeiro ciclo.

**Problema:** Promessa de resultado ("veja a diferença"). Tom de vendas.

**Reescrita proposta:**
> O ZionKit é um modelo conceitual em fase de prototipação. A leitura completa leva cerca de 15 minutos.

---

#### 7. Footer — tagline
**Original:**
> O conhecimento do seu produto, formalizado e versionado.

**Problema:** Menor gravidade. Factual, mas tem tom de slogan.

**Reescrita proposta:**
> Modelo conceitual para desenvolvimento de software orientado por especificações.

---

#### 8. Footer — Newsletter
**Original:**
> Receba atualizações / Inscrever → "Funcionalidade em breve! Obrigado pelo interesse."

**Problema:** CTA de conversão com funcionalidade fake — exibe mensagem enganosa quando o usuário tenta se inscrever.

**Ação proposta:** Remover completamente. Substituir por links úteis (repositório GitHub, documento do modelo) ou nota de status do projeto.

---

#### 9. Título da RolesSection
**Original:**
> Cada decisão é tomada por quem tem <span class="gradient-text">competência sobre ela</span>

**Problema:** Tom assertivo/marketeiro. Apresenta como fato consumado algo que é proposta do modelo.

**Reescrita proposta:**
> Quatro papéis com <span class="gradient-text">autoridades complementares</span>

---

#### 10. Analogia da IA nos papéis
**Original:**
> A secretária mais competente do mundo — organiza, lembra, sinaliza, mas nunca assina pelo chefe.

**Problema:** "Mais competente do mundo" é hipérbole. A analogia em si é boa, só precisa remover o superlativo.

**Reescrita proposta:**
> Uma assistente que organiza, lembra e sinaliza — mas nunca decide pelo responsável.

---

#### 11. Dados estatísticos sem fonte verificável
**Original (ConsequenciasSection):**
> 75% mais problemas de lógica em áreas críticas de negócio
> 65% dos desenvolvedores reportam que a IA "perde contexto relevante"

**Problema:** Dados sem atribuição de fonte. Os outros 3 dados (35% Accenture, 40% ScopeMaster, 56% PMI) citam fontes, mas também precisam de verificação — nenhuma estatística aparece no v0.6.

**Ação proposta:** Verificar fontes dos 3 dados atribuídos. Remover os 2 dados sem fonte ou substituir por formulação qualitativa ("é comum que..." / "frequentemente...").

---

## 3. Reorganização de Seções

### 3.1 Estrutura proposta

| # | ID | Nome | Depth | Conteúdo principal | Diagrama |
|---|---|---|---|---|---|
| 1 | `problema` | O Problema | 1 | Vazio de contexto entre conhecimento de negócio e código. Exemplo e-commerce. | ContextVoidDiagram (existente) |
| 2 | `consequencias` | Três Problemas Estruturais | 1 | IA sem contexto, exclusão do não-técnico, perda de aprendizado. Exemplos. | ThreeGapsDiagram (existente) |
| 3 | `solucao` | O Modelo ZionKit | 1 | Introdução da Product Canon, tríade de padrões (SBVR/IEEE/SBE), ciclo de 3 etapas. Nota de protótipo. | Nenhum (texto + badge) |
| 4 | `ciclo` | O Ciclo de Três Etapas | 1 | Visão geral das 3 etapas + Decisão de Continuidade + Edição Direta como canal complementar. | CycleDiagram (existente, expandir) |
| 5 | `canon-building` | Canon Building — Construir o Conhecimento | 2 | Detalhamento das 3 cerimônias. Metodologias. Gates de aprovação. Decisão de Continuidade com checkpoint IEEE. Exemplos fintech. | CanonBuildingDiagram (existente, expandir) + **NOVO**: CeremonyFlowDiagram |
| 6 | `spec-crafting` | Spec Crafting — Especificação Contextualizada | 2 | Injeção seletiva, clarificação/validação, Change Plan incremental, aprovação condicional. Exemplo saúde. | ContextualSpecDiagram (existente) |
| 7 | `enrichment` | Canon Enrichment — Retroalimentação | 2 | Descobertas emergentes, sinalização explícita, detecção assistida, aprovação leve com escalação. Anotações contextuais e ciclo de vida. | FeedbackDiagram (existente, expandir) |
| 8 | `guardrails` | Guardrails — Como a Integridade é Mantida | 2 | Os 5 guardrails nomeados. Hotspots de domínio como conceito transversal. | **NOVO**: GuardrailsDiagram |
| 9 | `papeis` | Os Quatro Papéis | 2 | Domain Builder, Architect, Domain Expert, IA. Protocolo de Perspectiva Assistida. Tabela de atuação por etapa. | RolesMatrixDiagram (existente, atualizar) |
| 10 | `change-plan` | O Canonical Change Plan | 3 | Envelope de metadados, 5 tipos, fluxo de aprovação por afinidade, janela de veto, rejeição/devolução. | **NOVO**: ChangePlanEnvelopeDiagram |
| 11 | `canon` | Anatomia da Product Canon | 3 | Duas camadas detalhadas, artefatos, hotspots, anotações contextuais, níveis de aderência. | Nenhum (layout cards existente) |
| 12 | `edicao-direta` | Edição Direta do Domain Expert | 3 | Fluxo operacional, guardrails iterativos, Relatório de Conformidade, `expert-edit-plan`, aprovação sequencial. | **NOVO**: DirectEditFlowDiagram |
| 13 | `comparacao` | Antes e Depois | 1 | Tabela comparativa expandida (9 itens). | BeforeAfterDiagram (existente) |
| 14 | `cenarios` | ZionKit em Ação | 1 | 3 cenários detalhados com terminologia v0.6. | Nenhum (timeline existente) |
| 15 | `riscos` | Riscos e Limitações | 2 | 10 riscos documentados no v0.6, com mitigações. Nota de protótipo. | Nenhum |
| 16 | `glossario` | Glossário | — | Todos os termos (existentes + novos). Busca filtrável. | Nenhum |

---

### 3.2 Justificativas estruturais

**Seções 5, 6, 7 — Desmembramento da PillarsSection:**
A PillarsSection atual (depth 2) concentra as 3 etapas em tabs. O v0.6 adiciona detalhamento substancial a cada etapa (cerimônias, guardrails, change plans tipados, aprovação condicional). Tabs limitam a profundidade de conteúdo. Proposta: desmembrar em 3 seções independentes (uma por etapa), cada uma depth 2.

**Seção 8 — Guardrails (nova):**
O v0.6 define 5 guardrails nomeados com responsabilidades distintas. O site atual menciona guardrails apenas no glossário. Conceito central do modelo — merece seção própria (depth 2) com diagrama explicativo.

**Seção 10 — Canonical Change Plan (nova):**
O v0.6 define o Change Plan como artefato central com envelope tipado, 5 tipos e fluxo de aprovação detalhado. Conceito complexo — seção dedicada (depth 3) com diagrama visual do envelope.

**Seção 12 — Edição Direta (nova):**
Funcionalidade nova no v0.6 com fluxo operacional próprio, guardrails iterativos e aprovação sequencial. Seção depth 3 dedicada.

**Seção 15 — Riscos e Limitações (nova):**
O v0.6 documenta 10 riscos. Transparência é constraint do tom. Seção depth 2 apresenta riscos de forma didática.

**Remoção do CTA Banner:**
O CTA "Experimente com seu produto" é incompatível com o tom do site. Substituir por nota informativa discreta ou remover.

**Reestruturação do Footer:**
Remover newsletter fake. Substituir por links úteis e nota de status.

### 3.3 Distribuição dos Princípios de Design (v0.6 §8)

Os 7 Princípios de Design do v0.6 não justificam seção própria — são princípios orientadores que se integram naturalmente nas seções temáticas:

| Princípio | Seção de destino | Como incorporar |
|---|---|---|
| "A Product Canon é viva, não estática" | SolutionBridgeSection (#3) | Integrar na descrição da Product Canon |
| "O ciclo é bidirecional" | CycleOverviewSection (#4) | Reforçar na narrativa do ciclo |
| "Prevenção sobre detecção" | CanonBuildingSection (#5) | Mencionar na introdução dos gates de aprovação |
| "Separação de autoridade" | RolesSection (#9) | Já implícito — explicitar como princípio de design |
| "Alterações radicais são graduais" | GuardrailsSection (#8) | Incluir no Versionamento por Estrangulamento |
| "Injeção seletiva de contexto" | SpecCraftingSection (#6) | Já planejado como conceito central |
| "Governança por cerimônia com canal de exceção" | CanonBuildingSection (#5) | Introduzir como princípio na abertura, referenciar Edição Direta |

**Regra:** Cada princípio é mencionado uma única vez na seção temática relevante, como nota contextual ("Este é um dos princípios de design do modelo: ..."), não como bloco separado.

---

## 4. Plano de Implementação

### 4.1 Mudanças por seção (ordem de implementação)

#### Fase 1 — Correções de tom e conteúdo (seções existentes, independentes entre si)

**1.1 — HeroSection**
- **Arquivo:** `src/components/sections/HeroSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Reescrever título: "O conhecimento do seu produto está espalhado em lugares que a IA não alcança"
  - Adicionar parágrafo introdutório mencionando status de protótipo conceitual
- **Depth:** 1

**1.2 — ConsequenciasSection**
- **Arquivo:** `src/components/sections/ConsequenciasSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Reescrever título: "Três problemas que persistem no desenvolvimento com IA"
  - Verificar fontes dos 3 dados atribuídos (Accenture, ScopeMaster, PMI)
  - Remover os 2 dados sem fonte ("75%", "65%") ou substituir por formulação qualitativa
- **Depth:** 1

**1.3 — SolutionBridgeSection**
- **Arquivo:** `src/components/sections/SolutionBridgeSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Reescrever título: "Um repositório central para todo o conhecimento do produto"
  - Adicionar parágrafo sobre tríade de padrões (SBVR, IEEE 29148, SBE) em linguagem acessível: "O ZionKit se apoia em três padrões: um para estruturar requisitos (IEEE 29148), um para verificá-los com exemplos concretos (SBE), e um que a IA usa internamente para encontrar ambiguidades (SBVR)"
  - Adicionar nota: "A IA propõe e sinaliza — quem decide é sempre o humano."
  - Integrar princípio "A Product Canon é viva, não estática" na descrição
  - Manter analogia da constituição (boa)
- **Depth:** 1

**1.4 — CycleOverviewSection**
- **Arquivo:** `src/components/sections/CycleOverviewSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Reescrever título: "Como o ciclo de três etapas funciona"
  - Atualizar step cards com terminologia v0.6 (Canon Building, Spec Crafting, Canon Enrichment)
  - Adicionar menção à Decisão de Continuidade e ao canal de Edição Direta
  - Integrar princípio "O ciclo é bidirecional" na narrativa
- **Depth:** 1

**1.5 — RolesSection**
- **Arquivo:** `src/components/sections/RolesSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Reescrever título: "Quatro papéis com autoridades complementares"
  - Atualizar descrições dos papéis com conteúdo v0.6:
    - Domain Expert: adicionar anotações contextuais, hotspots, edição direta
    - IA: adicionar distinção operacional vs. decisório
  - Adicionar bloco sobre Protocolo de Perspectiva Assistida
  - Corrigir analogia da IA (remover "mais competente do mundo")
  - Adicionar tabela resumo de atuação por etapa (do v0.6 §4)
  - Explicitar princípio "Separação de autoridade" como princípio de design
- **Depth:** 2
- **Componentes:** Atualizar `RolesMatrixDiagram` com novos dados

**1.6 — ComparisonSection**
- **Arquivo:** `src/components/sections/ComparisonSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Adicionar 2 comparações novas:
    - "Conhecimento de domínio tácito, preso na cabeça de indivíduos" → "Product Canon formaliza e versiona o conhecimento em documentos acessíveis a todos"
    - "Revisão de código é o único momento de validação de qualidade" → "Gates de aprovação operam antes da implementação, verificando coerência de negócio e viabilidade técnica"
  - Mover `sectionNumber` para 13
- **Depth:** 1

**1.7 — ScenariosSection**
- **Arquivo:** `src/components/sections/ScenariosSection.astro`
- **Tipo:** Edição de conteúdo
- **Mudança:**
  - Enriquecer cenários com terminologia v0.6:
    - Cenário 1: mencionar CTO na Technical Constitution, nível Mínimo, Canonical Change Plans tipados
    - Cenário 2: mencionar roteamento por bounded context, Domain Expert de Faturamento
    - Cenário 3: mencionar faces current/next, conclusão formal pelo Architect
  - Mover `sectionNumber` para 14
- **Depth:** 1

**1.8 — CTA Banner**
- **Arquivo:** `src/pages/index.astro`
- **Tipo:** Remoção / substituição
- **Mudança:** Remover CTA marketeiro. Substituir por nota informativa discreta:
  - "O ZionKit é um modelo conceitual em fase de prototipação. Este site explica como o modelo funciona."
- **Depth:** N/A

**1.9 — Footer**
- **Arquivo:** `src/components/layout/Footer.astro`
- **Tipo:** Edição
- **Mudança:**
  - Remover newsletter fake (incluindo o campo de email e o botão "Inscrever")
  - Alterar tagline para: "Modelo conceitual para desenvolvimento de software orientado por especificações"
  - Adicionar link para documento do modelo (quando publicado)
  - Adicionar nota de status: "Protótipo conceitual — v0.6"
- **Depth:** N/A

---

#### Fase 2 — Desmembramento da PillarsSection (independente da Fase 1)

**2.1 — CanonBuildingSection (nova)**
- **Arquivo:** `src/components/sections/CanonBuildingSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:**
  - Reutilizar `CanonBuildingDiagram` (existente)
  - **NOVO**: `CeremonyFlowDiagram.tsx` + `src/lib/diagrams/ceremony-flow-diagram.ts` — diagrama do fluxo sequencial das 3 cerimônias com gates de aprovação entre elas e Decisão de Continuidade
- **Conteúdo:**
  - Princípio orientador: "Governança por cerimônia com canal de exceção" (§8) — toda mudança na Product Canon passa por processo formal
  - **Sessão 1 — Domain Discovery Session:**
    - Baseada em Event Storming: "É uma técnica onde você conta a história do negócio e alguém organiza em um mapa — no ZionKit, esse alguém é a IA"
    - 4 fases: descoberta de eventos, identificação de comandos/atores, mapeamento de agregados/bounded contexts, decomposição de casos de uso
    - Exemplo fintech completo (do v0.6)
    - Saída: `discovery-plan` → aprovação primária Domain Expert + secundária Architect
  - **Sessão 2 — Technical Constitution Session:**
    - Architect define princípios técnicos constitucionais
    - Exemplo de princípios (stack, comunicação, persistência, segurança, observabilidade)
    - Níveis de aderência IEEE 29148 (Mínimo, Moderado, Completo) — explicar com analogia: "nível de detalhe de uma planta de casa"
    - Saída: `constitution-plan` → aprovação primária Architect + secundária Domain Expert
  - **Sessão 3 — Requirements Specification Session:**
    - Domain Builder descreve requisitos → IA valida (SBVR interno) → clarificação iterativa → formalização IEEE 29148 + SBE
    - Exemplo de requisito formalizado (REQ-CANCEL-001 do v0.6)
    - Saída: `specification-plan` → aprovação primária Domain Expert + secundária Architect
  - **Decisão de Continuidade:**
    - 3 caminhos (mais fluxos, mais requisitos, encerrar)
    - Pré-condição do caminho (b): só pode voltar direto para Requirements Specification se os bounded contexts já foram mapeados e têm constituição técnica definida; caso contrário, volta para Domain Discovery
    - Checkpoint de nível de aderência IEEE 29148: IA apresenta sinais indicativos de que o nível atual pode ser insuficiente (requisitos com dependências não rastreadas, requisitos não-funcionais aparecendo, rejeições por ambiguidade de escopo)
  - Princípio "Prevenção sobre detecção" — gates de aprovação capturam inconsistências no momento mais barato de corrigi-las
- **Depth:** 2

**2.2 — SpecCraftingSection (nova)**
- **Arquivo:** `src/components/sections/SpecCraftingSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:** Reutilizar `ContextualSpecDiagram` (existente)
- **Conteúdo:**
  - Injeção seletiva de contexto: "A IA não recebe toda a Product Canon — só os pedaços relevantes para a tarefa" (princípio de design §8)
  - Clarificação e validação contextualizada
  - Canonical Change Plan incremental (`incremental-plan`)
  - Aprovação condicional (Change Plan vazio = sem gate)
  - Aprovação por camada afetada (Domain Expert → negócio, Architect → arquitetura)
  - Exemplo completo (PIX no checkout, do v0.6)
- **Depth:** 2

**2.3 — EnrichmentSection (nova)**
- **Arquivo:** `src/components/sections/EnrichmentSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:** Reutilizar `FeedbackDiagram` (existente, expandir)
- **Conteúdo:**
  - Integração de Change Plans aprovados (parcialmente antecipada via Versionamento por Estrangulamento)
  - Descobertas emergentes — dois mecanismos complementares:
    - Sinalização explícita (`CANON-DISCOVERY`): desenvolvedor marca descobertas durante implementação
    - Detecção assistida pela IA: compara código contra Product Canon, identifica conceitos não sinalizados
  - Mecanismo de aprovação leve com escalação condicional:
    - Guardrails sem problemas → revisão assíncrona (janela de veto)
    - Guardrails com problemas → escalação para Change Plan formal
  - Anotações contextuais e ciclo de vida:
    - Anotações não formalizadas em ciclos anteriores são reapresentadas como candidatos
    - Resolução obrigatória: formalizar, descartar ou adiar
    - Adiamentos consecutivos (>2 ciclos) ativam sinalização da IA
  - Exemplo: conceito "OfertaExpirada" aparece no código mas não no glossário
- **Depth:** 2

**2.4 — Remover PillarsSection**
- **Arquivo:** `src/components/sections/PillarsSection.astro`
- **Tipo:** Remoção (substituída por 3 novas seções)
- **Dependência:** Executar após 2.1–2.3 estarem implementados e funcionais

---

#### Fase 3 — Novas seções (independente da Fase 2, exceto dependências indicadas)

**3.1 — GuardrailsSection (nova)**
- **Arquivo:** `src/components/sections/GuardrailsSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:**
  - **NOVO**: `GuardrailsDiagram.tsx` + `src/lib/diagrams/guardrails-diagram.ts` — diagrama visual dos 5 guardrails com seus pontos de atuação
- **Conteúdo:**
  - Introdução: "Guardrails são mecanismos automáticos que a IA usa para manter a integridade da Product Canon"
  - 5 guardrails explicados didaticamente:
    1. **Clarificação de Conformidade** — "Se você diz 'cliente' onde o glossário define 'titular da conta', a IA pergunta: 'Você quis dizer titular da conta?'" Inclui: hotspots de domínio recebem atenção especial — a IA exibe proativamente a definição e alerta sobre incerteza registrada
    2. **Validação de Consistência** — "Se você propõe algo que contradiz uma regra existente, a IA mostra a contradição antes de aceitar"
    3. **Validação Semântica Interna** — "A IA usa internamente métodos formais (como SBVR) para encontrar ambiguidades — mas apresenta os problemas como perguntas simples"
    4. **Padronização Canônica** — "Tudo que entra na Product Canon precisa estar no formato padrão (IEEE 29148 + SBE). A IA faz a formatação automaticamente." Dois modos: implícito nas cerimônias, explícito na edição direta
    5. **Versionamento por Estrangulamento** — "Mudanças grandes são aplicadas aos poucos. A Product Canon mantém duas versões: a vigente (current) e a em transição (next)." Escopo declarado, conclusão pelo Architect, cancelamento possível. Heurística de impacto cross-context. Princípio "Alterações radicais são graduais" (§8)
- **Depth:** 2

**3.2 — ChangePlanSection (nova)**
- **Arquivo:** `src/components/sections/ChangePlanSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:**
  - **NOVO**: `ChangePlanEnvelopeDiagram.tsx` + `src/lib/diagrams/change-plan-envelope-diagram.ts` — diagrama visual do envelope com campos e fluxo de aprovação
- **Conteúdo:**
  - O que é: "Documento que descreve exatamente o que vai mudar na Product Canon"
  - Envelope de metadados — campos universais: id, type, status, author, created-at, scope, approvals
  - Campos condicionais: affected-layer, edited-artifacts, compliance-report, conditionality
  - 5 tipos explicados com contexto de uso:
    - `discovery-plan` — saída da Domain Discovery Session
    - `constitution-plan` — saída da Technical Constitution Session
    - `specification-plan` — saída da Requirements Specification Session
    - `expert-edit-plan` — saída da Edição Direta
    - `incremental-plan` — saída da Spec Crafting (condicional)
  - Fluxo de aprovação por afinidade: primária (papel com expertise) + secundária assíncrona (janela de veto, expiração = aprovação tácita)
  - Exceção: `expert-edit-plan` tem aprovação sequencial obrigatória (expiração = bloqueio)
  - Rejeição: devolução com motivo, resubmissão ou abandono. Sem rejeição parcial
  - Exemplo visual do Change Plan incremental (PIX no checkout)
- **Depth:** 3

**3.3 — DirectEditSection (nova)**
- **Arquivo:** `src/components/sections/DirectEditSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:**
  - **NOVO**: `DirectEditFlowDiagram.tsx` + `src/lib/diagrams/direct-edit-flow-diagram.ts` — diagrama do fluxo: edição → guardrails iterativos → expert-edit-plan → aprovação sequencial
- **Conteúdo:**
  - Quando usar: "Para capturar conhecimento que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual"
  - Escopo limitado: apenas camada de negócio, apenas refinamentos/correções
  - Fluxo de guardrails iterativos (ciclo até resolução)
  - Relatório de Conformidade (4 seções fixas: divergências terminológicas, contradições com regras existentes, impactos em bounded contexts adjacentes, divergências intencionais aceitas)
  - `expert-edit-plan` com aprovação sequencial obrigatória (Domain Expert → Architect)
  - Salvaguardas: tipagem distinta para auditoria, fricção deliberada, proporção de `expert-edit-plan` como sinal de contorno
- **Depth:** 3

**3.4 — RiscosSection (nova)**
- **Arquivo:** `src/components/sections/RiscosSection.astro` (criar)
- **Tipo:** Criação
- **Componentes:** Nenhum diagrama
- **Conteúdo:**
  - Introdução: "Todo modelo tem limitações. O ZionKit documenta as suas abertamente."
  - Nota de status: "O modelo é um protótipo conceitual que ainda não foi testado em produção."
  - 10 riscos, cada um com: o que pode dar errado + o que o modelo faz para mitigar:
    1. Qualidade dos guardrails depende da capacidade da IA
    2. Injeção seletiva de contexto é problema não trivial
    3. Custo de bootstrap — construir a Product Canon inicial exige investimento
    4. Disciplina de retroalimentação — equipes sob pressão podem pular a Etapa 3
    5. Disponibilidade de aprovadores — múltiplos gates exigem múltiplos aprovadores
    6. Qualidade da tradução de validação interna para linguagem natural
    7. Acúmulo de papéis pode degradar governança
    8. Concorrência de transições no Versionamento por Estrangulamento
    9. Estagnação no nível Mínimo de aderência IEEE 29148
    10. Perda de detalhamento estrutural (escolha deliberada nesta fase)
- **Depth:** 2

**3.5 — CanonDeepDiveSection (atualizar)**
- **Arquivo:** `src/components/sections/CanonDeepDiveSection.astro`
- **Tipo:** Edição
- **Mudança:**
  - Camada de Negócio: adicionar "formato IEEE 29148 + SBE" nos requisitos
  - Adicionar menção a hotspots de domínio e anotações contextuais como metadados
  - Camada de Arquitetura: adicionar menção a níveis de aderência IEEE 29148 nos princípios técnicos
  - Adicionar Canonical Change Plans (com envelope tipado) como artefato da Canon
  - Mover `sectionNumber` para 11
- **Depth:** 3

**3.6 — GlossarySection (atualizar)**
- **Arquivo:** `src/components/sections/GlossarySection.astro`
- **Tipo:** Edição
- **Mudança:** Adicionar novos termos (ver §4.2), atualizar `sectionNumber` para 16
- **Dependência:** Deve ser implementado por último (depende de todas as seções para terminologia final)
- **Depth:** —

---

### 4.2 Novos termos para o glossário

| Termo | Definição | Analogia |
|---|---|---|
| **Canonical Change Plan** | Documento que descreve exatamente o que será adicionado ou alterado na Product Canon. Possui um envelope com metadados (tipo, status, autor, escopo) e um payload com o conteúdo da mudança. Precisa de aprovação antes de ser aplicado. | A proposta de emenda à constituição do produto — descreve o que muda, quem precisa aprovar, e só entra em vigor depois da votação. |
| **Envelope do Change Plan** | Conjunto de metadados que acompanha todo Canonical Change Plan: identificador, tipo, status, autor, escopo (bounded contexts afetados) e registro de aprovações. | A capa de um processo administrativo — identifica o processo, seu status e quem já assinou. |
| **`expert-edit-plan`** | Tipo de Canonical Change Plan originado por edição direta do Domain Expert. Tem aprovação sequencial obrigatória: primeiro o Domain Expert valida fidelidade, depois o Architect avalia impacto técnico. | Uma correção no manual do produto — o especialista propõe, mas o engenheiro precisa verificar se a mudança não quebra nada. |
| **`incremental-plan`** | Tipo de Canonical Change Plan gerado na Etapa 2 (Spec Crafting). Captura impactos emergentes que só aparecem quando uma especificação concreta é escrita contra a Product Canon. Pode ser vazio (sem impacto = sem aprovação necessária). | A lista de ajustes que aparece quando você aplica uma regra geral a um caso concreto — coisas que não eram visíveis no abstrato. |
| **Protocolo de Perspectiva Assistida** | Mecanismo que permite que uma mesma pessoa exerça múltiplos papéis no modelo sem perder a qualidade das validações. A IA apresenta perguntas específicas da perspectiva de cada papel. | Quando o fundador de uma startup precisa ser ao mesmo tempo o cliente e o vendedor — ele usa um checklist diferente para cada "chapéu". |
| **Hotspot de domínio** | Área da Product Canon marcada pelo Domain Expert como frágil, frequentemente mal interpretada, ou com histórico de problemas. A IA usa essas marcações para dar atenção especial durante validações. | Um trecho de uma receita com a anotação "cuidado aqui — já errei várias vezes nesse passo". |
| **Anotação contextual** | Observação que o Domain Expert adiciona durante a revisão de um Change Plan — nuances de domínio, ressalvas, esclarecimentos. Tem ciclo de vida: pode ser formalizada, descartada ou adiada para o próximo ciclo. | Um post-it na margem de um documento — "isso aqui merece uma discussão mais profunda depois". |
| **Relatório de Conformidade** | Documento gerado pela IA durante a edição direta do Domain Expert. Tem 4 seções: divergências terminológicas, contradições com regras existentes, impactos em bounded contexts adjacentes, divergências intencionais aceitas. | O parecer do revisor antes de publicar — lista tudo que encontrou de inconsistente para o autor decidir o que fazer. |
| **Aprovação por afinidade** | Modelo de aprovação onde o aprovador primário é o papel com expertise principal sobre o conteúdo do Change Plan. O aprovador secundário opera com janela de veto assíncrona — se não se manifesta no prazo, a aprovação é tácita. | Como funciona em um condomínio: quem entende de encanamento aprova a obra de encanamento; o síndico pode vetar, mas se não disser nada no prazo, a obra segue. |
| **Sinalização explícita** | Marcação que o desenvolvedor faz durante a implementação para registrar descobertas emergentes (ex.: `// CANON-DISCOVERY: conceito novo encontrado`). Permite capturar aprendizados no momento em que surgem. | Anotar no cantinho do caderno "lembrar de incluir isso no relatório" enquanto você está trabalhando. |
| **Detecção assistida** | Mecanismo onde a IA compara o código implementado contra a Product Canon e identifica conceitos novos que não foram sinalizados explicitamente. Funciona como rede de segurança. | O revisor que lê o texto final e percebe uma referência nova que o autor esqueceu de adicionar ao índice. |
| **Clarificação de Conformidade** | Guardrail que sinaliza quando alguém usa termos diferentes do vocabulário oficial da Product Canon. Não bloqueia — pergunta e propõe alinhamento. | O corretor ortográfico do produto — se você escreve "cliente" onde o glossário define "titular da conta", ele sublinha e pergunta. |
| **Validação de Consistência** | Guardrail que confronta alterações propostas com o estado atual da Product Canon, detectando contradições em ambas as camadas (negócio e arquitetura). | O verificador de compatibilidade — antes de instalar uma peça nova, confere se ela não conflita com as que já estão lá. |
| **Validação Semântica Interna** | Guardrail onde a IA usa internamente metodologias de validação (incluindo SBVR) para detectar ambiguidade, incompletude e contradição em cada requisito. Os problemas são apresentados como perguntas em linguagem natural. | O consultor que lê nas entrelinhas — encontra o que está faltando ou mal explicado e transforma em perguntas claras. |
| **Padronização Canônica** | Guardrail que garante que toda escrita na Product Canon esteja no formato IEEE 29148 + SBE. Quando alguém escreve em formato livre, a IA reescreve no formato padrão antes de qualquer validação. | O formatador de documentos — você escreve o conteúdo, ele cuida de colocar nos campos certos. |
| **Nível de aderência IEEE 29148** | Configuração que define quanta formalidade é exigida nos requisitos. Mínimo: tipo + descrição + SBE. Moderado: adiciona rastreabilidade e dependências. Completo: aplicação integral com atributos de qualidade. Definido pelo Architect. | O nível de detalhe de uma planta de casa — pode ser um croqui básico (para a reforma simples), uma planta técnica (para a construção nova), ou um projeto executivo (para o prédio de 20 andares). |
| **Decisão de Continuidade** | Ponto de decisão no final de cada ciclo de Canon Building. O Domain Builder escolhe entre 3 caminhos: mapear mais fluxos, formalizar mais requisitos, ou encerrar e seguir para Spec Crafting. | O final de cada capítulo de um livro — o autor decide se continua a história, aprofunda um ponto, ou passa para o próximo ato. |

---

### 4.3 Novos diagramas necessários

| Nome | Conceito que explica | Tipo | Arquivo |
|---|---|---|---|
| **CeremonyFlowDiagram** | Fluxo sequencial das 3 cerimônias do Canon Building com gates de aprovação entre elas e Decisão de Continuidade | React (.tsx) + config (.ts) | `src/components/diagrams/CeremonyFlowDiagram.tsx` + `src/lib/diagrams/ceremony-flow-diagram.ts` |
| **GuardrailsDiagram** | Os 5 guardrails como mecanismos de proteção, mostrando onde cada um atua no ciclo | React (.tsx) + config (.ts) | `src/components/diagrams/GuardrailsDiagram.tsx` + `src/lib/diagrams/guardrails-diagram.ts` |
| **ChangePlanEnvelopeDiagram** | Estrutura visual do envelope do Canonical Change Plan: campos, tipos, fluxo de aprovação | React (.tsx) + config (.ts) | `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx` + `src/lib/diagrams/change-plan-envelope-diagram.ts` |
| **DirectEditFlowDiagram** | Fluxo da Edição Direta: edição → guardrails iterativos → Relatório de Conformidade → expert-edit-plan → aprovação sequencial | React (.tsx) + config (.ts) | `src/components/diagrams/DirectEditFlowDiagram.tsx` + `src/lib/diagrams/direct-edit-flow-diagram.ts` |

**Diagramas existentes a atualizar:**

| Diagrama | Atualização necessária |
|---|---|
| **CycleDiagram** | Adicionar nó de "Decisão de Continuidade" e canal de "Edição Direta" ao fluxo |
| **CanonBuildingDiagram** | Adicionar labels de tipo de Change Plan (`discovery-plan`, `constitution-plan`, `specification-plan`) aos gates |
| **FeedbackDiagram** | Adicionar bifurcação: sinalização explícita + detecção assistida → guardrails → revisão assíncrona OU escalação |
| **RolesMatrixDiagram** | Adicionar coluna "Edição Direta", adicionar linhas para Protocolo de Perspectiva Assistida |

---

### 4.4 Ordem de implementação (com dependências)

```
Fase 1: Correções de tom e conteúdo (independentes entre si)
  ├─ 1.1 HeroSection
  ├─ 1.2 ConsequenciasSection
  ├─ 1.3 SolutionBridgeSection
  ├─ 1.4 CycleOverviewSection
  ├─ 1.5 RolesSection + RolesMatrixDiagram
  ├─ 1.6 ComparisonSection
  ├─ 1.7 ScenariosSection
  ├─ 1.8 CTA Banner (em index.astro)
  └─ 1.9 Footer

Fase 2: Desmembramento da PillarsSection (independente da Fase 1)
  ├─ 2.1 CanonBuildingSection + CeremonyFlowDiagram
  ├─ 2.2 SpecCraftingSection
  ├─ 2.3 EnrichmentSection + FeedbackDiagram (atualizar)
  └─ 2.4 Remover PillarsSection (depende de 2.1–2.3)

Fase 3: Novas seções (independente da Fase 2, exceto indicado)
  ├─ 3.1 GuardrailsSection + GuardrailsDiagram
  ├─ 3.2 ChangePlanSection + ChangePlanEnvelopeDiagram
  ├─ 3.3 DirectEditSection + DirectEditFlowDiagram
  ├─ 3.4 RiscosSection
  ├─ 3.5 CanonDeepDiveSection (atualizar)
  └─ 3.6 GlossarySection (atualizar) — deve ser última (depende de todas as seções)

Fase 4: Integração final (depende de Fases 1–3)
  ├─ 4.1 Atualizar StickyNav com estrutura final de 16 seções
  ├─ 4.2 Atualizar index.astro (imports, ordem, remoção do CTA)
  ├─ 4.3 Atualizar CycleDiagram + CanonBuildingDiagram
  └─ 4.4 Revisão geral de sectionNumber em todas as seções
```

**Notas sobre paralelismo:**
- Fases 1, 2 e 3 podem ser executadas em paralelo (exceto 2.4 e 3.6 que têm dependências internas).
- Fase 4 é integração final — só após todas as seções estarem prontas.
- Dentro de cada fase, os itens são independentes (exceto onde indicado).
