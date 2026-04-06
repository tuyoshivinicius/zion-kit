# Relatório de Análise de Impacto — Canon Building no Modelo ZionKit v0.4

---

## 1. Sumário Executivo

O documento Canon Building propõe uma reformulação substancial da Etapa 1 do modelo ZionKit v0.4 ("Construção e Manutenção da Golden Source"). As mudanças abrangem todas as dimensões do processo: nomenclatura dos artefatos centrais, estrutura de cerimônias, papéis, mecanismos de aprovação e guardrails. As três transformações mais significativas são: (1) a substituição do conceito de "Golden Source Semântica" por "Product Canon" — um artefato unificado com identidade e semântica próprias; (2) a eliminação da pipeline MARE em favor de uma Requirements Specification Session baseada em SBVR e SBE, formalizando requisitos com vocabulário controlado e exemplos concretos em vez de um framework multi-agente genérico; e (3) a promoção das atividades do Arquiteto a uma cerimônia formal (Technical Constitution Session) e a antecipação dos fluxos de aprovação para dentro do Canon Building, com Canonical Change Plans produzidos a cada cerimônia — em vez de apenas na Etapa 2.

A reformulação demonstra um amadurecimento conceitual do modelo: move-se de uma descrição orientada a pipelines técnicas para um processo orientado a cerimônias com identidade, sequência e governança explícitas. O impacto cascata nas demais etapas e seções do modelo v0.4 é relevante, mas predominantemente positivo — simplificando a Etapa 2, fortalecendo a Etapa 3, e alinhando o modelo com práticas reconhecidas de DDD, engenharia de requisitos e gestão de conhecimento.

---

## 2. Mapeamento DE → PARA

### 2.1 Nomenclaturas

| # | DE (v0.4) | PARA (Canon Building) | Observação |
|---|-----------|----------------------|------------|
| N1 | Golden Source Semântica | Product Canon | Mudança de identidade conceitual: de "fonte de dados" para "corpo canônico de conhecimento" |
| N2 | Etapa 1 — Construção e Manutenção da Golden Source | Canon Building — Construção e Manutenção da Product Canon | Nome próprio para o processo |
| N3 | Pipeline de Event Storming Conversacional | Domain Discovery Session | De "pipeline" para "cerimônia conversacional" |
| N4 | Pipeline MARE | Requirements Specification Session | Substituição completa do framework e da nomenclatura |
| N5 | Atuação do Arquiteto na Etapa 1 (seção descritiva) | Technical Constitution Session | De descrição de atividades para cerimônia formal |
| N6 | Plano de Alteração Conceitual | Canonical Change Plan | Anglicização e generalização do artefato |
| N7 | Usuário de Negócio | Domain Builder | Papel renomeado com identidade mais precisa |
| N8 | Especialista de Domínio | Domain Expert | Anglicização |
| N9 | Arquiteto | Architect | Anglicização |
| N10 | Clarificação Semântica (guardrail) | Clarificação de Conformidade | Escopo ampliado: não apenas semântica, mas conformidade com toda a Product Canon |
| N11 | Versionamento Gradual de Alterações Radicais | Versionamento Gradual por Estrangulamento (Strangler Fig) | Nomeação explícita do padrão utilizado |
| N12 | — (implícito) | Decisão de Continuidade do Ciclo | Ponto de decisão formal novo, sem equivalente direto no v0.4 |

### 2.2 Papéis

| # | DE (v0.4) | PARA (Canon Building) | Natureza da Mudança |
|---|-----------|----------------------|---------------------|
| P1 | **Usuário de Negócio** — "Conhece o produto e suas regras. Escreve em linguagem natural." Autor primário da camada de negócio via Event Storming e MARE. | **Domain Builder** — "Analista de Negócio, Product Owner ou Gestor de Operações — autor primário das cerimônias conversacionais." Descreve fluxos na Domain Discovery e comportamentos na Requirements Specification. | Renomeação + refinamento: o papel ganha identidade própria ("Builder") e descrição de perfis concretos. O escopo de atuação é preservado. |
| P2 | **Especialista de Domínio** — Valida mudanças na camada de negócio. Aprova seção de negócio do plano de alteração na Etapa 2. | **Domain Expert** — Aprovador primário dos Canonical Change Plans. Valida fidelidade semântica ao domínio. Guardião da integridade semântica da Product Canon. | Anglicização + antecipação: a aprovação agora ocorre dentro do Canon Building, não na Etapa 2. |
| P3 | **Arquiteto** — Constrói camada de arquitetura. Valida BCs. Define princípios, context maps, ADRs. Aprova camada de arquitetura na Etapa 2. | **Architect** — Conduz Technical Constitution Session. Aprovador secundário dos Canonical Change Plans. Valida viabilidade técnica e aderência aos princípios constitucionais. | Anglicização + promoção: atividades elevadas a cerimônia formal. Aprovação antecipada para Canon Building. |
| P4 | **IA (Agente de IA)** — "Mediador entre a intenção dos usuários e a integridade do domínio e da arquitetura." | **IA (Agentes LLM)** — "Mediadores de cerimônias e guardrails, sem autonomia decisória." Conduz sessões, mantém contexto, identifica inconsistências, gera Canonical Change Plans. | Restrição explícita: adição da cláusula "sem autonomia decisória". Pluralização ("agentes"). Escopo funcional preservado. |

### 2.3 Processos e Cerimônias

| # | DE (v0.4) | PARA (Canon Building) | Natureza da Mudança |
|---|-----------|----------------------|---------------------|
| C1 | **Pipeline de Event Storming Conversacional** — Processo em 4 fases (descoberta de eventos, identificação de comandos/atores, mapeamento de agregados/BCs, decomposição de casos de uso). Saída: artefatos da camada de negócio na golden source. | **Domain Discovery Session** — Cerimônia conversacional de mapeamento de fluxos e contextos via Event Storming. Saída: Canonical Change Plan com estruturas de domínio descobertas (eventos, comandos, atores, agregados, casos de uso, bounded contexts). | Reframing: de "pipeline com fases" para "cerimônia com saída formal". A dinâmica interna do Event Storming é preservada, mas a saída é agora um Canonical Change Plan (diff semântico) em vez de escrita direta na golden source. |
| C2 | **Pipeline MARE** — Framework multi-agente em 4 fases (elicitação, modelagem, verificação, especificação). Agentes especializados por fase. Saída: documento SRS. | **Requirements Specification Session** — Cerimônia conversacional de formalização semântica usando SBVR + SBE. Saída: Canonical Change Plan com requisitos formalizados, regras de negócio e critérios de aceitação. | Substituição completa: MARE (framework multi-agente) eliminado. Substituído por abordagem baseada em padrões reconhecidos (SBVR para vocabulário/regras, SBE para critérios de aceitação via exemplos). A saída muda de SRS para Canonical Change Plan. |
| C3 | **Atuação do Arquiteto na Etapa 1** (seção 2.2.4) — Conjunto de 5 atividades descritas narrativamente: validação de BCs, definição de context map, princípios constitucionais, ADRs fundacionais, avaliação técnica de requisitos. | **Technical Constitution Session** — Cerimônia formal conduzida pelo Architect para definir princípios técnicos constitucionais. Saída: Canonical Change Plan com princípios técnicos e decisões arquiteturais. | Promoção: atividades soltas elevadas a cerimônia com identidade, posição sequencial e saída formal. Foco concentrado em princípios constitucionais (as demais atividades do Architect se distribuem pelas aprovações). |
| C4 | **Combinação das Pipelines** (seção 2.2.3) — Sequência sugerida: Event Storming → MARE → Arquiteto. Descrita como recomendação, não como fluxo obrigatório. | **Fluxo sequencial com dependências explícitas**: Domain Discovery → (Canonical Change Plan aprovado) → Technical Constitution → (Canonical Change Plan aprovado) → Requirements Specification → (Canonical Change Plan aprovado) → Decisão de Continuidade. | Formalização: a sequência sugerida se torna fluxo com gates de aprovação entre cerimônias. Cada cerimônia é habilitada pela aprovação do Canonical Change Plan da anterior. |
| C5 | — (sem equivalente) | **Decisão de Continuidade do Ciclo** — Ponto de decisão explícito ao final do fluxo: "Formalizar mais requisitos", "Mapear mais fluxos e contextos" ou "Encerrar ciclo". | Adição: mecanismo de iteração formal que permite ciclos internos ao Canon Building sem sair para as etapas seguintes. |

### 2.4 Artefatos

| # | DE (v0.4) | PARA (Canon Building) | Natureza da Mudança |
|---|-----------|----------------------|---------------------|
| A1 | **Golden Source** — Conjunto de artefatos organizados em duas camadas (Negócio e Arquitetura), com estrutura de diretórios detalhada (glossary.md, business-rules.md, requirements/, contexts/, architecture/, changelog/). | **Product Canon** — "Núcleo vivo de conhecimento do produto" que contém glossário ubíquo, regras de negócio, requisitos, fluxos, princípios técnicos, bounded contexts, eventos, context maps e ADRs. Artefato versionado que evolui a cada ciclo. | Unificação conceitual: de coleção de arquivos para artefato singular com identidade. A estrutura interna de diretórios não é detalhada no Canon Building — o foco está na identidade e no ciclo de vida, não na organização física. |
| A2 | **Plano de Alteração Conceitual** — Gerado na Etapa 2, quando uma especificação de feature impacta a golden source. Organizado em "camada de negócio" e "camada de arquitetura". Único por spec. | **Canonical Change Plan** — Gerado em cada cerimônia do Canon Building (3 instâncias distintas): um para estruturas de domínio, um para princípios técnicos, um para requisitos formalizados. "Diff semântico da Product Canon." | Multiplicação e antecipação: o artefato deixa de ser exclusivo da Etapa 2 e passa a ser produzido em cada cerimônia do Canon Building. A aprovação ocorre antes da especificação de feature. |
| A3 | **Documento SRS** — Saída da pipeline MARE. Requisitos estruturados em formato padronizado com critérios de aceitação verificáveis. | Eliminado como artefato nomeado. Requisitos passam a ser parte do Canonical Change Plan da Requirements Specification Session, formalizados via SBVR + SBE. | Absorção: o SRS como artefato separado desaparece. Seu conteúdo é incorporado à Product Canon via Canonical Change Plan, com formalização mais rigorosa (SBVR + SBE). |

