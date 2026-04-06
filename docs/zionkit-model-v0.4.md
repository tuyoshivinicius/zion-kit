# ZionKit: Uma Camada Semântica Viva para Desenvolvimento de Software Orientado por Especificações

**Status do modelo**: Protótipo conceitual  
**Versão do documento**: 0.4 — Abril 2026  

---

## Resumo Executivo

**Em uma frase:** ZionKit é um modelo que garante que todo o conhecimento de um produto — suas regras, seu vocabulário, seus processos — guie automaticamente o que a inteligência artificial constrói, e que cada construção enriqueça esse conhecimento de volta.

ZionKit é um modelo de desenvolvimento de software assistido por inteligência artificial que introduz uma **golden source semântica** — uma fonte central de verdade sobre o domínio do produto e como ele funciona — como camada de primeira classe entre o conhecimento de domínio de negócio e a geração de código. O modelo opera em um ciclo fechado de três etapas: construção e manutenção assistida da golden source por usuários de negócio e arquitetos, criação de especificações (descrições detalhadas do que será construído) contextualizadas com um plano de alteração conceitual aprovado por especialistas de domínio e arquitetos, e retroalimentação formal da golden source com as decisões emergentes de cada ciclo.

O ZionKit resolve três problemas estruturais observados nos processos atuais de desenvolvimento assistido por IA: a ausência de uma camada viva de conhecimento de domínio e de arquitetura que sirva de contexto para especificações, a exclusão de usuários não-técnicos do processo de especificação de requisitos, e a inexistência de mecanismos formais que conectem o aprendizado de cada ciclo de implementação de volta ao conhecimento do produto.

O modelo ainda não foi testado em ambiente de produção e encontra-se em fase de prototipação conceitual.

---

## 1. Problema

### 1.1 O vazio entre conhecimento de negócio e especificação técnica

Nos processos atuais de desenvolvimento assistido por IA, o conhecimento de domínio de negócio existe de forma fragmentada: em documentos dispersos, na memória tácita de engenheiros seniores, em conversas não registradas entre stakeholders, ou em wikis desatualizadas. Quando um agente de IA recebe uma especificação de feature para gerar código, ele opera sem acesso formal a esse conhecimento. A consequência é que cada especificação precisa reconstruir contexto de domínio do zero, ou aceitar que decisões serão tomadas silenciosamente pelo agente com base em suposições não declaradas.

**Cenário ilustrativo.** Uma equipe de e-commerce precisa implementar uma feature de "reembolso parcial". O engenheiro escreve uma especificação para o agente de IA. No entanto, o conceito de "reembolso" tem regras específicas no domínio do produto: reembolsos acima de determinado valor exigem aprovação hierárquica, reembolsos de itens promocionais seguem regras diferentes, e o termo "parcial" tem significado distinto dependendo de se refere ao valor ou aos itens do pedido. Nenhuma dessas restrições está formalizada em um artefato acessível ao agente. O código gerado funciona, mas viola regras de negócio que só seriam descobertas em produção.

### 1.2 A exclusão do usuário de negócio

Os frameworks de desenvolvimento orientados por especificação assumem que quem escreve especificações é um engenheiro sênior ou um arquiteto de especificações. Usuários de negócio — product owners, analistas de produto, gestores de operações — conhecem o produto e suas regras, mas frequentemente não possuem o vocabulário técnico ou a precisão terminológica necessária para produzir especificações que agentes de IA possam consumir com segurança.

O resultado é uma de duas situações: ou o usuário de negócio é excluído do processo e suas intenções são traduzidas (com perda) por intermediários técnicos, ou ele participa diretamente e produz especificações ambíguas, contraditórias ou que utilizam termos inconsistentes com o vocabulário estabelecido do domínio.

**Cenário ilustrativo.** Um product owner descreve uma nova regra: "clientes inativos não devem receber promoções." Porém, na linguagem ubíqua do domínio, "cliente inativo" tem uma definição precisa (sem compras nos últimos 12 meses e sem login nos últimos 6 meses) que difere da intuição do product owner, que pensava apenas em "quem não compra há algum tempo." Sem um mecanismo que confronte o input do usuário com as definições existentes, a especificação é gerada com uma definição implícita incorreta.

### 1.3 O conhecimento que se perde a cada ciclo

Cada ciclo de implementação de uma feature gera descobertas sobre o domínio: conceitos que precisam ser refinados, regras que não estavam documentadas, bounded contexts que precisam ser reorganizados, decisões arquiteturais que afetam o entendimento do negócio. Nos processos atuais, essas descobertas morrem na especificação descartável ou no código gerado. Não há mecanismo formal para que o aprendizado de uma implementação retroalimente o corpo de conhecimento do produto, enriquecendo o contexto disponível para especificações futuras.

**Cenário ilustrativo.** Durante a implementação de um sistema de notificações, a equipe descobre que o conceito de "preferência do usuário" precisa ser separado em "preferência de canal" (email, SMS, push) e "preferência de conteúdo" (marketing, transacional, operacional). Essa descoberta é relevante para qualquer feature futura que toque notificações. No entanto, sem retroalimentação formal, a próxima equipe que trabalhar nesse domínio não terá acesso a essa decomposição e pode repetir o mesmo erro conceitual.

---

## 2. O Modelo ZionKit

O ZionKit resolve os problemas descritos acima criando um repositório central onde todo o conhecimento do produto — suas regras, seu vocabulário, seus processos, suas decisões técnicas — fica formalizado, versionado e acessível. Quando alguém pede para a IA construir algo, ela consulta esse repositório para garantir que o que será construído respeita o que já foi definido para o produto. E quando a construção revela algo novo sobre o domínio, esse aprendizado volta para o repositório, enriquecendo o contexto disponível para todos.

