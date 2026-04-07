# Análise de Mudanças — ZionKit v0.5 → v0.6

**Data:** 2026-04-07
**Base:** zionkit-model.md (v0.5), plan-refin-change-zionkit.md, plan-refin-change-session-all-messages.md

---

## Mudança 1 — Reposicionamento do SBVR: de formato de escrita visível para ferramenta interna de validação da IA

### Contexto Atual (v0.5)

Na versão 0.5, SBVR (Semantics of Business Vocabulary and Business Rules) é utilizado como formato de escrita visível nos artefatos do modelo. Na Requirements Specification Session (seção 2.2.3), o fluxo descrito é: o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e a formalização SBVR é apresentada ao Domain Builder para validação. O SBVR aparece como artefato primário de validação — o Domain Builder lê e aprova a notação formalizada. Na Product Canon (seção 2.1), a camada de negócio contém "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example)". Nos Canonical Change Plans (seção 2.3.3), a notação SBVR está presente como parte dos artefatos de aprovação. A seção de riscos (9.6) reconhece o problema: o Domain Builder pode aprovar mecanicamente ("rubber stamp") uma formalização SBVR que ele não escreveu e que pode não compreender plenamente.

### Proposta de Mudança (v0.6)

SBVR deixa de ser formato de escrita visível e torna-se uma das ferramentas internas de validação semântica da IA. A notação SBVR não aparece em nenhum artefato visível ao usuário — nem na Product Canon, nem nos Canonical Change Plans, nem nas telas de aprovação. Quando o Domain Builder descreve um requisito em linguagem natural, a IA internamente traduz para SBVR controlado e utiliza essa representação formal para detectar ambiguidades estruturais, incompletude de predicados, falta de quantificadores, indefinição de participantes e condições. Os problemas detectados são traduzidos de volta para linguagem natural e apresentados ao usuário como perguntas de clarificação — o usuário nunca vê a notação formal. A justificativa é dupla: (a) eliminar o risco de rubber stamp (seção 9.6) ao remover a necessidade de o Domain Builder validar um formato que frequentemente não compreende; (b) permitir que o SBVR opere com maior rigor formal nos bastidores, livre da necessidade de ser legível para humanos.

---

## Mudança 2 — SBVR como uma entre várias metodologias de validação, não a única

### Contexto Atual (v0.5)

Na versão 0.5, a Requirements Specification Session (seção 2.2.3) descreve SBVR como o mecanismo de formalização e validação de requisitos. O fluxo é linear: linguagem natural → tradução SBVR → apresentação para validação. SBVR é tratado implicitamente como a metodologia central e exclusiva de formalização de requisitos no modelo. Os guardrails existentes na seção 2.2.5 — Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições) — operam como mecanismos complementares, mas separados do SBVR.

### Proposta de Mudança (v0.6)

SBVR é explicitamente posicionado como uma das metodologias de validação interna disponíveis para a IA, não a única. SBVR é agregado ao arsenal de validação existente, complementando os guardrails de Clarificação de Conformidade e Validação de Consistência sem substituí-los. Cada mecanismo cobre um vetor diferente de falha: a Clarificação de Conformidade verifica alinhamento terminológico com o glossário; a Validação de Consistência confronta novos requisitos com regras existentes; a validação SBVR analisa a expressão individual do requisito para detectar ambiguidade estrutural, incompletude de predicados e indefinição de participantes. A IA pode e deve utilizar outras metodologias de validação além de SBVR — análise de dependências entre bounded contexts, verificação de completude de fluxos, análise de cobertura de cenários de erro — desde que os resultados sejam apresentados ao usuário como perguntas de clarificação em linguagem natural, nunca como notação formal. A justificativa é que SBVR preenche uma lacuna específica que os guardrails existentes não cobrem (análise da expressão individual), mas não é suficiente para cobrir todos os vetores de falha em requisitos.

---

## Mudança 3 — Adoção do IEEE 29148 como padrão oficial de estruturação de requisitos

### Contexto Atual (v0.5)

Na versão 0.5, o modelo utiliza SBVR para formalizar vocabulário e regras de negócio, e SBE para critérios de aceitação verificáveis. Não há um padrão formal para a estrutura documental do conjunto de requisitos como um todo. Requisitos não-funcionais (performance, disponibilidade, segurança), especificações de interface, restrições de design e critérios de qualidade não possuem framework organizacional definido no modelo. A Product Canon (seção 2.1) menciona "Requisitos formalizados via SBVR + SBE" sem definir como esses requisitos são classificados, rastreados ou organizados em categorias.

### Proposta de Mudança (v0.6)

