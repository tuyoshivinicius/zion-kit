# Proposta de Evolução do Modelo ZionKit — v0.6

**Status**: Rascunho em refinamento
**Base**: ZionKit v0.5 — Abril 2026
**Origem**: Conversa iterativa de construção da proposta

---

> **Nota**: Este documento consolida todo o conteúdo bruto das iterações de conversa que construíram a proposta de evolução v0.6. Cada seção representa uma rodada de refinamento, preservando o conteúdo integral das discussões e decisões tomadas.

---

## Rodada 1 — Aprovação Sequencial para Edição Direta do Domain Expert

### Solicitação

Adicionar como escopo da proposta de mudança no modelo: no fluxo de edição direta do Domain Expert, após a IA reescrever os requisitos utilizando o guardrail de formatação, o processo deve gerar um Canonical Change Plan que requer aprovação do Domain Expert primeiro (para mitigar o risco de a IA alterar o significado durante a formalização), e depois aprovação do Architect para impacto técnico. Ordem sequencial de aprovação: Domain Expert → Architect.

### Conteúdo Produzido

#### Escopo: Expansão do Papel do Domain Expert

O Domain Expert na v0.5 atua exclusivamente como aprovador nos gates de cerimônia. A v0.6 expande sua atuação com três novas capacidades:

##### 3.1 Anotações em Aprovações

O Domain Expert pode adicionar anotações contextuais ao aprovar ou vetar um Canonical Change Plan — observações sobre nuances de domínio, ressalvas sobre interpretações, ou esclarecimentos que enriquecem o registro.

##### 3.2 Hotspots de Domínio

O Domain Expert pode sinalizar áreas da Product Canon onde o conhecimento é frágil, incompleto ou em disputa — sem precisar formular requisitos completos. Hotspots são registrados como metadados no artefato afetado e guiam priorização de cerimônias futuras.

##### 3.3 Edição Direta na Camada de Negócio

O Domain Expert pode propor edições diretas em artefatos da camada de negócio da Product Canon — glossário, regras de negócio, requisitos — sem necessidade de iniciar uma cerimônia formal completa de Canon Building.

**Fluxo de edição direta (6 passos):**

1. O Domain Expert seleciona o artefato e descreve a alteração desejada em linguagem natural.
2. A IA valida a alteração contra a Product Canon existente (guardrails de Conformidade e Consistência).
3. A IA aplica o guardrail de Padronização Canônica: reescreve a alteração no formato canônico (IEEE 29148 + SBE).
4. A IA gera um Canonical Change Plan tipado como `expert-edit-plan`.
5. **Aprovação sequencial obrigatória:**
   - **Primeiro: Domain Expert** — valida que a formalização da IA preservou fielmente o significado da alteração original. Este gate existe especificamente para mitigar o risco de a IA alterar o significado durante a formalização.
   - **Segundo: Architect** — avalia o impacto técnico da alteração nos artefatos de arquitetura, bounded contexts afetados, eventos de domínio impactados e princípios constitucionais.
6. Após ambas as aprovações, a alteração é integrada à Product Canon via Versionamento por Estrangulamento.

**Justificativa da ordem sequencial (Domain Expert → Architect):**

- **Por que o Domain Expert aprova primeiro:** A fidelidade semântica é pré-requisito para avaliação técnica. Se a IA alterou o significado durante a formalização, o Architect avaliaria impacto técnico de algo que não corresponde à intenção original. A aprovação do Domain Expert garante que o artefato que o Architect receberá reflete a intenção real.
- **Por que o Architect não pode aprovar primeiro:** O Architect avaliaria impacto técnico de um artefato potencialmente incorreto do ponto de vista semântico. Se o Domain Expert depois rejeitasse a formalização, a análise técnica seria descartada — trabalho desperdiçado.
- **Analogia:** É como revisar a tradução de um documento antes de analisar suas implicações legais. Não faz sentido analisar as implicações legais de uma tradução que pode estar incorreta.

**Exemplo de fluxo:**

O Domain Expert quer adicionar uma regra: "Pacientes menores de 18 anos só podem agendar consulta com autorização do responsável legal."

