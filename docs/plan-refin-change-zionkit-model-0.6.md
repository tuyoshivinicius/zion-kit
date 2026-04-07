# Análise de Mudanças — ZionKit v0.5 → v0.6

**Data:** 2026-04-07
**Base:** zionkit-model.md (v0.5), plan-refin-change-zionkit.md, plan-refin-change-session-all-messages.md

---

## Mudança 1 — Reposicionamento do SBVR: de formato visível e exclusivo para ferramenta interna entre várias metodologias de validação

### Contexto Atual (v0.5)

Na versão 0.5, SBVR (Semantics of Business Vocabulary and Business Rules) é utilizado como formato de escrita visível nos artefatos do modelo e como mecanismo central e exclusivo de formalização de requisitos. Na Requirements Specification Session (seção 2.2.3), o fluxo é linear: o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e a formalização SBVR é apresentada ao Domain Builder para validação. O SBVR aparece como artefato primário de validação — o Domain Builder lê e aprova a notação formalizada. Na Product Canon (seção 2.1), a camada de negócio contém "Requisitos formalizados via SBVR + SBE". Nos Canonical Change Plans (seção 2.3.3), a notação SBVR está presente como parte dos artefatos de aprovação. A seção de riscos (9.6) reconhece o problema: o Domain Builder pode aprovar mecanicamente ("rubber stamp") uma formalização SBVR que ele não escreveu e que pode não compreender plenamente. Os guardrails existentes na seção 2.2.5 — Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições) — operam como mecanismos complementares, mas separados do SBVR, e o SBVR é tratado implicitamente como a metodologia única de formalização.

### Proposta de Mudança (v0.6)

SBVR deixa de ser formato de escrita visível e metodologia exclusiva, passando a ser uma das ferramentas internas de validação semântica da IA. A notação SBVR não aparece em nenhum artefato visível ao usuário — nem na Product Canon, nem nos Canonical Change Plans, nem nas telas de aprovação. Quando o Domain Builder descreve um requisito em linguagem natural, a IA internamente traduz para SBVR controlado e utiliza essa representação formal para detectar ambiguidades estruturais, incompletude de predicados, falta de quantificadores, indefinição de participantes e condições. Os problemas detectados são traduzidos de volta para linguagem natural e apresentados ao usuário como perguntas de clarificação — o usuário nunca vê a notação formal. SBVR é explicitamente posicionado como uma das metodologias de validação interna, agregado ao arsenal existente e complementando os guardrails de Clarificação de Conformidade e Validação de Consistência sem substituí-los. Cada mecanismo cobre um vetor diferente de falha: a Clarificação de Conformidade verifica alinhamento terminológico com o glossário; a Validação de Consistência confronta novos requisitos com regras existentes; a validação SBVR analisa a expressão individual do requisito para detectar ambiguidade estrutural, incompletude de predicados e indefinição de participantes. A IA pode e deve utilizar outras metodologias de validação além de SBVR — análise de dependências entre bounded contexts, verificação de completude de fluxos, análise de cobertura de cenários de erro — desde que os resultados sejam apresentados ao usuário como perguntas de clarificação em linguagem natural, nunca como notação formal. A justificativa é tripla: (a) eliminar o risco de rubber stamp (seção 9.6) ao remover a necessidade de o Domain Builder validar um formato que frequentemente não compreende; (b) permitir que o SBVR opere com maior rigor formal nos bastidores, livre da necessidade de ser legível para humanos; (c) SBVR preenche uma lacuna específica que os guardrails existentes não cobrem (análise da expressão individual), mas não é suficiente para cobrir todos os vetores de falha em requisitos.

### Prós

- Elimina o risco de rubber stamp documentado na seção 9.6, removendo a necessidade de o Domain Builder validar notação formal que frequentemente não compreende.
- Permite que o SBVR opere com maior rigor formal nos bastidores, livre da restrição de legibilidade humana — a representação interna pode ser mais precisa e detalhada.
- Posiciona SBVR como parte de um arsenal de validação, cobrindo a lacuna específica de análise da expressão individual do requisito (ambiguidade estrutural, incompletude de predicados) que os guardrails existentes não cobrem.
- Mantém a interação com o Domain Builder inteiramente em linguagem natural, preservando o diferencial de inclusão do modelo.
- Abre espaço para incorporar outras metodologias de validação sem alterar a experiência do usuário.

### Contras

- Perda de transparência sobre o processo de validação: o Domain Builder não sabe quais métodos a IA está utilizando, o que pode gerar desconfiança ou, inversamente, confiança excessiva.
- Dependência da qualidade da tradução IA→linguagem natural: se a IA não traduzir adequadamente os problemas detectados pelo SBVR em perguntas de clarificação claras e acionáveis, o benefício da validação se perde.
- Dificulta a auditoria externa do processo de validação — não há artefato visível que demonstre quais análises foram realizadas.
- Introduz uma camada de indireção: o Domain Builder valida perguntas de clarificação, não a formalização em si, o que requer confiança no processo intermediário da IA.

### Justificativa

O reposicionamento do SBVR resolve uma contradição fundamental da v0.5: o modelo propõe inclusão de Domain Builders não-técnicos, mas exige que eles validem uma notação formal que frequentemente não compreendem. A seção 9.6 do modelo v0.5 já reconhece esse problema como risco residual ("rubber stamp"). Ao internalizar o SBVR, a mudança reconcilia o rigor formal necessário para validação semântica com a acessibilidade necessária para participação efetiva do Domain Builder. Adicionalmente, posicionar SBVR como uma entre várias metodologias de validação é mais honesto sobre suas capacidades reais — SBVR é forte em análise de expressão individual, mas não cobre todos os vetores de falha em requisitos.

### Impacto no Modelo

- **Requirements Specification Session (seção 2.2.3):** O fluxo muda fundamentalmente — a IA não apresenta mais notação SBVR para validação; apresenta perguntas de clarificação e formalização em IEEE 29148 + SBE.
- **Product Canon (seção 2.1):** A camada de negócio deixa de conter "Requisitos formalizados via SBVR + SBE" — o formato canônico visível muda.
- **Canonical Change Plans:** Notação SBVR é removida de todos os tipos de Change Plan.
- **Guardrails (seção 2.2.5):** SBVR passa a operar como mecanismo interno complementar aos guardrails existentes, não como artefato visível nos guardrails.
- **Papel da IA (seção 4):** Ganha um novo ato operacional — usar SBVR e outras metodologias internamente para validação — distinto do ato anterior de "traduzir linguagem natural para SBVR".
- **Dependência direta:** Habilita e exige as Mudanças 2 (IEEE 29148), 4 (formato canônico) e 10 (revisão da Requirements Specification Session), que definem o que substitui o SBVR como formato visível.

### Riscos

- **Qualidade da tradução (risco reformulado do 9.6):** A IA pode não conseguir traduzir adequadamente os problemas detectados pelas metodologias de validação internas (incluindo SBVR) em perguntas de clarificação claras e acionáveis em linguagem natural. Se a tradução for imprecisa, o benefício da validação se perde.
- **Opacidade do processo (originado da absorção do risco 9.6 reformulado):** Ao tornar as metodologias de validação (SBVR e outras) invisíveis ao usuário, perde-se transparência sobre o processo. O Domain Builder não sabe quais métodos a IA está usando — ele vê apenas as perguntas de clarificação. Isso pode gerar desconfiança ("por que a IA está fazendo tantas perguntas?") ou, inversamente, confiança excessiva ("a IA já validou, então deve estar correto").
- **Regressão na detecção de problemas:** Sem a pressão de apresentar a formalização ao usuário, a IA pode internamente gerar formalizações SBVR de menor qualidade, dado que ninguém audita o resultado intermediário.

### Mitigações de Riscos

- A IA deve explicitar, quando relevante, a natureza da validação sem expor a metodologia — por exemplo, "Identifiquei que a regra menciona 'responsável' sem definir quem ocupa esse papel" é mais útil que silenciosamente adicionar uma definição. A transparência é sobre o resultado da validação, não sobre o método.
- O ciclo iterativo de clarificação permite que o Domain Builder questione e refine as perguntas da IA, criando um mecanismo de feedback sobre a qualidade da tradução.
- A prioridade de prototipação 6 (reformulada na Mudança 13) inclui métricas específicas para validar a eficácia da tradução interna.
- A formalização final em IEEE 29148 + SBE — formato compreensível por humanos — serve como ponto de validação auditável, mesmo que o processo intermediário seja opaco.

---

## Mudança 2 — Adoção do IEEE 29148 como padrão oficial de estruturação de requisitos

### Contexto Atual (v0.5)

Na versão 0.5, o modelo utiliza SBVR para formalizar vocabulário e regras de negócio, e SBE para critérios de aceitação verificáveis. Não há um padrão formal para a estrutura documental do conjunto de requisitos como um todo. Requisitos não-funcionais (performance, disponibilidade, segurança), especificações de interface, restrições de design e critérios de qualidade não possuem framework organizacional definido no modelo. A Product Canon (seção 2.1) menciona "Requisitos formalizados via SBVR + SBE" sem definir como esses requisitos são classificados, rastreados ou organizados em categorias.

### Proposta de Mudança (v0.6)

