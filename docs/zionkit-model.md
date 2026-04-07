# ZionKit: Um Corpo de Conhecimento Vivo para Desenvolvimento de Software Orientado por Especificações

**Status do modelo**: Protótipo conceitual  
**Versão do documento**: 0.5 — Abril 2026  

---

## Resumo Executivo

**Em uma frase:** ZionKit é um modelo que garante que todo o conhecimento de um produto — suas regras, seu vocabulário, seus processos — guie automaticamente o que a inteligência artificial constrói, e que cada construção enriqueça esse conhecimento de volta.

ZionKit é um modelo de desenvolvimento de software assistido por inteligência artificial que introduz uma **Product Canon (Cânone de Produto — fonte central de verdade)** sobre o domínio do produto e como ele funciona — como camada de primeira classe entre o conhecimento de domínio de negócio e a geração de código. O modelo opera sobre uma tríade de padrões oficiais (detalhada na seção 2) e em um ciclo fechado de três etapas: Canon Building — construção e manutenção assistida da Product Canon por Domain Builders (Construtores de Domínio) e Architects (Arquitetos), através de três cerimônias formais com Canonical Change Plans (Planos de Mudança Canônicos) aprovados, cujos artefatos seguem o formato canônico IEEE 29148 + SBE e são submetidos a validação semântica interna; criação de especificações contextualizadas com um Canonical Change Plan incremental aprovado condicionalmente, no formato canônico IEEE 29148 + SBE; e retroalimentação formal da Product Canon com as descobertas emergentes de cada ciclo. A IA opera sem autonomia decisória — propõe e sinaliza, humanos decidem.

O ZionKit resolve três problemas estruturais observados nos processos atuais de desenvolvimento assistido por IA: a ausência de uma camada viva de conhecimento de domínio e de arquitetura que sirva de contexto para especificações, a exclusão de usuários não-técnicos do processo de especificação de requisitos, e a inexistência de mecanismos formais que conectem o aprendizado de cada ciclo de implementação de volta ao conhecimento do produto.

O modelo ainda não foi testado em ambiente de produção e encontra-se em fase de prototipação conceitual.

---

## 1. Problema

### 1.1 O vazio entre conhecimento de negócio e especificação técnica

Nos processos atuais de desenvolvimento assistido por IA, o conhecimento de domínio de negócio existe de forma fragmentada: em documentos dispersos, na memória tácita de engenheiros seniores, em conversas não registradas entre stakeholders, ou em wikis desatualizadas. Quando um agente de IA recebe uma especificação de feature para gerar código, ele opera sem acesso formal a esse conhecimento. A consequência é que cada especificação precisa reconstruir contexto de domínio do zero, ou aceitar que decisões serão tomadas silenciosamente pelo agente com base em suposições não declaradas.

**Cenário ilustrativo.** Uma equipe de e-commerce precisa implementar uma feature de "reembolso parcial". O engenheiro escreve uma especificação para o agente de IA. No entanto, o conceito de "reembolso" tem regras específicas no domínio do produto: reembolsos acima de determinado valor exigem aprovação hierárquica, reembolsos de itens promocionais seguem regras diferentes, e o termo "parcial" tem significado distinto dependendo de se refere ao valor ou aos itens do pedido. Nenhuma dessas restrições está formalizada em um artefato acessível ao agente. O código gerado funciona, mas viola regras de negócio que só seriam descobertas em produção.

### 1.2 A exclusão do Domain Builder

Os frameworks de desenvolvimento orientados por especificação assumem que quem escreve especificações é um engenheiro sênior ou um arquiteto de especificações. Domain Builders — product owners, analistas de produto, gestores de operações — conhecem o produto e suas regras, mas frequentemente não possuem o vocabulário técnico ou a precisão terminológica necessária para produzir especificações que agentes de IA possam consumir com segurança.

O resultado é uma de duas situações: ou o Domain Builder é excluído do processo e suas intenções são traduzidas (com perda) por intermediários técnicos, ou ele participa diretamente e produz especificações ambíguas, contraditórias ou que utilizam termos inconsistentes com o vocabulário estabelecido do domínio.

**Cenário ilustrativo.** Um product owner descreve uma nova regra: "clientes inativos não devem receber promoções." Porém, na linguagem ubíqua do domínio, "cliente inativo" tem uma definição precisa (sem compras nos últimos 12 meses e sem login nos últimos 6 meses) que difere da intuição do product owner, que pensava apenas em "quem não compra há algum tempo." Sem um mecanismo que confronte o input do usuário com as definições existentes, a especificação é gerada com uma definição implícita incorreta.

### 1.3 O conhecimento que se perde a cada ciclo

Cada ciclo de implementação de uma feature gera descobertas sobre o domínio: conceitos que precisam ser refinados, regras que não estavam documentadas, bounded contexts que precisam ser reorganizados, decisões arquiteturais que afetam o entendimento do negócio. Nos processos atuais, essas descobertas morrem na especificação descartável ou no código gerado. Não há mecanismo formal para que o aprendizado de uma implementação retroalimente o corpo de conhecimento do produto, enriquecendo o contexto disponível para especificações futuras.

**Cenário ilustrativo.** Durante a implementação de um sistema de notificações, a equipe descobre que o conceito de "preferência do usuário" precisa ser separado em "preferência de canal" (email, SMS, push) e "preferência de conteúdo" (marketing, transacional, operacional). Essa descoberta é relevante para qualquer feature futura que toque notificações. No entanto, sem retroalimentação formal, a próxima equipe que trabalhar nesse domínio não terá acesso a essa decomposição e pode repetir o mesmo erro conceitual.

---

## 2. O Modelo ZionKit

O ZionKit resolve os problemas descritos acima criando um repositório central onde todo o conhecimento do produto — suas regras, seu vocabulário, seus processos, suas decisões técnicas — fica formalizado, versionado e acessível. Quando alguém pede para a IA construir algo, ela consulta esse repositório para garantir que o que será construído respeita o que já foi definido para o produto. E quando a construção revela algo novo sobre o domínio, esse aprendizado volta para o repositório, enriquecendo o contexto disponível para todos.

Em termos mais precisos, o ZionKit propõe uma arquitetura de conhecimento em camadas com ciclo bidirecional, onde a Product Canon serve simultaneamente como repositório vivo de conhecimento de domínio e como infraestrutura de contexto para especificações de software.

#### Tríade de padrões oficiais

O ZionKit v0.6 opera com uma tríade formal de padrões oficiais com papéis e visibilidades distintas:

- **SBVR (Semantics of Business Vocabulary and Business Rules)** — motor interno de validação semântica (invisível ao participante). Responsável por detectar ambiguidade, incompletude, contradição e redundância na expressão individual de requisitos. A IA utiliza SBVR internamente como metodologia principal de validação, mas não exclusiva — outras metodologias de validação podem ser utilizadas desde que os resultados sejam apresentados em linguagem natural.
- **IEEE 29148 (ISO/IEC/IEEE 29148:2018)** — formato canônico de estrutura (visível ao participante). Responsável por organizar requisitos com tipo, identificador, rastreabilidade e classificação, cobrindo categorias que o SBVR não alcança (requisitos não-funcionais, interfaces, restrições de design). A aderência ao IEEE 29148 é adaptativa, com três níveis (Mínimo, Moderado, Completo) definidos pelo Architect.
- **SBE (Specification by Example)** — formato canônico de verificação (visível ao participante). Responsável por transformar cada requisito em cenários concretos (Dado/Quando/Então) compreensíveis por pessoas de negócio e executáveis como testes. Obrigatório em todos os níveis de aderência.

Cada padrão tem responsabilidade única e delimitada: SBVR detecta, IEEE 29148 estrutura, SBE verifica. O formato canônico visível nos artefatos da Product Canon e nos Canonical Change Plans é IEEE 29148 + SBE.

### 2.1 A Product Canon