1. Domain Expert escreve a regra em linguagem natural.
2. IA verifica: o termo "responsável legal" não está no glossário. Propõe adição ao glossário com definição.
3. IA formaliza no formato canônico (IEEE 29148 + SBE):
   - Requisito: "O sistema deve exigir autorização de Responsável Legal para agendamento de consulta quando o Paciente possui idade inferior a 18 anos."
   - SBE: Dado que um Paciente tem 16 anos / Quando o Paciente tenta agendar uma consulta / Então o sistema deve solicitar autorização do Responsável Legal antes de confirmar o agendamento.
4. IA gera `expert-edit-plan` com os impactos.
5. **Domain Expert aprova primeiro**: confirma que "autorização do responsável legal" reflete exatamente sua intenção (e não, por exemplo, "consentimento parental", que teria escopo diferente).
6. **Architect aprova segundo**: identifica que o bounded context de Agendamento precisa se comunicar com um novo serviço de Autorização, valida o impacto técnico.

#### Novo Risco 9.10 — Fadiga de Aprovação Dupla

A aprovação sequencial (Domain Expert → Architect) no fluxo de edição direta adiciona um passo extra ao processo. Em edições frequentes, o volume de aprovações pode gerar fadiga nos aprovadores, levando a aprovações mecânicas ("rubber stamp"). Mitigação: monitorar taxas de rejeição — se caírem consistentemente abaixo de um limiar, investigar se os aprovadores estão efetivamente revisando. Considerar agrupamento de edições menores em lotes de aprovação periódicos.

---

## Rodada 2 — IEEE 29148 como Padrão Oficial

### Solicitação

Adicionar IEEE 29148 como padrão oficial. SBVR para formalizar vocabulário/regras de negócio (eliminar ambiguidade). IEEE 29148 para estruturar o documento geral de requisitos (requisitos não-funcionais, interfaces, restrições de design, critérios de qualidade).

### Conteúdo Produzido

#### Escopo: Tríade de Padrões (SBVR + IEEE 29148 + SBE)

O modelo v0.5 utiliza SBVR + SBE. A v0.6 adiciona IEEE 29148 (ISO/IEC/IEEE 29148:2018) como terceiro pilar, criando uma tríade complementar:

| Padrão | Função no ZionKit | O que governa |
|--------|-------------------|---------------|
| **SBVR** | Formalização de vocabulário e regras | Termos, definições, regras declarativas — eliminação de ambiguidade semântica |
| **IEEE 29148** | Estruturação do documento de requisitos | Organização, classificação e completude — requisitos não-funcionais, interfaces, restrições de design, critérios de qualidade |
| **SBE** | Verificação por exemplos concretos | Critérios de aceitação executáveis — Dado/Quando/Então |

**IEEE 29148 — O que traz:**

- Taxonomia para classificar requisitos: funcionais, de desempenho, de interface, de design, de qualidade
- Estrutura para garantir completude: cada requisito tem escopo, referências, dependências
- Atributos de qualidade para cada requisito: rastreabilidade, verificabilidade, necessidade, prioridade
- Framework para requisitos não-funcionais que SBVR não cobre diretamente

**Impacto na Product Canon:**

A seção "Requisitos formalizados" da camada de negócio passa a seguir a taxonomia IEEE 29148 para organização, SBVR para formalização semântica, e SBE para critérios verificáveis. A estrutura:

```
REQUISITO REQ-AGD-001
  Tipo: Funcional
  Contexto: Agendamento
  Descrição (SBVR): "É obrigatório que cada Consulta de Paciente 
    menor de 18 anos possua Autorização de Responsável Legal 
    aprovada."
  Critério de Aceitação (SBE):
    Dado que um Paciente tem 16 anos
    Quando o Paciente tenta agendar uma consulta
    Então o sistema deve solicitar autorização do Responsável Legal
  Prioridade: Alta
  Rastreabilidade: discovery-plan-003, constitution-plan-001
  Dependências: REQ-AUT-002 (serviço de Autorização)
```

**Impacto na Requirements Specification Session:**

A cerimônia passa a produzir requisitos organizados pela taxonomia IEEE 29148. A IA utiliza a estrutura IEEE como template, preenchendo cada seção com conteúdo formalizado via SBVR e verificado via SBE.

#### Novo Risco 9.11 — Excesso de Formalismo IEEE