Em termos mais precisos, o ZionKit propõe uma arquitetura de conhecimento em camadas com ciclo bidirecional, onde uma golden source semântica serve simultaneamente como repositório vivo de conhecimento de domínio e como infraestrutura de contexto para especificações de software.

### 2.1 A Golden Source Semântica

A golden source é um conjunto versionado de artefatos (documentos estruturados) que representam o conhecimento de domínio do produto em duas camadas complementares.

**Camada de Negócio.** Contém artefatos legíveis por pessoas não-técnicas, escritos em linguagem natural estruturada:

- **Glossário de linguagem ubíqua**: definições precisas dos termos do domínio — o vocabulário oficial do produto, onde cada palavra tem um significado acordado por todos. Cada termo é associado ao bounded context (a área do negócio) onde tem validade.
- **Regras de negócio declarativas**: restrições, políticas e invariantes do domínio, expressas em linguagem natural com critérios verificáveis. Por exemplo: "Reembolsos acima de R$ 500 exigem aprovação do gerente."
- **Requisitos de negócio (SRS)**: documentos de requisitos de software produzidos e mantidos através de processos assistidos, com completude e consistência validadas.
- **Fluxos de domínio**: representações dos processos de negócio — o que acontece, em que ordem, quem faz o quê — derivados de sessões de Event Storming (uma técnica colaborativa de mapeamento de processos, descrita na seção 2.2.1).

**Camada de Arquitetura.** Contém artefatos que formalizam as decisões técnicas e estruturais do sistema:

- **Princípios técnicos constitucionais**: as regras técnicas imutáveis do projeto — quais tecnologias usar, como os componentes se comunicam, como os dados são protegidos. Funcionam como o equivalente técnico do glossário de linguagem ubíqua: toda especificação deve respeitá-los ou justificar formalmente a exceção.
- **Bounded contexts** (contextos delimitados): fronteiras lógicas que separam áreas do negócio com vocabulário e regras próprias. Por exemplo, "Pagamentos" e "Notificações" são contextos diferentes com responsabilidades distintas.
- **Eventos de domínio**: catálogo dos fatos relevantes que acontecem no sistema — "PagamentoConfirmado", "PedidoCancelado" — com a descrição formal de quais dados cada evento carrega (seu schema) e quais áreas os consomem.
- **Context maps** (mapas de contexto): representação visual e formal de como os bounded contexts se relacionam entre si — quais dependem de quais, como trocam informações, onde há fronteiras de proteção.
- **Architecture Decision Records (ADRs)**: registros formais de decisões técnicas importantes — o que foi decidido, por quê, quais alternativas foram consideradas e quais são as consequências. Servem como memória técnica do produto sobre as escolhas feitas e suas justificativas.

A golden source não é um documento estático produzido em uma fase inicial de projeto. É um artefato vivo, continuamente construído e atualizado, que evolui com o sistema.

### 2.2 Etapa 1 — Construção e Manutenção da Golden Source

O usuário de negócio e o arquiteto constroem e mantêm a golden source de forma complementar. O usuário de negócio é responsável pela camada de negócio — glossário, regras, requisitos e fluxos — através de interações em linguagem natural orientadas por duas pipelines. O arquiteto é responsável pela camada de arquitetura — princípios técnicos constitucionais, context maps, ADRs e validação técnica dos bounded contexts propostos pelo Event Storming. Os dois papéis colaboram no ponto onde as camadas se encontram: a definição e delimitação de bounded contexts, que possui dimensão tanto semântica quanto técnica.

#### 2.2.1 Pipeline de Event Storming Conversacional

O usuário é guiado por um processo conversacional que replica a dinâmica de uma sessão de Event Storming. Em vez de post-its em uma parede, o usuário descreve fluxos de negócio em linguagem natural, e o agente de IA ajuda a identificar e organizar os elementos estruturais.

O processo segue o fluxo canônico do Event Storming:

1. **Descoberta de eventos de domínio.** O usuário descreve o que acontece no negócio. O agente identifica eventos (fatos que ocorreram, expressos no passado: "Pedido Criado", "Pagamento Confirmado", "Entrega Realizada") e os organiza em uma timeline.
2. **Identificação de comandos e atores.** Para cada evento, o agente investiga o que o causou (comando) e quem o disparou (ator humano, sistema externo ou política automatizada).
3. **Mapeamento de agregados e bounded contexts.** Com o fluxo mapeado, o agente propõe agrupamentos de eventos e comandos que formam agregados coesos, e sugere delimitações de bounded contexts com base em fronteiras naturais do negócio. O arquiteto então avalia a viabilidade técnica dessa proposta, conforme detalhado na seção 2.2.4.
4. **Decomposição de casos de uso.** Os fluxos identificados são decompostos em casos de uso concretos com pré-condições, pós-condições e fluxos alternativos.

**Exemplo — perspectiva do usuário de negócio.** Um gestor de operações de uma fintech descreve: "Quando um cliente pede pra sacar dinheiro, a gente verifica se tem saldo, se tem limite diário disponível, e se não tem nenhum bloqueio judicial. Se tudo ok, o saque é processado e o cliente recebe uma notificação." A partir dessa descrição, o agente identifica os eventos (SaqueSolicitado, SaldoVerificado, LimiteValidado, BloqueioVerificado, SaqueProcessado, NotificaçãoEnviada), os comandos (SolicitarSaque, VerificarSaldo, ValidarLimite, VerificarBloqueio, ProcessarSaque, EnviarNotificação), os atores (Cliente, Sistema de Compliance) e propõe bounded contexts (Conta, Compliance, Notificações).