### 2.5 Guardrails

| # | DE (v0.4) | PARA (Canon Building) | Natureza da Mudança |
|---|-----------|----------------------|---------------------|
| G1 | **Clarificação Semântica** — Detecta divergência entre termos usados pelo usuário e o glossário de linguagem ubíqua. Escopo: termos do domínio. | **Clarificação de Conformidade** — Detecta divergências entre termos utilizados nas cerimônias e o vocabulário formalizado na Product Canon. Atua nas sessões de Domain Discovery e Technical Constitution. | Ampliação de escopo: de "semântica" (só glossário de negócio) para "conformidade" (vocabulário completo da Product Canon, incluindo princípios técnicos). |
| G2 | **Validação de Consistência** — Confronta alterações com o estado atual da golden source, incluindo regras de negócio e princípios técnicos. | **Validação de Consistência** — Confronta alterações propostas com a Product Canon para identificar contradições, redundâncias e violações. Verifica camada de negócio e camada de arquitetura. | Preservação com refinamento: escopo e mecânica essencialmente mantidos. A descrição no Canon Building é mais concisa mas funcionalmente equivalente. |
| G3 | **Versionamento Gradual de Alterações Radicais** — Mecanismo de duas faces (current/next) para mudanças estruturais significativas. | **Versionamento Gradual por Estrangulamento (Strangler Fig)** — Mesmo mecanismo de duas faces (current/next), agora com nomeação explícita do padrão Strangler Fig. | Nomeação: o padrão é o mesmo, mas agora referencia explicitamente o Strangler Fig Pattern de Martin Fowler, ancorando o mecanismo em literatura reconhecida. |

### 2.6 Fluxos de Aprovação

| # | DE (v0.4) | PARA (Canon Building) | Natureza da Mudança |
|---|-----------|----------------------|---------------------|
| F1 | **Aprovação na Etapa 2** — O plano de alteração conceitual é gerado durante a especificação de feature (Etapa 2) e submetido a aprovação dual: Domain Expert (camada de negócio) e Arquiteto (camada de arquitetura). Aprovação roteada por camada afetada. | **Aprovação no Canon Building** — Cada Canonical Change Plan produzido por cada cerimônia requer aprovação dual: Domain Expert (aprovação primária: fidelidade semântica) e Architect (aprovação secundária: viabilidade técnica). Aprovação ocorre antes de qualquer especificação de feature. | Antecipação + multiplicação: a aprovação migra da Etapa 2 para a Etapa 1. Cada cerimônia gera um Canonical Change Plan com gate de aprovação, em vez de um único gate na Etapa 2. A aprovação habilita a próxima cerimônia. |
| F2 | **Roteamento por camada** — Specs que afetam só negócio passam só pelo Domain Expert. Specs que afetam só arquitetura passam só pelo Arquiteto. Ambas = aprovação dual. | **Aprovação dual em todos os Canonical Change Plans** — Tanto o Domain Expert quanto o Architect aprovam os Change Plans produzidos pelas cerimônias de Domain Discovery e Requirements Specification. O Architect conduz a Technical Constitution Session. | Simplificação do roteamento: o Canon Building aplica aprovação dual como padrão nos Change Plans de negócio, sem o roteamento condicional por camada descrito no v0.4 (que pode continuar vigente na Etapa 2). |

---

## 3. Análise de Impacto por Mudança

### 3.1 Golden Source → Product Canon (N1, A1)

**Impacto no modelo:** Afeta todas as referências à "golden source" nas Etapas 2 e 3, nos princípios de design, nos cenários de aplicação e na estrutura de artefatos. A mudança é transversal — o termo aparece dezenas de vezes no documento v0.4.

**Prós:**
- O termo "Product Canon" carrega semântica mais rica: "canon" remete a corpo autoritativo de conhecimento (como em universos ficcionais ou textos religiosos), enquanto "golden source" remete a integração de dados e bancos de dados mestres. "Canon" comunica melhor a ideia de fonte de verdade curada, versionada e com governança.
- Alinha o modelo com o conceito de Product Canon como prática de gestão de conhecimento, diferenciando-o de Canonical Data Models de integração enterprise.
- O termo é mais memorável e cria identidade para o modelo.

**Contras:**
- "Canon" pode ser menos intuitivo para audiências não familiarizadas com o conceito (ambiguidade com "cânone" religioso, literário, ou com "canonical" de URIs/data models).
- "Golden source" era auto-explicativo para profissionais técnicos; "Product Canon" exige uma definição explícita.
- A perda da estrutura de diretórios detalhada (seção 5 do v0.4) pode gerar ambiguidade sobre como a Product Canon é fisicamente organizada.

**Justificativa:** A mudança faz sentido porque o artefato central do ZionKit não é um data store — é um corpo de conhecimento vivo com ciclo de vida, governança e identidade. "Product Canon" captura essa natureza melhor do que "Golden Source Semântica", que herda conotações de integração de sistemas. A mudança também permite que o modelo ganhe vocabulário próprio, aumentando sua coesão terminológica.

**Aderência ao modelo: Alta.** Coerente com o princípio de "golden source viva, não estática" (que se traduz naturalmente como "canon vivo") e com a ênfase em linguagem ubíqua — o próprio modelo pratica o que prega ao refinar seu vocabulário.

---

### 3.2 Pipeline de Event Storming → Domain Discovery Session (N3, C1)

**Impacto no modelo:** Afeta a descrição da Etapa 1, os cenários de aplicação (que mencionam "pipeline de Event Storming") e as direções de prototipação (item 1). A mecânica interna (descoberta de eventos, comandos, atores, agregados, BCs) é preservada, mas a saída muda de "artefatos escritos na golden source" para "Canonical Change Plan".

**Prós:**
- O termo "cerimônia" é mais preciso que "pipeline": uma pipeline implica automação sequencial, enquanto o processo é essencialmente conversacional e interativo.
- "Domain Discovery Session" comunica claramente o propósito (descoberta de domínio) e o formato (sessão).
- A saída como Canonical Change Plan (diff semântico) é mais governável do que escrita direta na golden source — cria um ponto de inspeção e aprovação.

**Contras:**
- A perda do detalhamento das 4 fases do Event Storming (seção 2.2.1 do v0.4) pode reduzir a clareza sobre o que acontece dentro da sessão para quem não conhece Event Storming.
- O termo "Session" pode sugerir um evento pontual, enquanto o v0.4 deixava claro que o Event Storming podia ser iterativo.

**Justificativa:** Event Storming é por natureza uma cerimônia colaborativa de descoberta, não uma pipeline automatizada. Renomear para "Domain Discovery Session" alinha o modelo com a realidade do processo e com a nomenclatura de práticas ágeis (Sprint Planning Session, Refinement Session, etc.). A produção de um Canonical Change Plan como saída formaliza o ponto de governança que no v0.4 estava implícito.

**Aderência ao modelo: Alta.** Consistente com o princípio de separação de autoridade (a saída é submetida a aprovação) e com a filosofia de prevenção sobre detecção (o Change Plan é revisado antes de integrar a canon).

---

### 3.3 Eliminação da Pipeline MARE → Requirements Specification Session com SBVR + SBE (N4, C2, A3)

**Impacto no modelo:** Esta é a mudança com maior impacto estrutural. A pipeline MARE era descrita detalhadamente no v0.4 (seção 2.2.2), com quatro fases, agentes especializados e saída como SRS. Sua eliminação remove: (a) o framework multi-agente como modelo de engenharia de requisitos, (b) o conceito de agentes especializados por fase (elicitação, modelagem, verificação, especificação), (c) o artefato SRS como saída nomeada, (d) a seção de combinação de pipelines (2.2.3), e (e) várias referências nos cenários e direções de prototipação.

**Prós:**
- SBVR é um padrão OMG reconhecido para formalização de vocabulário e regras de negócio em linguagem natural controlada. Fornece ancoragem teórica mais sólida que MARE para a formalização semântica.
- SBE (Specification by Example) é uma prática madura e amplamente adotada (Gojko Adzic), com ecossistema de ferramentas (Cucumber, SpecFlow) e comunidade ativa. Produz critérios de aceitação verificáveis que servem simultaneamente como especificação e teste.
- A combinação SBVR + SBE é conceitualmente mais coerente: SBVR formaliza o vocabulário e as regras (o "quê"), SBE formaliza o comportamento esperado com exemplos (o "como se manifesta"). Juntos, produzem requisitos compreensíveis por negócio e precisos para consumo por IA.
- Elimina a dependência de um framework multi-agente específico (MARE), que é menos estabelecido na literatura do que SBVR e SBE.
- A saída como Canonical Change Plan é mais governável e integrável do que um SRS separado.