O IEEE 29148 é um padrão maduro e abrangente, mas seu uso completo pode ser excessivo para contextos de prototipação rápida ou equipes enxutas. Mitigação: a aplicação do IEEE 29148 deve ser proporcional à maturidade do produto e da equipe. Em fases iniciais, utilizar apenas as categorias essenciais (funcional, não-funcional, interface). A completude total do padrão é uma meta gradual, não um requisito de entrada.

#### Nova Prioridade de Prototipação 10

**Taxonomia IEEE 29148 na Requirements Specification Session.** Validar se a IA consegue organizar requisitos seguindo a taxonomia IEEE 29148 sem impor burocracia excessiva ao Domain Builder. Testar se a classificação por tipo (funcional, desempenho, interface, design, qualidade) e os atributos (rastreabilidade, verificabilidade, prioridade) agregam valor sem criar overhead desproporcional.

---

## Rodada 3 — SBVR como Ferramenta Interna Invisível

### Solicitação

Esclarecer que SBVR deve ser usado APENAS como ferramenta interna de validação — a IA usa a metodologia SBVR para ajudar os usuários a esclarecer requisitos, mas a notação SBVR NÃO deve aparecer nos Canonical Change Plans. Os usuários escrevem requisitos, a IA usa SBVR internamente para validação/esclarecimento, e o formato de saída é IEEE 29148 + SBE apenas.

### Conteúdo Produzido

#### Escopo: Reposicionamento do SBVR — De Formato Visível para Motor Interno de Validação

**Mudança fundamental:** SBVR deixa de ser um formato de saída visível nos artefatos e torna-se uma ferramenta interna que a IA utiliza para validar e refinar requisitos. O usuário nunca vê notação SBVR — ele vê apenas o resultado: requisitos claros, precisos e completos formatados em IEEE 29148 + SBE.

**O que muda:**

| Aspecto | v0.5 (antes) | v0.6 (depois) |
|---------|-------------|---------------|
| Formato visível nos artefatos | SBVR + SBE | IEEE 29148 + SBE |
| SBVR na Requirements Specification | IA traduz para SBVR controlado e apresenta ao Domain Builder | IA usa SBVR internamente; apresenta resultado em linguagem natural estruturada |
| Notação SBVR em Canonical Change Plans | Presente | Ausente |
| Papel do SBVR | Formato de formalização visível | Motor interno de validação semântica |

**Como funciona na prática:**

1. **O que o usuário vê:** O Domain Builder descreve um requisito em linguagem natural. A IA faz perguntas de esclarecimento em linguagem natural. O resultado final é um requisito formatado em IEEE 29148 com critérios SBE.

2. **O que acontece por baixo (invisível ao usuário):** A IA aplica internamente a metodologia SBVR para:
   - Verificar se todos os termos utilizados estão definidos no glossário (validação de vocabulário)
   - Identificar ambiguidades estruturais ("o cliente pode cancelar" — qual cliente? cancelar o quê? em que condições?)
   - Verificar completude de predicados (cada regra tem sujeito, verbo, objeto e condições explícitas?)
   - Detectar atores ou condições não definidos
   - Cruzar com regras existentes na Product Canon para identificar contradições

3. **O que o usuário recebe como saída:** Perguntas de esclarecimento em linguagem natural (quando há ambiguidade) e o requisito final formatado em IEEE 29148 + SBE.

**Exemplo — O que o usuário vê vs. o que acontece internamente:**

O Domain Builder diz: "O cliente deve poder cancelar um pedido antes do faturamento."

**O que acontece internamente (invisível):**
- IA aplica SBVR: "cada Pedido cujo Status é 'Pendente' ou 'Confirmado' possa ser cancelado pelo Cliente titular"
- Detecção: "Cliente" não é o mesmo que "Cliente titular" — há ambiguidade sobre quem pode cancelar
- Detecção: "antes do faturamento" implica status, mas a regra existente na Canon diz "Pedidos faturados não podem ser cancelados, apenas devolvidos" — há um caminho alternativo não mencionado

**O que o usuário vê:**
- IA pergunta: "Quando você diz 'o cliente', você se refere ao titular da conta que fez o pedido, ou qualquer usuário autorizado?"
- IA pergunta: "Na Product Canon existe uma regra sobre devolução para pedidos já faturados. Você quer que o requisito inclua esse caminho alternativo?"
- Após esclarecimento, o resultado é formatado como:

```
REQUISITO REQ-PED-015
  Tipo: Funcional
  Contexto: Pedidos
  Descrição: O sistema deve permitir que o Cliente Titular cancele 
    um Pedido cujo status seja "Pendente" ou "Confirmado". Pedidos 
    com status "Faturado" não são canceláveis — o fluxo alternativo 
    é Devolução (ver REQ-PED-008).
  Critério de Aceitação (SBE):
    Dado que um Pedido tem status "Confirmado"
    E o Cliente autenticado é o Titular do Pedido
    Quando o Cliente solicita cancelamento do Pedido
    Então o status do Pedido deve mudar para "Cancelado"
    E o Cliente deve receber notificação de cancelamento

    Dado que um Pedido tem status "Faturado"
    Quando o Cliente solicita cancelamento do Pedido
    Então o sistema deve informar que cancelamento não é possível
    E o sistema deve oferecer a opção de Devolução
```

**Nenhuma notação SBVR aparece no artefato final.**

**Impacto na seção 2.1 (Product Canon):**

A camada de negócio da Product Canon muda:
- **Antes (v0.5):** "Requisitos formalizados via SBVR + SBE"
- **Depois (v0.6):** "Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE, validados internamente pela IA utilizando metodologias como SBVR"

**Impacto na seção 2.2.3 (Requirements Specification Session):**

- **Antes (v0.5):** "A IA traduz para SBVR controlado e apresenta a formalização para validação do Domain Builder"
- **Depois (v0.6):** "A IA utiliza internamente metodologias de validação semântica (incluindo SBVR) para identificar ambiguidades, incompletudes e inconsistências. O resultado é apresentado ao Domain Builder em linguagem natural estruturada, formatado conforme IEEE 29148 com critérios SBE."

**Impacto no Risco 9.6 (Curva de aprendizado SBVR):**

- **Antes (v0.5):** Risco de o SBVR ser percebido como técnico/burocrático. Mitigação via mediação da IA.
- **Depois (v0.6):** **Risco eliminado.** O Domain Builder nunca vê notação SBVR. Ele interage em linguagem natural e recebe resultados em linguagem natural estruturada. O SBVR opera como um motor interno — se funciona bem, o usuário percebe apenas que as perguntas da IA são precisas e que os requisitos produzidos são claros. O risco "rubber stamp" da v0.5 (validar algo que não escreveu diretamente) é substituído por um risco menor: o Domain Builder pode não perceber que a IA está validando profundamente por baixo (opacidade do processo interno).

---

## Rodada 4 — SBVR como Uma Entre Várias Metodologias

### Solicitação

Esclarecer que SBVR é UMA DAS metodologias de validação, não a única. SBVR deve ser agregado ao modo de validação existente, não substituí-lo.

### Conteúdo Produzido

#### Escopo: SBVR como Metodologia Complementar (Não Exclusiva)

**Princípio estabelecido:** A IA pode utilizar qualquer metodologia de validação que considere adequada ao contexto. SBVR é uma entre várias — é agregada ao arsenal de validação, não substitui as validações existentes.

**Como SBVR se integra aos guardrails existentes:**

| Guardrail Existente | O que valida | Metodologia | SBVR agrega? |
|---------------------|-------------|-------------|--------------|
| **Clarificação de Conformidade** | Terminologia — termos usados vs. glossário da Product Canon | Comparação lexical e semântica | Sim — SBVR reforça a validação de vocabulário: verifica não só se o termo existe, mas se está sendo usado com a semântica correta no contexto |
| **Validação de Consistência** | Contradições — novas regras vs. regras existentes na Product Canon | Análise lógica de conflitos | Sim — SBVR complementa a detecção de contradições: identifica conflitos em predicados, condições e obrigações que uma análise superficial poderia perder |
| **SBVR (novo)** | Ambiguidade estrutural e incompletude — requisitos com sujeitos indefinidos, condições implícitas, predicados incompletos | Análise estrutural de predicados | Nova metodologia agregada — cobre uma classe de problemas que os guardrails anteriores não detectavam |
| **Versionamento por Estrangulamento** | Mudanças graduais — alterações estruturais aplicadas proporcionalmente à criticidade | Controle de versão semântico | Não — escopo diferente (processo, não validação) |

**O que SBVR adiciona que os guardrails existentes não cobriam:**