**Exemplo — perspectiva do arquiteto.** O arquiteto avalia a proposta de bounded contexts e identifica que a verificação de bloqueio judicial (Compliance) precisa ser síncrona com o processamento de saque (Conta), pois um saque não pode ser processado antes da verificação completar. Decide que a comunicação entre esses dois contextos será via chamada síncrona interna, enquanto a comunicação com Notificações será assíncrona via evento. Essa decisão é registrada como ADR fundacional e o mapa de contexto é atualizado.

#### 2.2.2 Pipeline MARE (Multi-Agents Collaboration Framework for Requirements Engineering)

Complementar ao Event Storming, a pipeline MARE aplica um processo multi-agente para estruturar e validar requisitos de software. O framework MARE divide a engenharia de requisitos em quatro fases — elicitação, modelagem, verificação e especificação — cada uma conduzida por agentes especializados com ações definidas.

No contexto do ZionKit, a pipeline MARE é utilizada quando o usuário de negócio precisa escrever ou alterar requisitos na golden source. O processo opera da seguinte forma:

1. **Elicitação.** O usuário expressa uma necessidade ou alteração em linguagem natural. Agentes especializados em elicitação fazem perguntas clarificadoras, identificam requisitos implícitos e exploram edge cases que o usuário não considerou.
2. **Modelagem.** Os requisitos elicitados são estruturados em formato padronizado, com critérios de aceitação verificáveis e rastreabilidade.
3. **Verificação.** Agentes de verificação confrontam os novos requisitos com os existentes na golden source, identificando contradições, redundâncias, gaps de completude e violações de regras de negócio já estabelecidas.
4. **Especificação.** O resultado é formalizado como um artefato de requisitos (documento SRS) pronto para ser incorporado à golden source.

**Exemplo.** O product owner escreve: "O cliente deve poder cancelar um pedido." O agente de elicitação questiona: "Em que momento do fluxo o cancelamento é permitido? Há restrições após faturamento? O cancelamento gera reembolso automático?" O agente de verificação confronta com a golden source e identifica que existe uma regra de negócio declarada: "Pedidos faturados não podem ser cancelados, apenas devolvidos." O agente sinaliza a contradição e propõe ao usuário reformular o requisito para "O cliente deve poder cancelar um pedido que ainda não foi faturado."

#### 2.2.3 Combinação das Pipelines

As duas pipelines são complementares e podem ser combinadas. Event Storming é um processo de descoberta bottom-up: parte do que acontece no negócio e organiza em estruturas. MARE é um processo de validação top-down: parte de um requisito declarado e verifica completude, consistência e aderência ao que já existe.

Uma sequência típica de construção da golden source seria: Event Storming para mapear o domínio e descobrir fluxos, eventos e bounded contexts, seguido de MARE para estruturar e validar os requisitos associados a cada contexto descoberto, e atuação do arquiteto para validar a decomposição técnica e estabelecer os fundamentos da camada de arquitetura.

#### 2.2.4 Atuação do Arquiteto na Etapa 1

Enquanto as pipelines de Event Storming e MARE produzem artefatos da camada de negócio, o arquiteto é responsável por construir a camada de arquitetura da golden source. Sua atuação na Etapa 1 compreende:

1. **Validação técnica de bounded contexts.** Os contextos propostos pelo Event Storming são avaliados sob a ótica de viabilidade técnica. O arquiteto verifica se as fronteiras semânticas são compatíveis com fronteiras de deploy, se há necessidade de consistência transacional entre contextos, e se o acoplamento proposto é sustentável.
2. **Definição do context map.** Com os bounded contexts validados, o arquiteto define formalmente as relações técnicas entre eles: quais são upstream/downstream, onde há shared kernels, onde são necessárias anticorruption layers, e quais padrões de integração cada relação utiliza.
3. **Estabelecimento dos princípios técnicos constitucionais.** O arquiteto define as restrições técnicas que governam todas as especificações futuras: stack tecnológica, padrões de comunicação entre contextos, estratégias de persistência, políticas de segurança e requisitos de observabilidade.
4. **Registro de ADRs fundacionais.** Decisões técnicas estruturais tomadas durante a construção da golden source são formalizadas como ADRs, com contexto, alternativas consideradas e consequências documentadas.
5. **Avaliação técnica de requisitos.** Requisitos produzidos pela pipeline MARE são avaliados pelo arquiteto sob a ótica de restrições técnicas. Um requisito que implica consulta cross-context em tempo real, por exemplo, pode ser tecnicamente inviável se o princípio constitucional determina comunicação assíncrona entre contextos.

**Exemplo de princípios técnicos constitucionais:**

```
PRINCÍPIOS TÉCNICOS CONSTITUCIONAIS
====================================

STACK
  - Backend: Python 3.12+ com FastAPI
  - Persistência: PostgreSQL para dados transacionais, Redis para cache
  - Mensageria: RabbitMQ para eventos de domínio

COMUNICAÇÃO ENTRE CONTEXTOS
  - Comunicação entre bounded contexts DEVE ser assíncrona via eventos
  - Comunicação síncrona é permitida APENAS dentro de um mesmo 
    bounded context ou quando justificada por ADR específico
  - Schemas de eventos seguem formato CloudEvents v1.0

PERSISTÊNCIA
  - Cada bounded context possui seu próprio schema de banco
  - Consultas cross-context são proibidas; dados de outros contextos 
    são obtidos via eventos ou APIs públicas

SEGURANÇA
  - Autenticação via OAuth2 com JWT
  - Dados sensíveis (PII) são criptografados em repouso
  - Logs nunca contêm dados de PII

OBSERVABILIDADE
  - Todos os eventos de domínio publicam traces OpenTelemetry
  - Métricas de negócio são expostas via Prometheus
```