O ZionKit adota IEEE 29148 (ISO/IEC/IEEE 29148:2018) como padrão oficial para estruturação de documentos de requisitos, complementando SBVR (agora interno) e SBE na tríade de padrões do modelo. IEEE 29148 fornece: taxonomia para classificar requisitos (funcionais, não-funcionais, de interface, de design, restrições); atributos obrigatórios por requisito (identificador único, rastreabilidade, prioridade, verificabilidade); estrutura mínima do documento de requisitos; e critérios de qualidade (não-ambiguidade, completude, consistência, verificabilidade, rastreabilidade). A adoção é motivada por dois fatores: performance da IA — LLMs produzem requisitos significativamente melhores quando operam com a taxonomia IEEE 29148, amplamente representada no corpus de treinamento; e maturidade do padrão — décadas de refinamento na engenharia de requisitos. O formato canônico visível nos artefatos da Product Canon e nos Canonical Change Plans passa a ser IEEE 29148 + SBE. Requisitos não-funcionais, interfaces e restrições — que SBVR não cobre — são classificados e estruturados por IEEE 29148, conectando-se aos princípios técnicos constitucionais da Product Canon.

### Prós

- Preenche uma lacuna concreta da v0.5: a ausência de framework organizacional para requisitos não-funcionais, interfaces, restrições de design e critérios de qualidade.
- Aproveita a familiaridade dos LLMs com a taxonomia IEEE 29148, amplamente representada no corpus de treinamento, resultando em requisitos de maior qualidade.
- Oferece atributos padronizados por requisito (identificador, rastreabilidade, prioridade, verificabilidade) que habilitam rastreabilidade formal na Product Canon.
- Complementa SBVR e SBE cobrindo dimensões que nenhum dos dois alcança: organização estrutural do documento, classificação por tipo e categoria.
- Padrão maduro com décadas de refinamento, reduzindo risco de adotar uma metodologia experimental.

### Contras

- Aumenta a complexidade conceitual do modelo ao introduzir um terceiro padrão formal na tríade.
- Pode criar resistência em equipes que percebem padrões IEEE como burocráticos ou excessivamente formais.
- Exige que a IA domine a taxonomia IEEE 29148 para aplicá-la corretamente, adicionando mais um vetor de falha potencial.
- O padrão completo é extenso; sem a Mudança 3 (aderência adaptativa), a adoção poderia ser desproporcional ao contexto.

### Justificativa

A v0.5 reconhece SBVR + SBE como padrões de formalização, mas esses padrões operam no nível do requisito individual (SBVR para expressão, SBE para verificação). Não existe na v0.5 um framework para organizar o conjunto de requisitos como documento — categorias, atributos obrigatórios, rastreabilidade entre requisitos, cobertura de tipos (não-funcionais, interfaces, restrições). IEEE 29148 preenche exatamente essa lacuna de nível documental. A motivação adicional de performance da IA é pragmática: LLMs produzem saídas melhores com estruturas que conhecem bem, e IEEE 29148 é amplamente representado nos dados de treinamento.

### Impacto no Modelo

- **Product Canon (seção 2.1):** O formato de armazenamento de requisitos muda para IEEE 29148 + SBE, afetando a descrição da camada de negócio.
- **Requirements Specification Session (seção 2.2.3):** O fluxo de formalização passa a produzir saída em IEEE 29148 + SBE em vez de SBVR + SBE.
- **Technical Constitution Session (seção 2.2.2):** O Architect ganha a responsabilidade de definir o nível de aderência IEEE 29148 (habilitado pela Mudança 3).
- **Canonical Change Plans:** Todos os tipos passam a conter requisitos em formato IEEE 29148 + SBE.
- **Princípios técnicos constitucionais:** Requisitos não-funcionais categorizados via IEEE 29148 conectam-se diretamente aos princípios técnicos, criando rastreabilidade entre camadas.
- **Dependência direta:** Requer a Mudança 3 (aderência adaptativa) para evitar burocracia excessiva e a Mudança 5 (Padronização Canônica) para garantir conformidade.

### Riscos

- A IA pode aplicar a taxonomia IEEE 29148 de forma mecânica, classificando requisitos em categorias incorretas ou forçando atributos desnecessários.
- Equipes podem perceber o padrão como excessivamente formal, especialmente em contextos de prototipação rápida, comprometendo a adoção do modelo.
- A introdução simultânea de IEEE 29148 e a internalização do SBVR representa uma mudança significativa na experiência do usuário, com risco de sobrecarga cognitiva na transição.

### Mitigações de Riscos

- A Mudança 3 (aderência adaptativa com três níveis) garante que a aplicação é proporcional ao contexto, evitando formalismo excessivo.
- A mediação da IA abstrai a complexidade do padrão — o Domain Builder continua descrevendo requisitos em linguagem natural; a IA aplica a taxonomia internamente.
- A prioridade de prototipação dedicada (Mudança 16) valida empiricamente se a taxonomia funciona na prática sem parecer burocrática.

---

## Mudança 3 — Natureza adaptativa do IEEE 29148 com três níveis de aderência

### Contexto Atual (v0.5)

Na versão 0.5, não existe conceito de níveis de aderência a padrões de requisitos. Os artefatos de requisitos seguem o formato SBVR + SBE de forma uniforme, independentemente da maturidade do produto ou do bounded context.

### Proposta de Mudança (v0.6)

A aplicação do IEEE 29148 é proporcional à maturidade do produto e ao contexto do ciclo, através de três níveis de aderência: **Mínimo** (produto novo, prototipação, discovery inicial — inclui apenas tipo de requisito, descrição em linguagem natural estruturada e critérios SBE); **Moderado** (produto em crescimento, após 2-3 ciclos de Canon Building — adiciona subtipo, rastreabilidade para Change Plans, dependências entre requisitos); **Completo** (produto maduro, domínios regulados, integrações complexas — aplicação integral da taxonomia IEEE 29148 com rastreabilidade bidirecional, atributos de qualidade, seções de interface e restrição de design). O Architect define e ajusta o nível de aderência como parte da Technical Constitution Session, registrando-o nos princípios técnicos constitucionais da Product Canon. O nível pode variar por bounded context — um contexto maduro pode operar em nível Completo enquanto um contexto novo opera em nível Mínimo. O SBE (Dado/Quando/Então) é obrigatório em todos os níveis. A justificativa é evitar que a adoção do IEEE 29148 introduza burocracia excessiva em contextos de prototipação rápida ou equipes enxutas, sem comprometer a completude em domínios regulados.

### Prós

- Permite que o modelo escale proporcionalmente — equipes enxutas ou produtos em fase de discovery operam com o mínimo necessário, sem sobrecarga documental.
- A granularidade por bounded context evita que a maturidade de um contexto imponha formalismo a outro.
- Preserva SBE como obrigatório em todos os níveis, garantindo verificabilidade independentemente do nível de aderência.
- A decisão de nível é do Architect, registrada formalmente nos princípios técnicos constitucionais — não é arbitrária nem implícita.

### Contras

- Introduz complexidade de governança: o Architect precisa avaliar e justificar o nível de aderência por bounded context, adicionando responsabilidade ao papel.
- A fronteira entre níveis pode ser subjetiva — quando um produto passa de "novo" para "em crescimento"? A decisão depende do julgamento do Architect.
- Pode haver pressão organizacional para escalar prematuramente o nível de aderência ("se o Completo é melhor, por que não usar desde o início?").
- A variação de nível por bounded context pode criar inconsistência perceptível dentro da mesma Product Canon.

### Justificativa

A adoção de IEEE 29148 sem aderência adaptativa criaria uma contradição com a filosofia do ZionKit: o modelo valoriza agilidade e inclusão, mas impor a taxonomia completa do IEEE 29148 a um produto em fase de prototipação seria burocracia incompatível com esses princípios. Os três níveis resolvem essa tensão ao alinhar o rigor documental à maturidade do produto. A decisão de registrar o nível nos princípios técnicos constitucionais garante rastreabilidade e evita que o nível seja decidido ad hoc a cada cerimônia.

### Impacto no Modelo

- **Technical Constitution Session (seção 2.2.2):** Ganha uma nova responsabilidade — o Architect define o nível de aderência IEEE 29148 como parte dos princípios técnicos constitucionais.
- **Guardrail de Padronização Canônica (Mudança 5):** O guardrail precisa respeitar o nível de aderência configurado, validando apenas os atributos correspondentes ao nível.
- **Product Canon (seção 2.1):** A camada de negócio pode conter artefatos com níveis diferentes de detalhamento por bounded context.
- **Cenários de aplicação (seção 6):** Greenfield opera naturalmente em nível Mínimo; brownfield pode operar em Moderado ou Completo.
- **Dependência direta:** Esta mudança é pré-requisito para que a Mudança 2 (IEEE 29148) e a Mudança 5 (Padronização Canônica) operem sem introduzir burocracia desproporcional.

### Riscos

- **Excesso de formalismo por IEEE 29148 (absorvido do risco 9.11):** A adoção integral de IEEE 29148 pode introduzir burocracia documental incompatível com a filosofia de agilidade do modelo, especialmente em contextos de prototipação rápida ou equipes enxutas. Pode haver pressão para escalar prematuramente o nível de aderência ("se o Completo é melhor, por que não usar desde o início?").
- A subjetividade na transição entre níveis pode gerar inconsistência entre equipes ou projetos diferentes que utilizam o ZionKit.
- Bounded contexts com níveis diferentes dentro da mesma Product Canon podem criar confusão sobre quais atributos são esperados em cada artefato.