O ZionKit adota IEEE 29148 (ISO/IEC/IEEE 29148:2018) como padrão oficial para estruturação de documentos de requisitos, complementando SBVR (agora interno) e SBE na tríade de padrões do modelo. IEEE 29148 fornece: taxonomia para classificar requisitos (funcionais, não-funcionais, de interface, de design, restrições); atributos obrigatórios por requisito (identificador único, rastreabilidade, prioridade, verificabilidade); estrutura mínima do documento de requisitos; e critérios de qualidade (não-ambiguidade, completude, consistência, verificabilidade, rastreabilidade). A adoção é motivada por dois fatores: performance da IA — LLMs produzem requisitos significativamente melhores quando operam com a taxonomia IEEE 29148, amplamente representada no corpus de treinamento; e maturidade do padrão — décadas de refinamento na engenharia de requisitos. O formato canônico visível nos artefatos da Product Canon e nos Canonical Change Plans passa a ser IEEE 29148 + SBE. Requisitos não-funcionais, interfaces e restrições — que SBVR não cobre — são classificados e estruturados por IEEE 29148, conectando-se aos princípios técnicos constitucionais da Product Canon.

---

## Mudança 4 — Natureza adaptativa do IEEE 29148 com três níveis de aderência

### Contexto Atual (v0.5)

Na versão 0.5, não existe conceito de níveis de aderência a padrões de requisitos. Os artefatos de requisitos seguem o formato SBVR + SBE de forma uniforme, independentemente da maturidade do produto ou do bounded context.

### Proposta de Mudança (v0.6)

A aplicação do IEEE 29148 é proporcional à maturidade do produto e ao contexto do ciclo, através de três níveis de aderência: **Mínimo** (produto novo, prototipação, discovery inicial — inclui apenas tipo de requisito, descrição em linguagem natural estruturada e critérios SBE); **Moderado** (produto em crescimento, após 2-3 ciclos de Canon Building — adiciona subtipo, rastreabilidade para Change Plans, dependências entre requisitos); **Completo** (produto maduro, domínios regulados, integrações complexas — aplicação integral da taxonomia IEEE 29148 com rastreabilidade bidirecional, atributos de qualidade, seções de interface e restrição de design). O Architect define e ajusta o nível de aderência como parte da Technical Constitution Session, registrando-o nos princípios técnicos constitucionais da Product Canon. O nível pode variar por bounded context — um contexto maduro pode operar em nível Completo enquanto um contexto novo opera em nível Mínimo. O SBE (Dado/Quando/Então) é obrigatório em todos os níveis. A justificativa é evitar que a adoção do IEEE 29148 introduza burocracia excessiva em contextos de prototipação rápida ou equipes enxutas, sem comprometer a completude em domínios regulados.

---

## Mudança 5 — Formato canônico da Product Canon: de SBVR + SBE para IEEE 29148 + SBE

### Contexto Atual (v0.5)

Na versão 0.5, a camada de negócio da Product Canon (seção 2.1) armazena "Requisitos formalizados via SBVR + SBE". A seção de Estrutura de Artefatos (seção 5) descreve "Regras de negócio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session" e "Requisitos com critérios de aceitação: especificados em SBE (Specification by Example) para verificabilidade". Os Canonical Change Plans tipados como `specification-plan` contêm notação SBVR visível.

### Proposta de Mudança (v0.6)

O formato canônico de armazenamento de requisitos na Product Canon muda para IEEE 29148 + SBE. A camada de negócio passa a conter "Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE, validados internamente pela IA utilizando metodologias como SBVR". Cada requisito armazenado segue a estrutura IEEE 29148 (tipo, identificador, bounded context, prioridade, rastreabilidade, descrição em linguagem natural estruturada, verificabilidade) acompanhado de cenários SBE (Dado/Quando/Então). Notação SBVR não aparece nos artefatos armazenados. Os Canonical Change Plans (`specification-plan`, `expert-edit-plan`) contêm requisitos exclusivamente no formato IEEE 29148 + SBE. A justificativa é que o formato de armazenamento deve servir aos consumidores humanos dos artefatos (Domain Builders, Domain Experts, Architects) e não à infraestrutura de validação da IA.

---

## Mudança 6 — Novo guardrail: Padronização Canônica (Canonical Formatting)

### Contexto Atual (v0.5)

Na versão 0.5, a seção 2.2.5 define dois guardrails: Clarificação de Conformidade (verifica se os termos utilizados são consistentes com o vocabulário formalizado na Product Canon) e Validação de Consistência (confronta alterações com o estado atual da Product Canon para identificar contradições). Adicionalmente, o Versionamento Gradual por Estrangulamento governa a integração de mudanças estruturais. Nenhum dos guardrails existentes trata do formato de escrita dos artefatos na Product Canon — não há mecanismo que garanta que os artefatos sigam um padrão uniforme de estrutura e formatação.