Esses princípios funcionam como o glossário de linguagem ubíqua funciona para a camada de negócio: quando uma especificação propõe comunicação síncrona entre dois bounded contexts, a IA sinaliza a violação do princípio constitucional e exige justificativa — que, se aprovada pelo arquiteto, é registrada como ADR.

#### 2.2.5 Guardrails da Golden Source

A manutenção da golden source requer guardrails que garantam sua integridade ao longo do tempo.

**Clarificação semântica.** Quando o usuário utiliza termos que divergem do glossário de linguagem ubíqua, o agente sinaliza a divergência e propõe alinhamento. Se o usuário utiliza "cliente" onde a golden source define "titular da conta", o agente identifica a inconsistência e pede confirmação sobre a intenção.

**Validação de consistência.** Alterações em requisitos ou regras de negócio são confrontadas com o estado atual da golden source, incluindo tanto as regras de negócio quanto os princípios técnicos constitucionais. Contradições em qualquer uma das camadas são identificadas antes de serem aceitas.

**Versionamento gradual de alterações radicais.** Nem toda alteração na golden source deve ser refletida imediatamente. Mudanças estruturais significativas — como a divisão de um bounded context, a redefinição de um conceito central ou a remoção de um evento de domínio — devem ser versionadas e aplicadas gradualmente, por criticidade. A golden source mantém duas faces: o estado vigente (current) e o estado aprovado em transição (next). Especificações de manutenção referenciam current; especificações de novos produtos podem referenciar next.

**Exemplo.** A equipe decide que o bounded context de "Faturamento" precisa ser dividido em "Cobrança" e "Receita." Essa alteração não é aplicada atomicamente. Ela é registrada como uma mudança em transição. Especificações existentes continuam referenciando "Faturamento" até que a migração seja completada. Novas especificações para os contextos separados podem ser escritas contra a versão next, que já reflete a divisão.

### 2.3 Etapa 2 — Especificação Contextualizada com Plano de Alteração Conceitual

Nesta etapa, um usuário de negócio ou um arquiteto escreve uma especificação de feature para um produto novo ou existente. A especificação é criada utilizando ferramentas de Spec-Driven Development existentes e consome contexto de ambas as camadas da golden source. O usuário de negócio define a intenção de produto; o arquiteto toma decisões técnicas dentro da spec — escolha de padrões de integração, estratégias de persistência, schemas — orientado pelos princípios técnicos constitucionais da golden source.

#### 2.3.1 Injeção de Contexto da Golden Source

A especificação não é escrita no vazio. O agente de IA injeta seletivamente na janela de contexto os fragmentos relevantes da golden source: o glossário do bounded context afetado, os eventos de domínio publicados e consumidos, as regras de negócio aplicáveis, os ADRs relevantes e os requisitos existentes relacionados.

Essa injeção seletiva é necessária porque a golden source completa pode exceder os limites de contexto efetivos dos modelos de linguagem. O agente identifica quais bounded contexts são tocados pela especificação e carrega apenas os artefatos pertinentes.

#### 2.3.2 Clarificação e Validação Contextualizada

Assim como na Etapa 1, a especificação de feature é submetida a clarificação e validação com base na golden source. Termos inconsistentes são sinalizados. Requisitos que contradizem regras de negócio existentes são flagrados. Dependências entre bounded contexts são identificadas.

**Exemplo.** Um engenheiro escreve uma especificação para "adicionar método de pagamento PIX ao checkout." O agente, com contexto da golden source, identifica que o bounded context de Pagamentos publica o evento "PagamentoConfirmado" com um schema que não inclui campos específicos de PIX. A especificação precisa declarar se o schema será estendido ou se um novo evento será criado. Essa decisão não pode ser tomada silenciosamente pelo agente — ela tem impacto conceitual.

#### 2.3.3 Plano de Alteração Conceitual

Quando a IA identifica que uma nova funcionalidade vai causar mudanças no conhecimento formalizado do produto — um termo novo precisa ser definido, uma regra de negócio precisa ser criada, um evento técnico precisa ser adicionado — ela gera automaticamente um **plano de alteração conceitual**. O propósito desse artefato é tornar visível, antes de qualquer código ser escrito, quais mudanças uma nova funcionalidade causa no corpo de conhecimento do produto.

Em termos de mecânica, o plano funciona como um "diff semântico" — uma comparação entre o estado atual da golden source e o estado que ela terá após a implementação. Ele é organizado em duas seções — **alterações na camada de negócio** e **alterações na camada de arquitetura** — tornando explícito qual aprovador é responsável por qual seção. O plano lista conceitos novos que serão introduzidos, definições existentes que serão alteradas, eventos de domínio que serão criados ou modificados, bounded contexts que serão afetados, princípios técnicos que serão impactados, e ADRs que precisam ser registrados.

**Exemplo de plano de alteração conceitual:**