A Product Canon é um conjunto versionado de artefatos (documentos estruturados) que representam o conhecimento de domínio do produto em duas camadas complementares.

**Camada de Negócio.** Contém artefatos legíveis por pessoas não-técnicas, escritos em linguagem natural estruturada:

- **Glossário de linguagem ubíqua**: definições precisas dos termos do domínio — o vocabulário oficial do produto, onde cada palavra tem um significado acordado por todos. Cada termo é associado ao bounded context (a área do negócio) onde tem validade.
- **Regras de negócio declarativas**: restrições, políticas e invariantes do domínio, expressas em linguagem natural com critérios verificáveis. Por exemplo: "Reembolsos acima de R$ 500 exigem aprovação do gerente."
- **Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE (Specification by Example)**: requisitos de software produzidos e mantidos através de processos assistidos de formalização, com completude e consistência validadas internamente pela IA utilizando metodologias como SBVR (Semantics of Business Vocabulary and Business Rules).

  IEEE 29148 (ISO/IEC/IEEE 29148:2018) fornece a taxonomia para classificar requisitos (funcionais, não-funcionais, de interface, de design, restrições), atributos obrigatórios por requisito (identificador único, rastreabilidade, prioridade, verificabilidade) e critérios de qualidade. A adoção é motivada pela maturidade do padrão e pela familiaridade dos LLMs com sua taxonomia.

- **Fluxos de domínio**: representações dos processos de negócio — o que acontece, em que ordem, quem faz o quê — derivados de sessões de Event Storming (uma técnica colaborativa de mapeamento de processos, descrita na seção 2.2.1).

**Camada de Arquitetura.** Contém artefatos que formalizam as decisões técnicas e estruturais do sistema:

- **Princípios técnicos constitucionais**: as regras técnicas imutáveis do projeto — quais tecnologias usar, como os componentes se comunicam, como os dados são protegidos. Funcionam como o equivalente técnico do glossário de linguagem ubíqua: toda especificação deve respeitá-los ou justificar formalmente a exceção. Incluem o nível de aderência IEEE 29148 configurado para cada bounded context.
- **Bounded contexts** (contextos delimitados): fronteiras lógicas que separam áreas do negócio com vocabulário e regras próprias. Por exemplo, "Pagamentos" e "Notificações" são contextos diferentes com responsabilidades distintas.
- **Eventos de domínio**: catálogo dos fatos relevantes que acontecem no sistema — "PagamentoConfirmado", "PedidoCancelado" — com a descrição formal de quais dados cada evento carrega (seu schema) e quais áreas os consomem.
- **Context maps** (mapas de contexto): representação visual e formal de como os bounded contexts se relacionam entre si — quais dependem de quais, como trocam informações, onde há fronteiras de proteção.
- **Architecture Decision Records (ADRs)**: registros formais de decisões técnicas importantes — o que foi decidido, por quê, quais alternativas foram consideradas e quais são as consequências. Servem como memória técnica do produto sobre as escolhas feitas e suas justificativas.

A Product Canon não é um documento estático produzido em uma fase inicial de projeto. É um artefato vivo, continuamente construído e atualizado, que evolui com o sistema. A Product Canon é um artefato versionado que evolui a cada ciclo de Canon Building (Construção do Cânone).

A organização física/interna da Product Canon é deliberadamente mínima nesta fase de prototipação, sem compromisso com hierarquia final (ver seção 5 — Estrutura de Artefatos).

Artefatos da Product Canon podem conter metadados de hotspot de domínio (autor, data, descrição) e histórico de anotações de aprovação, enriquecendo o contexto disponível para especificações futuras.

### 2.2 Etapa 1 — Canon Building (Construção e Manutenção da Product Canon)

O Domain Builder e o Architect constroem e mantêm a Product Canon de forma complementar, através de três cerimônias formais organizadas em um fluxo sequencial com gates de aprovação:

1. **Domain Discovery Session (Sessão de Descoberta de Domínio)** → Canonical Change Plan aprovado →
2. **Technical Constitution Session (Sessão de Constituição Técnica)** → Canonical Change Plan aprovado →
3. **Requirements Specification Session (Sessão de Especificação de Requisitos)** → Canonical Change Plan aprovado →
4. **Decisão de Continuidade do Ciclo**

Cada Canonical Change Plan requer aprovação primária pelo papel com expertise na cerimônia correspondente, e aprovação secundária assíncrona com janela de veto pelo outro papel humano. Somente após a aprovação do Change Plan de uma cerimônia a próxima cerimônia é habilitada.

O Domain Builder é responsável pela camada de negócio — glossário, regras, requisitos e fluxos — através de interações em linguagem natural nas cerimônias conversacionais. O Architect é responsável pela camada de arquitetura — princípios técnicos constitucionais, context maps, ADRs e validação técnica dos bounded contexts propostos pelo Event Storming. Os dois papéis colaboram no ponto onde as camadas se encontram: a definição e delimitação de bounded contexts, que possui dimensão tanto semântica quanto técnica.

#### 2.2.1 Domain Discovery Session

O Domain Builder é guiado por uma cerimônia conversacional que replica a dinâmica de uma sessão de Event Storming. Em vez de post-its em uma parede, o Domain Builder descreve fluxos de negócio em linguagem natural, e o agente de IA ajuda a identificar e organizar os elementos estruturais.

O processo segue o fluxo canônico do Event Storming:

1. **Descoberta de eventos de domínio.** O Domain Builder descreve o que acontece no negócio. O agente identifica eventos (fatos que ocorreram, expressos no passado: "Pedido Criado", "Pagamento Confirmado", "Entrega Realizada") e os organiza em uma timeline.
2. **Identificação de comandos e atores.** Para cada evento, o agente investiga o que o causou (comando) e quem o disparou (ator humano, sistema externo ou política automatizada).
3. **Mapeamento de agregados e bounded contexts.** Com o fluxo mapeado, o agente propõe agrupamentos de eventos e comandos que formam agregados coesos, e sugere delimitações de bounded contexts com base em fronteiras naturais do negócio.
4. **Decomposição de casos de uso.** Os fluxos identificados são decompostos em casos de uso concretos com pré-condições, pós-condições e fluxos alternativos.

A saída da Domain Discovery Session é um Canonical Change Plan tipado como `discovery-plan`. O Canonical Change Plan produzido requer aprovação primária do Domain Expert (Especialista de Domínio) — que valida a fidelidade semântica ao domínio — e aprovação secundária do Architect — que valida a viabilidade técnica, incluindo a validação de bounded contexts e context map. Somente após a aprovação a próxima cerimônia (Technical Constitution Session) é habilitada.

**Exemplo — perspectiva do Domain Builder.** Um gestor de operações de uma fintech descreve: "Quando um cliente pede pra sacar dinheiro, a gente verifica se tem saldo, se tem limite diário disponível, e se não tem nenhum bloqueio judicial. Se tudo ok, o saque é processado e o cliente recebe uma notificação." A partir dessa descrição, o agente identifica os eventos (SaqueSolicitado, SaldoVerificado, LimiteValidado, BloqueioVerificado, SaqueProcessado, NotificaçãoEnviada), os comandos (SolicitarSaque, VerificarSaldo, ValidarLimite, VerificarBloqueio, ProcessarSaque, EnviarNotificação), os atores (Cliente, Sistema de Compliance) e propõe bounded contexts (Conta, Compliance, Notificações).

**Exemplo — perspectiva do Architect.** O Architect avalia a proposta de bounded contexts e identifica que a verificação de bloqueio judicial (Compliance) precisa ser síncrona com o processamento de saque (Conta), pois um saque não pode ser processado antes da verificação completar. Decide que a comunicação entre esses dois contextos será via chamada síncrona interna, enquanto a comunicação com Notificações será assíncrona via evento. Essa decisão é registrada como ADR fundacional e o mapa de contexto é atualizado.