**Contras:**
- Perde-se a estrutura explícita de 4 fases (elicitação, modelagem, verificação, especificação) que dava ao processo uma progressão clara e legível.
- SBVR tem curva de aprendizado: sua notação controlada (termos em negrito, fact types em itálico, keywords modais como "It is obligatory that...") pode ser intimidadora para Domain Builders não-técnicos — justamente o público que o ZionKit busca incluir.
- A eliminação do conceito de "agentes especializados por fase" remove uma ideia arquiteturalmente interessante para implementação com LLMs (agentes com system prompts distintos por fase).
- O SRS como artefato padronizado desaparece. Organizações que dependem de SRS formais para compliance ou contratos podem sentir a lacuna.

**Justificativa:** A pipeline MARE, embora conceitualmente atraente, não era ancorada em padrões amplamente reconhecidos. SBVR e SBE são padrões com décadas de aplicação prática, literatura extensa e ecossistema de ferramentas. A mudança troca um framework proprietário por padrões abertos, aumentando a credibilidade do modelo e sua interoperabilidade com práticas existentes. A formalização via SBVR + SBE é também mais alinhada com o objetivo de produzir requisitos "compreensíveis por negócio e precisos para consumo por IA" — a estrutura controlada do SBVR é nativamente processável por LLMs.

**Aderência ao modelo: Alta.** A escolha de SBVR + SBE reforça o princípio de inclusão do usuário de negócio (SBVR usa linguagem natural controlada) e o princípio de prevenção sobre detecção (SBE com exemplos concretos captura ambiguidades mais cedo). A perda da estrutura de fases da MARE é compensada pela estrutura sequencial das cerimônias.

---

### 3.4 Atividades do Arquiteto → Technical Constitution Session (N5, C3)

**Impacto no modelo:** Eleva as 5 atividades descritas na seção 2.2.4 do v0.4 a uma cerimônia formal com posição fixa no fluxo (entre Domain Discovery e Requirements Specification), saída formal (Canonical Change Plan) e gate de aprovação. O Architect passa de "participante que faz coisas durante a Etapa 1" para "condutor de uma cerimônia dedicada".

**Prós:**
- Dá visibilidade e paridade às decisões de arquitetura. No v0.4, a atuação do Arquiteto era uma seção narrativa subordinada à Etapa 1. Agora é uma cerimônia com o mesmo status que as demais.
- Posiciona a definição de princípios técnicos como pré-requisito explícito para a formalização de requisitos — o que é conceitualmente correto, pois requisitos devem respeitar restrições técnicas.
- A saída como Canonical Change Plan garante que princípios técnicos e decisões arquiteturais sejam submetidos à mesma governança que as mudanças de negócio.

**Contras:**
- Concentra o foco em "princípios técnicos constitucionais", potencialmente perdendo o detalhamento das outras atividades do Arquiteto listadas no v0.4 (validação de BCs, context map, ADRs fundacionais, avaliação técnica de requisitos).
- Pode criar overhead cerimonial em projetos menores onde as decisões de arquitetura são rápidas e incrementais.
- A posição fixa na sequência (após Domain Discovery, antes de Requirements Specification) pode ser restritiva. Há cenários onde princípios técnicos já existem e não precisam ser revisitados a cada ciclo.

**Justificativa:** A promoção faz sentido porque decisões de arquitetura são frequentemente tratadas como cidadãs de segunda classe em processos de especificação — tomadas informalmente, não versionadas, não submetidas a revisão formal. Ao criar uma cerimônia dedicada com o mesmo nível de formalidade que a descoberta de domínio, o modelo sinaliza que princípios técnicos têm a mesma importância que regras de negócio. A posição entre Domain Discovery e Requirements Specification é logicamente correta: primeiro descobre-se o domínio, depois define-se as restrições técnicas, depois formaliza-se requisitos que respeitem ambos.

**Aderência ao modelo: Alta.** Diretamente alinhada com o princípio de separação de autoridade (o Architect tem sua cerimônia própria) e com a meta de que "princípios técnicos constitucionais funcionam como o glossário de linguagem ubíqua funciona para a camada de negócio" (v0.4, seção 2.2.4).

---

### 3.5 Antecipação dos Fluxos de Aprovação para o Canon Building (F1, F2, A2)

**Impacto no modelo:** No v0.4, a aprovação dual (Domain Expert + Arquiteto) ocorria na Etapa 2, sobre o plano de alteração conceitual gerado durante a especificação de feature. No Canon Building, cada cerimônia produz um Canonical Change Plan que requer aprovação antes de habilitar a próxima cerimônia. Isso muda fundamentalmente o momento e a frequência das aprovações.

**Prós:**
- Aplica governança mais cedo no processo: mudanças no corpo de conhecimento são aprovadas antes de qualquer especificação de feature, eliminando o risco de especificações construídas sobre premissas não validadas.
- Cada aprovação tem escopo menor e mais focado (artefatos de uma cerimônia específica), tornando a revisão mais gerenciável para os aprovadores.
- A habilitação sequencial (aprovação do Change Plan N habilita cerimônia N+1) cria um fluxo naturalmente progressivo com checkpoints de qualidade.
- Reduz o risco de retrabalho: no v0.4, uma especificação poderia ser escrita inteira antes de o Domain Expert rejeitar uma mudança conceitual. No Canon Building, a rejeição ocorre antes da especificação.

**Contras:**
- Multiplica os gates de aprovação: em vez de um gate na Etapa 2, há potencialmente três (um por cerimônia) no Canon Building. Isso aumenta o risco de gargalo de aprovadores (risco 9.5 do v0.4).
- Pode tornar o processo mais lento para mudanças simples que no v0.4 poderiam fluir diretamente para especificação.
- A aprovação dual (Domain Expert + Architect) em todos os Change Plans de cerimônias de negócio pode ser excessiva — no v0.4, o roteamento por camada era mais granular.
- Requer que Domain Expert e Architect estejam disponíveis e engajados ao longo de todo o Canon Building, não apenas em um momento pontual da Etapa 2.

**Justificativa:** A antecipação é conceitualmente correta porque o Canon Building constrói a base de conhecimento sobre a qual tudo será edificado. Aprovar apenas na Etapa 2 significava que a golden source podia ser construída com premissas incorretas que só seriam detectadas quando alguém tentasse escrever uma feature. No Canon Building, o Domain Expert e o Architect validam o conhecimento antes de ele se tornar contexto para qualquer especificação.

**Aderência ao modelo: Alta.** Fortalece diretamente o princípio de "prevenção sobre detecção" — a validação ocorre ainda mais cedo no processo.

---

### 3.6 Canonical Change Plan como Artefato Recorrente (A2)

**Impacto no modelo:** O plano de alteração conceitual, que no v0.4 era um artefato único gerado na Etapa 2, torna-se o artefato central de saída de cada cerimônia do Canon Building (3 instâncias distintas). Cada um carrega tipos de mudança diferentes: estruturas de domínio, princípios técnicos, ou requisitos formalizados.

**Prós:**
- Cria consistência processual: todas as cerimônias produzem o mesmo tipo de artefato, com o mesmo ciclo de vida (geração → aprovação → integração gradual via Strangler Fig).
- Facilita automação: um único formato de artefato com fluxo padronizado é mais simples de implementar do que artefatos heterogêneos com fluxos distintos.
- Torna rastreável a origem de cada mudança na Product Canon (qual cerimônia, qual ciclo).

**Contras:**
- O mesmo nome ("Canonical Change Plan") para artefatos com conteúdos estruturalmente diferentes pode gerar confusão. O Change Plan de Domain Discovery contém eventos e bounded contexts; o de Technical Constitution contém princípios e ADRs; o de Requirements Specification contém regras SBVR e exemplos SBE. São artefatos semanticamente distintos com o mesmo nome.
- Três Change Plans por ciclo completo podem gerar overhead documental em domínios simples.

**Justificativa:** A padronização é um ganho arquitetural: o Canonical Change Plan funciona como protocolo de comunicação entre cerimônias e a Product Canon, análogo a um formato de mensagem em integração de sistemas. A variação no conteúdo é esperada — o que é padronizado é o ciclo de vida (proposta → aprovação → integração), não a estrutura interna.

**Aderência ao modelo: Alta.** Consistente com a visão de que toda mudança na golden source/canon deve ser declarada explicitamente, aprovada, e aplicada de forma controlada.

---

### 3.7 Anglicização dos Nomes de Papéis (N7, N8, N9)

**Impacto no modelo:** Usuário de Negócio → Domain Builder, Especialista de Domínio → Domain Expert, Arquiteto → Architect. Os nomes em inglês criam uma terminologia consistente com a nomenclatura do modelo (Canon Building, Product Canon, Canonical Change Plan).

**Prós:**
- Coerência linguística: o modelo ganha um vocabulário interno consistente, todo em inglês, evitando a mistura português-inglês dos papéis no v0.4.
- "Domain Builder" é mais expressivo que "Usuário de Negócio" — transmite agência e autoria ("builder" = quem constrói), enquanto "usuário" transmite passividade.
- Nomes curtos e memoráveis, fáceis de usar em diagramas e fluxos.

**Contras:**
- Pode criar barreira para organizações que operam em português, especialmente os próprios Domain Builders que o modelo busca incluir (pessoas de negócio que podem não dominar inglês técnico).
- "Domain Builder" pode ser confundido com papéis de DDD existentes (Domain Expert, Domain Owner) ou com ferramentas (Builder pattern).