### Mitigações de Riscos

- **Mitigação do risco de excesso de formalismo (absorvida do risco 9.11):** O ZionKit adota IEEE 29148 como guia de taxonomia e completude, não como template rígido; a aderência é adaptativa com três níveis (Mínimo, Moderado, Completo); o nível de rigor é decisão do Architect, não imposição do modelo; e o Architect deve justificar cada mudança de nível.
- O registro do nível nos princípios técnicos constitucionais cria um ponto de auditoria — qualquer mudança de nível é rastreável e justificada.
- A obrigatoriedade do SBE em todos os níveis garante um piso mínimo de verificabilidade, independentemente do nível de aderência escolhido.

---

## Mudança 4 — Formato canônico da Product Canon: de SBVR + SBE para IEEE 29148 + SBE

### Contexto Atual (v0.5)

Na versão 0.5, a camada de negócio da Product Canon (seção 2.1) armazena "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example)". A seção de Estrutura de Artefatos (seção 5) descreve "Regras de negócio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session" e "Requisitos com critérios de aceitação: especificados em SBE (Specification by Example) para verificabilidade". Os Canonical Change Plans tipados como `specification-plan` contêm notação SBVR visível. A Product Canon não define explicitamente os atributos estruturais que cada requisito deve conter.

### Proposta de Mudança (v0.6)

O formato canônico de armazenamento de requisitos na Product Canon muda para IEEE 29148 + SBE. A descrição da camada de negócio na seção 2.1 passa a conter: "Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE, validados internamente pela IA utilizando metodologias como SBVR." Na seção 5 (Estrutura de Artefatos), a descrição de regras de negócio é atualizada para refletir que são armazenadas no formato IEEE 29148 + SBE, sem notação SBVR visível. Cada requisito armazenado segue a estrutura IEEE 29148 (tipo, identificador, bounded context, prioridade, rastreabilidade, descrição em linguagem natural estruturada, verificabilidade) acompanhado de cenários SBE (Dado/Quando/Então). Notação SBVR não aparece nos artefatos armazenados. Os Canonical Change Plans (`specification-plan`, `expert-edit-plan`) contêm requisitos exclusivamente no formato IEEE 29148 + SBE. A justificativa é que o formato de armazenamento deve servir aos consumidores humanos dos artefatos (Domain Builders, Domain Experts, Architects) e não à infraestrutura de validação da IA.

### Prós

- O formato de armazenamento passa a servir aos consumidores reais dos artefatos — Domain Builders, Domain Experts e Architects — em vez de refletir a infraestrutura interna de validação.
- IEEE 29148 + SBE é compreensível por pessoas de negócio (linguagem natural estruturada com cenários concretos), sem exigir conhecimento de notação formal.
- Cada requisito ganha atributos estruturais explícitos (tipo, identificador, rastreabilidade, prioridade), habilitando governança e consulta da Product Canon.
- Alinhamento consistente entre formato de armazenamento e formato de saída das cerimônias elimina conversões intermediárias.

### Contras

- Requer migração de todos os artefatos existentes da Product Canon que estejam em formato SBVR + SBE para IEEE 29148 + SBE.
- A remoção da notação SBVR dos artefatos armazenados elimina um ponto de auditoria sobre a formalização semântica realizada.
- Equipes que já se adaptaram ao formato SBVR + SBE precisam se readaptar ao novo formato.

### Justificativa

Esta mudança é consequência direta das Mudanças 1 (internalização do SBVR) e 2 (adoção do IEEE 29148). Se o SBVR é interno e o IEEE 29148 é o padrão de estruturação, o formato de armazenamento na Product Canon deve refletir essa nova realidade. Manter SBVR nos artefatos armazenados enquanto o modelo o posiciona como interno seria uma inconsistência. A justificativa adicional é pragmática: o formato de armazenamento deve servir a quem consome os artefatos, e os consumidores são humanos que compreendem linguagem natural estruturada, não notação formal.

### Impacto no Modelo

- **Product Canon (seção 2.1):** Alteração direta na descrição da camada de negócio.
- **Estrutura de Artefatos (seção 5):** Atualização das descrições de regras de negócio e requisitos.
- **Canonical Change Plans:** Todos os tipos passam a conter exclusivamente IEEE 29148 + SBE.
- **Guardrail de Padronização Canônica (Mudança 5):** O guardrail valida conformidade com IEEE 29148 + SBE, não com SBVR.
- **Etapa 2 (seção 2.3):** Canonical Change Plans incrementais referenciam e produzem artefatos em IEEE 29148 + SBE.
- **Etapa 3 (seção 2.4):** Retroalimentação incorpora descobertas no novo formato.

### Riscos

- A migração de artefatos existentes pode introduzir distorções semânticas se a conversão de SBVR para IEEE 29148 + SBE não for fiel ao significado original.
- Perda de rastreabilidade entre a formalização SBVR interna e o artefato armazenado — se houver divergência, não há como auditar.

### Mitigações de Riscos

- A migração pode ser gradual, utilizando o mecanismo de Versionamento por Estrangulamento já existente no modelo.
- O ciclo iterativo de clarificação (nas cerimônias e na edição direta) garante que o Domain Builder ou Domain Expert valida a formalização antes do armazenamento.
- A prioridade de prototipação da Mudança 14 (Padronização Canônica) valida empiricamente a qualidade da formalização automática.

---

## Mudança 5 — Novo guardrail: Padronização Canônica (Canonical Formatting)

### Contexto Atual (v0.5)

Na versão 0.5, a seção 2.2.5 define dois guardrails: Clarificação de Conformidade (verifica se os termos utilizados são consistentes com o vocabulário formalizado na Product Canon) e Validação de Consistência (confronta alterações com o estado atual da Product Canon para identificar contradições). Adicionalmente, o Versionamento Gradual por Estrangulamento governa a integração de mudanças estruturais. Nenhum dos guardrails existentes trata do formato de escrita dos artefatos na Product Canon — não há mecanismo que garanta que os artefatos sigam um padrão uniforme de estrutura e formatação.

### Proposta de Mudança (v0.6)

Adiciona-se à seção 2.2.5 um novo guardrail denominado Padronização Canônica (Canonical Formatting). Sua responsabilidade é única: garantir que toda escrita na Product Canon esteja no formato oficial aderido pelo modelo ZionKit. O guardrail valida duas dimensões visíveis: IEEE 29148 (o requisito está estruturado com os atributos obrigatórios, classificado na taxonomia correta, e o documento cobre as categorias necessárias conforme o nível de aderência configurado) e SBE (cada requisito funcional possui cenários de aceitação concretos). O guardrail opera em dois modos: nas cerimônias de Canon Building, a padronização é parte integrante da mediação da IA (modo implícito); na edição direta pelo Domain Expert, o guardrail é explícito — o Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O guardrail de Padronização Canônica respeita o nível de aderência IEEE 29148 configurado pelo Architect: em nível Mínimo valida apenas tipo + descrição + SBE; em nível Moderado adiciona subtipo, rastreabilidade e dependências; em nível Completo valida conformidade integral. A justificativa é que com a introdução da edição direta pelo Domain Expert e a adoção de IEEE 29148, torna-se necessário um mecanismo dedicado a garantir que toda escrita na Product Canon mantenha consistência de formato, independentemente de quem origina a mudança e por qual caminho ela entra.

### Prós

- Garante uniformidade de formato na Product Canon independentemente da origem da mudança (cerimônia formal ou edição direta).
- O Domain Expert nunca precisa escrever em formato canônico — o guardrail abstrai essa complexidade.
- Respeita o nível de aderência configurado, evitando validação excessiva em contextos de baixa maturidade.
- Opera em dois modos (implícito nas cerimônias, explícito na edição direta), adaptando-se ao contexto sem duplicar lógica.

### Contras

- Adiciona um novo guardrail ao modelo, aumentando a complexidade do sistema de governança.
- Depende da capacidade da IA de reescrever corretamente edições em linguagem natural para IEEE 29148 + SBE — uma capacidade que precisa ser validada empiricamente.
- O modo implícito nas cerimônias pode ser difícil de distinguir da mediação normal da IA, criando ambiguidade sobre quando o guardrail está atuando.

### Justificativa

Na v0.5, todo artefato da Product Canon é produzido exclusivamente por cerimônias formais mediadas pela IA, o que implicitamente garante uniformidade de formato. A introdução da edição direta pelo Domain Expert (Mudança 7) cria um novo canal de entrada para a Product Canon que não passa por cerimônias formais. Sem um guardrail dedicado, edições diretas poderiam contaminar a Product Canon com artefatos em formato inconsistente. Adicionalmente, a troca de SBVR + SBE para IEEE 29148 + SBE como formato canônico (Mudança 4) exige um mecanismo que garanta conformidade com o novo padrão em todos os pontos de entrada.

### Impacto no Modelo

- **Guardrails (seção 2.2.5):** Adição de um terceiro guardrail formal, expandindo a seção.
- **Edição direta do Domain Expert (Mudança 7):** O guardrail é pré-requisito para que a edição direta funcione sem degradar a qualidade da Product Canon.
- **Fluxo de guardrails pré-Change Plan (Mudança 8):** A Padronização Canônica é parte do ciclo de validação antes da geração de Change Plans.
- **Technical Constitution Session (seção 2.2.2):** O nível de aderência definido pelo Architect parametriza o comportamento do guardrail.
- **Cerimônias de Canon Building:** O guardrail opera em modo implícito, integrado à mediação da IA.