#### 2.2.2 Technical Constitution Session

A Technical Constitution Session é uma cerimônia conduzida pelo Architect, focada na definição dos princípios técnicos constitucionais e ADRs estratégicos que governam o produto. Diferente da Domain Discovery Session — que mantém fases explícitas do Event Storming — a Technical Constitution Session opera sem fases rígidas, seguindo diretrizes de condução adaptadas ao contexto do projeto.

A cerimônia é habilitada pela aprovação do Canonical Change Plan produzido pela Domain Discovery Session. O Architect utiliza as estruturas de domínio descobertas (bounded contexts, eventos, agregados) como insumo para definir as restrições técnicas que governam todas as especificações futuras: stack tecnológica, padrões de comunicação entre contextos, estratégias de persistência, políticas de segurança e requisitos de observabilidade. O Architect define também o nível de aderência IEEE 29148 (ver níveis de aderência) como parte dos princípios técnicos constitucionais.

A aplicação do IEEE 29148 é proporcional à maturidade do produto e ao contexto do ciclo, através de três níveis de aderência definidos pelo Architect nos princípios técnicos constitucionais:

- **Mínimo** — produto novo, prototipação, discovery inicial: tipo de requisito, descrição em linguagem natural estruturada, critérios SBE.
- **Moderado** — produto em crescimento, após 2–3 ciclos de Canon Building: adiciona subtipo, rastreabilidade para Change Plans, dependências entre requisitos.
- **Completo** — produto maduro, domínios regulados, integrações complexas: aplicação integral da taxonomia IEEE 29148 com rastreabilidade bidirecional, atributos de qualidade, seções de interface e restrição de design.

O nível pode variar por bounded context — um contexto maduro pode operar em nível Completo enquanto um contexto novo opera em nível Mínimo. O SBE (Dado/Quando/Então) é obrigatório em todos os níveis.

A saída é um Canonical Change Plan tipado como `constitution-plan`. A aprovação é primária pelo Architect — que valida a adequação técnica dos princípios — e secundária pelo Domain Expert — que valida que os princípios não restringem indevidamente as necessidades de negócio. Somente após a aprovação a próxima cerimônia (Requirements Specification Session) é habilitada.

**Exemplo de princípios técnicos constitucionais** — tipo de artefato produzido pela Technical Constitution Session:

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

REQUISITOS
  - Nível de aderência IEEE 29148: Mínimo (produto em fase de 
    prototipação)
  - SBE obrigatório em todos os requisitos funcionais