### Proposta de Mudança (v0.6)

Adiciona-se à seção 2.2.5 um novo guardrail denominado Padronização Canônica (Canonical Formatting). Sua responsabilidade é única: garantir que toda escrita na Product Canon esteja no formato oficial aderido pelo modelo ZionKit. O guardrail valida duas dimensões visíveis: IEEE 29148 (o requisito está estruturado com os atributos obrigatórios, classificado na taxonomia correta, e o documento cobre as categorias necessárias conforme o nível de aderência configurado) e SBE (cada requisito funcional possui cenários de aceitação concretos). O guardrail opera em dois modos: nas cerimônias de Canon Building, a padronização é parte integrante da mediação da IA (modo implícito); na edição direta pelo Domain Expert, o guardrail é explícito — o Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O guardrail de Padronização Canônica respeita o nível de aderência IEEE 29148 configurado pelo Architect: em nível Mínimo valida apenas tipo + descrição + SBE; em nível Moderado adiciona subtipo, rastreabilidade e dependências; em nível Completo valida conformidade integral. A justificativa é que com a introdução da edição direta pelo Domain Expert e a adoção de IEEE 29148, torna-se necessário um mecanismo dedicado a garantir que toda escrita na Product Canon mantenha consistência de formato, independentemente de quem origina a mudança e por qual caminho ela entra.

---

## Mudança 7 — Expansão do papel do Domain Expert: aprovação com anotações

### Contexto Atual (v0.5)

Na versão 0.5, o Domain Expert (seção 4) é definido como guardião semântico passivo: "Não participa diretamente das cerimônias nem escreve especificações. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution." Sua interação com a Product Canon é exclusivamente binária — aprova ou veta Canonical Change Plans — sem possibilidade de enriquecer o artefato durante a aprovação.

### Proposta de Mudança (v0.6)

A aprovação do Domain Expert é redefinida como processo ativo, não binário. Durante a avaliação de qualquer Canonical Change Plan (nos gates das cerimônias da Etapa 1 ou na Etapa 2), o Domain Expert pode adicionar anotações contextuais ao artefato sob revisão — observações sobre nuances de domínio, ressalvas sobre interpretações, ou esclarecimentos que enriquecem o registro. As anotações ficam registradas como parte do histórico de aprovação e são insumos formais: a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização. A justificativa é que a validação semântica frequentemente produz insights que precisam ser capturados no momento — termos que precisam de nuance, regras que precisam de ressalva. Forçar esses insights a fluir exclusivamente pelas cerimônias formais cria atrito e risco de perda de conhecimento.

---

## Mudança 8 — Expansão do papel do Domain Expert: hotspots de domínio

### Contexto Atual (v0.5)

Na versão 0.5, não existe mecanismo para sinalizar áreas da Product Canon onde o conhecimento é frágil, incompleto ou frequentemente mal interpretado. A Product Canon trata todos os artefatos com o mesmo nível de confiança implícito — não há como registrar formalmente que determinado conceito, regra ou bounded context é particularmente sensível ou tem histórico de problemas.

### Proposta de Mudança (v0.6)

O Domain Expert ganha a capacidade de marcar áreas da Product Canon como hotspots — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. Hotspots são registrados como metadados no artefato afetado e possuem autor, data e descrição. Eles não impedem a aprovação — registram formalmente que existe incerteza reconhecida naquele ponto. A IA prioriza esses pontos na Clarificação de Conformidade: quando uma especificação futura tocar o trecho marcado como hotspot, a IA exibe proativamente a definição precisa e alerta sobre a incerteza registrada. A justificativa é capturar conhecimento tácito sobre fragilidades do domínio em um formato que guie priorização de cerimônias futuras e alerte autores de especificações sobre áreas sensíveis.

---

## Mudança 9 — Expansão do papel do Domain Expert: edição direta na camada de negócio da Product Canon

### Contexto Atual (v0.5)

Na versão 0.5, o Domain Expert não tem acesso de edição à Product Canon. Sua interação é exclusivamente mediada pelos gates de aprovação — ele valida ou veta artefatos produzidos por outros (Domain Builder nas cerimônias, IA na mediação), mas não pode alterar diretamente nenhum artefato. Qualquer alteração na Product Canon requer uma cerimônia formal completa de Canon Building (Domain Discovery Session, Technical Constitution Session, ou Requirements Specification Session), com todo o fluxo de gates e aprovações.

