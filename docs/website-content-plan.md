# ZionKit — Roteiro de Conteúdo para o Site Institucional

**Versão:** 1.0  
**Data:** Abril 2026  
**Framework narrativo:** Híbrido PAS (Problem-Agitate-Solve) + Progressive Disclosure  
**Audiência:** Product owners, gestores, desenvolvedores juniores, arquitetos e stakeholders não-técnicos

---

## Sobre Este Documento

Este documento contém a estrutura de roteiro e conteúdo narrativo para o site institucional do ZionKit. Define o que cada seção do site deve comunicar, com exemplos práticos e descrições de diagramas. Não contém instruções visuais, de layout ou tecnologias front-end.

---

## Estrutura Narrativa

O site usa um híbrido de dois frameworks:

- **PAS (Problem-Agitate-Solve)** como abertura narrativa — aterrissa o leitor no problema antes de apresentar qualquer solução.
- **Progressive Disclosure** como estrutura do corpo — revela complexidade em camadas, permitindo que públicos diferentes consumam profundidades diferentes do mesmo conteúdo.

Cada seção funciona como unidade autônoma (leitura não-linear é possível), mas a progressão narrativa completa segue: **problema → consequências → solução resumida → como funciona → detalhes → exemplos → glossário**.

---

## Seção 1 — O Problema (Abertura PAS)

### Objetivo

O leitor deve sair desta seção pensando: "Isso acontece no meu time. Eu conheço essa dor."

### Conteúdo Narrativo

**Título sugerido:** "O conhecimento do seu produto morre a cada sprint"

Hoje, quando um time de desenvolvimento pede para a inteligência artificial construir uma funcionalidade, algo crítico está faltando. A IA tem acesso ao código do sistema, mas não tem acesso ao conhecimento sobre o produto — as regras de negócio, o vocabulário acordado entre as equipes, os processos que fazem o produto funcionar, as decisões que já foram tomadas e por quê.

Esse conhecimento existe — mas está espalhado: na cabeça do engenheiro sênior que está de férias, em uma wiki que ninguém atualiza, em uma conversa de Slack de seis meses atrás, ou nas entrelinhas de uma spec descartada depois da implementação.

O resultado? Cada nova funcionalidade precisa reconstruir contexto do zero. A IA toma decisões silenciosas sobre regras de negócio que ela não conhece. E tudo que o time aprende durante a implementação se perde — porque não tem para onde ir.

### Exemplo Prático

> Uma equipe de e-commerce precisa implementar "reembolso parcial." O engenheiro escreve uma spec para a IA. Mas "reembolso" tem regras específicas nesse produto: reembolsos acima de R$ 500 exigem aprovação do gerente, itens promocionais seguem regras diferentes, e "parcial" significa coisas distintas dependendo de se refere ao valor ou aos itens. Nenhuma dessas regras está formalizada em um lugar que a IA possa consultar. O código gerado funciona — mas viola regras de negócio que só seriam descobertas em produção.

### Diagrama Necessário

**Diagrama 1 — "O Vazio de Contexto"**

Representação visual do fluxo atual de desenvolvimento assistido por IA:

```
Conhecimento do produto               Especificação              Código gerado
(disperso, informal, tácito)    →     (sem contexto)       →     (decisões silenciosas)
                                                                        ↓
                                                               Bugs de lógica de negócio
                                                               descobertos em produção
```

O diagrama deve comunicar visualmente que existe um "vazio" entre onde o conhecimento vive (cabeças, wikis, Slack) e onde a IA opera (código, specs). A seta entre eles está quebrada — não há ponte formal.

---

## Seção 2 — A Agitação (Consequências do Problema)

### Objetivo

O leitor deve entender a magnitude do problema — não é um incômodo menor, é um custo estrutural que escala com o time.

### Conteúdo Narrativo

**Título sugerido:** "Três problemas que ninguém resolveu"

**Problema 1 — A IA trabalha no escuro.**

Ferramentas de IA atuais geram código a partir de padrões estatísticos — elas inferem o que parece correto, não o que é correto para o seu produto. Pesquisas mostram que código gerado por IA apresenta até 75% mais problemas de lógica em áreas críticas de negócio. 65% dos desenvolvedores reportam que assistentes de IA "perdem contexto relevante" durante o trabalho. Não é culpa da IA — ela simplesmente não tem acesso ao conhecimento que precisaria ter.

**Problema 2 — Quem conhece o negócio não participa.**

As ferramentas de especificação atuais são feitas para engenheiros. O product owner que conhece as regras do produto, o analista que sabe como o processo funciona na prática, o gestor que entende as restrições do negócio — essas pessoas ou são excluídas do processo, ou participam e produzem especificações ambíguas porque a ferramenta não fala a língua delas.

> Um product owner descreve: "clientes inativos não devem receber promoções." Mas no vocabulário do produto, "cliente inativo" tem uma definição precisa — sem compras nos últimos 12 meses E sem login nos últimos 6 meses. O PO pensava apenas em "quem não compra há algum tempo." Sem algo que confronte o que ele disse com o que já está definido, a spec nasce com uma definição errada.