### Riscos

- **Qualidade da formalização automática pela IA (absorvido parcialmente do risco 9.9):** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para IEEE 29148 + SBE. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert.
- O guardrail pode criar falsa sensação de segurança — conformidade de formato não implica conformidade semântica.
- Em nível Completo de aderência, o guardrail pode ser excessivamente restritivo, rejeitando edições válidas por motivos formais.

### Mitigações de Riscos

- **Mitigação do risco de qualidade de formalização (absorvida parcialmente do risco 9.9):** O Domain Expert revisa e aprova a formalização durante o ciclo iterativo; o ciclo iterativo permite correções antes da geração do Change Plan.
- O guardrail opera em conjunto com a Clarificação de Conformidade e a Validação de Consistência — a conformidade semântica é coberta por esses guardrails complementares.
- A parametrização por nível de aderência garante que o guardrail é proporcional ao contexto.
- A prioridade de prototipação da Mudança 14 valida empiricamente a taxa de aceitação na primeira tentativa de formalização.

---

## Mudança 6 — Expansão do papel do Domain Expert: aprovação com anotações e hotspots de domínio

### Contexto Atual (v0.5)

Na versão 0.5, o Domain Expert (seção 4) é definido como guardião semântico passivo: "Não participa diretamente das cerimônias nem escreve especificações. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution." Sua interação com a Product Canon é exclusivamente binária — aprova ou veta Canonical Change Plans — sem possibilidade de enriquecer o artefato durante a aprovação. Adicionalmente, não existe mecanismo para sinalizar áreas da Product Canon onde o conhecimento é frágil, incompleto ou frequentemente mal interpretado. A Product Canon trata todos os artefatos com o mesmo nível de confiança implícito — não há como registrar formalmente que determinado conceito, regra ou bounded context é particularmente sensível ou tem histórico de problemas.

### Proposta de Mudança (v0.6)

A aprovação do Domain Expert é redefinida como processo ativo, não binário, através de duas novas capacidades complementares:

**Anotações contextuais:** Durante a avaliação de qualquer Canonical Change Plan (nos gates das cerimônias da Etapa 1 ou na Etapa 2), o Domain Expert pode adicionar anotações contextuais ao artefato sob revisão — observações sobre nuances de domínio, ressalvas sobre interpretações, ou esclarecimentos que enriquecem o registro. As anotações ficam registradas como parte do histórico de aprovação e são insumos formais: a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Hotspots de domínio:** O Domain Expert ganha a capacidade de marcar áreas da Product Canon como hotspots — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. Hotspots são registrados como metadados no artefato afetado e possuem autor, data e descrição. Eles não impedem a aprovação — registram formalmente que existe incerteza reconhecida naquele ponto. A IA prioriza esses pontos na Clarificação de Conformidade: quando uma especificação futura tocar o trecho marcado como hotspot, a IA exibe proativamente a definição precisa e alerta sobre a incerteza registrada.

A justificativa conjunta é capturar conhecimento tácito no momento da validação — tanto insights pontuais (anotações) quanto fragilidades estruturais (hotspots) — em formatos que guiem priorização de cerimônias futuras e alertem autores de especificações sobre áreas sensíveis, sem forçar esses insights a fluir exclusivamente pelas cerimônias formais.

### Prós

- Transforma a aprovação de ato binário (aprova/veta) em processo de enriquecimento, capturando conhecimento tácito que se perderia no fluxo anterior.
- Anotações contextuais criam insumos formais para cerimônias futuras, reduzindo a dependência de memória individual.
- Hotspots de domínio introduzem o conceito de confiança variável na Product Canon — áreas frágeis são explicitamente sinalizadas.
- A IA utiliza hotspots proativamente na Clarificação de Conformidade, criando um mecanismo de alerta automático para áreas sensíveis.
- Nenhuma das duas capacidades impede ou retarda a aprovação — são adições, não obstáculos.

### Contras

- Aumenta a carga cognitiva do Domain Expert durante a aprovação, que agora inclui decisões sobre anotações e hotspots além da avaliação binária.
- Anotações podem acumular-se sem formalização, criando uma camada de conhecimento semi-estruturado que precisa ser gerida.
- Hotspots sem revisão periódica podem ficar obsoletos, sinalizando incerteza em pontos já resolvidos.
- A definição de "frágil" ou "frequentemente mal interpretado" é subjetiva e depende do julgamento individual do Domain Expert.

### Justificativa

Na v0.5, o Domain Expert detém autoridade sobre o significado dos conceitos do domínio, mas seu único canal de expressão é a aprovação binária de Change Plans. Isso cria uma perda estrutural de informação: o Domain Expert pode saber que um conceito é particularmente sutil, que uma regra tem exceções não documentadas, ou que determinado bounded context tem histórico de mal-entendidos — mas não tem como registrar esse conhecimento formalmente. Anotações e hotspots criam canais para esse conhecimento tácito sem exigir cerimônias formais.

### Impacto no Modelo

- **Papel do Domain Expert (seção 4):** Expansão da descrição e da tabela de atuação por etapa, adicionando capacidades ativas à atuação nos gates.
- **Guardrail de Clarificação de Conformidade (seção 2.2.5):** Passa a utilizar hotspots como insumo para priorização de alertas.
- **Product Canon (seção 2.1):** Artefatos ganham metadados de hotspot (autor, data, descrição) e histórico de anotações de aprovação.
- **Etapa 1 e Etapa 2:** Os gates de aprovação passam a suportar anotações contextuais.
- **Retroalimentação (Etapa 3):** Anotações não formalizadas são candidatos a incorporação na Product Canon nos próximos ciclos.

### Riscos

- O acúmulo de anotações não formalizadas pode criar uma "sombra" da Product Canon — conhecimento registrado mas não integrado ao corpo principal.
- Hotspots podem gerar excesso de alertas se muitas áreas forem marcadas, diluindo o valor do mecanismo.
- A IA pode não saber como ponderar hotspots em relação a outros sinais de validação, tratando-os com peso excessivo ou insuficiente.

### Mitigações de Riscos

- Anotações são explicitamente posicionadas como insumos para formalização futura — a IA as apresenta como candidatos em cerimônias subsequentes, criando pressão natural para resolução.
- Hotspots podem ter data de validade ou ser revisados periodicamente como parte do ciclo de Canon Building.
- A IA utiliza hotspots especificamente na Clarificação de Conformidade, com escopo delimitado — não os aplica indiscriminadamente em toda validação.

---

## Mudança 7 — Edição direta do Domain Expert na camada de negócio da Product Canon com salvaguardas contra uso indevido

### Contexto Atual (v0.5)

Na versão 0.5, o Domain Expert não tem acesso de edição à Product Canon. Sua interação é exclusivamente mediada pelos gates de aprovação — ele valida ou veta artefatos produzidos por outros (Domain Builder nas cerimônias, IA na mediação), mas não pode alterar diretamente nenhum artefato. Qualquer alteração na Product Canon requer uma cerimônia formal completa de Canon Building (Domain Discovery Session, Technical Constitution Session, ou Requirements Specification Session), com todo o fluxo de gates e aprovações. Não há necessidade de salvaguardas contra uso indevido, pois toda alteração passa obrigatoriamente pelas cerimônias formais.

### Proposta de Mudança (v0.6)

O Domain Expert ganha a capacidade de editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal. Este processo é tratado como canal de exceção, não de rotina, e não substitui o processo de elicitação clássico do modelo. A edição direta é um canal complementar de manutenção para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais.

As restrições e salvaguardas que preservam a primazia das cerimônias formais são: (a) escopo limitado à camada de negócio — artefatos de arquitetura permanecem exclusivos do Architect; (b) natureza restrita a refinamentos e correções de artefatos existentes — conceitos inteiramente novos requerem cerimônia completa; (c) o Domain Expert não escreve diretamente no formato canônico da Product Canon — ele propõe edições em linguagem natural ou formato livre, e a IA formaliza no formato oficial IEEE 29148 + SBE; (d) tipagem distinta do Change Plan (`expert-edit-plan`) permite auditoria e análise de frequência; (e) aprovação do Architect obrigatória e não delegável — diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente, introduzindo fricção deliberada; (f) guardrails antes do Change Plan, não depois — as divergências são resolvidas antes de o artefato ser empacotado para aprovação. Se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal detectável de que o processo formal está sendo contornado.

### Prós

- Captura conhecimento de domínio que emerge fora do ritmo das cerimônias — mudanças regulatórias, correções factuais, ajustes de definição — sem exigir o custo de uma cerimônia formal completa.
- Preserva a primazia das cerimônias formais através de salvaguardas estruturais (escopo restrito, aprovação obrigatória do Architect, tipagem distinta).
- O Domain Expert propõe em linguagem natural e a IA formaliza, mantendo o princípio de que o Domain Expert nunca escreve em formato canônico.
- A tipagem distinta (`expert-edit-plan`) permite monitoramento de frequência e detecção de uso indevido.
- A fricção deliberada (aprovação ativa do Architect) distingue o canal de exceção do canal principal.

### Contras

- Cria um canal alternativo de modificação da Product Canon, o que pode degradar a qualidade se utilizado excessivamente como atalho.
- Exige aprovação obrigatória do Architect para cada edição direta, potencialmente criando gargalo no Architect.
- A fronteira entre "refinamento de artefato existente" e "conceito inteiramente novo" pode ser ambígua na prática.
- Aumenta a complexidade do modelo ao introduzir um quarto caminho de alteração da Product Canon (três cerimônias + edição direta).