### Proposta de Mudança (v0.6)

O Domain Expert ganha a capacidade de editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal. Este processo é tratado como extremamente sensível e não substitui o processo de elicitação clássico do modelo. A edição direta é um canal complementar de manutenção para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais. As restrições são: escopo limitado à camada de negócio (artefatos de arquitetura permanecem exclusivos do Architect); natureza restrita a refinamentos e correções de artefatos existentes (conceitos novos requerem cerimônia completa); e o Domain Expert não escreve diretamente no formato canônico da Product Canon — ele propõe edições em linguagem natural ou formato livre, e a IA formaliza no formato oficial IEEE 29148 + SBE.

---

## Mudança 10 — Fluxo de guardrails pré-Change Plan na edição direta do Domain Expert

### Contexto Atual (v0.5)

Na versão 0.5, não existe edição direta pelo Domain Expert, portanto não há fluxo de guardrails específico para esse cenário. Os guardrails existentes (Clarificação de Conformidade, Validação de Consistência) operam durante as cerimônias de Canon Building como parte da mediação da IA.

### Proposta de Mudança (v0.6)

Quando o Domain Expert propõe uma edição direta, um ciclo iterativo de guardrails opera antes da geração de qualquer Canonical Change Plan. O fluxo é: (1) o Domain Expert propõe alteração em linguagem natural; (2) a IA executa todos os mecanismos de validação (Clarificação de Conformidade, validação SBVR interna, Validação de Consistência e outros) e simultaneamente o Guardrail de Padronização Canônica — reescrevendo a edição no formato oficial IEEE 29148 + SBE; (3) a IA apresenta ao Domain Expert perguntas de clarificação em linguagem natural, a versão formalizada como proposta (não como alteração consumada), e um Relatório de Conformidade consolidando divergências, contradições e impactos; (4) o Domain Expert está no controle — pode aceitar a formalização, solicitar ajustes, responder perguntas de clarificação, ou reescrever a edição original e submeter novamente; (5) o ciclo se repete até que o Domain Expert aceite a versão formalizada e as divergências sejam resolvidas ou explicitamente justificadas. O Relatório de Conformidade pode assumir duas formas à escolha do Domain Expert: forma estática (documento estruturado) ou forma conversacional (sessão interativa onde a IA apresenta cada divergência individualmente). O princípio central é: a IA sinaliza e propõe a formalização, o Domain Expert decide — ele nunca escreve diretamente no formato canônico da Product Canon. A justificativa é preservar a autoria integral do Domain Expert sobre a intenção enquanto garante que o artefato resultante esteja no padrão oficial do modelo, com todas as validações semânticas e de consistência executadas antes de o artefato ser empacotado para aprovação.

---

## Mudança 11 — Novo tipo de Canonical Change Plan: `expert-edit-plan`

### Contexto Atual (v0.5)

Na versão 0.5, existem três tipos de Canonical Change Plan, cada um associado a uma cerimônia: `discovery-plan` (produzido pela Domain Discovery Session), `constitution-plan` (produzido pela Technical Constitution Session), e `specification-plan` (produzido pela Requirements Specification Session). Não há tipo de Change Plan para alterações originadas fora das cerimônias formais.

### Proposta de Mudança (v0.6)

Adiciona-se um quarto tipo de Canonical Change Plan: `expert-edit-plan`, gerado exclusivamente pelo processo de edição direta do Domain Expert. Este tipo distingue formalmente edições diretas de artefatos produzidos por cerimônias, preservando rastreabilidade sobre a origem de cada mudança. O `expert-edit-plan` contém: a versão final formalizada em IEEE 29148 + SBE; o Relatório de Conformidade final; divergências intencionais flagradas (quando o Domain Expert conscientemente diverge de uma regra existente, as divergências constam como itens sinalizados); e impactos em bounded contexts adjacentes. A tipagem distinta permite auditoria e análise de frequência — se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal de que o processo de elicitação está sendo contornado.

---

## Mudança 12 — Aprovação sequencial obrigatória no fluxo de edição direta: Domain Expert primeiro, Architect depois

### Contexto Atual (v0.5)

Na versão 0.5, a mecânica de aprovação nos gates das cerimônias segue um padrão de aprovação primária pelo papel com expertise na cerimônia correspondente, e aprovação secundária assíncrona com janela de veto pelo outro papel humano (seção 2.2). Não existe fluxo de aprovação sequencial com ordem fixa.

### Proposta de Mudança (v0.6)