**Problema 3 — O que o time aprende, o time esquece.**

Cada implementação gera descobertas: conceitos que precisam ser refinados, regras que não estavam documentadas, áreas do sistema que precisam ser reorganizadas. Hoje, essas descobertas morrem no código ou na cabeça de quem implementou. A próxima pessoa que trabalhar nessa área começa do zero.

> Durante a implementação de um sistema de notificações, o time descobre que "preferência do usuário" precisa ser separado em "preferência de canal" (email, SMS, push) e "preferência de conteúdo" (marketing, transacional, operacional). Essa descoberta é valiosa para qualquer funcionalidade futura. Mas sem um mecanismo formal de retroalimentação, ela se perde.

### Dados de Contexto

Dados para usar como apoio narrativo nas visualizações ou textos de suporte:

- 35% dos defeitos em produção são causados por problemas de requisitos (Accenture)
- 40% do esforço em projetos ágeis é retrabalho por baixa qualidade pré-código (ScopeMaster)
- 56% das falhas em projetos de TI são causadas por falha de comunicação
- Desenvolvedores perdem em média 23 minutos para reconstruir contexto após cada interrupção
- Apenas 5% dos agentes de IA em produção têm monitoramento maduro sobre suas decisões (Cleanlab, 2025)

### Diagrama Necessário

**Diagrama 2 — "Os Três Gaps"**

Três colunas paralelas, cada uma representando um gap:

```
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   IA SEM          │  │   NEGÓCIO         │  │   CONHECIMENTO   │
│   CONTEXTO        │  │   EXCLUÍDO        │  │   DESCARTÁVEL    │
│                    │  │                    │  │                    │
│ A IA gera código   │  │ Quem conhece o    │  │ Descobertas da   │
│ sem saber as       │  │ produto não       │  │ implementação    │
│ regras do produto  │  │ participa da      │  │ morrem no código │
│                    │  │ especificação     │  │ e na memória     │
└──────────────────┘  └──────────────────┘  └──────────────────┘
```

O diagrama deve ser limpo e comunicar visualmente que são três problemas distintos mas conectados.

---

## Seção 3 — A Solução em Uma Frase (Ponte PAS → Progressive Disclosure)

### Objetivo

Transição. O leitor sai do problema e recebe uma resposta clara e concisa antes de entrar nos detalhes. Deve funcionar como um "respiro" narrativo.

### Conteúdo Narrativo

**Título sugerido:** "E se todo o conhecimento do seu produto tivesse uma casa?"

O ZionKit é um modelo que cria um repositório central onde todo o conhecimento do produto — suas regras, seu vocabulário, seus processos, suas decisões técnicas — fica formalizado, versionado e acessível.

Quando alguém pede para a IA construir algo, ela consulta esse repositório para garantir que o que será construído respeita o que já foi definido. E quando a construção revela algo novo sobre o produto, esse aprendizado volta para o repositório, enriquecendo o contexto disponível para todos.

Esse repositório se chama **Product Canon** — o cânone do produto. E o ciclo que o mantém vivo tem três etapas: construir o conhecimento, usá-lo para especificar, e devolver o que foi aprendido.

### Analogia de Apoio

> Pense na Product Canon como a constituição de um país. Todo mundo precisa seguir as mesmas regras, usar os mesmos termos com os mesmos significados, e quando algo precisa mudar, existe um processo formal para isso — não é cada um interpretando do seu jeito. A diferença é que essa constituição evolui continuamente, ficando mais rica a cada ciclo.

---

## Seção 4 — Como Funciona: Visão Geral (Camada 1 — Progressive Disclosure)

### Objetivo

O leitor deve entender o modelo em alto nível: o que é a Product Canon e como o ciclo de 3 etapas funciona. Sem jargão. Qualquer pessoa deve sair desta seção com um mapa mental claro.

### Conteúdo Narrativo

**Título sugerido:** "O ciclo que faz o conhecimento crescer"

O ZionKit opera em um ciclo de três etapas que se repete continuamente:

**Etapa 1 — Construir o conhecimento.**
As pessoas que entendem o negócio (product owners, analistas, gestores) e as pessoas que entendem a tecnologia (arquitetos, engenheiros seniores) trabalham juntas, em sessões guiadas por IA, para formalizar o que sabem sobre o produto. Regras de negócio, vocabulário, processos, decisões técnicas — tudo é registrado no repositório central, a Product Canon.

Esse trabalho é feito em três sessões, cada uma com um foco diferente:
- **Descoberta de processos** — mapear o que acontece no negócio: quais eventos ocorrem, quem os causa, como se conectam
- **Constituição técnica** — definir as regras técnicas do sistema: quais tecnologias usar, como os componentes se comunicam, como os dados são protegidos
- **Especificação de requisitos** — formalizar o que o produto precisa fazer, com critérios claros e verificáveis

Cada sessão produz um plano de mudanças que precisa ser aprovado antes de avançar. Quem aprova? A pessoa com autoridade sobre aquele assunto — o especialista de negócio valida se o conhecimento está correto, o arquiteto valida se é viável tecnicamente.