1. **Detecção de atores indefinidos:** "O sistema deve notificar o responsável" — qual responsável? SBVR identifica que "responsável" não está definido como ator.
2. **Completude de predicados:** "Pedidos acima de R$ 500 precisam de aprovação" — aprovação de quem? Para quê? SBVR identifica predicados incompletos.
3. **Ambiguidade de escopo:** "Clientes inativos não recebem promoções" — SBVR cruza com a definição formal de "cliente inativo" no glossário para verificar se a intenção do autor corresponde à definição acordada.
4. **Condições implícitas:** "A devolução é processada em 5 dias úteis" — SBVR identifica que não há condição de quando a contagem começa (a partir da solicitação? Da aprovação? Do recebimento do item?).

**Princípio de design adicionado:**

"A IA utiliza internamente um arsenal de metodologias de validação semântica — incluindo, mas não limitado a, SBVR — para garantir que os requisitos produzidos sejam precisos, completos e consistentes. A escolha de qual metodologia aplicar a cada validação é operacional (decidida pela IA com base no contexto), não decisória (não requer aprovação humana). O que requer aprovação humana é o resultado da validação, não o método utilizado."

**Impacto na seção 2.2.5 (Guardrails):**

Adicionar ao texto dos guardrails:

"As validações descritas acima são complementadas por metodologias internas de análise semântica — como SBVR — que a IA pode empregar conforme o contexto. Essas metodologias operam de forma invisível ao usuário: o resultado é apresentado como perguntas de esclarecimento em linguagem natural ou como sinalizações de inconsistência. A IA não está restrita a uma única metodologia de validação; ela pode combinar ou alternar conforme a natureza do artefato sendo avaliado."

#### Novo Risco 9.12 — Opacidade da Validação Interna

Ao tornar as metodologias de validação invisíveis ao usuário, perde-se transparência sobre o processo. O Domain Builder não sabe se a IA está usando SBVR, análise de frames, lógica de predicados ou outra abordagem — ele vê apenas as perguntas. Isso pode gerar desconfiança ("por que a IA está fazendo tantas perguntas?") ou, inversamente, confiança excessiva ("a IA já validou, então deve estar correto").

Mitigação: a IA deve explicitar, quando relevante, a natureza da validação sem expor a metodologia. Exemplo: "Identifiquei que a regra menciona 'responsável' sem definir quem ocupa esse papel. Podemos esclarecer?" é mais útil que silenciosamente adicionar uma definição. A transparência é sobre o resultado da validação, não sobre o método.

---

## Rodada 5 — IEEE 29148 com Natureza Adaptativa

### Solicitação

Adicionar como escopo da proposta: IEEE 29148 deve ter natureza adaptativa — não forçar um formato formal exaustivo. As razões para adoção são: performance da IA com o padrão e sua maturidade.

### Conteúdo Produzido

#### Escopo: Natureza Adaptativa do IEEE 29148

##### Por que IEEE 29148?

A adoção do IEEE 29148 como padrão estrutural para requisitos no ZionKit é motivada por dois fatores específicos:

1. **Performance da IA.** Large Language Models (LLMs) produzem requisitos significativamente melhores quando operam com a taxonomia do IEEE 29148. O padrão está amplamente representado no corpus de treinamento desses modelos, o que significa que a IA "pensa melhor" quando organiza requisitos em categorias como funcional, de interface, de desempenho, de restrição. A qualidade da formalização — clareza, completude, precisão — aumenta quando a IA tem uma estrutura reconhecível para trabalhar.

2. **Maturidade do padrão.** O IEEE 29148 (e seus predecessores IEEE 830 e ISO/IEC/IEEE 29148:2018) representam décadas de refinamento na engenharia de requisitos. A taxonomia, os atributos de qualidade e a organização por seções já foram testados em milhares de projetos reais. Ao adotar essa estrutura, o ZionKit se ancora em conhecimento consolidado em vez de inventar uma organização ad hoc.

##### O que o IEEE 29148 dá ao ZionKit — e o que NÃO impõe

**O que dá:**
- Taxonomia para classificar requisitos (funcional, interface, desempenho, restrição, qualidade)
- Atributos de qualidade por requisito (verificabilidade, rastreabilidade, necessidade)
- Framework para requisitos não-funcionais (que SBVR e SBE não cobrem diretamente)
- Estrutura reconhecível pelos LLMs, aumentando a qualidade da formalização