```
PLANO DE ALTERAÇÃO CONCEITUAL — Spec: PIX no Checkout
================================================================

CAMADA DE NEGÓCIO (aprovação: domain expert)
────────────────────────────────────────────

  GLOSSÁRIO
    [NOVO] "Chave PIX" — Identificador único do recebedor em 
           transações PIX. Pode ser CPF, CNPJ, email, telefone 
           ou chave aleatória. Contexto: Pagamentos.

  REGRAS DE NEGÓCIO
    [NOVA] "Transações PIX acima de R$ 1.000 em horário noturno 
           (20h-6h) requerem confirmação adicional do titular."
           Contexto: Pagamentos, Compliance.

  BOUNDED CONTEXTS AFETADOS
    - Pagamentos (alteração direta)
    - Compliance (nova regra de validação noturna)
    - Notificações (novo template de confirmação)

CAMADA DE ARQUITETURA (aprovação: arquiteto)
────────────────────────────────────────────

  EVENTOS DE DOMÍNIO
    [ALTERAÇÃO] "PagamentoConfirmado" — Adicionar campo 
                "metodo_pagamento" (enum: cartao_credito, boleto, 
                pix) ao schema existente.
    [NOVO] "ChavePixValidada" — Evento emitido após validação da 
           chave PIX junto ao banco central. Contexto: Pagamentos.
           Schema: CloudEvents v1.0 conforme constituição técnica.

  PRINCÍPIOS CONSTITUCIONAIS
    [SEM VIOLAÇÃO] Comunicação entre Pagamentos e Compliance 
    permanece síncrona conforme ADR-001. Nova validação de chave 
    PIX segue mesmo padrão.

  ADRs NECESSÁRIOS
    [NOVO] Decisão sobre extensão do schema de PagamentoConfirmado 
           vs. criação de evento separado PagamentoPIXConfirmado.
```

#### 2.3.4 Aprovação Dual: Domain Expert e Arquiteto

O plano de alteração conceitual é submetido a aprovação em duas dimensões complementares, cada uma exercida por quem detém autoridade sobre a respectiva camada.

**Aprovação da camada de negócio pelo domain expert.** O domain expert avalia se as mudanças conceituais propostas — novos termos no glossário, novas regras de negócio, alterações em requisitos — são consistentes com a realidade do domínio, se os termos estão corretos, se as regras fazem sentido, e se as implicações cross-context foram consideradas.

**Aprovação da camada de arquitetura pelo arquiteto.** O arquiteto avalia se as mudanças técnicas propostas — novos eventos de domínio, alterações em schemas, novos ADRs, exceções a princípios constitucionais — são tecnicamente viáveis, consistentes com a arquitetura existente, e respeitam ou justificam desvios dos princípios técnicos constitucionais.

A aprovação é roteada conforme a natureza do impacto. Especificações que afetam apenas a camada de negócio passam somente pelo domain expert. Especificações que afetam apenas a camada de arquitetura passam somente pelo arquiteto. Especificações que afetam ambas as camadas exigem as duas aprovações, sinalizando corretamente a maior complexidade e risco dessas mudanças.

Em organizações com múltiplos bounded contexts, domain experts e arquitetos podem ser designados por contexto. O plano de alteração conceitual é roteado para o(s) responsável(is) do(s) contexto(s) afetado(s).

**Somente após a(s) aprovação(ões) pertinente(s) a IA implementa a especificação.**

### 2.4 Etapa 3 — Retroalimentação da Golden Source

Uma vez que o plano de alteração conceitual foi aprovado e a especificação foi implementada, as alterações declaradas no plano são refletidas na golden source.

Essa etapa é mecanicamente segura porque não há ambiguidade sobre o que atualizar. O plano de alteração conceitual, já aprovado pelo domain expert e/ou pelo arquiteto conforme a natureza das alterações, declarou explicitamente quais artefatos da golden source serão afetados e como. A retroalimentação é a materialização de decisões já tomadas.

Os novos termos são adicionados ao glossário. Os eventos de domínio novos ou alterados são registrados no catálogo. As regras de negócio são incorporadas. Os ADRs são formalizados. Os princípios técnicos constitucionais são atualizados quando necessário. As alterações são versionadas e passam a integrar o corpo de contexto disponível para todas as especificações futuras.

---

## 3. O Ciclo Completo

O ZionKit opera como um ciclo contínuo que se retroalimenta:

```
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 1                              │
│         Construção e Manutenção da Golden Source             │
│                                                             │
│  Camada de Negócio:                                         │
│    Usuário de Negócio + IA + Event Storming + MARE          │
│    → Glossário, Regras, Requisitos (SRS), Fluxos            │
│  Camada de Arquitetura:                                     │
│    Arquiteto + IA                                           │
│    → Princípios constitucionais, Context Map, ADRs, BCs     │
│  Colaboração: validação técnica de BCs propostos            │
│  → Guardrails: clarificação, validação, versionamento       │
│  → Domain Expert valida mudanças estruturais de negócio     │
└──────────────────────────┬──────────────────────────────────┘
                           │
                contexto de ambas as
                  camadas injetado
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 2                              │
│        Especificação com Plano de Alteração Conceitual       │
│                                                             │
│  Usuário de Negócio / Arquiteto + IA + Golden Source        │
│  → Spec de feature contextualizada                          │
│  → Plano de alteração conceitual gerado automaticamente     │
│     (seção negócio + seção arquitetura)                     │
│  → Domain Expert aprova camada de negócio                   │
│  → Arquiteto aprova camada de arquitetura                   │
│  → IA implementa código                                    │
└──────────────────────────┬──────────────────────────────────┘
                           │
                  alterações aprovadas
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 3                              │
│            Retroalimentação da Golden Source                  │
│                                                             │
│  Alterações do plano conceitual refletidas formalmente       │
│  → Glossário atualizado                                     │
│  → Eventos de domínio registrados                           │
│  → Regras de negócio incorporadas                           │
│  → ADRs formalizados                                        │
│  → Princípios técnicos atualizados se necessário            │
│  → Tudo versionado e disponível como contexto futuro        │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           └──────────► volta para ETAPA 1/2
```