```

Esses princípios funcionam como o glossário de linguagem ubíqua funciona para a camada de negócio: quando uma especificação propõe comunicação síncrona entre dois bounded contexts, a IA sinaliza a violação do princípio constitucional e exige justificativa — que, se aprovada pelo Architect, é registrada como ADR.

#### 2.2.3 Requirements Specification Session

A Requirements Specification Session é uma cerimônia conversacional de formalização de requisitos, produzindo requisitos no formato IEEE 29148 com critérios de aceitação SBE (Specification by Example). A cerimônia opera em dois níveis — regra individual e documento — sem fases rígidas, seguindo diretrizes de condução.

No nível de regras individuais: (1) o Domain Builder descreve o requisito em linguagem natural; (2) a IA ativa simultaneamente todos os mecanismos de validação — Clarificação de Conformidade, validação semântica interna (incluindo SBVR), Validação de Consistência, Padronização Canônica; (3) a IA consolida problemas detectados e apresenta perguntas de clarificação em linguagem natural; (4) o Domain Builder refina o requisito em ciclo iterativo; (5) a IA formaliza o requisito no formato canônico IEEE 29148 + SBE; (6) o Domain Builder valida o resultado em linguagem natural estruturada. No nível de documento: ao final da sessão, a IA utiliza a taxonomia IEEE 29148 para verificar completude estrutural do conjunto de requisitos, sinalizando categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) — como sinalização, não como bloqueio. O objetivo é produzir requisitos simultaneamente compreensíveis por pessoas de negócio e formalmente precisos para consumo por agentes de IA.

A cerimônia é habilitada pela aprovação do Canonical Change Plan produzido pela Technical Constitution Session. A saída é um Canonical Change Plan tipado como `specification-plan`, contendo requisitos em formato IEEE 29148 + SBE. A aprovação é primária pelo Domain Expert — que valida a fidelidade semântica — e secundária pelo Architect — que realiza avaliação técnica de requisitos. Somente após a aprovação a Decisão de Continuidade do Ciclo é habilitada.

**Exemplo — clarificação e formalização.** O Domain Builder descreve: "O cliente deve poder cancelar um pedido antes do faturamento." A IA, utilizando validação semântica interna, detecta que a expressão não define o que "antes do faturamento" significa em termos de status do pedido, e apresenta uma pergunta de clarificação: "Quais status de pedido permitem cancelamento? Apenas Pendente, ou também Confirmado?" O Domain Builder esclarece: "Pendente e Confirmado." A IA, consultando a Product Canon, identifica que já existe uma regra: "Pedidos faturados não podem ser cancelados, apenas devolvidos." A IA apresenta essa regra e sugere incluir o caminho de devolução. O requisito é formalizado em IEEE 29148 + SBE:

**REQ-CANCEL-001** | Tipo: Funcional | Contexto: Pedidos | Prioridade: Alta
*O sistema deve permitir que o Cliente titular cancele um Pedido cujo status é Pendente ou Confirmado. Pedidos com status Faturado não podem ser cancelados — o caminho alternativo é a devolução (ver REQ-RETURN-003).*
**Cenário SBE:** Dado um Pedido com status 'Confirmado' pertencente ao Cliente titular / Quando o Cliente solicita cancelamento / Então o status do Pedido muda para 'Cancelado' e o evento PedidoCancelado é emitido.

#### 2.2.4 Decisão de Continuidade do Ciclo

Ao final do fluxo de Canon Building — após a aprovação do Canonical Change Plan da Requirements Specification Session — o ciclo chega a um ponto de decisão explícito. Três caminhos são possíveis:

a) **Mapear mais fluxos e contextos** → volta para Domain Discovery Session
b) **Formalizar mais requisitos** → volta para Requirements Specification Session
c) **Encerrar ciclo** → prosseguir para Etapa 2

A autoridade sobre essa decisão é do Domain Builder, com input da IA sobre cobertura. A IA pode sinalizar áreas não mapeadas ou requisitos pendentes — por exemplo, bounded contexts mencionados mas não explorados, ou fluxos de negócio referenciados sem decomposição — mas **não decide** se o ciclo deve continuar ou encerrar. A decisão é sempre humana.

#### 2.2.5 Guardrails da Product Canon

A manutenção da Product Canon requer guardrails que garantam sua integridade ao longo do tempo.

**Clarificação de Conformidade (Compliance Clarification).** Quando um participante utiliza termos que divergem do vocabulário formalizado na Product Canon — incluindo o glossário de linguagem ubíqua e os princípios técnicos constitucionais — o agente sinaliza a divergência e propõe alinhamento. Se o participante utiliza "cliente" onde a Product Canon define "titular da conta", o agente identifica a inconsistência e pede confirmação sobre a intenção. Este guardrail atua nas sessões de Domain Discovery e Technical Constitution. Quando uma especificação ou edição toca um trecho marcado como hotspot de domínio, a IA exibe proativamente a definição precisa e alerta sobre a incerteza registrada, priorizando esses pontos na clarificação.

**Validação de consistência.** Alterações em requisitos ou regras de negócio são confrontadas com o estado atual da Product Canon, incluindo tanto as regras de negócio quanto os princípios técnicos constitucionais. Contradições em qualquer uma das camadas são identificadas antes de serem aceitas.

**Validação semântica interna.** A IA utiliza internamente metodologias de validação semântica — incluindo SBVR para detecção de ambiguidade estrutural, incompletude de predicados e indefinição de participantes — para analisar a expressão individual de cada requisito. Os problemas detectados são apresentados ao participante como perguntas de clarificação em linguagem natural, nunca como notação formal. SBVR é a metodologia principal de validação interna, mas não exclusiva — a IA pode utilizar outras metodologias (análise de dependências entre bounded contexts, verificação de completude de fluxos, análise de cobertura de cenários de erro) desde que os resultados sejam apresentados em linguagem natural.

**Padronização Canônica (Canonical Formatting).** Garante que toda escrita na Product Canon esteja no formato canônico IEEE 29148 + SBE aderido pelo modelo. Valida duas dimensões: IEEE 29148 (o requisito está estruturado com os atributos obrigatórios conforme o nível de aderência configurado, classificado na taxonomia correta) e SBE (cada requisito funcional possui cenários de aceitação concretos Dado/Quando/Então). O guardrail opera em dois modos: nas cerimônias de Canon Building, a padronização é parte integrante da mediação da IA (modo implícito); na edição direta pelo Domain Expert, o guardrail é explícito — o Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O guardrail respeita o nível de aderência IEEE 29148 configurado pelo Architect: em nível Mínimo valida apenas tipo + descrição + SBE; em nível Moderado adiciona subtipo, rastreabilidade e dependências; em nível Completo valida conformidade integral.

**Versionamento Gradual por Estrangulamento (Strangler Fig).** Nem toda alteração na Product Canon deve ser refletida imediatamente. Inspirado no padrão Strangler Fig de Martin Fowler, mudanças estruturais significativas — como a divisão de um bounded context, a redefinição de um conceito central ou a remoção de um evento de domínio — devem ser versionadas e aplicadas gradualmente, por criticidade. A Product Canon mantém duas faces: o estado vigente (current) e o estado aprovado em transição (next). Especificações de manutenção referenciam current; especificações de novos produtos podem referenciar next. Canonical Change Plans aprovados são integrados à Product Canon via este mecanismo.

**Exemplo.** A equipe decide que o bounded context de "Faturamento" precisa ser dividido em "Cobrança" e "Receita." Essa alteração não é aplicada atomicamente. Ela é registrada como uma mudança em transição na Product Canon. Especificações existentes continuam referenciando "Faturamento" até que a migração seja completada. Novas especificações para os contextos separados podem ser escritas contra a versão next, que já reflete a divisão.

#### 2.2.6 Edição Direta do Domain Expert

O Domain Expert pode editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal. A edição direta é um canal complementar de manutenção, não de rotina, para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais.

As salvaguardas que preservam a primazia das cerimônias formais são: (a) escopo limitado à camada de negócio — artefatos de arquitetura permanecem exclusivos do Architect; (b) natureza restrita a refinamentos e correções de artefatos existentes — conceitos inteiramente novos requerem cerimônia completa; (c) o Domain Expert propõe edições em linguagem natural ou formato livre, e a IA formaliza no formato canônico IEEE 29148 + SBE (ver Guardrail de Padronização Canônica na seção 2.2.5); (d) tipagem distinta do Change Plan (`expert-edit-plan`) permite auditoria e análise de frequência; (e) aprovação do Architect obrigatória e não delegável — diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente, introduzindo fricção deliberada; (f) guardrails operam antes do Change Plan, não depois — divergências são resolvidas antes de o artefato ser empacotado para aprovação. Se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal detectável de que o processo formal está sendo contornado.

O fluxo operacional da edição direta é descrito nas subseções seguintes.

##### Fluxo de Guardrails na Edição Direta

Quando o Domain Expert propõe uma edição direta, um ciclo iterativo de guardrails opera antes da geração de qualquer Canonical Change Plan:

1. O Domain Expert propõe a alteração em linguagem natural ou formato livre.
2. A IA executa simultaneamente todos os mecanismos de validação — Clarificação de Conformidade (alinhamento terminológico), validação semântica interna (incluindo SBVR, para ambiguidade e incompletude), Validação de Consistência (contradições com regras existentes) — e o Guardrail de Padronização Canônica (reescrita no formato IEEE 29148 + SBE).
3. A IA apresenta ao Domain Expert: perguntas de clarificação em linguagem natural; a versão formalizada como proposta (não como alteração consumada); e um Relatório de Conformidade consolidando divergências, contradições e impactos em bounded contexts adjacentes.
4. O Domain Expert decide: aceitar a formalização, solicitar ajustes, responder perguntas de clarificação, ou reescrever a edição original e submeter novamente.
5. O ciclo se repete até que o Domain Expert aceite a versão formalizada e as divergências sejam resolvidas ou explicitamente justificadas.

O Relatório de Conformidade pode assumir forma estática (documento estruturado) ou forma conversacional (sessão interativa), à escolha do Domain Expert. Somente após a conclusão do ciclo, o `expert-edit-plan` é gerado.

##### `expert-edit-plan` e Aprovação Sequencial

A saída do processo de edição direta é um Canonical Change Plan tipado como `expert-edit-plan`, contendo: a versão final formalizada em IEEE 29148 + SBE; o Relatório de Conformidade final; divergências intencionais flagradas; e impactos em bounded contexts adjacentes.

O `expert-edit-plan` requer aprovação sequencial com ordem fixa:

1. **Domain Expert** aprova primeiro — valida que a formalização IEEE 29148 + SBE contida no Change Plan preserva fielmente a intenção original. Embora o Domain Expert já tenha revisado a formalização no ciclo iterativo de guardrails, esta aprovação mitiga o risco de que a IA, ao consolidar o Change Plan, tenha alterado o significado.
2. **Architect** aprova depois — avalia impacto técnico: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais. A aprovação do Architect é obrigatória e não delegável.

A ordem é derivada da lógica do modelo: fidelidade semântica é pré-requisito para avaliação técnica. Se o Architect aprovasse primeiro, avaliaria impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção. A tipagem distinta (`expert-edit-plan`) permite auditoria de frequência — crescimento excessivo da proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` sinaliza contorno do processo formal.

### 2.3 Etapa 2 — Especificação Contextualizada com Canonical Change Plan Incremental

Nesta etapa, um Domain Builder ou um Architect escreve uma especificação de feature para um produto novo ou existente. A especificação é criada utilizando ferramentas de Spec-Driven Development existentes e consome contexto de ambas as camadas da Product Canon. O Domain Builder define a intenção de produto; o Architect toma decisões técnicas dentro da spec — escolha de padrões de integração, estratégias de persistência, schemas — orientado pelos princípios técnicos constitucionais da Product Canon.

A base conceitual do produto já foi aprovada no Canon Building. O Canonical Change Plan da Etapa 2 é **incremental** — captura apenas impactos emergentes que só se tornam visíveis quando uma especificação concreta é escrita contra a Product Canon. Mudanças fundamentais (novos termos, novas regras, novos bounded contexts) já foram tratadas no Canon Building.

#### 2.3.1 Injeção de Contexto da Product Canon

A especificação não é escrita no vazio. O agente de IA injeta seletivamente na janela de contexto os fragmentos relevantes da Product Canon: o glossário do bounded context afetado, os eventos de domínio publicados e consumidos, as regras de negócio aplicáveis, os ADRs relevantes e os requisitos existentes relacionados.

Essa injeção seletiva é necessária porque a Product Canon completa pode exceder os limites de contexto efetivos dos modelos de linguagem. O agente identifica quais bounded contexts são tocados pela especificação e carrega apenas os artefatos pertinentes.

#### 2.3.2 Clarificação e Validação Contextualizada

Assim como na Etapa 1, a especificação de feature é submetida a clarificação e validação com base na Product Canon. Termos inconsistentes são sinalizados. Requisitos que contradizem regras de negócio existentes são flagrados. Dependências entre bounded contexts são identificadas.