**O que NÃO impõe:**
- Não exige documento SRS (Software Requirements Specification) completo desde o primeiro ciclo
- Não exige todas as seções em todos os momentos
- Não exige conformidade formal com o padrão como certificação
- Não substitui a linguagem natural — complementa com estrutura

##### Natureza Adaptativa — Três Níveis de Aderência

A aplicação do IEEE 29148 é proporcional à maturidade do produto e ao contexto do ciclo. Três níveis de aderência:

| Nível | Quando usar | O que inclui | O que omite |
|-------|------------|--------------|-------------|
| **Mínimo** | Produto novo (greenfield), prototipação, discovery inicial | Tipo de requisito (funcional/não-funcional), descrição em linguagem natural estruturada, critérios SBE | Rastreabilidade formal, atributos de qualidade detalhados, seções de interface e restrição |
| **Moderado** | Produto em crescimento, após 2-3 ciclos de Canon Building | Tipo + subtipo (funcional, interface, desempenho), rastreabilidade para Change Plans, critérios SBE, dependências entre requisitos | Seções completas de restrição de design, análise de qualidade formalizada |
| **Completo** | Produto maduro, domínios regulados (saúde, finanças), integrações complexas | Taxonomia completa IEEE 29148, rastreabilidade bidirecional, atributos de qualidade, seções de interface, restrição de design, critérios de qualidade | Nada é omitido — aplicação integral |

##### Quem controla o nível de aderência?

O **Architect** define e ajusta o nível de aderência do IEEE 29148 como parte da Technical Constitution Session. A decisão é registrada nos princípios técnicos constitucionais da Product Canon:

```
PADRÕES DE REQUISITOS
  Aderência IEEE 29148: Mínimo
  Justificativa: Produto em fase de discovery, 1º ciclo de 
    Canon Building. Aderência será revisada após 3 ciclos.
  Próxima revisão: Após ciclo 3
```

O nível pode ser diferente por bounded context — um contexto maduro (Pagamentos, 10 ciclos) pode operar em nível Completo enquanto um contexto novo (Telemedicina, 1º ciclo) opera em nível Mínimo.

##### Exemplo — Mesmo Requisito em Nível Mínimo vs. Completo

**Nível Mínimo:**

```
REQUISITO REQ-AGD-001
  Tipo: Funcional
  Contexto: Agendamento
  Descrição: O sistema deve permitir que o Paciente agende 
    consultas online com escolha de especialidade e horário 
    disponível.
  Critério de Aceitação (SBE):
    Dado que o Paciente está autenticado
    E existem horários disponíveis para Cardiologia
    Quando o Paciente seleciona Cardiologia e um horário disponível
    Então o sistema deve confirmar o agendamento
    E enviar notificação ao Paciente e ao Médico
```

**Nível Completo:**

```
REQUISITO REQ-AGD-001
  Tipo: Funcional
  Subtipo: Interação do Usuário
  Contexto: Agendamento
  Descrição: O sistema deve permitir que o Paciente agende 
    consultas online com escolha de especialidade e horário 
    disponível.
  
  Requisitos de Interface:
    - UI-AGD-001: Calendário com slots disponíveis por especialidade
    - UI-AGD-002: Confirmação visual antes do agendamento
    - INT-AGD-001: Integração com sistema de agenda do Médico
  
  Requisitos de Desempenho:
    - PERF-AGD-001: Listagem de horários em < 2 segundos
    - PERF-AGD-002: Suporte a 500 agendamentos simultâneos
  
  Restrições de Design:
    - Calendário deve seguir padrão ISO 8601
    - Fuso horário baseado na localização do Paciente
  
  Critérios de Qualidade:
    - Disponibilidade: 99.9% no horário comercial
    - Acessibilidade: WCAG 2.1 nível AA
  
  Critério de Aceitação (SBE):
    Dado que o Paciente está autenticado
    E existem horários disponíveis para Cardiologia
    Quando o Paciente seleciona Cardiologia e um horário disponível
    Então o sistema deve confirmar o agendamento
    E enviar notificação ao Paciente e ao Médico
    
    Dado que o Paciente está autenticado
    E não existem horários disponíveis para Cardiologia 
      nos próximos 7 dias
    Quando o Paciente pesquisa Cardiologia
    Então o sistema deve oferecer lista de espera
    E notificar o Paciente quando houver disponibilidade
  
  Rastreabilidade:
    Origem: discovery-plan-005 (Domain Discovery Session 2)
    Dependências: REQ-AUT-001 (Autenticação), REQ-NOT-003 (Notificações)
    Impacta: Prontuário (evento ConsultaAgendada)
  
  Atributos:
    Prioridade: Alta
    Necessidade: Essencial
    Verificabilidade: Automatizável via testes E2E
    Estabilidade: Estável (3 ciclos sem alteração)
```