### Justificativa

Na v0.5, o princípio de "governança por cerimônia" (seção 8) estabelece que a Product Canon é modificada exclusivamente por cerimônias formais. Isso garante qualidade, mas cria uma rigidez que pode ser contraproducente quando o conhecimento de domínio evolui fora do ritmo das cerimônias — uma regulação muda, uma definição é descoberta como imprecisa, um termo do glossário precisa de ajuste factual. Sem canal de exceção, essas correções ficam pendentes até a próxima cerimônia ou, pior, são informalmente comunicadas mas não formalizadas. A edição direta resolve esse problema sem comprometer a governança, desde que as salvaguardas sejam efetivas.

### Impacto no Modelo

- **Papel do Domain Expert (seção 4):** Ganha capacidade de edição direta na camada de negócio, expandindo significativamente sua atuação.
- **Princípio de governança por cerimônia (seção 8):** Precisa ser qualificado — a Product Canon é modificada primariamente por cerimônias formais, com canal de exceção para refinamentos via edição direta.
- **Papel do Architect:** Ganha responsabilidade de aprovação obrigatória e não delegável para edições diretas.
- **Product Canon:** Precisa suportar tipagem de Change Plans como `expert-edit-plan`.
- **Dependência direta:** Requer a Mudança 8 (fluxo de guardrails), Mudança 9 (`expert-edit-plan`) e Mudança 5 (Padronização Canônica) para operar.

### Riscos

- **Edição direta como atalho para cerimônias (absorvido do risco 9.8):** A edição direta pelo Domain Expert pode ser usada, sob pressão, para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon.
- A dependência de aprovação do Architect pode criar gargalos em organizações com muitos Domain Experts e poucos Architects.
- Edições diretas frequentes podem fragmentar a narrativa da Product Canon, que nas cerimônias é construída de forma coesa.

### Mitigações de Riscos

- **Mitigação do risco de uso como atalho (absorvida do risco 9.8):** Escopo restrito a refinamentos de artefatos existentes (conceitos novos requerem cerimônia); aprovação sequencial obrigatória funciona como check de adequação do canal; a tipagem distinta (`expert-edit-plan`) permite monitoramento de frequência de uso; e o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.
- Em organizações com múltiplos bounded contexts, Architects podem ser designados por contexto, distribuindo a carga de aprovação.
- O Relatório de Conformidade (Mudança 8) explicita impactos em bounded contexts adjacentes, ajudando o Architect a avaliar se a edição deveria ter sido uma cerimônia formal.

---

## Mudança 8 — Fluxo de guardrails pré-Change Plan na edição direta do Domain Expert

### Contexto Atual (v0.5)

Na versão 0.5, não existe edição direta pelo Domain Expert, portanto não há fluxo de guardrails específico para esse cenário. Os guardrails existentes (Clarificação de Conformidade, Validação de Consistência) operam durante as cerimônias de Canon Building como parte da mediação da IA.

### Proposta de Mudança (v0.6)

Quando o Domain Expert propõe uma edição direta, um ciclo iterativo de guardrails opera antes da geração de qualquer Canonical Change Plan. O fluxo é: (1) o Domain Expert propõe alteração em linguagem natural; (2) a IA executa todos os mecanismos de validação (Clarificação de Conformidade, validação SBVR interna, Validação de Consistência e outros) e simultaneamente o Guardrail de Padronização Canônica — reescrevendo a edição no formato oficial IEEE 29148 + SBE; (3) a IA apresenta ao Domain Expert perguntas de clarificação em linguagem natural, a versão formalizada como proposta (não como alteração consumada), e um Relatório de Conformidade consolidando divergências, contradições e impactos; (4) o Domain Expert está no controle — pode aceitar a formalização, solicitar ajustes, responder perguntas de clarificação, ou reescrever a edição original e submeter novamente; (5) o ciclo se repete até que o Domain Expert aceite a versão formalizada e as divergências sejam resolvidas ou explicitamente justificadas. O Relatório de Conformidade pode assumir duas formas à escolha do Domain Expert: forma estática (documento estruturado) ou forma conversacional (sessão interativa onde a IA apresenta cada divergência individualmente). O princípio central é: a IA sinaliza e propõe a formalização, o Domain Expert decide — ele nunca escreve diretamente no formato canônico da Product Canon. A justificativa é preservar a autoria integral do Domain Expert sobre a intenção enquanto garante que o artefato resultante esteja no padrão oficial do modelo, com todas as validações semânticas e de consistência executadas antes de o artefato ser empacotado para aprovação.

### Prós

- Garante que todas as validações semânticas e de consistência são executadas antes da geração do Change Plan, não depois — prevenção sobre detecção.
- Preserva a autoria do Domain Expert sobre a intenção, enquanto a IA assume a responsabilidade pela formalização.
- O ciclo iterativo permite refinamento incremental, reduzindo o risco de formalização incorreta na primeira tentativa.
- O Relatório de Conformidade em duas formas (estática e conversacional) adapta-se a diferentes preferências de interação.
- Divergências intencionais podem ser explicitamente justificadas, evitando que o guardrail force conformidade cega.

### Contras

- O ciclo iterativo pode ser percebido como lento ou burocrático para edições simples (correção de um termo no glossário, por exemplo).
- A complexidade do fluxo (proposta → validação → clarificação → formalização → aceitação → repetição) pode ser intimidante para Domain Experts menos familiarizados com o processo.
- A existência de duas formas de Relatório de Conformidade (estática e conversacional) adiciona uma decisão ao fluxo.

### Justificativa

O fluxo de guardrails pré-Change Plan é a implementação operacional da salvaguarda (f) descrita na Mudança 7: "guardrails antes do Change Plan, não depois." Na v0.5, guardrails operam durante cerimônias formais onde a IA media o processo completo. Na edição direta, o Domain Expert origina a mudança sem mediação prévia da IA, o que exige que os guardrails sejam aplicados explicitamente antes de o artefato ser empacotado. Executar guardrails após o Change Plan seria inverter a lógica de prevenção do modelo — problemas seriam detectados na aprovação, quando corrigi-los é mais caro.

### Impacto no Modelo

- **Guardrails (seção 2.2.5):** Todos os guardrails existentes (Clarificação de Conformidade, Validação de Consistência) mais o novo (Padronização Canônica) são ativados no fluxo de edição direta.
- **Edição direta (Mudança 7):** O fluxo de guardrails é componente operacional essencial da edição direta.
- **`expert-edit-plan` (Mudança 9):** O Change Plan é gerado apenas após o ciclo de guardrails ser concluído, contendo o Relatório de Conformidade final.
- **Papel da IA (seção 4):** Ganha responsabilidade operacional de conduzir o ciclo iterativo de guardrails na edição direta.

### Riscos

- **Qualidade da formalização automática pela IA (absorvido parcialmente do risco 9.9):** Na edição direta, a IA reescreve edições em linguagem natural para IEEE 29148 + SBE. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Adicionalmente, na Requirements Specification Session, a tradução da validação SBVR interna em perguntas de clarificação depende da mesma capacidade.
- O ciclo iterativo pode entrar em loop se o Domain Expert e a IA não convergirem sobre a formalização.
- A forma conversacional do Relatório de Conformidade pode induzir o Domain Expert a aceitar divergências sem reflexão suficiente, por fadiga conversacional.

### Mitigações de Riscos

- **Mitigação do risco de qualidade de formalização (absorvida parcialmente do risco 9.9):** O Domain Expert revisa e aprova a formalização durante o ciclo iterativo; o Domain Expert aprova novamente o Change Plan consolidado (mitigando distorções introduzidas na consolidação); a aprovação sequencial garante que o Architect avalia apenas artefatos com semântica confirmada; e o ciclo iterativo permite correções antes da geração do Change Plan.
- O Domain Expert tem controle total sobre o ciclo — pode aceitar, rejeitar, ajustar ou recomeçar a qualquer momento.
- Divergências não resolvidas são explicitamente flagradas no Change Plan, visíveis para o Architect na aprovação.

---

## Mudança 9 — Novo tipo de Canonical Change Plan `expert-edit-plan` com aprovação sequencial obrigatória

### Contexto Atual (v0.5)

Na versão 0.5, existem três tipos de Canonical Change Plan, cada um associado a uma cerimônia: `discovery-plan` (produzido pela Domain Discovery Session), `constitution-plan` (produzido pela Technical Constitution Session), e `specification-plan` (produzido pela Requirements Specification Session). Não há tipo de Change Plan para alterações originadas fora das cerimônias formais. A mecânica de aprovação nos gates das cerimônias segue um padrão de aprovação primária pelo papel com expertise na cerimônia correspondente, e aprovação secundária assíncrona com janela de veto pelo outro papel humano (seção 2.2). Não existe fluxo de aprovação sequencial com ordem fixa.

### Proposta de Mudança (v0.6)