**Exemplo.** Um engenheiro escreve uma especificação para "adicionar método de pagamento PIX ao checkout." O agente, com contexto da Product Canon, identifica que o bounded context de Pagamentos publica o evento "PagamentoConfirmado" com um schema que não inclui campos específicos de PIX. A especificação precisa declarar se o schema será estendido ou se um novo evento será criado. Essa decisão não pode ser tomada silenciosamente pelo agente — ela tem impacto conceitual.

#### 2.3.3 Canonical Change Plan Incremental

Quando a IA identifica que uma nova funcionalidade vai causar mudanças emergentes no conhecimento formalizado do produto — um ajuste em definição existente, uma extensão de schema, um novo ADR — ela gera automaticamente um **Canonical Change Plan incremental**. O propósito desse artefato é tornar visível, antes de qualquer código ser escrito, quais mudanças uma nova funcionalidade causa na Product Canon que não foram antecipadas no Canon Building.

Em termos de mecânica, o plano funciona como um "diff semântico" — uma comparação entre o estado atual da Product Canon e o estado que ela terá após a implementação. Ele é organizado em duas seções — **alterações na camada de negócio** e **alterações na camada de arquitetura** — tornando explícito qual aprovador é responsável por qual seção. O plano lista conceitos novos que serão introduzidos, definições existentes que serão alteradas, eventos de domínio que serão criados ou modificados, bounded contexts que serão afetados, princípios técnicos que serão impactados, e ADRs que precisam ser registrados. O Canonical Change Plan incremental contém requisitos no formato IEEE 29148 + SBE. O modelo define quatro tipos de Canonical Change Plan — `discovery-plan`, `constitution-plan`, `specification-plan` e `expert-edit-plan` — cada um originado em uma cerimônia ou canal distinto; o `expert-edit-plan` corresponde a planos de mudança originados por edição direta do Domain Expert (seção 2.2.6).

**Exemplo de Canonical Change Plan incremental:**

```
CANONICAL CHANGE PLAN INCREMENTAL — Spec: PIX no Checkout
================================================================

CAMADA DE NEGÓCIO (aprovação: Domain Expert)
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

CAMADA DE ARQUITETURA (aprovação: Architect)
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

#### 2.3.4 Aprovação Condicional

A aprovação na Etapa 2 é **condicional**: só se o Canonical Change Plan incremental contiver impactos na Product Canon. Se o Change Plan for vazio — a especificação consome a Product Canon sem alterá-la — a aprovação é dispensada e a especificação pode fluir diretamente para implementação.

Se houver impacto, a aprovação é roteada por camada afetada: o Domain Expert aprova alterações na camada de negócio, e o Architect aprova alterações na camada de arquitetura. Especificações que afetam ambas as camadas exigem as duas aprovações, sinalizando corretamente a maior complexidade e risco dessas mudanças.

Em organizações com múltiplos bounded contexts, Domain Experts e Architects podem ser designados por contexto. O Canonical Change Plan incremental é roteado para o(s) responsável(is) do(s) contexto(s) afetado(s).

**Somente após a(s) aprovação(ões) pertinente(s) — quando necessárias — a IA implementa a especificação.**

### 2.4 Etapa 3 — Retroalimentação da Product Canon

Canonical Change Plans aprovados no Canon Building já são integrados à Product Canon via Versionamento Gradual por Estrangulamento — essa integração é parcialmente antecipada. A Etapa 3 concentra-se em **descobertas emergentes da implementação**: conceitos que precisaram ser refinados, regras não documentadas descobertas durante o código, decisões técnicas não previstas.

Uma vez que o Canonical Change Plan incremental da Etapa 2 foi aprovado (quando aplicável) e a especificação foi implementada, as alterações declaradas no plano são refletidas na Product Canon, junto com as descobertas emergentes do ciclo de implementação.

Essa etapa é mecanicamente segura porque não há ambiguidade sobre o que atualizar. Os múltiplos Canonical Change Plans aprovados — tanto os do Canon Building quanto o incremental da Etapa 2 — declararam explicitamente quais artefatos da Product Canon serão afetados e como. A retroalimentação é a materialização de decisões já tomadas, complementada pelas descobertas emergentes.

Os novos termos são adicionados ao glossário. Os eventos de domínio novos ou alterados são registrados no catálogo. As regras de negócio são incorporadas. Os ADRs são formalizados. Os princípios técnicos constitucionais são atualizados quando necessário. As alterações são versionadas e passam a integrar o corpo de contexto disponível para todas as especificações futuras.

Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building.

---

## 3. O Ciclo Completo

O ZionKit opera como um ciclo contínuo que se retroalimenta:

```
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 1                              │
│              Canon Building — Product Canon                  │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ Domain Discovery Session                             │    │
│  │   Domain Builder + IA (Event Storming)               │    │
│  │   → Canonical Change Plan (discovery-plan)           │    │
│  │   Gate: Domain Expert (1°) + Architect (2°)          │    │
│  └──────────────────────┬──────────────────────────────┘    │
│                         ▼                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ Technical Constitution Session                       │    │
│  │   Architect + IA                                     │    │
│  │   → Canonical Change Plan (constitution-plan)        │    │
│  │   Gate: Architect (1°) + Domain Expert (2°)          │    │
│  └──────────────────────┬──────────────────────────────┘    │
│                         ▼                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ Requirements Specification Session                   │    │
│  │   Domain Builder + IA (IEEE 29148 + SBE)              │    │
│  │   → Canonical Change Plan (specification-plan)       │    │
│  │   Gate: Domain Expert (1°) + Architect (2°)          │    │
│  └──────────────────────┬──────────────────────────────┘    │
│                         ▼                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ Decisão de Continuidade do Ciclo                     │    │
│  │   Domain Builder decide (IA sinaliza cobertura)      │    │
│  │   → Mais fluxos (↑ Discovery)                        │    │
│  │   → Mais requisitos (↑ Specification)                │    │
│  │   → Encerrar ciclo (↓ Etapa 2)                       │    │
│  └──────────────────────┬──────────────────────────────┘    │
│                                                             │
│  Guardrails: Clarificação de Conformidade,                  │
│    Validação de Consistência, Padronização Canônica,        │
│    Validação Semântica Interna,                             │
│    Versionamento por Estrangulamento                        │
└──────────────────────────┬──────────────────────────────────┘
                           │
   ┌───────────────────────────────────────────────────┐
   │ Canal Complementar: Edição Direta (Domain Expert) │
   │   Domain Expert + IA (expert-edit-plan)           │
   │   → Alterações pontuais na Product Canon          │
   │   Gate: Architect aprova expert-edit-plan          │
   │   Guardrails: ciclo iterativo de validação pela IA │
   └───────────────────────────────────────────────────┘
                           │
                contexto de ambas as
                  camadas injetado
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 2                              │
│     Especificação com Canonical Change Plan Incremental      │
│                                                             │
│  Domain Builder / Architect + IA + Product Canon            │
│  → Spec de feature contextualizada                          │
│  → Canonical Change Plan incremental (condicional)          │
│     (seção negócio + seção arquitetura)                     │
│  → Se houver impacto: aprovação por camada afetada          │
│     Domain Expert (negócio) / Architect (arquitetura)       │
│  → IA implementa código                                    │
└──────────────────────────┬──────────────────────────────────┘
                           │
                  alterações aprovadas +
                  descobertas emergentes
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                        ETAPA 3                              │
│            Retroalimentação da Product Canon                  │
│                                                             │
│  Change Plans do Canon Building: integração antecipada       │
│  via Versionamento por Estrangulamento                      │
│  Foco da Etapa 3: descobertas emergentes da implementação    │
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

Cada ciclo enriquece a Product Canon. Especificações futuras operam com contexto mais rico e preciso do que as anteriores. O conhecimento do produto não se perde em especificações descartáveis ou na memória tácita de indivíduos — ele se acumula formalmente.

---