**Observação:** O SBE (Dado/Quando/Então) é obrigatório em TODOS os níveis de aderência. O que varia entre níveis é a quantidade de metadados estruturais do IEEE 29148 ao redor do SBE.

##### Impacto no Guardrail de Padronização Canônica

O guardrail de Padronização Canônica deve respeitar o nível de aderência configurado:
- Em nível Mínimo: valida apenas tipo de requisito + descrição + SBE
- Em nível Moderado: valida tipo + subtipo + rastreabilidade + SBE + dependências
- Em nível Completo: valida conformidade integral com a estrutura IEEE 29148

A IA não deve exigir seções que o nível configurado não prevê.

##### Impacto no Risco 9.11 (Excesso de Formalismo IEEE)

O risco 9.11 é parcialmente mitigado pela natureza adaptativa: o nível Mínimo garante que equipes em fase inicial não são sobrecarregadas com estrutura prematura. Risco residual: pressão para escalar o nível de aderência prematuramente ("se o Completo é melhor, por que não usar desde o início?"). Mitigação: o Architect controla a progressão e deve justificar cada mudança de nível.

##### Nova Prioridade de Prototipação

**Taxonomia IEEE 29148 adaptativa na Requirements Specification Session.** Validar se: (a) os três níveis de aderência são percebidos como proporcionais e não arbitrários; (b) a progressão de nível Mínimo para Moderado acontece naturalmente conforme a Product Canon cresce; (c) a IA respeita o nível configurado sem adicionar seções não previstas; (d) o nível Completo agrega valor em domínios regulados sem criar overhead desproporcional.

---

## Consolidação — Quadro Resumo de Todos os Escopos

| Escopo | Conteúdo |
|--------|----------|
| 1 | SBVR como ferramenta interna de validação (uma entre várias, agrega aos guardrails existentes). IEEE 29148 + SBE como formato canônico visível. SBVR não aparece em artefatos. |
| 2 | IEEE 29148 como padrão estrutural — natureza adaptativa (3 níveis: mínimo/moderado/completo), proporcional à maturidade do produto, controlado pelo Architect. Motivação: performance da IA + maturidade do padrão. |
| 3 | Expansão do Domain Expert: 3.1 Anotações em aprovações, 3.2 Hotspots de domínio, 3.3 Edição direta na camada de negócio com guardrails (fluxo de 6 passos + aprovação sequencial Domain Expert → Architect). |
| 4 | Novo guardrail: Padronização Canônica — valida IEEE 29148 + SBE (adaptativo conforme nível de aderência). |
| Riscos | 9.6 revisado (SBVR invisível — risco eliminado). Novos: 9.8 (edição como atalho), 9.9 (qualidade formalização), 9.10 (fadiga aprovação dupla), 9.11 (excesso formalismo IEEE — mitigado por natureza adaptativa), 9.12 (opacidade validação interna). |
| Prototipação | 6 revisada (validação interna como motor). Novas: 8 (guardrail padronização), 9 (edição direta + aprovação sequencial), 10 (taxonomia IEEE 29148 adaptativa). |

---

## Decisões Consolidadas

### Padrões e Formatos

1. **SBVR** é uma ferramenta interna de validação semântica — uma entre várias que a IA pode utilizar. Sua notação NUNCA aparece em artefatos visíveis ao usuário.
2. **IEEE 29148** é o padrão estrutural para organização de requisitos, adotado por dois motivos: performance da IA (LLMs produzem melhor com essa taxonomia) e maturidade do padrão (décadas de refinamento).
3. **IEEE 29148 é adaptativo** — três níveis de aderência (mínimo/moderado/completo), proporcionais à maturidade do produto, controlados pelo Architect na Technical Constitution Session.
4. **SBE (Dado/Quando/Então)** é obrigatório em todos os níveis de aderência como formato de critérios de aceitação verificáveis.
5. A IA pode usar qualquer metodologia de validação internamente — SBVR, análise de frames, lógica de predicados, etc. O que importa é o resultado, não o método.