Adiciona-se um quarto tipo de Canonical Change Plan: `expert-edit-plan`, gerado exclusivamente pelo processo de edição direta do Domain Expert. Este tipo distingue formalmente edições diretas de artefatos produzidos por cerimônias, preservando rastreabilidade sobre a origem de cada mudança. O `expert-edit-plan` contém: a versão final formalizada em IEEE 29148 + SBE; o Relatório de Conformidade final; divergências intencionais flagradas (quando o Domain Expert conscientemente diverge de uma regra existente, as divergências constam como itens sinalizados); e impactos em bounded contexts adjacentes. A tipagem distinta permite auditoria e análise de frequência — se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal de que o processo de elicitação está sendo contornado.

O `expert-edit-plan` requer aprovação sequencial com ordem fixa: Domain Expert primeiro, Architect depois. O Domain Expert aprova a formalização IEEE 29148 + SBE contida no Change Plan. Embora o Domain Expert já tenha revisado a formalização no ciclo iterativo de guardrails, a aprovação no Change Plan tem propósito distinto: mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido. Somente após o Domain Expert aprovar, o Architect avalia o `expert-edit-plan` com foco exclusivo no impacto técnico: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais categorizados via IEEE 29148. A aprovação do Architect é obrigatória e não delegável — deliberadamente mais restritiva que os gates das cerimônias (onde o Architect é aprovador secundário). A justificativa da ordem é: fidelidade semântica é pré-requisito para avaliação técnica. Se o Architect aprovasse primeiro, ele avaliaria impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção; se o Domain Expert depois rejeitasse, o trabalho do Architect seria descartado.

### Prós

- Rastreabilidade formal sobre a origem de cada mudança na Product Canon — edições diretas são distinguíveis de artefatos produzidos por cerimônias.
- A auditoria de frequência permite detecção precoce de contorno do processo formal.
- A aprovação sequencial com ordem fixa garante que fidelidade semântica é validada antes do impacto técnico, eliminando retrabalho.
- O conteúdo do Change Plan (Relatório de Conformidade, divergências flagradas, impactos cross-context) fornece ao Architect todas as informações necessárias para avaliação técnica.
- A aprovação obrigatória e não delegável do Architect introduz fricção deliberada que distingue o canal de exceção do canal principal.

### Contras

- O Domain Expert aprova a formalização duas vezes — uma no ciclo iterativo e outra no Change Plan — o que pode ser percebido como redundância.
- A sequencialidade da aprovação (Domain Expert → Architect) adiciona latência ao processo, pois o Architect não pode avaliar em paralelo.
- Para edições triviais (correção de um termo no glossário), o processo completo de Change Plan + aprovação sequencial pode ser desproporcional.

### Justificativa

Na v0.5, cada tipo de Change Plan corresponde a uma cerimônia, e a mecânica de aprovação é uniforme (aprovação primária + secundária assíncrona). A edição direta não se encaixa nesse padrão porque não é uma cerimônia e requer salvaguardas adicionais. O `expert-edit-plan` é o mecanismo que materializa essas salvaguardas: tipagem distinta para auditoria, aprovação sequencial para garantir ordem correta de validação, e conteúdo enriquecido (Relatório de Conformidade, divergências flagradas) para subsidiar a aprovação do Architect. A ordem fixa (Domain Expert → Architect) é derivada da lógica do modelo: o Architect avalia impacto técnico, que só faz sentido sobre um artefato com semântica confirmada.

### Impacto no Modelo

- **Canonical Change Plans (seção 2.3.3 e seção 5):** Adição de um quarto tipo, expandindo a lista de tipos com envelope.
- **Papel do Domain Expert (seção 4):** O Domain Expert passa a ser aprovador primário sequencial de um tipo de Change Plan que ele próprio originou.
- **Papel do Architect (seção 4):** Aprovação obrigatória e não delegável para `expert-edit-plan`, mais restritiva que sua atuação nos gates de cerimônias.
- **Etapa 3 — Retroalimentação:** `expert-edit-plan` aprovados são integrados à Product Canon pelo mesmo mecanismo de Versionamento por Estrangulamento.
- **Dependência direta:** Requer a Mudança 7 (edição direta) e a Mudança 8 (fluxo de guardrails) para existir.

### Riscos

- **Fadiga de aprovação dupla do Domain Expert (absorvido do risco 9.10):** No fluxo de edição direta, o Domain Expert aprova a formalização duas vezes — uma no ciclo iterativo de guardrails e outra no Change Plan consolidado. Se as duas aprovações forem percebidas como idênticas, a segunda pode sofrer o efeito rubber stamp.
- O Architect pode se tornar gargalo se o volume de `expert-edit-plan` for alto, dado que a aprovação é obrigatória e não delegável.
- A sequencialidade da aprovação pode criar frustração quando o Domain Expert e o Architect estão disponíveis simultaneamente mas o processo impede paralelismo.

### Mitigações de Riscos

- **Mitigação do risco de fadiga de aprovação dupla (absorvida do risco 9.10):** A segunda aprovação opera sobre o artefato consolidado (não sobre cada edição individual), podendo revelar inconsistências não visíveis no refinamento incremental; tooling pode destacar diferenças entre o que foi aceito no ciclo iterativo e o que aparece no Change Plan final; em edições simples com Change Plan trivial, a segunda aprovação pode ser abreviada (confirmação rápida em vez de revisão completa).
- A designação de Architects por bounded context distribui a carga de aprovação em organizações maiores.
- A prioridade de prototipação da Mudança 15 avalia empiricamente se a segunda aprovação agrega valor ou é percebida como burocracia.

---

## Mudança 10 — Revisão do fluxo da Requirements Specification Session (seção 2.2.3)

### Contexto Atual (v0.5)

Na seção 2.2.3, a Requirements Specification Session é descrita como uma "cerimônia conversacional de formalização semântica de requisitos, utilizando SBVR para vocabulário e regras de negócio declarativas, e SBE para critérios de aceitação verificáveis." O fluxo é: o Domain Builder descreve requisitos em linguagem natural; a IA traduz para SBVR controlado e apresenta a formalização para validação do Domain Builder; o objetivo é produzir requisitos compreensíveis por pessoas de negócio e formalmente precisos para consumo por agentes de IA.

### Proposta de Mudança (v0.6)

O fluxo da Requirements Specification Session muda para operar em dois níveis. No nível de regras individuais: (1) o Domain Builder descreve o requisito em linguagem natural; (2) a IA ativa todos os mecanismos de validação simultaneamente (Clarificação de Conformidade + SBVR interno + Validação de Consistência + outros); (3) a IA consolida problemas detectados e apresenta perguntas de clarificação em linguagem natural; (4) o Domain Builder refina o requisito em ciclo iterativo; (5) a IA formaliza o requisito no formato canônico IEEE 29148 + SBE; (6) o Domain Builder valida o resultado. No nível de documento: a IA utiliza a taxonomia IEEE 29148 para verificar completude estrutural do conjunto de requisitos ao final da sessão, sinalizando categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design). A saída continua sendo um Canonical Change Plan tipado como `specification-plan`, mas agora contendo requisitos em IEEE 29148 + SBE sem notação SBVR.

### Prós

- O Domain Builder valida requisitos em linguagem natural estruturada (IEEE 29148 + SBE), não em notação formal — eliminando o risco de rubber stamp da v0.5.
- A verificação de completude no nível de documento (taxonomia IEEE 29148) captura lacunas que a análise requisito-a-requisito não detecta.
- O ciclo iterativo de clarificação permite refinamento antes da formalização, em vez de apresentar um fato consumado.
- A ativação simultânea de todos os mecanismos de validação é mais eficiente que a abordagem linear da v0.5.

### Contras

- O fluxo em dois níveis (regra individual + documento) adiciona complexidade à cerimônia.
- A verificação de completude no nível de documento pode sinalizar categorias que não são relevantes para o escopo atual, criando ruído.
- A ausência de notação SBVR visível reduz a transparência sobre o processo de formalização para observadores externos.

### Justificativa

Esta mudança é a materialização operacional das Mudanças 1 (SBVR interno) e 2 (IEEE 29148) na cerimônia central de formalização de requisitos. O fluxo da v0.5 é linear e centrado no SBVR como artefato de validação. O novo fluxo opera em dois níveis porque a adoção de IEEE 29148 habilita uma verificação de completude no nível do documento que o SBVR não oferece — a taxonomia IEEE 29148 permite que a IA sinalize categorias de requisitos não cobertas, algo que a análise SBVR requisito-a-requisito não faz.

### Impacto no Modelo

- **Requirements Specification Session (seção 2.2.3):** Reescrita completa do fluxo e da descrição da cerimônia.
- **Guardrails (seção 2.2.5):** Todos os guardrails (Clarificação de Conformidade, Validação de Consistência, Padronização Canônica) são ativados simultaneamente na cerimônia.
- **Canonical Change Plans:** `specification-plan` passa a conter IEEE 29148 + SBE sem SBVR.
- **Cenários de aplicação (seção 6):** O exemplo da Requirements Specification Session precisa ser atualizado (Mudança 12).
- **Dependência direta:** Consequência direta das Mudanças 1, 2 e 5.

### Riscos

- O Domain Builder pode ser sobrecarregado com perguntas de clarificação se a IA ativar todos os mecanismos de validação simultaneamente, gerando muitas observações de uma vez.
- A verificação de completude no nível de documento pode pressionar o Domain Builder a cobrir categorias que não são relevantes para o escopo, dilatando a cerimônia.

### Mitigações de Riscos