**Etapa 2 — Usar o conhecimento.**
Quando alguém escreve uma especificação de funcionalidade, a IA automaticamente consulta a Product Canon e carrega o contexto relevante: o vocabulário daquela área do negócio, as regras aplicáveis, as decisões técnicas já tomadas. Se a funcionalidade vai causar mudanças no conhecimento do produto (um termo novo, uma regra nova, uma decisão técnica), isso é tornado visível antes de qualquer código ser escrito.

**Etapa 3 — Devolver o que foi aprendido.**
Depois da implementação, tudo que foi descoberto durante o processo — conceitos que precisaram ser refinados, regras que não estavam documentadas, decisões que foram tomadas — volta para a Product Canon. A próxima pessoa que trabalhar nessa área já terá acesso a esse conhecimento.

O resultado: a cada ciclo, o repositório de conhecimento fica mais rico. Especificações futuras operam com contexto melhor que as anteriores. O conhecimento do produto não se perde — ele se acumula.

### Diagrama Necessário

**Diagrama 3 — "O Ciclo ZionKit"**

Ciclo visual de 3 etapas com setas bidirecionais:

```
            ┌───────────────────────┐
            │   PRODUCT CANON       │
            │   (Repositório Vivo   │
            │    de Conhecimento)   │
            └───┬──────────────┬────┘
       contexto │              │ retroalimentação
       injetado │              │ (descobertas)
                ▼              │
  ┌──────────────────┐         │
  │  ETAPA 1          │         │
  │  Construir o      │         │
  │  Conhecimento     │─────────┘
  │  (3 sessões)      │
  └────────┬─────────┘
           │
           ▼
  ┌──────────────────┐
  │  ETAPA 2          │
  │  Usar para        │
  │  Especificar      │
  └────────┬─────────┘
           │
           ▼
  ┌──────────────────┐
  │  ETAPA 3          │
  │  Devolver o       │
  │  Aprendizado      │──── → volta para Product Canon
  └──────────────────┘
```

O diagrama deve comunicar o caráter cíclico e bidirecional: informação flui da Canon para as specs E das specs de volta para a Canon. O repositório cresce a cada volta.

---

## Seção 5 — Os Três Pilares em Detalhe (Camada 2 — Progressive Disclosure)

### Objetivo

O leitor interessado em entender melhor deve sair desta seção sabendo o que acontece dentro de cada etapa. Linguagem ainda acessível, mas com mais profundidade.

### Conteúdo Narrativo

**Título sugerido:** "Por dentro de cada etapa"

### 5.1 — Etapa 1: Construir o Conhecimento (Canon Building)

O Canon Building é onde o conhecimento bruto se transforma em conhecimento formalizado. Funciona como uma sequência de três sessões, cada uma focada em uma dimensão do produto.

**Sessão 1 — Descoberta de Processos (Domain Discovery Session)**

Quem participa: a pessoa de negócio (Domain Builder) + IA como facilitadora.

Em vez de reuniões com post-its em uma parede, o Domain Builder descreve os processos do negócio em linguagem natural — como se estivesse explicando para um colega novo. A IA escuta, organiza e faz perguntas.

A partir da descrição, a IA identifica:
- **Eventos** — fatos que acontecem no negócio ("Pedido Criado", "Pagamento Confirmado", "Entrega Realizada")
- **Comandos** — ações que causam esses eventos ("Criar Pedido", "Confirmar Pagamento")
- **Atores** — quem ou o que dispara cada ação (um cliente, um sistema, uma regra automática)
- **Áreas do negócio** — agrupamentos naturais de processos que têm vocabulário e regras próprias ("Pagamentos", "Entregas", "Notificações")

> **Exemplo concreto.** Um gestor de operações de uma fintech descreve: "Quando um cliente pede pra sacar dinheiro, a gente verifica se tem saldo, se tem limite diário disponível, e se não tem nenhum bloqueio judicial. Se tudo ok, o saque é processado e o cliente recebe uma notificação."
>
> A partir dessa fala, a IA identifica 6 eventos (SaqueSolicitado, SaldoVerificado, LimiteValidado, BloqueioVerificado, SaqueProcessado, NotificaçãoEnviada), os comandos associados, e propõe três áreas do negócio: Conta, Compliance e Notificações.
>
> O gestor não precisou saber nenhum termo técnico. Ele descreveu o que acontece — a IA formalizou.

**Sessão 2 — Constituição Técnica (Technical Constitution Session)**

Quem participa: o arquiteto + IA como facilitadora.

O arquiteto recebe as áreas de negócio e os processos mapeados na sessão anterior e define as regras técnicas que governam o sistema. É o equivalente técnico do que o Domain Builder fez para o negócio.

O resultado são os "princípios técnicos constitucionais" — regras que toda especificação futura precisa respeitar:
- Qual stack de tecnologia será usada
- Como as diferentes áreas do sistema se comunicam entre si
- Como os dados são protegidos
- Como o sistema será monitorado