**Justificativa:** A anglicização é coerente com a decisão de dar ao modelo uma identidade terminológica própria. "Domain Builder" é particularmente inspirado — captura a essência do papel (construir o domínio formalizado) melhor que "Usuário de Negócio", que é genérico e passivo.

**Aderência ao modelo: Média-Alta.** Coerente com o vocabulário do modelo, mas a barreira linguística pode conflitar com o princípio de inclusão de usuários não-técnicos. A tensão é gerenciável se os nomes forem sempre apresentados com descrição em português.

---

### 3.8 Restrição Explícita da Autonomia da IA (P4)

**Impacto no modelo:** A cláusula "sem autonomia decisória" é uma adição nova que não existia no v0.4. No modelo anterior, a IA era descrita como "mediador", mas a restrição não era formulada como princípio.

**Prós:**
- Torna explícito um princípio implícito: a IA propõe, humanos decidem. Isso é fundamental para a credibilidade do modelo.
- Facilita a comunicação com stakeholders preocupados com autonomia de IA.
- Cria um guardrail de design para implementação: qualquer feature que dê autonomia decisória à IA viola o princípio declarado.

**Contras:**
- A formulação é absoluta ("sem autonomia decisória"). Pode haver cenários de baixo risco onde alguma autonomia é desejável (ex: formatação automática de outputs, seleção de templates).
- A restrição pode precisar de refinamento: distinguir entre autonomia decisória (sobre o que muda na canon) e autonomia operacional (como conduzir uma sessão).

**Justificativa:** Em um modelo que propõe IA como participante de processos de governança de conhecimento, a restrição explícita de autonomia é um princípio de design fundamental. Ela diferencia o ZionKit de abordagens "AI-first" onde a IA opera com carta branca.

**Aderência ao modelo: Alta.** Diretamente alinhada com o princípio de separação de autoridade.

---

### 3.9 Clarificação Semântica → Clarificação de Conformidade (G1)

**Impacto no modelo:** A ampliação de "semântica" para "conformidade" estende o escopo do guardrail: não verifica apenas se termos do glossário de negócio estão sendo usados corretamente, mas também se há conformidade com princípios técnicos constitucionais e demais elementos da Product Canon.

**Prós:**
- Escopo mais completo e realista: inconsistências podem ocorrer tanto na linguagem de negócio quanto na linguagem técnica.
- Atua explicitamente nas sessões de Domain Discovery e Technical Constitution, não apenas genericamente "durante a Etapa 1".

**Contras:**
- Aumenta a complexidade do guardrail: verificar conformidade contra toda a Product Canon (glossário + princípios + regras + eventos + ...) é significativamente mais difícil do que verificar contra o glossário.
- O nome "Conformidade" pode sugerir rigidez excessiva, quando o objetivo é alinhamento (o guardrail sinaliza divergências, não bloqueia).

**Justificativa:** A ampliação é natural: se a Product Canon contém tanto conhecimento de negócio quanto de arquitetura, o guardrail de conformidade deve verificar ambas as dimensões. No v0.4, a Validação de Consistência já cobria princípios técnicos, mas a Clarificação Semântica era limitada ao glossário. A mudança distribui melhor a responsabilidade entre os dois guardrails.

**Aderência ao modelo: Alta.** Consistente com a visão de Product Canon como fonte de verdade unificada.

---

### 3.10 Nomeação do Strangler Fig no Versionamento Gradual (G3)

**Impacto no modelo:** A mecânica é preservada (current/next, duas faces), mas o padrão é agora explicitamente nomeado como Strangler Fig.

**Prós:**
- Ancora o mecanismo em uma referência amplamente conhecida na engenharia de software (Martin Fowler, 2004).
- Facilita o diálogo com arquitetos e engenheiros que já conhecem o padrão.
- Comunica imediatamente a ideia de coexistência e migração gradual sem precisar explicar a mecânica.

**Contras:**
- O Strangler Fig Pattern foi concebido para migração de sistemas de software (componentes, serviços), não para versionamento de artefatos de conhecimento. A analogia é útil mas não perfeita — pode gerar expectativas incorretas (ex: "quando elimino o estado current?" funciona diferente em código vs. em uma canon de conhecimento).
- O nome "Strangler Fig" pode ser pouco intuitivo para audiências não-técnicas.

**Justificativa:** A nomeação é um ganho de comunicação. O padrão Strangler Fig é a referência mais reconhecida para migração incremental, e sua aplicação a artefatos de conhecimento é uma extensão criativa e legítima do conceito. A analogia se sustenta: o estado "next" cresce ao redor do estado "current" até substituí-lo completamente.

**Aderência ao modelo: Alta.** O versionamento gradual é um dos princípios de design do modelo. Ancorar em padrão reconhecido fortalece a credibilidade.

---

### 3.11 Decisão de Continuidade do Ciclo (C5)

**Impacto no modelo:** Adiciona um ponto de decisão explícito ao final do fluxo do Canon Building, permitindo três caminhos: mapear mais fluxos (voltar para Domain Discovery), formalizar mais requisitos (voltar para Requirements Specification) ou encerrar o ciclo.

**Prós:**
- Torna explícito o que era implícito no v0.4: o processo de construção da golden source/canon é iterativo.
- Dá ao Domain Builder (ou a quem conduz o ciclo) controle formal sobre quando parar e quando continuar.
- Permite ciclos focados (ex: um ciclo só para mapear domínio, outro só para formalizar requisitos) sem obrigar a passagem por todas as cerimônias.

**Contras:**
- Pode criar ambiguidade sobre se a Technical Constitution Session é re-executada a cada iteração ou apenas na primeira passagem do ciclo.
- A opção de voltar para Requirements Specification sem passar por Domain Discovery ou Technical Constitution pode criar inconsistências se o contexto mudou entre iterações.

**Justificativa:** O ciclo de descoberta de domínio é inerentemente iterativo — nenhuma sessão única captura todo o conhecimento. Formalizar esse ponto de decisão remove a ambiguidade sobre quando o Canon Building "termina" e quem toma essa decisão.

**Aderência ao modelo: Alta.** Consistente com o princípio de que "a golden source é viva, não estática" — a iteração é parte do design, não uma exceção.

---

## 4. Impacto nas Demais Seções do Modelo v0.4

### 4.1 Etapa 2 — Especificação Contextualizada

**Impacto: Significativo, predominantemente simplificador.**

A antecipação das aprovações para o Canon Building simplifica substancialmente a Etapa 2. No v0.4, a Etapa 2 era responsável por: (1) injetar contexto da golden source, (2) clarificar e validar a especificação, (3) gerar o plano de alteração conceitual, (4) rotear aprovação dual, e (5) implementar após aprovação. Com as mudanças do Canon Building:

- **A Product Canon já contém conhecimento aprovado e governado** quando a Etapa 2 é alcançada. A base conceitual sobre a qual a especificação é escrita é mais sólida.
- **O plano de alteração conceitual na Etapa 2 muda de natureza**: no v0.4, podia conter mudanças fundamentais (novos termos, novas regras). Com o Canon Building, mudanças fundamentais já foram tratadas. O plano da Etapa 2 tende a capturar impactos emergentes — mudanças que só se tornam visíveis quando uma especificação concreta é escrita contra a canon.
- **A aprovação dual na Etapa 2 pode ser flexibilizada**: se o conhecimento base já foi aprovado no Canon Building, o gate da Etapa 2 pode ser mais leve (apenas impactos emergentes). Isso alivia o risco de gargalo de aprovadores (risco 9.5).
- **A seção 2.3.1 (Injeção de Contexto)** é preservada mas refere-se agora à Product Canon.
- **A seção 2.3.2 (Clarificação e Validação)** é preservada — guardrails continuam atuando na Etapa 2.
- **A seção 2.3.3 (Plano de Alteração Conceitual)** precisa ser recontextualizada: o artefato agora se chama Canonical Change Plan e já existe no Canon Building. O plano da Etapa 2 é o Change Plan *incremental* da especificação.
- **A seção 2.3.4 (Aprovação Dual)** precisa ser revisada para refletir que a aprovação primária ocorreu no Canon Building.

### 4.2 Etapa 3 — Retroalimentação

**Impacto: Moderado, predominantemente positivo.**

A Etapa 3 no v0.4 reflete alterações aprovadas do plano de alteração conceitual na golden source. Com o Canon Building:

- **A retroalimentação é parcialmente antecipada**: Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento. A Etapa 3 pode se concentrar em descobertas emergentes da implementação, não em mudanças já aprovadas.
- **O escopo da Etapa 3 pode ser refinado**: retroalimentar a Product Canon com aprendizados da implementação (conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código) em vez de meramente aplicar um plano já aprovado.
- **A mecânica de "a retroalimentação é segura porque o plano já foi aprovado" (v0.4, seção 2.4) é fortalecida**: com múltiplos Canonical Change Plans aprovados antes da implementação, há menos ambiguidade.

### 4.3 Papéis (Seção 4)

**Impacto: Moderado, predominantemente de renomeação e reposicionamento.**

- A tabela de "Resumo de atuação por etapa" (seção 4 do v0.4) precisa ser atualizada com os novos nomes de papéis e com a redistribuição de responsabilidades:
  - O **Domain Builder** (ex-Usuário de Negócio) agora participa de cerimônias nomeadas (Domain Discovery, Requirements Specification) em vez de "pipelines".
  - O **Architect** (ex-Arquiteto) agora conduz uma cerimônia formal (Technical Constitution Session) em vez de apenas "construir a camada de arquitetura".
  - O **Domain Expert** (ex-Especialista de Domínio) agora aprova no Canon Building, não apenas na Etapa 2.
  - A **IA** ganha a restrição explícita "sem autonomia decisória".