Cada ciclo enriquece a golden source. Especificações futuras operam com contexto mais rico e preciso do que as anteriores. O conhecimento do produto não se perde em especificações descartáveis ou na memória tácita de indivíduos — ele se acumula formalmente.

---

## 4. Papéis no Modelo

O ZionKit define quatro papéis com autoridades complementares e não sobrepostas.

**Usuário de Negócio.** Conhece o produto e suas regras. Escreve em linguagem natural. Pode não ter precisão terminológica ou consciência de todas as implicações técnicas de suas decisões. No ZionKit, ele é o autor primário da camada de negócio da golden source (Etapa 1, via Event Storming e MARE) e de especificações de feature orientadas a produto (Etapa 2). Seus gaps de vocabulário e consistência são compensados pelos guardrails semânticos da IA.

**Arquiteto.** Detém autoridade sobre decisões técnicas e estruturais do sistema. Atua na Etapa 1 construindo a camada de arquitetura da golden source: princípios técnicos constitucionais, context maps, ADRs fundacionais, e validação técnica de bounded contexts propostos pelo Event Storming. Atua na Etapa 2 tomando decisões técnicas dentro de especificações e aprovando alterações na camada de arquitetura do plano de alteração conceitual. Funciona como guardião da integridade técnica — garante que toda mudança é compatível com os princípios constitucionais ou, quando não é, formaliza a exceção como ADR.

**IA (Agente de Inteligência Artificial).** Processa linguagem natural, mantém contexto de ambas as camadas da golden source, identifica inconsistências semânticas e técnicas, propõe clarificações, gera planos de alteração conceitual, e implementa código. No ZionKit, a IA não é um gerador de código autônomo — é um mediador entre a intenção dos usuários e a integridade do domínio e da arquitetura.

**Especialista de Domínio.** Detém autoridade sobre o significado dos conceitos do domínio. Não escreve especificações nem implementa código. Valida que as mudanças conceituais propostas na camada de negócio são consistentes com a realidade do domínio. Funciona como guardião da integridade semântica — aprova ou rejeita a seção de negócio do plano de alteração conceitual.

Em organizações com múltiplos bounded contexts, especialistas de domínio e arquitetos podem ser designados por contexto. O roteamento de aprovações é determinado pelos contextos e camadas afetados no plano de alteração conceitual.

**Resumo de atuação por etapa:**

| Papel | Etapa 1 — Golden Source | Etapa 2 — Especificação | Etapa 3 — Retroalimentação |
|-------|------------------------|------------------------|---------------------------|
| Usuário de Negócio | Constrói camada de negócio (Event Storming, MARE) | Escreve especificação de feature | — |
| Arquiteto | Constrói camada de arquitetura (princípios, context map, ADRs) | Toma decisões técnicas na spec; aprova camada de arquitetura | — |
| Especialista de Domínio | Valida mudanças estruturais de negócio | Aprova camada de negócio do plano de alteração | — |
| IA (LLM) | Guia pipelines, clarifica, valida | Gera plano de alteração conceitual; implementa código | Atualiza golden source |

---

## 5. Estrutura de Artefatos

A golden source pode ser organizada como um diretório versionado no repositório do projeto:

```
/golden-source/
├── domain/
│   ├── glossary.md                    # Linguagem ubíqua
│   ├── business-rules.md              # Regras de negócio declarativas
│   ├── requirements/
│   │   ├── srs-onboarding.md          # Requisitos por domínio
│   │   ├── srs-payments.md
│   │   └── srs-notifications.md
│   └── contexts/
│       ├── payments/
│       │   ├── context.md             # Definição do bounded context
│       │   ├── events.md              # Eventos publicados/consumidos
│       │   ├── flows.md               # Fluxos de Event Storming
│       │   └── use-cases.md           # Casos de uso decompostos
│       ├── compliance/
│       │   └── ...
│       └── notifications/
│           └── ...
├── architecture/
│   ├── constitution.md              # Princípios técnicos constitucionais
│   ├── context-map.md                 # Relações entre BCs
│   └── adrs/
│       ├── 001-event-driven-payments.md
│       ├── 002-auth-strategy.md
│       └── 003-pix-schema-extension.md
└── changelog/
    ├── v1.0-initial-domain.md
    ├── v1.1-billing-split.md          # Mudança radical versionada
    └── v1.2-pix-integration.md
```

Todos os artefatos são markdown versionado em Git, garantindo rastreabilidade de quem alterou o quê, quando e por quê, e permitindo diff, merge e rollback com ferramentas padrão.

---

## 6. Cenários de Aplicação

### 6.1 Produto Novo (Greenfield)

**Contexto.** Uma startup de logística está construindo sua primeira plataforma. O fundador entende profundamente o negócio mas não é técnico.

**Aplicação do ZionKit.**

1. O fundador inicia pela pipeline de Event Storming conversacional. Descreve os fluxos operacionais: "Um embarcador cadastra uma carga, transportadoras fazem ofertas, o embarcador aceita uma oferta, a carga é coletada, rastreada e entregue." O agente decompõe em eventos, comandos, atores e propõe bounded contexts (Marketplace, Transporte, Rastreamento, Faturamento).

2. O arquiteto (neste caso, o CTO da startup) avalia os bounded contexts propostos, define que a comunicação entre Marketplace e Transporte será via eventos assíncronos, estabelece a stack inicial (Node.js, PostgreSQL, RabbitMQ) e registra os princípios técnicos constitucionais e ADRs fundacionais na golden source.