- A IA consolida e prioriza as observações antes de apresentá-las, em vez de despejar todos os problemas detectados simultaneamente.
- A verificação de completude opera como sinalização, não como bloqueio — categorias não cobertas são informadas, mas não impedem a geração do Change Plan.
- O nível de aderência IEEE 29148 (Mudança 3) limita quais categorias são consideradas obrigatórias em cada nível.

---

## Mudança 11 — Atualização da tabela de papéis (seção 4) para refletir as novas capacidades do Domain Expert

### Contexto Atual (v0.5)

Na seção 4, o Domain Expert é descrito como: "Detém autoridade sobre o significado dos conceitos do domínio. Não participa diretamente das cerimônias nem escreve especificações. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution. Funciona como guardião da integridade semântica da Product Canon." A tabela de atuação por etapa mostra o Domain Expert atuando apenas nas colunas de Etapa 1 (aprovação) e Etapa 2 (aprovação condicional), sem nenhuma atividade na Etapa 3 e sem canal de edição direta.

### Proposta de Mudança (v0.6)

A descrição do Domain Expert é expandida para incluir três novas capacidades: anotações em aprovações, hotspots de domínio e edição direta na camada de negócio. A tabela de atuação por etapa ganha uma nova coluna "Edição Direta" onde o Domain Expert edita artefatos da camada de negócio, resolve divergências guiado por relatório/conversa com a IA, e suas alterações passam por aprovação sequencial obrigatória (Domain Expert → Architect). Nas colunas existentes, a descrição é atualizada para incluir "(com anotações e hotspots)" na atuação de aprovação. Adicionalmente, o `expert-edit-plan` é adicionado à lista de tipos de Canonical Change Plan. A descrição dos atos da IA na seção 4 ganha um novo ato operacional: "usar metodologias de validação semântica (incluindo SBVR) internamente para validação."

### Prós

- Mantém a seção 4 como referência centralizada e atualizada de todos os papéis e suas capacidades.
- A nova coluna "Edição Direta" na tabela torna explícita a expansão de atuação do Domain Expert.
- A atualização dos atos da IA formaliza a mudança de "traduzir para SBVR" para "usar SBVR internamente".

### Contras

- A tabela de atuação por etapa se torna mais complexa com uma coluna adicional.
- A expansão do papel do Domain Expert pode diluir a clareza da separação de autoridades entre papéis.

### Justificativa

A seção 4 é a referência centralizada de papéis no modelo. As Mudanças 6 (anotações e hotspots), 7 (edição direta) e 1 (SBVR interno) alteram materialmente as capacidades e atos dos papéis. Sem atualização da seção 4, o documento do modelo conteria descrições de papéis inconsistentes com as capacidades reais.

### Impacto no Modelo

- **Seção 4 (Papéis no Modelo):** Alteração direta na descrição do Domain Expert, na tabela de atuação por etapa e na descrição dos atos da IA.
- **Canonical Change Plans (seção 5):** Adição de `expert-edit-plan` à lista de tipos.
- **Dependência direta:** Reflete as Mudanças 1, 6, 7 e 9; deve ser atualizada simultaneamente.

### Riscos

- Se a atualização não refletir fielmente todas as mudanças, a seção 4 se torna fonte de confusão em vez de referência.

### Mitigações de Riscos

- A atualização deve ser tratada como consolidação das Mudanças 1, 6, 7 e 9, com revisão cruzada para garantir consistência.

---

## Mudança 12 — Atualização dos cenários de aplicação (seção 6), diagrama do Ciclo Completo (seção 3) e tabela de dores endereçadas (seção 7) para refletir os novos padrões

### Contexto Atual (v0.5)

Na seção 6.1 (Produto Novo — Greenfield), o cenário descreve: "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA, os requisitos de cada contexto são formalizados e validados. O Domain Builder descreve os requisitos em linguagem natural, e a IA traduz para SBVR controlado, apresentando a formalização para validação." Na seção 7 (Dores Endereçadas), a tabela menciona: "Na Requirements Specification, a IA traduz para SBVR controlado." Na seção 3, o diagrama textual do ciclo completo contém a referência "Domain Builder + IA (SBVR + SBE)" na caixa da Requirements Specification Session, apresentando SBVR como artefato visível no processo.

### Proposta de Mudança (v0.6)

As três seções são atualizadas para refletir os novos padrões de forma consistente. Nos cenários de aplicação (seção 6): a IA utiliza metodologias de validação interna (incluindo SBVR) para guiar o processo de clarificação com o Domain Builder, e formaliza o resultado no formato canônico IEEE 29148 + SBE; referências a SBVR como formato visível ao usuário são removidas dos exemplos. Na tabela de dores endereçadas (seção 7): a descrição é atualizada para refletir que a mediação ocorre via processo de clarificação em linguagem natural com formalização IEEE 29148 + SBE. No diagrama do ciclo completo (seção 3): a referência na Requirements Specification Session muda de "SBVR + SBE" para "IEEE 29148 + SBE" como formato de saída, com SBVR operando como validação interna; a caixa de guardrails inclui o novo Guardrail de Padronização Canônica junto aos existentes.

### Prós

- Garante consistência entre as seções descritivas do modelo e as mudanças substanciais implementadas.
- Elimina referências a SBVR como formato visível em todas as seções do documento, evitando confusão.
- O diagrama do ciclo completo atualizado serve como visão consolidada de todo o modelo v0.6.

### Contras

- Atualização de múltiplas seções simultâneas aumenta o risco de inconsistência se alguma referência for esquecida.
- O diagrama textual pode se tornar mais complexo com a adição do Guardrail de Padronização Canônica.

### Justificativa

Seções 3, 6 e 7 são seções derivadas — refletem o modelo descrito nas seções 2 e 4. Quando o modelo muda, essas seções devem ser atualizadas para manter consistência documental. Deixá-las desatualizadas criaria contradição interna no documento.

### Impacto no Modelo

- **Seções 3, 6 e 7:** Alterações diretas para refletir IEEE 29148 + SBE como formato canônico, SBVR como interno, e Padronização Canônica como guardrail.
- **Dependência direta:** Reflete as Mudanças 1, 2, 4, 5 e 10; deve ser atualizada após essas mudanças serem finalizadas.

### Riscos

- Referências a SBVR como formato visível podem persistir em trechos não cobertos pela atualização, criando inconsistência.

### Mitigações de Riscos

- Busca textual completa por "SBVR" no documento para garantir que todas as referências visíveis sejam atualizadas ou contextualizadas como "interno".

---

## Mudança 13 — Revisão da prioridade de prototipação 6: de formalização SBVR + SBE para validação SBVR como motor interno de clarificação

### Contexto Atual (v0.5)

Na seção 10, a prioridade 6 é: "Formalização SBVR + SBE mediada pela IA. Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade; (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis. Risco a monitorar: efeito 'rubber stamp' na validação."

### Proposta de Mudança (v0.6)

A prioridade 6 é reformulada para: "Validação SBVR como motor interno de clarificação." O foco muda de testar se o Domain Builder compreende SBVR (irrelevante, pois ele não o verá) para testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradições em requisitos em linguagem natural; (b) a IA consegue traduzir os problemas detectados pela validação SBVR em perguntas de clarificação claras e acionáveis em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE mais completos e consistentes do que sem a validação SBVR. Métrica principal: taxa de problemas detectados pela validação SBVR que resultam em mudanças efetivas no requisito final.

### Prós

- Alinha a prioridade de prototipação ao novo papel do SBVR no modelo, eliminando testes irrelevantes (compreensão humana do SBVR).
- Introduz uma métrica concreta (taxa de problemas detectados que resultam em mudanças efetivas), permitindo avaliação objetiva do valor do SBVR como motor interno.
- Focaliza a validação empírica no ponto de maior risco: a qualidade da tradução de problemas formais para perguntas de clarificação em linguagem natural.

### Contras

- A métrica proposta (taxa de problemas → mudanças efetivas) pode ser difícil de medir sem tooling dedicado.
- Não testa a eficácia das "outras metodologias de validação" mencionadas na Mudança 1, focando exclusivamente no SBVR.

### Justificativa

A prioridade 6 da v0.5 testa a compreensão humana do SBVR, que se torna irrelevante com a internalização (Mudança 1). A reformulação focaliza a validação empírica no novo papel do SBVR — motor interno de detecção de problemas — e especificamente no ponto de maior risco identificado na Mudança 1: a qualidade da tradução para linguagem natural.

### Impacto no Modelo

- **Seção 10 (Direções para Prototipação):** Reescrita da prioridade 6.
- **Dependência direta:** Reflete a Mudança 1 (reposicionamento do SBVR).

### Riscos

- Se a prototipação focar exclusivamente no SBVR como motor interno, outras metodologias de validação mencionadas na Mudança 1 podem ficar sem validação empírica.

### Mitigações de Riscos

- A métrica de "mudanças efetivas" serve como baseline para comparar o valor agregado pelo SBVR versus outras metodologias de validação em prototipações futuras.

---

## Mudança 14 — Nova prioridade de prototipação 8: Guardrail de Padronização Canônica

### Contexto Atual (v0.5)

Na versão 0.5, a seção 10 contém 7 prioridades de prototipação. Não há prioridade relacionada a validação de formato de escrita, pois o guardrail de Padronização Canônica não existe.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 8: testar se a IA consegue formalizar corretamente edições em linguagem natural para o formato oficial IEEE 29148 + SBE (com classificação conforme nível de aderência), preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização versus necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

### Prós