- O texto descritivo de cada papel (seção 4 do v0.4) precisa ser harmonizado com as descrições mais concisas do Canon Building.

### 4.4 Estrutura de Artefatos (Seção 5)

**Impacto: Significativo, requer decisão.**

A seção 5 do v0.4 descreve uma estrutura de diretórios detalhada para a golden source (`/golden-source/domain/`, `/golden-source/architecture/`, `/golden-source/changelog/`). O Canon Building não detalha a organização física da Product Canon. Há duas direções possíveis:

1. **Manter a estrutura de diretórios**, renomeando de `/golden-source/` para `/product-canon/` (ou similar) e adicionando artefatos de Canonical Change Plans.
2. **Redefinir a estrutura** para refletir a nova organização por cerimônias e Canonical Change Plans.

A decisão não pode ser tomada pelo Canon Building isoladamente — depende de como a Product Canon será consumida nas Etapas 2 e 3 e de como o Versionamento por Estrangulamento será implementado (current/next como branches? como diretórios? como tags?).

### 4.5 Cenários de Aplicação (Seção 6)

**Impacto: Moderado, predominantemente de atualização terminológica.**

- **Cenário 6.1 (Greenfield)**: referências a "pipeline de Event Storming" → "Domain Discovery Session"; "pipeline MARE" → "Requirements Specification Session"; "golden source" → "Product Canon". O fluxo narrativo é preservado, mas os nomes mudam. O passo 3 (MARE para requisitos) precisa refletir SBVR + SBE.
- **Cenário 6.2 (Brownfield)**: referência a "golden source do produto já existe" → "Product Canon do produto já existe". O fluxo de plano de alteração conceitual na Etapa 2 precisa ser recontextualizado.
- **Cenário 6.3 (Migração Gradual)**: o cenário de divisão de "Faturamento" em "Cobrança" e "Receita" agora referencia explicitamente o Strangler Fig Pattern. O fluxo é preservado mas ganha terminologia mais precisa.

### 4.6 Riscos e Limitações (Seção 9)

**Impacto: Moderado, com redistribuição de riscos.**

- **Risco 9.1 (Qualidade do guardrail semântico)**: permanece válido, mas agora o guardrail é de "conformidade" com escopo ampliado. O risco é maior porque o escopo de verificação é mais amplo.
- **Risco 9.2 (Injeção seletiva de contexto)**: permanece válido. A Product Canon como artefato unificado pode facilitar ou dificultar a seleção — depende da organização interna.
- **Risco 9.3 (Custo de bootstrap)**: possivelmente aumentado. O Canon Building é mais estruturado que a Etapa 1 do v0.4 (três cerimônias com gates de aprovação vs. duas pipelines com combinação livre). O investimento inicial pode ser maior, mas o retorno é mais previsível.
- **Risco 9.4 (Disciplina de retroalimentação)**: parcialmente mitigado. Se Canonical Change Plans do Canon Building já são integrados à Product Canon, a retroalimentação formal da Etapa 3 é um incremento menor. A disciplina necessária diminui.
- **Risco 9.5 (Disponibilidade de aprovadores)**: agravado. Três gates de aprovação no Canon Building + potencial gate na Etapa 2 multiplicam as demandas sobre Domain Expert e Architect. Este é o risco que mais cresce com a reformulação.
- **Novo risco potencial**: a dependência de SBVR como método de formalização introduz risco de adoção — se os Domain Builders acharem a notação SBVR difícil de entender ou de revisar, o processo perde seu apelo de inclusão.

### 4.7 Direções para Prototipação (Seção 10)

**Impacto: Moderado, com reorientação de prioridades.**

- **Item 1 (Event Storming Conversacional)**: preservado, agora como "Domain Discovery Session". O escopo de validação é o mesmo.
- **Item 2 (Guardrail semântico)**: permanece, mas agora como "Clarificação de Conformidade" com escopo ampliado. A golden source mínima de teste torna-se uma Product Canon mínima.
- **Item 3 (Geração do plano de alteração)**: agora é geração de Canonical Change Plan em cada cerimônia, não apenas na Etapa 2. O teste deve validar se a IA consegue produzir Change Plans corretos em cada cerimônia.
- **Item 4 (Validação por aprovadores)**: preservado, mas agora com aprovação em cada cerimônia. Testar se aprovadores conseguem lidar com múltiplos Change Plans por ciclo.
- **Item 5 (Ciclo completo)**: agora inclui as três cerimônias do Canon Building + Decisão de Continuidade como parte do ciclo mínimo. A complexidade do protótipo aumenta.
- **Novo item sugerido pelo Canon Building**: validação da formalização SBVR + SBE. Testar se um Domain Builder consegue compreender e validar requisitos formalizados nesse formato, e se a IA consegue traduzir linguagem natural para SBVR + SBE com fidelidade.

---

## 5. Síntese e Visão Consolidada

A reformulação proposta pelo Canon Building representa um amadurecimento significativo da Etapa 1 do modelo ZionKit v0.4. As mudanças não são superficiais — afetam nomenclatura, estrutura processual, artefatos, fluxos de aprovação e a filosofia do modelo. No entanto, os princípios de design fundamentais do ZionKit são não apenas preservados, mas fortalecidos.

**As mudanças de maior impacto positivo são:**

1. **A substituição de MARE por SBVR + SBE** ancora o modelo em padrões reconhecidos com ecossistema maduro, aumentando sua credibilidade e implementabilidade.
2. **A antecipação das aprovações para o Canon Building** fortalece o princípio de prevenção sobre detecção e simplifica a Etapa 2.
3. **A promoção das atividades do Architect a cerimônia formal** dá paridade à camada de arquitetura e cria um fluxo sequencial logicamente sólido.
4. **A identidade "Product Canon"** comunica a natureza do artefato central de forma mais precisa e memorável.

**Os riscos que merecem atenção são:**

1. **Gargalo de aprovadores** — o risco mais significativo da reformulação. Três gates de aprovação multiplicam a demanda sobre Domain Expert e Architect. Mitigações possíveis: aprovação assíncrona, delegação por contexto, ou consolidação de Change Plans em ciclos rápidos.
2. **Curva de aprendizado de SBVR** — se a notação controlada do SBVR for percebida como técnica ou burocrática pelos Domain Builders, o modelo perde seu diferencial de inclusão. A IA como mediadora que traduz linguagem natural para SBVR pode mitigar, mas precisa ser validada empiricamente.
3. **Perda de detalhamento estrutural** — o Canon Building não detalha a organização física da Product Canon nem as fases internas das cerimônias. Isso é adequado para o estágio atual (diagrama conceitual), mas precisará ser endereçado na evolução do modelo.

**Visão consolidada:** o Canon Building é uma evolução bem fundamentada que transforma a Etapa 1 de um processo orientado a pipelines técnicas em um processo orientado a cerimônias com governança. O modelo ganha identidade terminológica, ancoragem em padrões reconhecidos e fluxos de aprovação mais robustos. O custo é um aumento controlado de complexidade processual, com o risco principal concentrado na disponibilidade de aprovadores. A aderência geral ao modelo ZionKit v0.4 é **Alta** — nenhuma mudança contradiz os princípios de design, e várias os fortalecem diretamente.

---

## 6. Decisões de Design Pendentes

As decisões abaixo foram extraídas dos pontos marcados como "requer decisão", trade-offs não resolvidos e ambiguidades identificadas nas seções anteriores. Estão ordenadas da mais crítica (bloqueia progresso ou tem impacto cascata) para a menos crítica (pode ser adiada sem prejuízo estrutural).

---

### D1. Organização Interna da Product Canon

**O que precisa ser decidido:** Como a Product Canon é estruturada internamente — sua organização lógica e física. O v0.4 definia uma estrutura de diretórios explícita (`/golden-source/domain/`, `/golden-source/architecture/`, `/golden-source/changelog/`). O Canon Building não detalha essa organização, focando na identidade e no ciclo de vida. A seção 4.4 da análise marca este ponto como "requer decisão".

**Referências:** Seção 4.4 (Estrutura de Artefatos), Seção 3.1 (Product Canon), A1.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Preservar estrutura do v0.4, renomeando** | Manter `/product-canon/domain/`, `/product-canon/architecture/`, `/product-canon/changelog/` com os mesmos artefatos, adicionando diretório para Canonical Change Plans. | Continuidade; estrutura já pensada e detalhada; baixo risco de perder informação. | Pode não refletir a nova semântica de cerimônias; mantém organização por camada técnica em vez de por fluxo de governança. |
| **⭐ B. Estrutura mínima para prototipação** | Definir apenas as seções essenciais (glossário, regras, princípios, eventos/comandos, change plans) sem compromisso com hierarquia final. Usar flat structure ou organização simples por tipo de artefato. | Permite prototipar rápido sem decisão prematura; a estrutura ideal emergirá do uso real; alinhado com fase de prototipação. | Risco de acumular dívida organizacional; pode dificultar testes de injeção seletiva (Etapa 2) se a estrutura for muito plana. |
| **C. Redesenhar por cerimônia de origem** | Organizar a Product Canon por cerimônia que produziu o conhecimento (`/discovery/`, `/constitution/`, `/specification/`), com change plans aninhados. | Reflete a nova filosofia de cerimônias; rastreabilidade nativa da origem do conhecimento. | Conhecimento transversal (glossário usado por todas as cerimônias) não tem "dono" claro; pode criar duplicação ou referências cruzadas complexas. |