## 4. Papéis no Modelo

O ZionKit define quatro papéis com autoridades complementares e não sobrepostas.

**Domain Builder.** Analista de negócio, product owner ou gestor de operações que conhece o produto e suas regras. Escreve em linguagem natural. Pode não ter precisão terminológica ou consciência de todas as implicações técnicas de suas decisões. No ZionKit, é o autor primário das cerimônias conversacionais: participa da Domain Discovery Session e da Requirements Specification Session (Etapa 1), escreve especificações de feature orientadas a produto (Etapa 2) e decide se o ciclo de Canon Building continua com mais cerimônias ou encerra. Seus gaps de vocabulário e consistência são compensados pelos guardrails da IA.

**Architect.** Detém autoridade sobre decisões técnicas e estruturais do sistema. Conduz a Technical Constitution Session como cerimônia formal (Etapa 1). É aprovador secundário nos gates de Domain Discovery e Requirements Specification, validando viabilidade técnica. É aprovador primário no gate de Technical Constitution. Suas atividades são distribuídas pelos gates de aprovação das cerimônias. Atua na Etapa 2 tomando decisões técnicas dentro de especificações e aprovando alterações na camada de arquitetura do Canonical Change Plan incremental. Funciona como guardião da integridade técnica — garante que toda mudança é compatível com os princípios constitucionais ou, quando não é, formaliza a exceção como ADR. Aprova obrigatoriamente e sem delegação cada `expert-edit-plan` originado por edição direta do Domain Expert, com foco no impacto técnico.

**IA (Agentes LLM — mediadores de cerimônias e guardrails).** Processa linguagem natural, mantém contexto de ambas as camadas da Product Canon, identifica inconsistências semânticas e técnicas, propõe clarificações, gera Canonical Change Plans, e implementa código. No ZionKit, a IA opera **sem autonomia decisória** — é um mediador entre a intenção dos participantes e a integridade do domínio e da arquitetura. Atos da IA dividem-se em:

- **Operacional** (permitido): formatar, sugerir, reorganizar, sinalizar inconsistência, usar metodologias de validação semântica (incluindo SBVR) internamente para detectar ambiguidades, incompletudes e contradições, traduzir os problemas detectados em perguntas de clarificação em linguagem natural, e conduzir o ciclo iterativo de guardrails na edição direta do Domain Expert
- **Decisório** (requer humano): incluir/excluir da Product Canon, aprovar Canonical Change Plan, resolver ambiguidade de domínio

**Domain Expert.** Detém autoridade sobre o significado dos conceitos do domínio. Funciona como guardião ativo da integridade semântica da Product Canon. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution. Durante a avaliação de qualquer Canonical Change Plan, pode adicionar **anotações contextuais** ao artefato sob revisão — observações sobre nuances de domínio, ressalvas sobre interpretações, ou esclarecimentos que enriquecem o registro. As anotações são registradas como parte do histórico de aprovação e são insumos formais para cerimônias futuras: a IA as apresenta como candidatos a formalização no próximo ciclo de Canon Building. Adicionalmente, o Domain Expert pode marcar áreas da Product Canon como **hotspots de domínio** — zonas que requerem atenção especial por serem frágeis, frequentemente mal interpretadas, ou com histórico de problemas. Hotspots são metadados no artefato afetado (autor, data, descrição), não impedem a aprovação, e são utilizados proativamente pela IA na Clarificação de Conformidade. Ganha capacidade de edição direta na camada de negócio da Product Canon (seção 2.2.6), propondo refinamentos e correções fora do contexto de cerimônias formais, com aprovação sequencial obrigatória (Domain Expert → Architect).

Em organizações com múltiplos bounded contexts, Domain Experts e Architects podem ser designados por contexto. O roteamento de aprovações é determinado pelos contextos e camadas afetados no Canonical Change Plan.

**Resumo de atuação por etapa:**

| Papel | Etapa 1 — Canon Building | Etapa 2 — Especificação | Etapa 3 — Retroalimentação | Edição Direta |
|-------|------------------------|------------------------|---------------------------|---------------|
| Domain Builder | Participa de Domain Discovery e Requirements Specification; decide continuidade do ciclo | Escreve especificação de feature | — | — |
| Architect | Conduz Technical Constitution Session; aprova secundariamente Discovery e Specification; aprova primariamente Constitution | Toma decisões técnicas na spec; aprova camada de arquitetura | — | Aprova `expert-edit-plan` (obrigatório, não delegável) |
| Domain Expert | Aprova primariamente Discovery e Specification; aprova secundariamente Constitution (com anotações e hotspots) | Aprova camada de negócio do Canonical Change Plan incremental (quando aplicável) (com anotações e hotspots) | — | Edita camada de negócio; resolve divergências com IA; aprova Change Plan consolidado |
| IA (Agentes LLM) | Conduz sessões, gera Canonical Change Plans, opera guardrails; sem autonomia decisória | Gera Canonical Change Plan incremental; implementa código | Atualiza Product Canon | Conduz ciclo de guardrails; formaliza em IEEE 29148 + SBE; gera `expert-edit-plan` |

---

## 5. Estrutura de Artefatos

A Product Canon contém as seguintes seções essenciais de conhecimento:

- **Glossário de linguagem ubíqua**: definições precisas dos termos do domínio, associados aos bounded contexts onde têm validade
- **Regras de negócio**: formalizadas em formato IEEE 29148, validadas internamente pela IA utilizando metodologias como SBVR
- **Requisitos com critérios de aceitação**: estruturados em IEEE 29148 com cenários SBE (Specification by Example) para verificabilidade
- **Fluxos de domínio**: eventos, comandos, atores e agregados descobertos na Domain Discovery Session
- **Bounded contexts com seus artefatos**: definição, eventos publicados/consumidos, fluxos e casos de uso por contexto
- **Princípios técnicos constitucionais**: restrições técnicas definidas na Technical Constitution Session
- **Context maps**: relações formais entre bounded contexts
- **ADRs (Architecture Decision Records)**: registros de decisões técnicas com contexto e justificativa
- **Canonical Change Plans** (com envelope tipado): `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan` — registros dos planos de mudança aprovados em cada cerimônia, onde `expert-edit-plan` designa planos de mudança originados por edição direta do Domain Expert. Todos os tipos contêm requisitos em formato IEEE 29148 + SBE
- **Changelog / histórico de transições**: registro versionado de cada evolução da Product Canon

A estrutura física é deliberadamente mínima nesta fase de prototipação. A hierarquia final deve emergir da experimentação prática com o modelo.

Todos os artefatos são markdown versionado em Git, garantindo rastreabilidade de quem alterou o quê, quando e por quê, e permitindo diff, merge e rollback com ferramentas padrão.

---

## 6. Cenários de Aplicação

### 6.1 Produto Novo (Greenfield)

**Contexto.** Uma startup de logística está construindo sua primeira plataforma. O fundador entende profundamente o negócio mas não é técnico.

**Aplicação do ZionKit.**

1. O fundador inicia pela Domain Discovery Session. Descreve os fluxos operacionais: "Um embarcador cadastra uma carga, transportadoras fazem ofertas, o embarcador aceita uma oferta, a carga é coletada, rastreada e entregue." O agente decompõe em eventos, comandos, atores e propõe bounded contexts (Marketplace, Transporte, Rastreamento, Faturamento).

2. O Architect (neste caso, o CTO da startup) conduz a Technical Constitution Session: avalia os bounded contexts propostos, define que a comunicação entre Marketplace e Transporte será via eventos assíncronos, estabelece a stack inicial (Node.js, PostgreSQL, RabbitMQ) e registra os princípios técnicos constitucionais e ADRs fundacionais na Product Canon.