O `expert-edit-plan` requer aprovação sequencial com ordem fixa: Domain Expert primeiro, Architect depois. O Domain Expert aprova a formalização IEEE 29148 + SBE contida no Change Plan. Embora o Domain Expert já tenha revisado a formalização no ciclo iterativo de guardrails, a aprovação no Change Plan tem propósito distinto: mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido. Somente após o Domain Expert aprovar, o Architect avalia o `expert-edit-plan` com foco exclusivo no impacto técnico: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais categorizados via IEEE 29148. A aprovação do Architect é obrigatória e não delegável — deliberadamente mais restritiva que os gates das cerimônias (onde o Architect é aprovador secundário). A justificativa da ordem é: fidelidade semântica é pré-requisito para avaliação técnica. Se o Architect aprovasse primeiro, ele avaliaria impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção; se o Domain Expert depois rejeitasse, o trabalho do Architect seria descartado.

---

## Mudança 13 — Salvaguardas contra uso indevido da edição direta

### Contexto Atual (v0.5)

Na versão 0.5, não existe edição direta, portanto não há necessidade de salvaguardas contra uso indevido. Toda alteração na Product Canon passa obrigatoriamente pelas cerimônias formais do Canon Building.

### Proposta de Mudança (v0.6)

O modelo trata a edição direta como canal de exceção, não de rotina, através de mecanismos que preservam a primazia das cerimônias formais: (a) tipagem distinta do Change Plan (`expert-edit-plan`) permite auditoria e análise de frequência; (b) aprovação do Architect obrigatória e não delegável — diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente, introduzindo fricção deliberada; (c) ausência de mediação da IA na redação — o Domain Expert assume responsabilidade integral pelo conteúdo, sem "tradução assistida" como nas cerimônias; (d) guardrails antes do Change Plan, não depois — as divergências são resolvidas antes de o artefato ser empacotado para aprovação; (e) escopo restrito a refinamentos de artefatos existentes — conceitos inteiramente novos requerem cerimônia completa. A justificativa é que a edição direta não deve substituir o processo de elicitação clássico do modelo, e essas salvaguardas garantem que se a proporção de `expert-edit-plan` crescer excessivamente, é sinal detectável de que o processo formal está sendo contornado.

---

## Mudança 14 — Revisão do fluxo da Requirements Specification Session (seção 2.2.3)

### Contexto Atual (v0.5)

Na seção 2.2.3, a Requirements Specification Session é descrita como uma "cerimônia conversacional de formalização semântica de requisitos, utilizando SBVR para vocabulário e regras de negócio declarativas, e SBE para critérios de aceitação verificáveis." O fluxo é: o Domain Builder descreve requisitos em linguagem natural; a IA traduz para SBVR controlado e apresenta a formalização para validação do Domain Builder; o objetivo é produzir requisitos compreensíveis por pessoas de negócio e formalmente precisos para consumo por agentes de IA.

### Proposta de Mudança (v0.6)

O fluxo da Requirements Specification Session muda para operar em dois níveis. No nível de regras individuais: (1) o Domain Builder descreve o requisito em linguagem natural; (2) a IA ativa todos os mecanismos de validação simultaneamente (Clarificação de Conformidade + SBVR interno + Validação de Consistência + outros); (3) a IA consolida problemas detectados e apresenta perguntas de clarificação em linguagem natural; (4) o Domain Builder refina o requisito em ciclo iterativo; (5) a IA formaliza o requisito no formato canônico IEEE 29148 + SBE; (6) o Domain Builder valida o resultado. No nível de documento: a IA utiliza a taxonomia IEEE 29148 para verificar completude estrutural do conjunto de requisitos ao final da sessão, sinalizando categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design). A saída continua sendo um Canonical Change Plan tipado como `specification-plan`, mas agora contendo requisitos em IEEE 29148 + SBE sem notação SBVR.

---

## Mudança 15 — Atualização da descrição da Product Canon (seção 2.1) para refletir o novo formato de requisitos

### Contexto Atual (v0.5)

Na seção 2.1, a camada de negócio da Product Canon contém, entre outros artefatos: "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example): requisitos de software produzidos e mantidos através de processos assistidos de formalização semântica, com completude e consistência validadas." A seção 5 (Estrutura de Artefatos) descreve "Regras de negócio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session."

### Proposta de Mudança (v0.6)

A descrição da camada de negócio na seção 2.1 muda para: "Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE, validados internamente pela IA utilizando metodologias como SBVR." Na seção 5 (Estrutura de Artefatos), a descrição de regras de negócio é atualizada para refletir que são armazenadas no formato IEEE 29148 + SBE, sem notação SBVR visível. Os requisitos na Product Canon passam a conter explicitamente: tipo, identificador, bounded context, prioridade, rastreabilidade, descrição em linguagem natural estruturada, e cenários SBE de verificação.