**Recomendação:** Opção B. Em fase de prototipação, a estrutura interna da Product Canon é um detalhe que deve emergir da experimentação. Definir uma hierarquia rígida agora seria prematura — você ainda não sabe como a IA vai consumir e produzir conteúdo na canon, nem como a injeção seletiva da Etapa 2 vai funcionar na prática. Uma estrutura mínima flat com seções nomeadas é suficiente para validar o modelo.

**Impacto de adiar:** **Baixo no curto prazo, crescente no médio prazo.** Para prototipar as cerimônias e validar o fluxo de Canonical Change Plans, uma estrutura mínima funciona. O risco aparece quando você prototipar a Etapa 2 (injeção seletiva de contexto) — nesse ponto, a organização interna da canon afeta diretamente a qualidade da seleção. Decisão pode ser adiada até o segundo ciclo de prototipação.

---

### D2. Schema e Diferenciação dos Canonical Change Plans

**O que precisa ser decidido:** Se os três tipos de Canonical Change Plan (Domain Discovery, Technical Constitution, Requirements Specification) compartilham um schema único com seções opcionais ou se são artefatos tipados com schemas distintos. A análise (seção 3.6) identifica que o mesmo nome cobre conteúdos estruturalmente diferentes.

**Referências:** Seção 3.6 (Canonical Change Plan como Artefato Recorrente), A2.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Schema único genérico** | Um único template com seções opcionais (domínio, arquitetura, requisitos). Cada cerimônia preenche as seções relevantes. | Simplicidade; um só artefato para governar; facilita automação e aprovação com fluxo único. | Seções vazias podem confundir; perde expressividade sobre o que cada cerimônia produz; aprovadores revisam template parcialmente preenchido. |
| **⭐ B. Schema base + extensão tipada** | Um envelope comum (metadata: cerimônia de origem, ciclo, autor, status de aprovação) com payload tipado por cerimônia. Três tipos: `discovery-plan`, `constitution-plan`, `specification-plan`. | Padronização do ciclo de vida + especificidade do conteúdo; a IA sabe o que gerar para cada cerimônia; aprovadores sabem o que esperar. | Mais complexo de definir inicialmente; risco de over-engineering se os tipos divergirem pouco na prática. |
| **C. Artefatos independentes nomeados** | Três artefatos distintos com nomes próprios (ex: Domain Discovery Report, Technical Constitution Record, Requirements Specification Sheet), sem relação formal entre eles. | Máxima clareza sobre o que cada cerimônia produz; sem ambiguidade de nome. | Perde a elegância conceitual do "protocolo único"; triplica a governança (3 fluxos de aprovação com regras potencialmente diferentes); inconsistente com a filosofia declarada no Canon Building. |

**Recomendação:** Opção B. O Canonical Change Plan funciona como protocolo de comunicação entre cerimônias e Product Canon (analogia da seção 3.6). Protocolos têm headers comuns e payloads variáveis — essa é a abstração correta. Para prototipação, defina o envelope mínimo (cerimônia, ciclo, autor, status) e esboce os campos do payload de cada tipo. Refine com base no que a IA realmente consegue gerar.

**Impacto de adiar:** **Médio.** Sem uma definição mínima de schema, o protótipo das cerimônias não tem como validar se a IA gera Change Plans corretos. Não precisa ser o schema final, mas precisa existir algo para testar contra. Decisão necessária antes de prototipar a primeira cerimônia.

---

### D3. Modelo de Aprovação nos Gates Cerimoniais

**O que precisa ser decidido:** Como operacionalizar a aprovação dual (Domain Expert + Architect) em cada cerimônia sem criar gargalo. A análise identifica este como o risco mais significativo da reformulação (risco 9.5 agravado, seção 4.6). Mitigações possíveis foram sugeridas (aprovação assíncrona, delegação por contexto, consolidação), mas nenhuma foi escolhida.

**Referências:** Seção 3.5 (Antecipação dos Fluxos), Seção 4.6 (Risco 9.5), F1, F2.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Aprovação dual síncrona em todos os gates** | Domain Expert e Architect aprovam cada Change Plan antes da próxima cerimônia. Fiel ao fluxo descrito no Canon Building. | Máxima governança; nenhuma cerimônia avança sem validação completa; modelo mais seguro. | Gargalo máximo; 3 pontos de espera por ciclo; inviável em equipes onde aprovadores têm baixa disponibilidade; pode matar a adoção. |
| **⭐ B. Aprovação primária por afinidade + aprovação secundária assíncrona** | Domain Expert aprova primariamente Change Plans de Discovery e Specification; Architect aprova primariamente Change Plan de Constitution. A aprovação primária habilita a próxima cerimônia. A aprovação secundária ocorre em paralelo, com janela de veto. | Desbloqueia fluxo com metade das dependências; respeita expertise (quem entende mais, aprova primeiro); mantém governança dual sem serializar tudo. | Risco de a aprovação secundária virar rubber stamp; complexidade de governança (o que acontece se o veto chega depois da cerimônia seguinte?). |
| **C. Consolidação de Change Plans com gate único ao final do ciclo** | As três cerimônias executam sequencialmente sem gates intermediários. Um único gate de aprovação consolida os três Change Plans ao final do ciclo. | Fluxo mais rápido; um único ponto de aprovação; menor overhead para aprovadores. | Perde o benefício de "prevenção sobre detecção" (cerimônias avançam sobre premissas não validadas); contradiz parcialmente a filosofia declarada no Canon Building; rejeição tardia causa retrabalho maior. |

**Recomendação:** Opção B. A aprovação por afinidade com veto assíncrono é o ponto de equilíbrio entre governança e velocidade. O Domain Expert é a pessoa certa para validar descobertas de domínio e requisitos; o Architect é a pessoa certa para validar princípios técnicos. A aprovação cruzada (secundária) adiciona segurança sem bloquear. Para prototipação, simule a aprovação primária e observe se a secundária agrega valor real — se não agregar, simplifique.

**Impacto de adiar:** **Alto.** O modelo de aprovação afeta diretamente o design do fluxo entre cerimônias e a experiência dos participantes. Prototipar sem definir isso significa prototipar um fluxo que pode ser fundamentalmente diferente do modelo final. Decisão necessária antes de prototipar o ciclo completo.

---

### D4. Nível de Formalidade do SBVR na Requirements Specification

**O que precisa ser decidido:** O quanto da notação formal do SBVR será exigido dos Domain Builders vs. o quanto a IA mediará a tradução. A análise (seção 3.3) identifica a curva de aprendizado do SBVR como risco de adoção — se a notação for percebida como técnica, o modelo perde seu diferencial de inclusão.

**Referências:** Seção 3.3 (Eliminação MARE → SBVR+SBE), Seção 4.6 (novo risco de adoção SBVR).

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. SBVR formal completo** | Domain Builders interagem com a notação SBVR diretamente (termos em negrito, fact types em itálico, keywords modais "It is obligatory that..."). A IA auxilia mas o artefato final é SBVR puro. | Máxima precisão; ancoragem total no padrão OMG; interoperável com ferramentas SBVR existentes. | Curva de aprendizado alta; intimida Domain Builders não-técnicos; contradiz o princípio de inclusão; pode ser abandonado na prática. |
| **⭐ B. SBVR mediado pela IA** | Domain Builders descrevem regras e requisitos em linguagem natural. A IA traduz para SBVR controlado e apresenta para validação. O artefato na Product Canon é SBVR, mas a interface de autoria é conversacional. | Preserva inclusão (Domain Builder fala natural); preserva precisão (artefato final é formal); a IA é usada no que faz melhor (tradução de linguagem); valida empiricamente se LLMs conseguem fazer essa tradução. | Depende da qualidade da tradução da IA (precisa ser validado); Domain Builder valida algo que não escreveu diretamente (risco de rubber stamp); a IA torna-se ponto único de falha na formalização. |
| **C. SBVR-lite (vocabulário controlado sem notação formal)** | Adotar apenas os princípios do SBVR (vocabulário controlado, regras declarativas) sem a notação formal. Requisitos escritos em português/inglês estruturado com termos do glossário, sem fact types ou keywords modais. | Baixa barreira de entrada; qualquer Domain Builder entende; ainda melhor que linguagem completamente livre. | Perde a ancoragem no padrão formal; ambiguidades reaparecem sem a notação controlada; não interoperável com ferramentas SBVR; pode ser percebido como "SBVR de mentira". |

**Recomendação:** Opção B. A IA como mediadora entre linguagem natural e SBVR é a proposta mais alinhada com o espírito do ZionKit — o modelo existe justamente para mediar entre intenção humana e precisão formal. Além disso, validar essa capacidade de tradução é um dos testes mais valiosos da prototipação: se a IA não conseguir traduzir linguagem natural para SBVR com fidelidade, isso invalida uma premissa central do Canon Building.

**Impacto de adiar:** **Médio-baixo.** Para prototipar a Requirements Specification Session, você precisa saber se vai pedir SBVR direto do Domain Builder ou se a IA traduz. Mas a definição do nível exato de formalidade do output SBVR pode ser refinada iterativamente. Decisão da abordagem geral (direta vs. mediada) necessária antes de prototipar a cerimônia; detalhes da notação podem evoluir.

---

### D5. Estrutura Interna das Cerimônias (Fases)

**O que precisa ser decidido:** Se as cerimônias do Canon Building terão fases internas explícitas (como as 4 fases do Event Storming no v0.4 e as 4 fases da MARE) ou se permanecerão como "sessões" sem decomposição interna. A análise (seções 3.2 e 3.3) identifica a perda de detalhamento estrutural como contra das mudanças.