3. Via pipeline MARE, os requisitos de cada contexto são elicitados, validados e estruturados. O agente identifica gaps: "O que acontece se nenhuma transportadora fizer oferta dentro de 24 horas? O embarcador é notificado? A carga expira?" O fundador esclarece, e os requisitos são incorporados à golden source.

4. Um desenvolvedor escreve a primeira especificação de feature: "Implementar o fluxo de cadastro de carga." A spec consome o contexto do bounded context Marketplace e os princípios técnicos constitucionais. O plano de alteração conceitual é mínimo (nenhum conceito novo). O domain expert (o próprio fundador) aprova.

5. A segunda spec, "Implementar sistema de ofertas", gera um plano de alteração mais significativo: introduz o conceito de "Oferta Vinculante" (uma vez aceita, a transportadora não pode desistir) que não estava no glossário original, e propõe um novo evento "OfertaAceita" com schema específico. O fundador valida a camada de negócio, o arquiteto valida a camada técnica, e a golden source é atualizada.

### 6.2 Feature em Produto Existente (Brownfield)

**Contexto.** Carla é product owner em uma empresa de saúde com um sistema maduro. Ela precisa adicionar telemedicina ao produto, mas não conhece todas as implicações técnicas dessa mudança em um sistema que já tem anos de operação.

**Aplicação do ZionKit.**

1. A golden source do produto já existe e contém os bounded contexts (Agendamento, Prontuário, Faturamento, Notificações) com seus glossários, eventos e regras de negócio. Carla não precisou construí-la — ela foi sendo alimentada ao longo do tempo por ciclos anteriores do ZionKit.

2. Carla escreve uma especificação em linguagem simples: "Adicionar consulta por vídeo ao sistema de agendamento." A IA, com acesso à golden source, injeta o contexto de Agendamento e Prontuário e identifica impactos que Carla não havia considerado: o evento "ConsultaRealizada" precisa ser estendido com metadados de vídeo, o conceito de "sala" precisa incluir "sala virtual", e o Faturamento precisa de uma nova regra para diferenciar preço entre consulta presencial e remota.

3. O plano de alteração conceitual gerado lista três bounded contexts afetados. A camada de negócio é avaliada pelos especialistas de domínio de Agendamento, Prontuário e Faturamento. O especialista de Faturamento identifica que a regra de preço proposta conflita com um contrato de operadora de saúde existente — algo que Carla não tinha como saber. A camada de arquitetura é avaliada pelo arquiteto, que valida que o schema do evento "ConsultaRealizada" pode ser estendido sem quebrar os sistemas que já o consomem. A especificação é ajustada antes de qualquer código ser escrito.

4. Após aprovação e implementação, a golden source é atualizada com os novos conceitos, eventos e regras. A próxima pessoa que trabalhar em Agendamento, Prontuário ou Faturamento já terá acesso a todo esse contexto.

### 6.3 Mudança Conceitual com Migração Gradual

**Contexto.** Uma reorganização do negócio exige que o bounded context de "Faturamento" seja dividido em "Cobrança" e "Receita."

**Aplicação do ZionKit.**

1. O diretor financeiro inicia uma sessão de Event Storming para mapear os fluxos que pertencem a cada novo contexto. "Emissão de boleto, negociação de inadimplência e régua de cobrança são Cobrança. Reconhecimento de receita, conciliação bancária e relatórios contábeis são Receita."

2. A alteração é radical. Via guardrails de versionamento, é registrada na golden source como mudança em transição (versão next), não alteração imediata. Os artefatos do contexto "Faturamento" (versão current) permanecem vigentes.

3. Novas especificações que tocam "Cobrança" ou "Receita" podem ser escritas contra a versão next. Especificações de manutenção do sistema existente continuam referenciando "Faturamento" (current).

4. A migração ocorre gradualmente. Cada spec implementada no novo modelo conceitual contribui para a transição. Quando todas as dependências de "Faturamento" forem migradas, a versão current é descontinuada.

---

## 7. Dores Endereçadas

| Dor | Como o ZionKit endereça |
|-----|------------------------|
| Conhecimento de domínio tácito, preso na cabeça de indivíduos | A golden source formaliza e versiona o conhecimento em documentos acessíveis a todos — ninguém precisa depender da memória de uma pessoa |
| Cada nova funcionalidade precisa reconstruir contexto do zero | A IA recebe automaticamente o conhecimento relevante da golden source antes de trabalhar em qualquer especificação |
| Usuários de negócio excluídos do processo de especificação | As pipelines de Event Storming e MARE permitem que pessoas não-técnicas participem descrevendo o negócio em linguagem natural, com a IA corrigindo inconsistências |
| Vocabulário inconsistente entre equipes e entre especificações | O glossário de linguagem ubíqua na golden source funciona como o dicionário oficial do produto — todos usam os mesmos termos com os mesmos significados |
| Decisões conceituais tomadas silenciosamente pela IA | O plano de alteração conceitual torna visíveis todas as mudanças que uma funcionalidade causa no conhecimento do produto, antes de qualquer código ser escrito |
| Decisões técnicas dispersas ou não documentadas | Os princípios técnicos constitucionais e os ADRs na golden source concentram todas as decisões técnicas em um único lugar versionado |
| Descobertas de domínio que se perdem após cada implementação | A retroalimentação formal devolve à golden source tudo que foi aprendido durante cada ciclo de construção |
| Mudanças radicais no domínio que causam efeito cascata | O versionamento gradual permite que mudanças grandes sejam aplicadas aos poucos, sem quebrar o que já funciona |
| Revisão de código como único momento de validação de qualidade | A aprovação dual (especialista de domínio + arquiteto) opera antes da implementação, verificando tanto a coerência de negócio quanto a viabilidade técnica |