---

## Mudança 16 — Atualização da tabela de papéis (seção 4) para refletir as novas capacidades do Domain Expert

### Contexto Atual (v0.5)

Na seção 4, o Domain Expert é descrito como: "Detém autoridade sobre o significado dos conceitos do domínio. Não participa diretamente das cerimônias nem escreve especificações. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution. Funciona como guardião da integridade semântica da Product Canon." A tabela de atuação por etapa mostra o Domain Expert atuando apenas nas colunas de Etapa 1 (aprovação) e Etapa 2 (aprovação condicional), sem nenhuma atividade na Etapa 3 e sem canal de edição direta.

### Proposta de Mudança (v0.6)

A descrição do Domain Expert é expandida para incluir três novas capacidades: anotações em aprovações, hotspots de domínio e edição direta na camada de negócio. A tabela de atuação por etapa ganha uma nova coluna "Edição Direta" onde o Domain Expert edita artefatos da camada de negócio, resolve divergências guiado por relatório/conversa com a IA, e suas alterações passam por aprovação sequencial obrigatória (Domain Expert → Architect). Nas colunas existentes, a descrição é atualizada para incluir "(com anotações e hotspots)" na atuação de aprovação. Adicionalmente, o `expert-edit-plan` é adicionado à lista de tipos de Canonical Change Plan. A descrição dos atos da IA na seção 4 ganha um novo ato operacional: "usar metodologias de validação semântica (incluindo SBVR) internamente para validação."

---

## Mudança 17 — Atualização dos cenários de aplicação (seção 6) para refletir o novo formato

### Contexto Atual (v0.5)

Na seção 6.1 (Produto Novo — Greenfield), o cenário descreve: "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA, os requisitos de cada contexto são formalizados e validados. O Domain Builder descreve os requisitos em linguagem natural, e a IA traduz para SBVR controlado, apresentando a formalização para validação." Na seção 7 (Dores Endereçadas), a tabela menciona: "Na Requirements Specification, a IA traduz para SBVR controlado."

### Proposta de Mudança (v0.6)

Os cenários de aplicação são atualizados para refletir o novo fluxo: a IA utiliza metodologias de validação interna (incluindo SBVR) para guiar o processo de clarificação com o Domain Builder, e formaliza o resultado no formato canônico IEEE 29148 + SBE. Referências a SBVR como formato visível ao usuário são removidas dos exemplos. A tabela de dores endereçadas é atualizada para refletir que a mediação ocorre via processo de clarificação em linguagem natural com formalização IEEE 29148 + SBE.

---

## Mudança 18 — Revisão do risco 9.6 (Curva de aprendizado SBVR)

### Contexto Atual (v0.5)

Na seção 9.6, o risco é descrito como: "Se a notação SBVR for percebida como técnica ou burocrática pelos Domain Builders, o modelo perde seu diferencial de inclusão. Mitigação: SBVR é mediado pela IA — o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado e apresenta a formalização para validação. Risco residual: o Domain Builder pode validar algo que não escreveu diretamente, criando um efeito 'rubber stamp' onde a aprovação é mecânica em vez de reflexiva."

### Proposta de Mudança (v0.6)

O risco 9.6 é reformulado. O risco original de rubber stamp na notação SBVR é eliminado pelo reposicionamento: o Domain Builder nunca vê notação SBVR — ele interage em linguagem natural e recebe resultados em IEEE 29148 + SBE. O risco residual migra para um novo vetor: a qualidade da tradução dos problemas detectados pelas metodologias de validação internas (incluindo SBVR) em perguntas de clarificação claras e acionáveis em linguagem natural. Se a IA não consegue traduzir adequadamente os problemas detectados, o benefício da validação se perde. Adicionalmente, o risco de opacidade do processo interno surge: o Domain Builder pode não perceber que a IA está validando profundamente nos bastidores, o que pode gerar tanto confiança excessiva quanto desconfiança sobre o volume de perguntas.

---

## Mudança 19 — Novo risco 9.8: edição direta como atalho para cerimônias

### Contexto Atual (v0.5)

Na versão 0.5, não existe edição direta, portanto este risco não está documentado. Toda alteração na Product Canon segue o fluxo de cerimônias formais.

### Proposta de Mudança (v0.6)

Adiciona-se o risco 9.8: a edição direta pelo Domain Expert pode ser usada, sob pressão, para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon. Mitigações: escopo restrito a refinamentos de artefatos existentes (conceitos novos requerem cerimônia); aprovação sequencial obrigatória funciona como check de adequação do canal; a tipagem distinta (`expert-edit-plan`) permite monitoramento de frequência de uso; e o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.