> **Exemplo concreto.** O arquiteto avalia que a verificação de bloqueio judicial (área de Compliance) precisa ser síncrona com o saque (área de Conta) — o saque não pode ser processado antes da verificação terminar. Mas a comunicação com Notificações pode ser assíncrona — a notificação pode demorar um pouco sem impactar o saque. Essas decisões são registradas formalmente.

**Sessão 3 — Especificação de Requisitos (Requirements Specification Session)**

Quem participa: a pessoa de negócio (Domain Builder) + IA como mediadora.

O Domain Builder descreve o que o produto precisa fazer, em linguagem natural. A IA traduz para uma linguagem formal, precisa, mas ainda legível — e apresenta de volta para o Domain Builder validar.

O objetivo é produzir requisitos que são simultaneamente compreensíveis por pessoas de negócio e precisos o suficiente para a IA usar ao gerar código.

> **Exemplo concreto.** O Domain Builder diz: "O cliente deve poder cancelar um pedido antes do faturamento."
>
> A IA traduz: "É obrigatório que cada Pedido cujo status é 'Pendente' ou 'Confirmado' possa ser cancelado pelo Cliente titular. É proibido que um Pedido cujo status é 'Faturado' seja cancelado."
>
> O Domain Builder olha e valida. A IA então consulta a Product Canon e descobre que já existe uma regra: "Pedidos faturados não podem ser cancelados, apenas devolvidos." A formalização é ajustada para incluir o caminho de devolução.
>
> O Domain Builder não precisou escrever a formalização — apenas validou que o que a IA produziu reflete fielmente sua intenção.

**Gates de aprovação.** Cada sessão produz um Plano de Mudanças (Canonical Change Plan) — um documento que descreve exatamente o que será adicionado ou alterado na Product Canon. Esse plano precisa ser aprovado antes de avançar para a próxima sessão. Quem aprova depende do assunto: mudanças de negócio são aprovadas pelo especialista de domínio; mudanças técnicas são aprovadas pelo arquiteto.

### Diagrama Necessário

**Diagrama 4 — "As Três Sessões do Canon Building"**

Fluxo sequencial com gates entre cada sessão:

```
┌─────────────────────┐     ┌─────────────────────┐     ┌─────────────────────┐
│ DESCOBERTA          │     │ CONSTITUIÇÃO        │     │ ESPECIFICAÇÃO       │
│ DE PROCESSOS        │     │ TÉCNICA             │     │ DE REQUISITOS       │
│                     │     │                     │     │                     │
│ Quem: Domain Builder│     │ Quem: Architect     │     │ Quem: Domain Builder│
│ O quê: processos,   │     │ O quê: stack,       │     │ O quê: requisitos   │
│ eventos, atores,    │     │ comunicação,        │     │ formalizados com    │
│ áreas do negócio    │     │ segurança, regras   │     │ critérios claros    │
│                     │     │ técnicas            │     │                     │
└────────┬────────────┘     └────────┬────────────┘     └────────┬────────────┘
         │                           │                           │
         ▼                           ▼                           ▼
   ┌───────────┐              ┌───────────┐              ┌───────────┐
   │ APROVAÇÃO │──────────►   │ APROVAÇÃO │──────────►   │ APROVAÇÃO │
   │ Gate 1    │              │ Gate 2    │              │ Gate 3    │
   └───────────┘              └───────────┘              └───────────┘
```

O diagrama deve comunicar a sequência obrigatória: uma sessão só começa depois que o plano da anterior foi aprovado.

---

### 5.2 — Etapa 2: Usar o Conhecimento (Especificação Contextualizada)

Com a Product Canon construída, qualquer pessoa pode escrever uma especificação de funcionalidade. A diferença é que agora a IA não trabalha no escuro.

**Como funciona:**

1. Alguém descreve uma funcionalidade ("Adicionar pagamento via PIX ao checkout")
2. A IA identifica quais áreas do negócio são afetadas e carrega automaticamente o contexto relevante da Product Canon: vocabulário, regras de negócio, decisões técnicas, eventos existentes
3. A IA confronta a especificação com o conhecimento existente e identifica impactos: termos novos, regras novas, decisões que precisam ser tomadas
4. Esses impactos são documentados em um Plano de Mudanças antes de qualquer código ser escrito
5. Se há impacto, o plano é aprovado por quem tem autoridade sobre o assunto afetado

> **Exemplo concreto.** Carla é product owner em uma empresa de saúde. A Product Canon já existe — construída ao longo de ciclos anteriores. Carla escreve: "Adicionar consulta por vídeo ao sistema de agendamento."
>
> A IA, com acesso à Product Canon, identifica impactos que Carla não havia considerado:
> - O evento "ConsultaRealizada" precisa ser estendido com dados de vídeo
> - O conceito de "sala" precisa incluir "sala virtual"
> - O Faturamento precisa de uma regra para diferenciar preço entre consulta presencial e remota
>
> O especialista de Faturamento identifica que a regra de preço proposta conflita com um contrato de operadora de saúde existente — algo que Carla não tinha como saber. Tudo isso é capturado antes de qualquer código ser escrito. A especificação é ajustada, e depois a próxima pessoa que trabalhar nessas áreas já terá acesso a todo esse contexto.