**Referências:** Seção 3.2 (perda das 4 fases do Event Storming), Seção 3.3 (perda das 4 fases da MARE), Seção 5 (síntese: perda de detalhamento estrutural).

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Fases explícitas para todas as cerimônias** | Definir fases internas para Domain Discovery (4 fases do Event Storming preservadas), Technical Constitution (fases a definir) e Requirements Specification (fases a definir, substituindo as da MARE). | Máxima clareza sobre o que acontece dentro de cada cerimônia; guia implementação de prompts por fase; reprodutível. | Over-specification prematura; pode engessar cerimônias que precisam de flexibilidade; esforço de design alto para 3 cerimônias × N fases. |
| **B. Sem fases, cerimônias opacas** | Manter cerimônias como unidades atômicas: entrada (contexto), processo (sessão conversacional), saída (Canonical Change Plan). Sem decomposição interna no modelo. | Simplicidade máxima; deixa a implementação definir a dinâmica; foco no que entra e no que sai, não no como. | Difícil de prototipar (o que exatamente a IA faz durante uma "sessão"?); perde o guia prático que as fases forneciam; reprodutibilidade baixa. |
| **⭐ C. Fases para Domain Discovery, diretrizes para as demais** | Preservar as 4 fases do Event Storming na Domain Discovery (já validadas pela prática). Para Technical Constitution e Requirements Specification, definir diretrizes de condução (objetivos de cada momento da sessão) sem fases rígidas. | Preserva o que funciona (Event Storming é bem documentado); dá flexibilidade onde não há precedente claro; pragmático para prototipação. | Assimetria no nível de detalhe entre cerimônias; Technical Constitution e Requirements Specification podem parecer sub-especificadas em comparação. |

**Recomendação:** Opção C. O Event Storming tem um fluxo de fases testado por décadas de prática — preservá-lo é aproveitar conhecimento validado. Para Technical Constitution e Requirements Specification, que são cerimônias novas no contexto do ZionKit, definir fases rígidas agora seria especulação. Diretrizes (objetivos + entradas + saídas esperadas por momento) fornecem estrutura suficiente para prototipar sem engessar.

**Impacto de adiar:** **Médio.** Sem alguma noção de "o que acontece dentro da cerimônia", é difícil construir prompts de sistema para a IA mediadora. Mas a decisão pode ser tomada incrementalmente: defina fases para a primeira cerimônia que prototipar e observe o que funciona antes de definir as demais.

---

### D6. Escopo da Technical Constitution Session

**O que precisa ser decidido:** Se a Technical Constitution Session abrange apenas princípios técnicos constitucionais (foco declarado no Canon Building) ou se absorve também as outras atividades do Architect listadas no v0.4: validação de BCs, definição de context map, ADRs fundacionais, avaliação técnica de requisitos. A análise (seção 3.4) identifica que o Canon Building concentra o foco em princípios, potencialmente perdendo as demais atividades.

**Referências:** Seção 3.4 (Technical Constitution Session), C3, seção 2.2.4 do v0.4.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Escopo amplo (todas as atividades do Architect)** | A Technical Constitution Session cobre: princípios constitucionais, validação de BCs, context maps, ADRs fundacionais e avaliação técnica de requisitos. | Nenhuma atividade do Architect fica órfã; cerimônia completa; não requer redistribuição. | Cerimônia longa e pesada; mistura atividades de natureza diferente (princípios estratégicos vs. validações técnicas); pode sobrecarregar um único gate de aprovação. |
| **⭐ B. Escopo focado + distribuição das demais atividades** | Technical Constitution Session foca em princípios constitucionais e ADRs estratégicos. Validação de BCs e context maps acontece como parte da aprovação do Change Plan de Domain Discovery (o Architect valida a estrutura de domínio proposta). Avaliação técnica de requisitos acontece como parte da aprovação do Change Plan de Requirements Specification. | Cada atividade do Architect acontece no momento mais natural; cerimônia focada e rápida; aprovações secundárias do Architect nas outras cerimônias ganham substância (não são rubber stamp — há trabalho real). | Atividades do Architect ficam distribuídas em 3 pontos; pode ser difícil rastrear o que o Architect faz; exige que as aprovações secundárias sejam genuínas, não formais. |
| **C. Escopo mínimo (apenas princípios constitucionais)** | Technical Constitution Session define exclusivamente princípios técnicos constitucionais. Todas as outras atividades do Architect são tratadas ad hoc, fora das cerimônias. | Cerimônia mais enxuta possível; foco absoluto. | 4 das 5 atividades do Architect ficam sem "casa" formal; risco de regressão ao modelo v0.4 onde o Architect era um participante narrativo sem cerimônia definida. |

**Recomendação:** Opção B. A distribuição natural das atividades do Architect pelos gates de aprovação é elegante e resolve dois problemas simultaneamente: mantém a Technical Constitution Session focada e dá substância às aprovações secundárias do Architect nas outras cerimônias. O Architect não é um rubber stamp nos gates de Domain Discovery e Requirements Specification — ele está ativamente validando BCs, context maps e viabilidade técnica.

**Impacto de adiar:** **Baixo.** Para prototipação, foque na Technical Constitution Session com princípios constitucionais. A redistribuição das demais atividades pode ser decidida quando prototipar o ciclo completo com aprovações. Não bloqueia o protótipo inicial.

---

### D7. Critérios e Autoridade na Decisão de Continuidade do Ciclo

**O que precisa ser decidido:** Quem toma a Decisão de Continuidade do Ciclo (D.C.C.) e com base em quais critérios. O Canon Building define as três opções (mapear mais fluxos, formalizar mais requisitos, encerrar ciclo) mas não especifica quem decide nem como. A análise (seção 3.11) identifica ambiguidade sobre se Technical Constitution é re-executada nas iterações.

**Referências:** Seção 3.11 (Decisão de Continuidade), C5.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **⭐ A. Domain Builder decide com input da IA** | O Domain Builder, como autor primário do ciclo, decide se continua ou encerra. A IA pode sugerir com base em cobertura (áreas do domínio não mapeadas, requisitos pendentes), mas a decisão é humana. | Consistente com "IA sem autonomia decisória"; o Domain Builder conhece o contexto de negócio e sabe quando há cobertura suficiente; simples. | Domain Builder pode não ter visibilidade técnica para saber se faltam decisões de arquitetura; pode encerrar prematuramente. |
| **B. Decisão consensual (Domain Builder + Architect)** | Ambos precisam concordar que o ciclo pode encerrar. Cada um avalia cobertura na sua dimensão (negócio e arquitetura). | Governança mais robusta; ambas as dimensões são avaliadas; reduz risco de encerramento prematuro. | Mais um ponto de sincronização entre dois papéis; pode gerar atrito se houver divergência sobre "quando é suficiente". |
| **C. Critérios formais de completude** | Definir checklist de cobertura mínima (ex: todos os BCs mapeados, todos os fluxos críticos com requisitos, princípios técnicos definidos) que deve ser satisfeito para encerrar. A IA valida automaticamente. | Objetividade; decisão baseada em evidência, não em opinião; automação possível. | Definir critérios universais de "completude" para domínios diversos é impraticável nesta fase; burocracia excessiva; rigidez. |

**Recomendação:** Opção A. Em prototipação, a decisão de continuidade é fundamentalmente uma decisão de negócio ("já descobri o suficiente para avançar?"), não uma decisão técnica com critérios formais. O Domain Builder está na melhor posição para julgar isso. A IA pode auxiliar sinalizando áreas não cobertas, mas a autonomia decisória permanece humana — consistente com o princípio P4.

**Impacto de adiar:** **Baixo.** Nos primeiros protótipos, o ciclo provavelmente será executado uma vez de ponta a ponta. A decisão de continuidade só se torna relevante quando você tiver ciclos iterativos reais. Pode ser definida após o primeiro ciclo completo de prototipação.

---

### D8. Fronteira entre Autonomia Operacional e Decisória da IA

**O que precisa ser decidido:** Onde traçar a linha entre o que a IA pode fazer autonomamente (autonomia operacional: conduzir sessão, formatar outputs, sugerir próximos passos) e o que requer decisão humana (autonomia decisória: o que entra na canon, o que é aprovado, o que muda). A análise (seção 3.8) identifica que a formulação atual é absoluta ("sem autonomia decisória") e pode precisar de refinamento.

**Referências:** Seção 3.8 (Restrição Explícita da Autonomia da IA), P4.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Manter formulação absoluta** | "Sem autonomia decisória" permanece como princípio sem detalhamento. A implementação interpreta caso a caso. | Princípio claro e forte; não gera edge cases no modelo; simplicidade. | Ambiguidade na implementação (a IA sugerir uma estrutura de Change Plan é decisão ou operação?); cada protótipo interpreta diferente. |
| **⭐ B. Definir categorias com exemplos** | Manter o princípio "sem autonomia decisória" e adicionar uma lista indicativa de atos operacionais (permitidos) e atos decisórios (requerem humano). Ex: operacional = formatar, sugerir, reorganizar, sinalizar inconsistência. Decisório = incluir/excluir da canon, aprovar, resolver ambiguidade de domínio. | Princípio preservado com guia de aplicação; reduz ambiguidade sem criar burocracia; exemplos são mais úteis que definições abstratas. | Lista nunca será exaustiva; pode criar falsa sensação de completude; edge cases sempre existirão. |
| **C. Framework formal de níveis de autonomia** | Definir escala de autonomia (ex: Level 0 = humano faz tudo, Level 1 = IA sugere, Level 2 = IA faz com confirmação, Level 3 = IA faz com veto, Level 4 = IA faz sozinha) e classificar cada ação da IA no modelo. | Máxima precisão; framework reutilizável; base para configuração de agentes. | Over-engineering para fase de prototipação; decisões de nível por ação são especulativas sem experiência prática; custo de manutenção alto. |