---

## Mudança 20 — Novo risco 9.9: qualidade da formalização automática pela IA

### Contexto Atual (v0.5)

Na versão 0.5, a IA traduz para SBVR e o resultado é apresentado ao humano como artefato primário de validação. Não há risco específico documentado sobre a qualidade da tradução para formato canônico, pois a validação humana do formato é parte explícita do fluxo.

### Proposta de Mudança (v0.6)

Adiciona-se o risco 9.9: o Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para IEEE 29148 + SBE (e, no caso da Requirements Specification Session, de traduzir corretamente a validação SBVR interna em perguntas de clarificação). Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Mitigações: o Domain Expert revisa e aprova a formalização durante o ciclo iterativo; o Domain Expert aprova novamente o Change Plan consolidado (mitigando distorções introduzidas na consolidação); a aprovação sequencial garante que o Architect avalia apenas artefatos com semântica confirmada; e o ciclo iterativo permite correções antes da geração do Change Plan.

---

## Mudança 21 — Novo risco 9.10: fadiga de aprovação dupla do Domain Expert

### Contexto Atual (v0.5)

Na versão 0.5, não existe aprovação dupla pelo mesmo papel. Cada gate possui um aprovador primário e um aprovador secundário, que são papéis diferentes.

### Proposta de Mudança (v0.6)

Adiciona-se o risco 9.10: no fluxo de edição direta, o Domain Expert aprova a formalização duas vezes — uma no ciclo iterativo de guardrails e outra no Change Plan consolidado. Se as duas aprovações forem percebidas como idênticas, a segunda pode sofrer o efeito rubber stamp. Mitigações: a segunda aprovação opera sobre o artefato consolidado (não sobre cada edição individual), podendo revelar inconsistências não visíveis no refinamento incremental; tooling pode destacar diferenças entre o que foi aceito no ciclo iterativo e o que aparece no Change Plan final; em edições simples com Change Plan trivial, a segunda aprovação pode ser abreviada (confirmação rápida em vez de revisão completa).

---

## Mudança 22 — Novo risco 9.11: excesso de formalismo por IEEE 29148

### Contexto Atual (v0.5)

Na versão 0.5, não há adoção de IEEE 29148, portanto este risco não existe. O formato de requisitos é SBVR + SBE sem framework organizacional formal.

### Proposta de Mudança (v0.6)

Adiciona-se o risco 9.11: a adoção integral de IEEE 29148 pode introduzir burocracia documental incompatível com a filosofia de agilidade do modelo, especialmente em contextos de prototipação rápida ou equipes enxutas. Pode haver pressão para escalar prematuramente o nível de aderência ("se o Completo é melhor, por que não usar desde o início?"). Mitigação: o ZionKit adota IEEE 29148 como guia de taxonomia e completude, não como template rígido; a aderência é adaptativa com três níveis (Mínimo, Moderado, Completo); o nível de rigor é decisão do Architect, não imposição do modelo; e o Architect deve justificar cada mudança de nível.

---

## Mudança 23 — Novo risco 9.12: opacidade da validação interna

### Contexto Atual (v0.5)

Na versão 0.5, o processo de validação SBVR é visível ao usuário — ele vê a notação formalizada e pode (em tese) validar se a tradução está correta. A transparência do processo de validação é uma propriedade do fluxo existente.

### Proposta de Mudança (v0.6)

Adiciona-se o risco 9.12: ao tornar as metodologias de validação (SBVR e outras) invisíveis ao usuário, perde-se transparência sobre o processo. O Domain Builder não sabe quais métodos a IA está usando — ele vê apenas as perguntas de clarificação. Isso pode gerar desconfiança ("por que a IA está fazendo tantas perguntas?") ou, inversamente, confiança excessiva ("a IA já validou, então deve estar correto"). Mitigação: a IA deve explicitar, quando relevante, a natureza da validação sem expor a metodologia — por exemplo, "Identifiquei que a regra menciona 'responsável' sem definir quem ocupa esse papel" é mais útil que silenciosamente adicionar uma definição. A transparência é sobre o resultado da validação, não sobre o método.

---

## Mudança 24 — Revisão da prioridade de prototipação 6 (formalização SBVR + SBE)

### Contexto Atual (v0.5)

Na seção 10, a prioridade 6 é: "Formalização SBVR + SBE mediada pela IA. Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade; (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis. Risco a monitorar: efeito 'rubber stamp' na validação."