**O papel da IA nesta etapa — sem autonomia decisória:**

A IA identifica, sinaliza e propõe — mas nunca decide. Se uma funcionalidade vai criar um termo novo no vocabulário do produto, a IA aponta isso e pede aprovação humana. Se a funcionalidade contradiz uma regra existente, a IA sinaliza o conflito — mas quem decide como resolver é o humano responsável.

### Diagrama Necessário

**Diagrama 5 — "Especificação Contextualizada"**

Fluxo mostrando como a spec consome contexto e gera o plano de mudanças:

```
┌────────────────┐
│ PRODUCT CANON  │
│ (conhecimento  │
│  formalizado)  │
└───────┬────────┘
        │ contexto relevante
        │ injetado automaticamente
        ▼
┌────────────────────────────────────────┐
│  ESPECIFICAÇÃO DE FUNCIONALIDADE       │
│                                        │
│  "Adicionar PIX ao checkout"           │
│                                        │
│  IA confronta com a Product Canon:     │
│  ✓ Vocabulário consistente?            │
│  ✓ Regras de negócio respeitadas?      │
│  ✓ Decisões técnicas compatíveis?      │
│  ⚠ Impactos identificados              │
└───────┬────────────────────────────────┘
        │
        ▼
┌────────────────────────────────────────┐
│  PLANO DE MUDANÇAS INCREMENTAL         │
│                                        │
│  Negócio: novo termo "Chave PIX",      │
│  nova regra de validação noturna       │
│  → Aprovação: Especialista de Domínio  │
│                                        │
│  Arquitetura: novo evento, extensão    │
│  de schema existente                   │
│  → Aprovação: Arquiteto                │
└────────────────────────────────────────┘
```

---

### 5.3 — Etapa 3: Devolver o Aprendizado (Retroalimentação)

Depois que a funcionalidade é implementada, tudo que foi descoberto durante o processo volta para a Product Canon:

- Termos novos são adicionados ao vocabulário
- Regras de negócio descobertas são formalizadas
- Eventos de domínio novos ou alterados são registrados
- Decisões técnicas são documentadas
- Tudo é versionado — quem alterou, quando e por quê

A Product Canon depois da retroalimentação é mais rica que antes. A próxima especificação que tocar as mesmas áreas do negócio terá acesso a todo esse contexto que antes não existia.

**E quando a mudança é grande demais?**

Nem toda alteração precisa ser aplicada de uma vez. Mudanças estruturais grandes — como dividir uma área do negócio em duas — são aplicadas gradualmente. A Product Canon mantém duas versões: a vigente e a em transição. Funcionalidades de manutenção usam a versão vigente; funcionalidades novas podem usar a versão em transição.

> **Exemplo concreto.** A empresa decide que a área de "Faturamento" precisa ser dividida em "Cobrança" e "Receita." Essa mudança não é aplicada de uma vez. A Product Canon registra a versão atual (Faturamento) e a versão em transição (Cobrança + Receita). Especificações de manutenção continuam referenciando Faturamento. Novas especificações já podem ser escritas para os contextos separados. A migração acontece gradualmente, sem quebrar o que já funciona.

### Diagrama Necessário

**Diagrama 6 — "Retroalimentação e Versionamento Gradual"**

Duas partes:

**Parte A — Retroalimentação normal:**
```
Implementação concluída
        │
        ▼
Descobertas emergentes:
• Termos novos
• Regras não documentadas
• Decisões técnicas
        │
        ▼
Product Canon atualizada
(mais rica que antes)
```

**Parte B — Versionamento gradual (mudanças grandes):**
```
Product Canon
├── Versão VIGENTE: "Faturamento" ← specs de manutenção usam esta
└── Versão EM TRANSIÇÃO: "Cobrança" + "Receita" ← specs novas usam esta

Migração gradual: cada spec implementada no novo modelo contribui para a transição.
Quando todas as dependências forem migradas, a versão vigente é descontinuada.
```

---

## Seção 6 — Quem Faz O Quê (Os Papéis)

### Objetivo

O leitor deve entender que existem papéis com autoridades claras e não sobrepostas — e que a IA é uma ferramenta, não uma tomadora de decisões.

### Conteúdo Narrativo

**Título sugerido:** "Cada decisão é tomada por quem tem competência sobre ela"

O ZionKit define quatro papéis. Cada um tem uma autoridade específica — nenhum substitui o outro.

**Domain Builder (Construtor de Domínio)**
Quem é: product owner, analista de produto, gestor de operações — quem conhece o negócio.
O que faz: descreve processos e requisitos em linguagem natural. Decide quando o ciclo de construção de conhecimento está completo.
Analogia: é o dono do conteúdo da enciclopédia — sabe o que precisa estar lá.