3. Na Requirements Specification Session, os requisitos de cada contexto são formalizados utilizando o processo de clarificação iterativa mediado pela IA. O Domain Builder descreve os requisitos em linguagem natural; a IA utiliza validação semântica interna para detectar ambiguidades e incompletudes, apresentando perguntas de clarificação em linguagem natural. Os requisitos são formalizados em IEEE 29148 + SBE, com nível de aderência Mínimo (adequado ao estágio de prototipação do produto). O agente identifica gaps: "O que acontece se nenhuma transportadora fizer oferta dentro de 24 horas? O embarcador é notificado? A carga expira?" O fundador esclarece, e os requisitos são incorporados à Product Canon. Cada cerimônia produz um Canonical Change Plan que é aprovado antes de habilitar a próxima.

4. Um desenvolvedor escreve a primeira especificação de feature: "Implementar o fluxo de cadastro de carga." A spec consome o contexto do bounded context Marketplace e os princípios técnicos constitucionais. O Canonical Change Plan incremental é mínimo (nenhum conceito novo). O Domain Expert (o próprio fundador) aprova.

5. A segunda spec, "Implementar sistema de ofertas", gera um Canonical Change Plan incremental mais significativo: introduz o conceito de "Oferta Vinculante" (uma vez aceita, a transportadora não pode desistir) que não estava no glossário original, e propõe um novo evento "OfertaAceita" com schema específico. O fundador valida a camada de negócio, o Architect valida a camada técnica, e a Product Canon é atualizada.

### 6.2 Feature em Produto Existente (Brownfield)

**Contexto.** Carla é product owner em uma empresa de saúde com um sistema maduro. Ela precisa adicionar telemedicina ao produto, mas não conhece todas as implicações técnicas dessa mudança em um sistema que já tem anos de operação.

**Aplicação do ZionKit.**

1. A Product Canon do produto já existe e contém os bounded contexts (Agendamento, Prontuário, Faturamento, Notificações) com seus glossários, eventos e regras de negócio. Carla não precisou construí-la — ela foi sendo alimentada ao longo do tempo por ciclos anteriores do ZionKit. A base conceitual já foi aprovada no Canon Building.

2. Carla escreve uma especificação em linguagem simples: "Adicionar consulta por vídeo ao sistema de agendamento." A IA, com acesso à Product Canon, injeta o contexto de Agendamento e Prontuário e identifica impactos que Carla não havia considerado: o evento "ConsultaRealizada" precisa ser estendido com metadados de vídeo, o conceito de "sala" precisa incluir "sala virtual", e o Faturamento precisa de uma nova regra para diferenciar preço entre consulta presencial e remota.

3. O Canonical Change Plan incremental gerado lista três bounded contexts afetados — capturando apenas impactos emergentes que não foram antecipados no Canon Building. A camada de negócio é avaliada pelos Domain Experts de Agendamento, Prontuário e Faturamento. O Domain Expert de Faturamento identifica que a regra de preço proposta conflita com um contrato de operadora de saúde existente — algo que Carla não tinha como saber. A camada de arquitetura é avaliada pelo Architect, que valida que o schema do evento "ConsultaRealizada" pode ser estendido sem quebrar os sistemas que já o consomem. A especificação é ajustada antes de qualquer código ser escrito.

4. Após aprovação e implementação, a Product Canon é atualizada com os novos conceitos, eventos e regras. A próxima pessoa que trabalhar em Agendamento, Prontuário ou Faturamento já terá acesso a todo esse contexto.

### 6.3 Mudança Conceitual com Migração Gradual

**Contexto.** Uma reorganização do negócio exige que o bounded context de "Faturamento" seja dividido em "Cobrança" e "Receita."

**Aplicação do ZionKit.**

1. O diretor financeiro inicia uma Domain Discovery Session para mapear os fluxos que pertencem a cada novo contexto. "Emissão de boleto, negociação de inadimplência e régua de cobrança são Cobrança. Reconhecimento de receita, conciliação bancária e relatórios contábeis são Receita."

2. A alteração é radical. Via Versionamento Gradual por Estrangulamento, é registrada na Product Canon como mudança em transição (versão next), não alteração imediata. Os artefatos do contexto "Faturamento" (versão current) permanecem vigentes.

3. Novas especificações que tocam "Cobrança" ou "Receita" podem ser escritas contra a versão next. Especificações de manutenção do sistema existente continuam referenciando "Faturamento" (current).

4. A migração ocorre gradualmente. Cada spec implementada no novo modelo conceitual contribui para a transição. Quando todas as dependências de "Faturamento" forem migradas, a versão current é descontinuada.

---

## 7. Dores Endereçadas

| Dor | Como o ZionKit endereça |
|-----|------------------------|
| Conhecimento de domínio tácito, preso na cabeça de indivíduos | A Product Canon formaliza e versiona o conhecimento em documentos acessíveis a todos — ninguém precisa depender da memória de uma pessoa |
| Cada nova funcionalidade precisa reconstruir contexto do zero | A IA recebe automaticamente o conhecimento relevante da Product Canon antes de trabalhar em qualquer especificação |
| Domain Builders excluídos do processo de especificação | As cerimônias de Domain Discovery e Requirements Specification permitem que Domain Builders participem, descrevendo o negócio em linguagem natural. A IA utiliza validação semântica interna para garantir rigor, e formaliza os requisitos em IEEE 29148 + SBE — formato compreensível por pessoas de negócio |
| Vocabulário inconsistente entre equipes e entre especificações | O glossário de linguagem ubíqua na Product Canon funciona como o dicionário oficial do produto — todos usam os mesmos termos com os mesmos significados |
| Decisões conceituais tomadas silenciosamente pela IA | O Canonical Change Plan torna visíveis todas as mudanças que uma funcionalidade causa no conhecimento do produto, antes de qualquer código ser escrito. A IA opera sem autonomia decisória — propõe e sinaliza, mas não decide |
| Decisões técnicas dispersas ou não documentadas | Os princípios técnicos constitucionais e os ADRs na Product Canon concentram todas as decisões técnicas em um único lugar versionado |
| Descobertas de domínio que se perdem após cada implementação | A retroalimentação formal devolve à Product Canon tudo que foi aprendido durante cada ciclo de construção |
| Mudanças radicais no domínio que causam efeito cascata | O versionamento gradual permite que mudanças grandes sejam aplicadas aos poucos, sem quebrar o que já funciona |
| Revisão de código como único momento de validação de qualidade | A aprovação por afinidade (Domain Expert + Architect) nos gates do Canon Building e, condicionalmente, na Etapa 2 opera antes da implementação, verificando tanto a coerência de negócio quanto a viabilidade técnica |

---

## 8. Princípios de Design

**A Product Canon é viva, não estática.** Diferente de documentos tradicionais que são escritos uma vez e se desatualizam, a Product Canon é continuamente alimentada pelo uso. Na prática, isso significa que o repositório de conhecimento do produto fica mais rico e mais preciso a cada funcionalidade construída.

**O ciclo é bidirecional.** Informação flui da Product Canon para as especificações (como contexto) e das especificações de volta para a Product Canon (como retroalimentação). Na prática, isso significa que a documentação não é apenas consultada — ela é enriquecida de volta. O conhecimento cresce em vez de se degradar.

**Prevenção sobre detecção.** Com o Canon Building, a prevenção ocorre ainda mais cedo — o Canonical Change Plan é revisado antes de qualquer especificação de feature, não apenas antes do código. Os gates de aprovação nas cerimônias garantem que inconsistências conceituais sejam capturadas no momento mais barato de corrigi-las. Na prática, isso significa que erros de entendimento sobre o negócio são capturados antes de qualquer linha de código existir.

**Separação de autoridade.** O Domain Builder tem autoridade sobre intenção de produto. O Architect tem autoridade sobre decisões técnicas e estruturais. A IA tem capacidade de processamento e consistência, mas sem autonomia decisória — propõe, humanos decidem. O Domain Expert tem autoridade sobre o significado dos conceitos do negócio. Nenhum dos quatro substitui os outros. Na prática, isso significa que cada decisão é validada por quem tem competência sobre ela.