- Valida empiricamente a capacidade da IA de formalizar corretamente, que é pré-requisito para as Mudanças 5 e 8.
- A métrica proposta (taxa de aceitação na primeira tentativa) é concreta e mensurável.
- Testa ambos os modos de operação do guardrail (implícito nas cerimônias, explícito na edição direta).

### Contras

- Uma prioridade de prototipação focada exclusivamente em formato pode parecer de baixa prioridade em comparação com prioridades de validação semântica.

### Justificativa

O Guardrail de Padronização Canônica é um componente novo no modelo que depende de uma capacidade da IA não testada — formalização de linguagem natural para IEEE 29148 + SBE. Sem validação empírica, o modelo assume uma capacidade que pode não existir na prática. A prioridade 8 testa especificamente essa capacidade.

### Impacto no Modelo

- **Seção 10 (Direções para Prototipação):** Adição da prioridade 8.
- **Dependência direta:** Valida as Mudanças 5 (Padronização Canônica) e 8 (fluxo de guardrails).

### Riscos

- Se a prototipação revelar que a IA não consegue formalizar com qualidade, as Mudanças 5 e 8 precisam ser revisadas.

### Mitigações de Riscos

- A prioridade 8 deve ser executada antes de testar o fluxo completo de edição direta (prioridade 9), para isolar o componente de formalização.

---

## Mudança 15 — Nova prioridade de prototipação 9: edição direta com aprovação sequencial

### Contexto Atual (v0.5)

Na versão 0.5, não há prioridade de prototipação relacionada a edição direta pelo Domain Expert, pois essa capacidade não existe no modelo.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 9: testar o fluxo completo de edição direta — Domain Expert edita em formato livre → guardrails validam e formalizam em IEEE 29148 + SBE → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar especificamente: (a) se a segunda aprovação do Domain Expert no Change Plan agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final; (d) se o processo é percebido como facilitador ou como burocracia pelo Domain Expert; (e) testar ambas as formas do relatório de conformidade (estática e conversacional).

### Prós

- Valida o fluxo completo de edição direta de ponta a ponta, incluindo todos os componentes envolvidos.
- Os itens de avaliação (a)-(e) abordam diretamente os riscos identificados nas Mudanças 7, 8 e 9 (uso como atalho, fadiga de aprovação dupla, percepção de burocracia).
- Testa ambas as formas do relatório de conformidade, permitindo decisão informada sobre qual priorizar.

### Contras

- A complexidade do fluxo completo pode dificultar o isolamento de variáveis — se o fluxo falhar, pode ser difícil identificar qual componente é responsável.

### Justificativa

A edição direta é a maior expansão funcional do modelo na v0.6, envolvendo três mudanças interdependentes (7, 8, 9) e três papéis (Domain Expert, IA, Architect). A validação empírica do fluxo completo é essencial para confirmar que as salvaguardas funcionam na prática e que o processo não é percebido como burocrático pelo Domain Expert.

### Impacto no Modelo

- **Seção 10 (Direções para Prototipação):** Adição da prioridade 9.
- **Dependência direta:** Valida as Mudanças 7 (edição direta), 8 (fluxo de guardrails), 9 (`expert-edit-plan`).

### Riscos

- Se a prototipação revelar que o fluxo é percebido como burocrático, as Mudanças 7, 8 e 9 podem precisar de simplificação.

### Mitigações de Riscos

- Executar a prioridade 8 (Padronização Canônica) antes da 9, para isolar o componente de formalização dos componentes de governança.
- Testar com cenários de diferentes complexidades (edição trivial, edição moderada, edição significativa) para identificar onde a burocracia é desproporcional.

---

## Mudança 16 — Nova prioridade de prototipação 10: taxonomia IEEE 29148 na Requirements Specification Session

### Contexto Atual (v0.5)

Na versão 0.5, não há prioridade de prototipação relacionada a IEEE 29148, pois o padrão não faz parte do modelo.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 10: testar se (a) a IA consegue guiar Domain Builder e Architect pelas categorias IEEE 29148 sem que o processo pareça burocrático; (b) a sinalização de categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) produz requisitos que teriam sido omitidos sem o guia; (c) a aderência adaptativa funciona na prática — projetos em fase inicial aceitam seções "pendente" sem pressão artificial de preenchimento; (d) os três níveis de aderência são percebidos como proporcionais e não arbitrários; (e) a progressão de nível Mínimo para Moderado acontece naturalmente conforme a Product Canon cresce.

### Prós

- Valida a adoção de IEEE 29148 com foco em percepção humana (burocracia percebida, proporcionalidade, pressão artificial), não apenas em capacidade técnica da IA.
- Os itens (c)-(e) testam especificamente a Mudança 3 (aderência adaptativa), que é a principal mitigação do risco de formalismo excessivo.
- O item (b) mede o valor concreto da taxonomia — requisitos que teriam sido omitidos sem o guia.

### Contras

- A avaliação de percepção ("parece burocrático", "proporcionais e não arbitrários") é subjetiva e difícil de medir objetivamente.

### Justificativa

IEEE 29148 é uma adição significativa ao modelo (Mudanças 2 e 3) com risco documentado de formalismo excessivo (absorvido na Mudança 3). A validação empírica deve focar na percepção humana — se Domain Builders e Architects perceberem o padrão como burocrático, a adoção fracassa independentemente da qualidade técnica dos requisitos produzidos.

### Impacto no Modelo

- **Seção 10 (Direções para Prototipação):** Adição da prioridade 10.
- **Dependência direta:** Valida as Mudanças 2 (IEEE 29148), 3 (aderência adaptativa) e 10 (revisão da Requirements Specification Session).

### Riscos

- Se a prototipação revelar que IEEE 29148 é percebido como burocrático mesmo no nível Mínimo, a adoção do padrão precisa ser reconsiderada.

### Mitigações de Riscos

- Testar com Domain Builders de perfis variados (técnicos e não-técnicos) para isolar se a percepção de burocracia é universal ou dependente do perfil.

---

## Mudança 17 — Tríade de padrões oficiais do ZionKit v0.6

### Contexto Atual (v0.5)

Na versão 0.5, o modelo utiliza dois padrões explícitos: SBVR (como formato de formalização visível para vocabulário e regras de negócio) e SBE (como formato de critérios de aceitação verificáveis). Não há formalização de uma tríade de padrões nem diferenciação entre padrões visíveis e internos.

### Proposta de Mudança (v0.6)

O ZionKit v0.6 estabelece uma tríade formal de padrões oficiais com papéis e visibilidades distintas: **SBVR** — motor interno de validação (invisível ao usuário), responsável por detectar ambiguidade, incompletude, contradição e redundância na expressão de requisitos; **IEEE 29148** — formato canônico de estrutura (visível), responsável por organizar requisitos com tipo, identificador, rastreabilidade e classificação, cobrindo categorias que SBVR não alcança (requisitos não-funcionais, interfaces, restrições de design); **SBE** — formato canônico de verificação (visível), responsável por transformar cada requisito em cenários concretos (Dado/Quando/Então) compreensíveis por pessoas de negócio e executáveis como testes. A formalização dessa tríade com papéis distintos é uma consolidação conceitual que não existia na v0.5.

### Prós

- Consolida a arquitetura de padrões do modelo em uma formulação clara, com papéis e visibilidades explicitamente diferenciados.
- Cada padrão tem responsabilidade única e delimitada: SBVR detecta, IEEE 29148 estrutura, SBE verifica.
- A diferenciação entre padrões visíveis (IEEE 29148, SBE) e interno (SBVR) resolve a ambiguidade da v0.5 onde SBVR era simultaneamente método interno e formato visível.
- Serve como referência conceitual para todas as outras mudanças que alteram o uso dos padrões.

### Contras

- A formalização da tríade é uma consolidação conceitual, não uma mudança operacional — seu valor depende de as mudanças substanciais (1-5, 10) serem implementadas.
- Pode criar a impressão de que os três padrões têm peso igual, quando na prática SBVR é opcional (a IA pode usar outras metodologias) e IEEE 29148 é adaptativo (três níveis).

### Justificativa

Na v0.5, os padrões utilizados pelo modelo são mencionados em diferentes seções sem uma formulação unificada. A tríade formaliza a arquitetura de padrões como conceito de primeira classe no modelo, servindo como referência centralizada para entender o papel de cada padrão. É particularmente importante para comunicar a distinção entre padrões visíveis e internos — uma distinção que não existia na v0.5 e que permeia todas as mudanças da v0.6.

### Impacto no Modelo

- **Conceitual:** Serve como consolidação de referência para as Mudanças 1, 2, 3, 4, 5 e 10.
- **Seção de padrões (nova ou incorporada):** Pode justificar uma nova subseção dedicada à tríade de padrões, ou ser incorporada na introdução do modelo.
- **Documentação externa:** Serve como resumo de alto nível das mudanças de padrões na v0.6 para comunicação com stakeholders.

### Riscos

- Se formulada como regra rígida, pode inibir a adoção de novas metodologias de validação interna além do SBVR, contradizendo o espírito aberto da Mudança 1.

### Mitigações de Riscos

- A formulação deve explicitar que SBVR é a metodologia principal de validação interna, mas não exclusiva — a tríade é extensível no vetor de validação interna.
- A Mudança 1 já estabelece que "a IA pode e deve utilizar outras metodologias de validação além de SBVR", o que deve ser referenciado na formulação da tríade.