**Architect (Arquiteto)**
Quem é: engenheiro sênior, arquiteto de software, CTO.
O que faz: define regras técnicas, valida viabilidade, toma decisões de arquitetura.
Analogia: é o engenheiro estrutural — garante que o prédio de pé, não importa como o morador quer decorar.

**Domain Expert (Especialista de Domínio)**
Quem é: autoridade sobre o significado dos conceitos do negócio.
O que faz: aprova que o conhecimento registrado é fiel à realidade. Não participa das sessões — valida os resultados.
Analogia: é o revisor técnico — garante que o que foi escrito reflete a verdade do negócio.

**IA (Agentes de Inteligência Artificial)**
O que faz: facilita sessões, organiza informação, identifica inconsistências, traduz linguagem natural para formatos precisos, gera planos de mudança, implementa código.
O que NÃO faz: não decide. Não inclui nem exclui nada da Product Canon por conta própria. Não resolve ambiguidades — sinaliza e espera a decisão humana.
Analogia: é a secretária mais competente do mundo — organiza, lembra, sinaliza, mas nunca assina pelo chefe.

### Diagrama Necessário

**Diagrama 7 — "Quem Faz O Quê em Cada Etapa"**

Tabela visual simplificada:

```
                    Etapa 1              Etapa 2              Etapa 3
                    Construir            Especificar          Retroalimentar
                    ─────────            ───────────          ──────────────
Domain Builder      Participa das        Escreve specs        —
                    sessões de           de funcionalidade
                    descoberta e
                    requisitos

Architect           Conduz sessão        Toma decisões        —
                    técnica; aprova      técnicas na spec;
                    viabilidade          aprova arquitetura

Domain Expert       Aprova fidelidade    Aprova impactos      —
                    do conhecimento      de negócio
                    ao domínio           (quando houver)

IA                  Facilita sessões,    Injeta contexto,     Atualiza a
                    gera planos          gera plano           Product Canon
                    de mudança           incremental,
                                         implementa código
```

---

## Seção 7 — Antes e Depois (Comparação)

### Objetivo

O leitor deve visualizar a diferença concreta entre desenvolver sem e com o ZionKit.

### Conteúdo Narrativo

**Título sugerido:** "O que muda na prática"

**Sem o ZionKit:**

- Cada funcionalidade reconstrói contexto de domínio do zero
- A IA toma decisões silenciosas sobre regras de negócio
- Product owners descrevem requisitos que são traduzidos (com perda) por intermediários
- Descobertas da implementação morrem no código
- Vocabulário inconsistente entre equipes gera bugs sutis
- Decisões técnicas ficam dispersas em PRs, Slack e cabeças
- Mudanças grandes no domínio causam efeito cascata

**Com o ZionKit:**

- A IA recebe automaticamente o contexto relevante do produto antes de trabalhar
- Toda mudança no conhecimento do produto é tornado visível e aprovada antes do código
- Product owners participam diretamente — descrevem em linguagem natural, a IA formaliza
- Descobertas da implementação voltam para o repositório de conhecimento
- Um vocabulário oficial garante que todos usam os mesmos termos
- Decisões técnicas ficam registradas formalmente com justificativa
- Mudanças grandes são aplicadas gradualmente, sem quebrar o existente

### Diagrama Necessário

**Diagrama 8 — "Antes / Depois"**

Duas colunas lado a lado com ícones visuais contrastantes (vermelho/verde ou problema/solução):

```
        SEM ZionKit                          COM ZionKit
        ───────────                          ───────────

  Conhecimento disperso              Product Canon centralizada
  (wikis, Slack, cabeças)            e versionada

  Contexto reconstruído              Contexto injetado
  a cada spec                        automaticamente

  PO traduzido por                   PO participa diretamente
  intermediários                     com mediação da IA

  Descobertas perdidas               Retroalimentação formal
  no código                          após cada ciclo

  IA decide sozinha                  IA propõe, humanos decidem

  Mudanças grandes =                 Versionamento gradual
  efeito cascata                     (Strangler Fig)
```

---

## Seção 8 — O Que É a Product Canon (Camada 3 — Para Quem Quer Ir Fundo)

### Objetivo

Leitores técnicos ou muito interessados devem entender a composição detalhada da Product Canon. Esta seção é opcional para a maioria dos visitantes.

### Conteúdo Narrativo

**Título sugerido:** "Anatomia da Product Canon"

A Product Canon é um conjunto de documentos versionados que representam o conhecimento do produto em duas camadas complementares.

**Camada de Negócio** — legível por pessoas não-técnicas:

- **Glossário de linguagem ubíqua** — O dicionário oficial do produto. Cada termo tem uma definição precisa, acordada por todos, associada à área do negócio onde vale. "Cliente inativo" significa a mesma coisa para todo mundo.
- **Regras de negócio** — Restrições e políticas do produto, expressas de forma clara e verificável. "Reembolsos acima de R$ 500 exigem aprovação do gerente."
- **Requisitos formalizados** — Requisitos produzidos através da mediação da IA: o Domain Builder fala em linguagem natural, a IA formaliza em linguagem precisa (SBVR + SBE), o Domain Builder valida.
- **Fluxos de domínio** — O que acontece, em que ordem, quem faz o quê — derivados das sessões de descoberta.