**Alterações radicais são graduais.** Mudanças estruturais no domínio não propagam imediatamente. Seguindo o padrão Strangler Fig, são versionadas e aplicadas por criticidade. Na prática, isso significa que uma mudança estrutural grande — como separar a área de Faturamento do produto em Cobrança e Receita — é refletida no sistema aos poucos, sem quebrar o que já funciona.

**Injeção seletiva de contexto.** A Product Canon completa não é enviada inteira para a IA a cada interação. Apenas os fragmentos relevantes para a tarefa em questão são carregados. Na prática, isso significa que a IA recebe apenas as informações que precisa para aquela especificação, evitando sobrecarga e mantendo a qualidade das respostas.

**Governança por cerimônia com canal de exceção.** O conhecimento da Product Canon é construído e modificado primariamente através de cerimônias formais (Domain Discovery, Technical Constitution, Requirements Specification), cada uma com saída padronizada (Canonical Change Plan), gate de aprovação e rastreabilidade. Para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias, o Domain Expert dispõe de um canal de exceção — edição direta na camada de negócio (seção 2.2.6) — com salvaguardas que preservam a primazia das cerimônias: escopo restrito a refinamentos, tipagem distinta para auditoria, e aprovação obrigatória do Architect. Na prática, isso significa que toda mudança no corpo de conhecimento do produto passa por um processo formal — seja cerimônia ou edição direta com guardrails — garantindo que nada é alterado silenciosamente.

---

## 9. Riscos e Limitações Conhecidas

### 9.1 Qualidade do guardrail de conformidade

O modelo depende da capacidade da IA de identificar inconsistências entre o input do participante e a Product Canon — incluindo não apenas o glossário de linguagem ubíqua, mas também os princípios técnicos constitucionais e as regras de negócio formalizadas. Se a IA não detecta que um termo está sendo usado incorretamente ou que um requisito contradiz uma regra existente, o guardrail falha silenciosamente. A eficácia desse componente precisa ser validada empiricamente.

### 9.2 Injeção seletiva de contexto

Determinar automaticamente quais fragmentos da Product Canon são relevantes para uma especificação é um problema não trivial. Uma especificação que aparenta tocar apenas um bounded context pode ter implicações em outros. A qualidade da seleção de contexto afeta diretamente a qualidade do Canonical Change Plan.

### 9.3 Custo de bootstrap

Organizações que não possuem nenhum conhecimento de domínio formalizado precisam investir na construção inicial da Product Canon. O Canon Building é mais estruturado que o modelo anterior (três cerimônias com gates vs. dois processos informais). O investimento inicial pode ser maior, mas o retorno é mais previsível graças à governança por cerimônia. As cerimônias do Canon Building reduzem o custo de formalização mas não o eliminam. O retorno sobre o investimento se materializa ao longo de múltiplos ciclos de especificação, não imediatamente.

### 9.4 Disciplina de retroalimentação

O modelo depende de que a Etapa 3 seja efetivamente executada após cada implementação. Se equipes sob pressão de prazo começam a pular a retroalimentação, a Product Canon se desatualiza e o modelo degrada para SDD convencional sem camada semântica. Este risco é parcialmente mitigado pelo Canon Building: se Canonical Change Plans já são integrados à Product Canon durante a Etapa 1, a Etapa 3 é um incremento menor — focado em descobertas emergentes da implementação. O risco residual concentra-se nessas descobertas emergentes.

### 9.5 Disponibilidade de aprovadores

O Canon Building introduz três gates de aprovação na Etapa 1 e um gate condicional na Etapa 2, o que aumenta a demanda sobre aprovadores. Mitigações: a aprovação por afinidade direciona cada gate para o papel mais competente, evitando sobrecarga simétrica; a aprovação secundária é assíncrona com janela de veto, não exigindo presença simultânea; na Etapa 2, a aprovação é condicional — specs que consomem a Product Canon sem alterá-la fluem sem gate; o roteamento por camada na Etapa 2 exige apenas o aprovador correspondente à camada afetada. Em organizações com múltiplos bounded contexts, Domain Experts e Architects podem ser designados por contexto.

### 9.6 Qualidade da tradução de validação interna para linguagem natural

A IA utiliza metodologias de validação semântica (incluindo SBVR) internamente para detectar problemas em requisitos. A eficácia desse processo depende da capacidade da IA de traduzir os problemas detectados em perguntas de clarificação claras e acionáveis em linguagem natural. Se a tradução for imprecisa, o benefício da validação se perde. Mitigação: o ciclo iterativo de clarificação permite que o Domain Builder questione e refine as perguntas da IA; a formalização final em IEEE 29148 + SBE serve como ponto de validação auditável.

### 9.7 Perda de detalhamento estrutural

O Canon Building não detalha fases internas de todas as cerimônias (apenas Domain Discovery mantém fases explícitas do Event Storming) nem a organização física da Product Canon. Isso é uma escolha deliberada: a estrutura mínima permite adaptação durante a prototipação. A decisão D5 (fases explícitas apenas para Discovery) e D1 (estrutura flat) mitigam parcialmente. Risco gerenciável — detalhamento deve emergir da prototipação prática.

---

## 10. Direções para Prototipação

O modelo conceitual sugere as seguintes prioridades para validação experimental:

1. **Domain Discovery Session.** Componente mais tangível e demonstrável. Validar, com um Domain Builder real, se ele consegue — através de conversa guiada com a IA — produzir um mapa de processos, eventos e áreas do negócio que ele próprio reconheça como fiel à realidade do produto. A sessão deve produzir um Canonical Change Plan tipado como `discovery-plan`. Essa validação deve envolver alguém sem formação técnica para confirmar que o processo é acessível.

2. **Guardrail de Conformidade com Product Canon existente.** Criar uma Product Canon mínima (glossário de 20-30 termos, 3-4 bounded contexts, 10-15 regras de negócio, princípios técnicos constitucionais) e testar se a IA consegue detectar inconsistências — tanto no vocabulário de negócio quanto nos princípios técnicos — quando um participante escreve uma especificação com termos incorretos ou requisitos contraditórios.

3. **Geração de Canonical Change Plans em cada cerimônia.** Validar se a IA gera Change Plans corretos com envelope + payload tipado (`discovery-plan`, `constitution-plan`, `specification-plan`) em cada cerimônia, não apenas na Etapa 2. Testar se os Change Plans identificam corretamente quais conceitos são afetados e quais aprovadores precisam ser consultados.

4. **Validação de Canonical Change Plans por aprovadores reais.** Testar a aprovação por afinidade: o Domain Expert aprova primariamente Change Plans de Domain Discovery e Requirements Specification; o Architect aprova primariamente Constitution. Avaliar se a aprovação secundária assíncrona agrega valor ou é percebida como burocracia. Avaliar se o artefato é compreensível e se a separação entre camadas é clara.

5. **Ciclo completo em escopo reduzido.** Executar o ciclo mínimo — três cerimônias do Canon Building + Decisão de Continuidade + Etapa 2 + Etapa 3 — em um domínio simples (3 bounded contexts, 1 funcionalidade) e avaliar se a Product Canon resultante é efetivamente mais rica e útil após um ciclo completo.

6. **Formalização SBVR + SBE mediada pela IA.** Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade; (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis. Risco a monitorar: efeito "rubber stamp" na validação.

7. **Fluxo sequencial com gates entre cerimônias.** Testar se: (a) habilitação sequencial funciona na prática sem criar gargalos; (b) aprovadores lidam com múltiplos Canonical Change Plans sem sobrecarga; (c) Decisão de Continuidade é exercida naturalmente pelo Domain Builder.

---

*ZionKit — Versão 0.5 do modelo conceitual. Documento gerado como registro de insights para prototipação futura.*