**Recomendação:** Opção B. Uma lista indicativa com exemplos concretos é o formato mais útil para prototipação — dá aos implementadores (e aos LLMs) orientação prática sem exigir uma taxonomia completa. O princípio "sem autonomia decisória" permanece como regra geral; os exemplos são guia, não lei.

**Impacto de adiar:** **Baixo.** O princípio genérico é suficiente para iniciar a prototipação. Os edge cases vão emergir naturalmente quando a IA começar a mediar cerimônias, e aí você terá evidência concreta para categorizar. Decisão pode ser tomada incrementalmente.

---

### D9. Escopo Residual da Aprovação na Etapa 2

**O que precisa ser decidido:** Com a aprovação primária antecipada para o Canon Building, o que resta da aprovação dual na Etapa 2? A análise (seção 4.1) identifica que a Etapa 2 pode ser "flexibilizada" para cobrir apenas "impactos emergentes", mas não define o que isso significa na prática.

**Referências:** Seção 4.1 (Impacto na Etapa 2), F1, F2.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Manter aprovação dual na Etapa 2** | Mesmo com Canon Building, a Etapa 2 mantém aprovação dual completa sobre o Change Plan incremental da especificação. | Máxima segurança; cobre impactos emergentes com o mesmo rigor; sem risco de mudança não revisada. | Risco de fadiga de aprovadores (já aprovaram 3x no Canon Building); gate pode virar formalidade; agrava risco 9.5. |
| **⭐ B. Aprovação condicional (só se houver impacto na canon)** | A Etapa 2 gera Canonical Change Plan incremental. Se o Change Plan for vazio (a spec não altera a canon), a aprovação é dispensada. Se houver impacto, aprovação pelo papel afetado (Domain Expert para negócio, Architect para arquitetura — retoma roteamento por camada do v0.4). | Reduz overhead quando a base já está sólida; mantém governança quando necessário; roteamento por camada é mais eficiente que dual obrigatório. | Requer mecanismo de detecção de impacto (a IA precisa saber se a spec altera a canon); risco de falso negativo (impacto não detectado = aprovação pulada indevidamente). |
| **C. Eliminar aprovação na Etapa 2** | Se o Canon Building aprovou o corpo de conhecimento, a Etapa 2 confia na base aprovada e não tem gate próprio. | Máxima velocidade; zero overhead adicional; simplificação radical da Etapa 2. | Risco real: especificações concretas revelam impactos que a análise conceitual não antecipou; sem gate, essas mudanças entram na canon sem revisão; contradiz "prevenção sobre detecção". |

**Recomendação:** Opção B. A aprovação condicional é o ponto de equilíbrio: não burocratiza o caminho feliz (spec sem impacto na canon flui direto) mas mantém a rede de segurança quando há mudança real. O retorno do roteamento por camada do v0.4 é uma boa ideia — na Etapa 2, o escopo do Change Plan é tipicamente mais focado, e aprovação por camada é mais eficiente que dual obrigatória.

**Impacto de adiar:** **Muito baixo.** A Etapa 2 não é prioridade de prototipação imediata — o foco está no Canon Building. Esta decisão pode ser tomada quando a prototipação chegar à Etapa 2. Até lá, a experiência com o Canon Building vai informar se a aprovação da Etapa 2 é realmente necessária.

---

### D10. Estratégia de Terminologia Bilíngue

**O que precisa ser decidido:** Se o modelo adota terminologia totalmente em inglês (como propõe o Canon Building) ou mantém uma estratégia bilíngue (termos técnicos em inglês com descrições em português). A análise (seção 3.7) identifica tensão entre coerência linguística e inclusão de audiências lusófonas.

**Referências:** Seção 3.7 (Anglicização dos Nomes de Papéis), N7-N9.

| Opção | Descrição | Prós | Contras |
|-------|-----------|------|---------|
| **A. Inglês total** | Todos os termos do modelo em inglês. Documentação pode ser em português, mas os conceitos são referenciados pelos nomes em inglês. | Máxima coerência terminológica; modelo pronto para audiência internacional; sem ambiguidade de tradução. | Barreira para Domain Builders lusófonos; "Domain Builder" pode soar alienígena em contextos brasileiros; o modelo fala de inclusão mas exclui por idioma. |
| **⭐ B. Termos canônicos em inglês + glosa em português na primeira ocorrência** | Usar os nomes em inglês como termos canônicos (Product Canon, Domain Builder, Canonical Change Plan), mas sempre com descrição em português na primeira ocorrência e no glossário. Ex: "Domain Builder (Construtor de Domínio — analista de negócio, PO ou gestor que conduz as cerimônias)". | Coerência do vocabulário técnico; acessibilidade via glosa; padrão comum em literatura técnica brasileira; funciona para ambas as audiências. | Verbosidade na primeira ocorrência; risco de as glosas divergirem dos termos canônicos ao longo do tempo; necessário manter glossário bilíngue atualizado. |
| **C. Português com termos técnicos em inglês entre parênteses** | Termos primários em português (Construtor de Domínio, Cânone do Produto, Plano de Mudança Canônico) com original em inglês entre parênteses. | Máxima acessibilidade para audiência lusófona; os termos em português podem ser mais intuitivos. | Perde identidade terminológica do modelo; "Cânone do Produto" não tem o mesmo impacto que "Product Canon"; cria termos portugueses que ninguém vai usar na prática. |

**Recomendação:** Opção B. É o padrão de facto em documentação técnica brasileira — termos canônicos em inglês, explicação em português. Mantém a identidade do modelo sem alienar a audiência primária. Para prototipação, simplesmente use os termos em inglês e explique quando necessário.

**Impacto de adiar:** **Muito baixo.** Esta é uma decisão de documentação, não de modelo. Qualquer terminologia usada agora pode ser harmonizada depois. Zero impacto na prototipação.

---

## 7. Registro de Decisões

*Seção editável para registro das decisões tomadas pelo autor do modelo.*

---

### D1. Organização Interna da Product Canon
- [ ] Opção A: Preservar estrutura de diretórios do v0.4, renomeando para `/product-canon/`
- [X] Opção B: Estrutura mínima flat para prototipação, sem compromisso com hierarquia final ⭐
- [ ] Opção C: Redesenhar organização por cerimônia de origem (`/discovery/`, `/constitution/`, `/specification/`)



---

### D2. Schema e Diferenciação dos Canonical Change Plans
- [ ] Opção A: Schema único genérico com seções opcionais
- [X] Opção B: Schema base (envelope com metadata) + extensão tipada por cerimônia ⭐
- [ ] Opção C: Artefatos independentes nomeados, sem relação formal



---

### D3. Modelo de Aprovação nos Gates Cerimoniais
- [ ] Opção A: Aprovação dual síncrona em todos os gates
- [X] Opção B: Aprovação primária por afinidade + aprovação secundária assíncrona com janela de veto ⭐
- [ ] Opção C: Consolidação com gate único ao final do ciclo



---

### D4. Nível de Formalidade do SBVR
- [ ] Opção A: SBVR formal completo — Domain Builders interagem com notação diretamente
- [X] Opção B: SBVR mediado pela IA — autoria conversacional, artefato formal ⭐
- [ ] Opção C: SBVR-lite — vocabulário controlado sem notação formal



---

### D5. Estrutura Interna das Cerimônias (Fases)
- [ ] Opção A: Fases explícitas para todas as 3 cerimônias
- [ ] Opção B: Sem fases — cerimônias como unidades atômicas (entrada → sessão → saída)
- [X] Opção C: Fases para Domain Discovery (Event Storming), diretrizes para as demais ⭐



---

### D6. Escopo da Technical Constitution Session
- [ ] Opção A: Escopo amplo — todas as 5 atividades do Architect
- [X] Opção B: Escopo focado em princípios + distribuição das demais atividades pelos gates ⭐
- [ ] Opção C: Escopo mínimo — apenas princípios constitucionais



---

### D7. Critérios e Autoridade na Decisão de Continuidade do Ciclo
- [X] Opção A: Domain Builder decide com input da IA ⭐
- [ ] Opção B: Decisão consensual (Domain Builder + Architect)
- [ ] Opção C: Critérios formais de completude com checklist



---

### D8. Fronteira entre Autonomia Operacional e Decisória da IA
- [ ] Opção A: Manter formulação absoluta ("sem autonomia decisória"), sem detalhamento
- [X] Opção B: Manter princípio + lista indicativa de exemplos (operacional vs. decisório) ⭐
- [ ] Opção C: Framework formal de níveis de autonomia



---

### D9. Escopo Residual da Aprovação na Etapa 2
- [ ] Opção A: Manter aprovação dual completa
- [X] Opção B: Aprovação condicional — só se houver impacto na canon, com roteamento por camada ⭐
- [ ] Opção C: Eliminar aprovação na Etapa 2



---

### D10. Estratégia de Terminologia Bilíngue
- [ ] Opção A: Inglês total — todos os termos e referências em inglês
- [X] Opção B: Termos canônicos em inglês + glosa em português na primeira ocorrência ⭐
- [ ] Opção C: Português como idioma primário, inglês entre parênteses