**Camada de Arquitetura** — decisões técnicas e estruturais:

- **Princípios técnicos constitucionais** — As regras técnicas do projeto: stack, comunicação entre componentes, segurança, observabilidade. Toda especificação deve respeitar esses princípios ou justificar a exceção formalmente.
- **Bounded contexts (áreas delimitadas do negócio)** — Fronteiras lógicas que separam áreas com vocabulário e regras próprias. "Pagamentos" e "Notificações" são contextos diferentes.
- **Eventos de domínio** — Catálogo dos fatos relevantes que acontecem no sistema: "PagamentoConfirmado", "PedidoCancelado" — com a descrição de quais dados cada evento carrega e quem os consome.
- **Context maps** — Como as áreas do negócio se relacionam entre si: quais dependem de quais, como trocam informações.
- **ADRs (Registros de Decisões de Arquitetura)** — O que foi decidido, por quê, quais alternativas foram consideradas e quais são as consequências. A memória técnica do produto.

Todos os artefatos são documentos markdown versionados em Git — com rastreabilidade completa de quem alterou o quê, quando e por quê.

---

## Seção 9 — Cenários de Aplicação

### Objetivo

O leitor deve ver o modelo em ação em situações concretas que ele pode reconhecer.

### Conteúdo Narrativo

**Título sugerido:** "ZionKit em ação"

### Cenário 1 — Produto Novo (Greenfield)

**Situação:** Uma startup de logística está construindo sua primeira plataforma. O fundador entende profundamente o negócio mas não é técnico.

**O que acontece com o ZionKit:**

1. O fundador descreve os fluxos do negócio em linguagem natural: "Um embarcador cadastra uma carga, transportadoras fazem ofertas, o embarcador aceita uma oferta, a carga é coletada, rastreada e entregue." A IA organiza em eventos, atores e áreas do negócio (Marketplace, Transporte, Rastreamento, Faturamento).

2. O CTO (como Arquiteto) define as regras técnicas: comunicação assíncrona entre áreas, stack inicial, princípios de segurança.

3. Na sessão de requisitos, a IA identifica gaps: "O que acontece se nenhuma transportadora fizer oferta dentro de 24 horas? O embarcador é notificado? A carga expira?" O fundador responde e os requisitos são registrados.

4. A primeira spec de funcionalidade — "Implementar cadastro de carga" — consome o contexto já construído. A segunda spec — "Implementar sistema de ofertas" — gera descobertas: o conceito de "Oferta Vinculante" (uma vez aceita, a transportadora não pode desistir) que não estava no glossário original. A Product Canon é atualizada.

### Cenário 2 — Funcionalidade em Produto Existente (Brownfield)

**Situação:** Carla é product owner em uma empresa de saúde. Precisa adicionar telemedicina a um sistema maduro.

**O que acontece com o ZionKit:**

1. A Product Canon já existe — construída ao longo de ciclos anteriores. Carla não precisou construí-la do zero.

2. Carla escreve: "Adicionar consulta por vídeo ao agendamento." A IA carrega o contexto e identifica impactos que Carla não considerou: o evento "ConsultaRealizada" precisa de metadados de vídeo, "sala" precisa incluir "sala virtual", e Faturamento precisa diferenciar preço presencial de remoto.

3. O especialista de Faturamento identifica que a regra de preço proposta conflita com um contrato existente de operadora — algo que Carla não tinha como saber. A spec é ajustada antes de qualquer código.

4. Após implementação, a Product Canon é atualizada. A próxima pessoa que trabalhar em Agendamento, Prontuário ou Faturamento já tem acesso a esse contexto.

### Cenário 3 — Mudança Conceitual Grande

**Situação:** Uma reorganização exige que "Faturamento" seja dividido em "Cobrança" e "Receita."

**O que acontece com o ZionKit:**

1. O diretor financeiro mapeia os processos: "Emissão de boleto e régua de cobrança são Cobrança. Reconhecimento de receita e conciliação bancária são Receita."

2. A mudança é registrada como transição — não como alteração imediata. A Product Canon mantém duas versões.

3. Specs de manutenção continuam referenciando "Faturamento." Specs novas para os contextos separados já usam a versão em transição.

4. A migração acontece gradualmente. Quando tudo for migrado, a versão antiga é descontinuada.

---

## Seção 10 — Glossário Acessível

### Objetivo

Referência rápida para qualquer conceito mencionado no site. Cada definição deve ser compreensível sem ler o resto do conteúdo.

### Conteúdo