### Papéis e Aprovações

6. **Domain Expert** ganha três novas capacidades: anotações em aprovações, hotspots de domínio, edição direta na camada de negócio.
7. Edição direta gera `expert-edit-plan` com **aprovação sequencial obrigatória**: Domain Expert primeiro (fidelidade semântica), Architect segundo (impacto técnico).
8. A ordem é justificada: fidelidade semântica é pré-requisito para avaliação técnica.

### Guardrails

9. **Novo guardrail: Padronização Canônica** — valida que artefatos seguem IEEE 29148 + SBE conforme o nível de aderência configurado.
10. SBVR é agregado aos guardrails existentes (Clarificação de Conformidade + Validação de Consistência) como metodologia complementar, não como substituto.
11. Os guardrails existentes continuam operando exatamente como antes — SBVR adiciona uma camada extra de detecção (ambiguidade estrutural, predicados incompletos, atores indefinidos).

### Riscos Adicionados

12. **9.8 — Edição direta como atalho:** Domain Experts podem usar edição direta para evitar cerimônias completas quando estas seriam mais apropriadas.
13. **9.9 — Qualidade da formalização pela IA:** A IA pode introduzir sutis alterações de significado ao formalizar linguagem natural em IEEE 29148.
14. **9.10 — Fadiga de aprovação dupla:** Volume de edições diretas pode gerar aprovação mecânica nos dois aprovadores sequenciais.
15. **9.11 — Excesso de formalismo IEEE:** Pressão para usar nível Completo prematuramente. Mitigado pela natureza adaptativa e controle do Architect.
16. **9.12 — Opacidade da validação interna:** Ao tornar metodologias como SBVR invisíveis, perde-se transparência sobre como a IA está validando.

---

## Impactos no Modelo v0.5 — Seções Afetadas

Quando esta proposta for aplicada ao modelo, as seguintes seções de `zionkit-model.md` precisarão de edição:

| Seção | Impacto |
|-------|---------|
| **2.1 — Product Canon** | Camada de Negócio: "Requisitos formalizados via SBVR + SBE" → "Requisitos formalizados em IEEE 29148 + SBE, validados internamente com metodologias como SBVR" |
| **2.2.3 — Requirements Specification Session** | Remover referências a SBVR visível. Adicionar IEEE 29148 como formato de saída. Mencionar SBVR como validação interna. |
| **2.2.5 — Guardrails** | Adicionar guardrail de Padronização Canônica. Adicionar texto sobre metodologias internas complementares. |
| **3 — Ciclo Completo (diagrama)** | Atualizar referências SBVR → IEEE 29148 + SBE no fluxo visual. |
| **4 — Papéis** | Expandir Domain Expert com anotações, hotspots, edição direta. Adicionar `expert-edit-plan` à tabela. Adicionar aprovação sequencial. |
| **5 — Estrutura de Artefatos** | "Regras formalizadas em SBVR" → formato IEEE 29148. Adicionar `expert-edit-plan` aos tipos de Change Plan. |
| **6 — Cenários** | Atualizar exemplos para refletir IEEE 29148 + SBE (sem SBVR visível). |
| **7 — Dores** | Atualizar referência à mediação SBVR. |
| **9 — Riscos** | Revisar 9.6. Adicionar 9.8-9.12. |
| **10 — Prototipação** | Revisar prioridade 6. Adicionar prioridades 8-10. |

---

## Tabela de Padrões do Modelo v0.6

| Padrão | Visível ao Usuário? | Função | Quem Controla | Obrigatório? |
|--------|---------------------|--------|---------------|-------------|
| **IEEE 29148** | Sim | Estrutura e taxonomia dos requisitos | Architect (nível de aderência) | Sim (nível adaptativo) |
| **SBE** | Sim | Critérios de aceitação verificáveis (Dado/Quando/Então) | Automático (obrigatório em todos os níveis) | Sim (sempre) |
| **SBVR** | Não | Validação interna de ambiguidade, completude, consistência | IA (operacional) | Não (uma entre várias metodologias) |

---

*Documento gerado como consolidação bruta da conversa de construção da proposta v0.6. Conteúdo a ser refinado.*