### Proposta de Mudança (v0.6)

A prioridade 6 é reformulada para: "Validação SBVR como motor interno de clarificação." O foco muda de testar se o Domain Builder compreende SBVR (irrelevante, pois ele não o verá) para testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradições em requisitos em linguagem natural; (b) a IA consegue traduzir os problemas detectados pela validação SBVR em perguntas de clarificação claras e acionáveis em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE mais completos e consistentes do que sem a validação SBVR. Métrica principal: taxa de problemas detectados pela validação SBVR que resultam em mudanças efetivas no requisito final.

---

## Mudança 25 — Nova prioridade de prototipação 8: Guardrail de Padronização Canônica

### Contexto Atual (v0.5)

Na versão 0.5, a seção 10 contém 7 prioridades de prototipação. Não há prioridade relacionada a validação de formato de escrita, pois o guardrail de Padronização Canônica não existe.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 8: testar se a IA consegue formalizar corretamente edições em linguagem natural para o formato oficial IEEE 29148 + SBE (com classificação conforme nível de aderência), preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização versus necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

---

## Mudança 26 — Nova prioridade de prototipação 9: edição direta com aprovação sequencial

### Contexto Atual (v0.5)

Na versão 0.5, não há prioridade de prototipação relacionada a edição direta pelo Domain Expert, pois essa capacidade não existe no modelo.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 9: testar o fluxo completo de edição direta — Domain Expert edita em formato livre → guardrails validam e formalizam em IEEE 29148 + SBE → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar especificamente: (a) se a segunda aprovação do Domain Expert no Change Plan agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final; (d) se o processo é percebido como facilitador ou como burocracia pelo Domain Expert; (e) testar ambas as formas do relatório de conformidade (estática e conversacional).

---

## Mudança 27 — Nova prioridade de prototipação 10: taxonomia IEEE 29148 na Requirements Specification Session

### Contexto Atual (v0.5)

Na versão 0.5, não há prioridade de prototipação relacionada a IEEE 29148, pois o padrão não faz parte do modelo.

### Proposta de Mudança (v0.6)

Adiciona-se a prioridade 10: testar se (a) a IA consegue guiar Domain Builder e Architect pelas categorias IEEE 29148 sem que o processo pareça burocrático; (b) a sinalização de categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) produz requisitos que teriam sido omitidos sem o guia; (c) a aderência adaptativa funciona na prática — projetos em fase inicial aceitam seções "pendente" sem pressão artificial de preenchimento; (d) os três níveis de aderência são percebidos como proporcionais e não arbitrários; (e) a progressão de nível Mínimo para Moderado acontece naturalmente conforme a Product Canon cresce.

---

## Mudança 28 — Atualização do diagrama do Ciclo Completo (seção 3) para refletir os novos padrões

### Contexto Atual (v0.5)

Na seção 3, o diagrama textual do ciclo completo contém a referência "Domain Builder + IA (SBVR + SBE)" na caixa da Requirements Specification Session. O fluxo visual apresenta SBVR como artefato visível no processo.

### Proposta de Mudança (v0.6)

O diagrama é atualizado para refletir os novos padrões: a referência na Requirements Specification Session muda de "SBVR + SBE" para "IEEE 29148 + SBE" como formato de saída, com SBVR operando como validação interna. A caixa de guardrails inclui o novo Guardrail de Padronização Canônica junto aos existentes.

---

## Mudança 29 — Tríade de padrões oficiais do ZionKit v0.6

### Contexto Atual (v0.5)

Na versão 0.5, o modelo utiliza dois padrões explícitos: SBVR (como formato de formalização visível para vocabulário e regras de negócio) e SBE (como formato de critérios de aceitação verificáveis). Não há formalização de uma tríade de padrões nem diferenciação entre padrões visíveis e internos.

### Proposta de Mudança (v0.6)

O ZionKit v0.6 estabelece uma tríade formal de padrões oficiais com papéis e visibilidades distintas: **SBVR** — motor interno de validação (invisível ao usuário), responsável por detectar ambiguidade, incompletude, contradição e redundância na expressão de requisitos; **IEEE 29148** — formato canônico de estrutura (visível), responsável por organizar requisitos com tipo, identificador, rastreabilidade e classificação, cobrindo categorias que SBVR não alcança (requisitos não-funcionais, interfaces, restrições de design); **SBE** — formato canônico de verificação (visível), responsável por transformar cada requisito em cenários concretos (Dado/Quando/Então) compreensíveis por pessoas de negócio e executáveis como testes. A formalização dessa tríade com papéis distintos é uma consolidação conceitual que não existia na v0.5.