| Conceito | O que é | Analogia |
|----------|---------|----------|
| **Product Canon** | Repositório central e versionado onde todo o conhecimento do produto fica formalizado — regras, vocabulário, processos, decisões técnicas. | A constituição do produto: todo mundo segue as mesmas regras, e quando algo muda, existe um processo formal. |
| **Canon Building** | Processo de construir e manter a Product Canon, composto por três sessões formais com aprovação entre cada uma. | Montar a enciclopédia do produto — sessão por sessão, com revisão antes de publicar cada capítulo. |
| **Canonical Change Plan** | Documento que descreve exatamente o que será adicionado ou alterado na Product Canon. Precisa de aprovação antes de ser aplicado. | A "proposta de emenda" à constituição — descreve o que muda e precisa ser votada antes de entrar em vigor. |
| **Domain Builder** | Pessoa de negócio (PO, analista, gestor) que conhece o produto e descreve processos e requisitos em linguagem natural. | O morador da casa — sabe como quer viver nela, mesmo sem ser engenheiro civil. |
| **Architect** | Pessoa técnica que define as regras de arquitetura e valida viabilidade. | O engenheiro estrutural — garante que o prédio fica de pé. |
| **Domain Expert** | Autoridade sobre o significado dos conceitos do negócio. Aprova que o conhecimento registrado é fiel à realidade. | O revisor técnico da enciclopédia — garante que o que está escrito é verdade. |
| **Bounded Context** | Área delimitada do negócio com vocabulário e regras próprias. "Pagamentos" e "Notificações" são contextos diferentes. | Departamentos de uma empresa — cada um tem sua linguagem e suas regras, mesmo fazendo parte do mesmo negócio. |
| **Linguagem Ubíqua** | Vocabulário oficial do produto onde cada palavra tem um significado acordado por todos. | O dicionário da empresa — quando alguém diz "cliente inativo", todo mundo entende a mesma coisa. |
| **Event Storming** | Técnica colaborativa de mapeamento de processos. No ZionKit, é feita via conversa com a IA em vez de post-its em uma parede. | Contar a história do negócio do começo ao fim, e alguém organiza em um mapa enquanto você fala. |
| **SBVR** | Método para escrever regras de negócio de forma precisa mas legível. No ZionKit, a IA faz a tradução — o Domain Builder fala normal e valida o resultado. | Traduzir "o cliente pode cancelar antes de pagar" para "É obrigatório que Pedidos com status 'Pendente' possam ser cancelados pelo titular" — preciso, mas compreensível. |
| **SBE (Specification by Example)** | Técnica que usa exemplos concretos como critérios de aceitação. Em vez de "o sistema deve validar o pagamento", diz "Dado um pagamento de R$ 100 via PIX, quando confirmado, então o saldo é debitado em R$ 100." | Explicar uma regra mostrando casos — como explicar um jogo mostrando jogadas. |
| **ADR (Architecture Decision Record)** | Registro formal de uma decisão técnica: o que foi decidido, por quê, quais alternativas existiam e quais são as consequências. | A ata de uma decisão importante — para que ninguém precise perguntar "por que fizemos assim?" daqui a 6 meses. |
| **Strangler Fig (Versionamento Gradual)** | Padrão para aplicar mudanças grandes de forma gradual. A versão nova cresce ao redor da antiga até substituí-la completamente. | Reformar uma casa morando nela — um cômodo por vez, sem precisar mudar para outro lugar. |
| **Guardrails de Conformidade** | Mecanismos automáticos da IA que identificam quando alguém usa um termo diferente do vocabulário oficial ou propõe algo que contradiz regras existentes. | O corretor ortográfico do produto — se você escreve "cliente" onde o vocabulário define "titular da conta", ele sinaliza. |
| **Injeção Seletiva de Contexto** | A IA não recebe toda a Product Canon de uma vez — apenas os fragmentos relevantes para a tarefa atual. | Levar para a reunião só os documentos que importam para aquele assunto, não o arquivo inteiro. |
| **Retroalimentação** | Processo de devolver à Product Canon as descobertas feitas durante a implementação. | Atualizar o manual depois de montar o móvel, incluindo os passos que estavam faltando. |

---

## Notas de Implementação para o Redator/Designer

1. **Cada seção é autônoma.** O leitor pode entrar em qualquer seção e entender o contexto local. Links entre seções são recomendados, mas não obrigatórios para compreensão.

2. **Camadas de profundidade.** As seções 1-4 e 7 são para todos. As seções 5 e 6 são para quem quer mais detalhe. A seção 8 é para técnicos. A seção 9 é para quem quer ver exemplos. O glossário (seção 10) é referência.

3. **Diagramas são obrigatórios.** Os 8 diagramas descritos neste documento comunicam conceitos que texto sozinho não consegue transmitir. Todos têm descrição funcional — o designer deve traduzi-los visualmente mantendo a comunicação descrita.

4. **Tom.** Direto, sem jargão não explicado, sem frases que não carregam informação. Todo conceito técnico que aparece fora do glossário deve ser explicado no parágrafo em que é mencionado.

5. **Dados de apoio.** Os dados da Seção 2 (estatísticas sobre o cenário atual) podem ser usados como visualizações de impacto ou callouts, mas não devem dominar a narrativa — o site é sobre a solução, não sobre o problema.

---

*Documento gerado como roteiro de conteúdo para o site institucional do ZionKit. Versão 1.0 — Abril 2026.*