---

## 8. Princípios de Design

**A golden source é viva, não estática.** Diferente de documentos tradicionais que são escritos uma vez e se desatualizam, a golden source é continuamente alimentada pelo uso. Na prática, isso significa que o repositório de conhecimento do produto fica mais rico e mais preciso a cada funcionalidade construída.

**O ciclo é bidirecional.** Informação flui da golden source para as especificações (como contexto) e das especificações de volta para a golden source (como retroalimentação). Na prática, isso significa que a documentação não é apenas consultada — ela é enriquecida de volta. O conhecimento cresce em vez de se degradar.

**Prevenção sobre detecção.** Ao confrontar a especificação do usuário com a golden source antes da geração de código, o modelo busca prevenir inconsistências conceituais em vez de detectá-las depois, em testes ou em produção. Na prática, isso significa que erros de entendimento sobre o negócio são capturados no momento mais barato de corrigi-los: antes de qualquer linha de código existir.

**Separação de autoridade.** O usuário de negócio tem autoridade sobre intenção de produto. O arquiteto tem autoridade sobre decisões técnicas e estruturais. A IA tem capacidade de processamento e consistência. O especialista de domínio tem autoridade sobre o significado dos conceitos do negócio. Nenhum dos quatro substitui os outros. Na prática, isso significa que cada decisão é validada por quem tem competência sobre ela.

**Alterações radicais são graduais.** Mudanças estruturais no domínio não propagam imediatamente. São versionadas e aplicadas por criticidade. Na prática, isso significa que uma mudança estrutural grande — como separar a área de Faturamento do produto em Cobrança e Receita — é refletida no sistema aos poucos, sem quebrar o que já funciona.

**Injeção seletiva de contexto.** A golden source completa não é enviada inteira para a IA a cada interação. Apenas os fragmentos relevantes para a tarefa em questão são carregados. Na prática, isso significa que a IA recebe apenas as informações que precisa para aquela especificação, evitando sobrecarga e mantendo a qualidade das respostas.

---

## 9. Riscos e Limitações Conhecidas

### 9.1 Qualidade do guardrail semântico

O modelo depende da capacidade da IA de identificar inconsistências entre o input do usuário e a golden source. Se a IA não detecta que um termo está sendo usado incorretamente ou que um requisito contradiz uma regra existente, o guardrail falha silenciosamente. A eficácia desse componente precisa ser validada empiricamente.

### 9.2 Injeção seletiva de contexto

Determinar automaticamente quais fragmentos da golden source são relevantes para uma especificação é um problema não trivial. Uma especificação que aparenta tocar apenas um bounded context pode ter implicações em outros. A qualidade da seleção de contexto afeta diretamente a qualidade do plano de alteração conceitual.

### 9.3 Custo de bootstrap

Organizações que não possuem nenhum conhecimento de domínio formalizado precisam investir na construção inicial da golden source. As pipelines de Event Storming e MARE reduzem esse custo mas não o eliminam. O retorno sobre o investimento se materializa ao longo de múltiplos ciclos de especificação, não imediatamente.

### 9.4 Disciplina de retroalimentação

O modelo depende de que a Etapa 3 seja efetivamente executada após cada implementação. Se equipes sob pressão de prazo começam a pular a retroalimentação, a golden source se desatualiza e o modelo degrada para SDD convencional sem camada semântica.

### 9.5 Disponibilidade de aprovadores

O gate de aprovação do plano de alteração conceitual depende de domain experts e arquitetos disponíveis e engajados. Em organizações onde esses papéis são escassos ou sobrecarregados, o gate pode se tornar gargalo. A mitigação natural é que nem toda spec gera plano de alteração conceitual — specs que consomem a golden source sem alterá-la podem fluir sem esse gate. Adicionalmente, a aprovação dual é roteada: specs que afetam apenas uma camada exigem apenas o aprovador correspondente.

---

## 10. Direções para Prototipação

O modelo conceitual sugere as seguintes prioridades para validação experimental:

1. **Pipeline de Event Storming Conversacional.** Componente mais tangível e demonstrável. Validar, com um usuário de negócio real, se ele consegue — através de conversa guiada com a IA — produzir um mapa de processos, eventos e áreas do negócio que ele próprio reconheça como fiel à realidade do produto. Essa validação deve envolver alguém sem formação técnica para confirmar que o processo é acessível.

2. **Guardrail semântico com golden source existente.** Criar uma golden source mínima (glossário de 20-30 termos, 3-4 bounded contexts, 10-15 regras de negócio) e testar se a IA consegue detectar inconsistências quando um usuário escreve uma especificação com termos incorretos ou requisitos contraditórios.

3. **Geração automática do plano de alteração conceitual.** Testar se, dada uma especificação e uma golden source, a IA consegue produzir automaticamente um plano de alteração que identifique corretamente quais conceitos são afetados e quais aprovadores precisam ser consultados.

4. **Validação do plano de alteração por aprovadores reais.** Apresentar um plano de alteração conceitual gerado pela IA a um especialista de domínio e a um arquiteto reais, e avaliar se o artefato é compreensível, se cobre os impactos relevantes, e se a separação entre camada de negócio e camada de arquitetura é clara o suficiente para que cada aprovador identifique rapidamente o que é sua responsabilidade.

5. **Ciclo completo em escopo reduzido.** Executar as três etapas em um domínio simples (3 bounded contexts, 1 funcionalidade) e avaliar se a golden source resultante é efetivamente mais rica e útil após um ciclo completo.

---

*ZionKit — Versão 0.4 do modelo conceitual. Documento gerado como registro de insights para prototipação futura.*
