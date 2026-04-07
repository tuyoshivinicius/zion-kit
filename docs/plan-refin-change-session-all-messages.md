User: Na etapa de requisitos como a IA ira utilizar a metodologia SBVR (Semantics of Business Vocabulary and Rules) ? o usuario ira escrever o requisito em linguagem natural e ia com ajuda do SBVR ira tentar transpor o requsitos para o padrão e depois ...?

GitHub Copilot: Based on the model document, the SBVR flow in the Requirements Specification Session works as follows:

**1. Domain Builder escreve em linguagem natural**
O Domain Builder descreve o requisito como ele entende: *"O cliente deve poder cancelar um pedido antes do faturamento."*

**2. IA traduz para SBVR controlado**
A IA transpõe para vocabulário formal com quantificadores e restrições explícitas:
> *"É obrigatório que cada Pedido cujo Status é 'Pendente' ou 'Confirmado' possa ser cancelado pelo Cliente titular. É proibido que um Pedido cujo Status é 'Faturado' seja cancelado."*

**3. Validação pelo Domain Builder**
O Domain Builder lê a formalização e confirma se ela captura sua intenção. Aqui está o risco que o próprio documento reconhece na seção 9.6 — o efeito "rubber stamp", onde o Domain Builder aprova mecanicamente algo que não escreveu.

**4. Confronto com a Product Canon**
A IA cruza a regra formalizada contra o conhecimento já existente. No exemplo do documento, ela descobre que já existe uma regra: *"Pedidos faturados não podem ser cancelados, apenas devolvidos"* — e ajusta a formalização para incluir o caminho de devolução.

**5. Geração de critérios de aceitação via SBE (Specification by Example)**
Os requisitos SBVR são complementados com exemplos concretos verificáveis — cenários com dados reais que demonstram o comportamento esperado.

**6. Canonical Change Plan (`specification-plan`)**
As regras formalizadas, termos novos e critérios de aceitação são empacotados em um Change Plan para aprovação (primária pelo Domain Expert, secundária pelo Architect).

---

**O que o documento não detalha** (e que parece ser o cerne da sua dúvida): a mecânica exata da mediação SBVR — como a IA apresenta a formalização, se há iteração (o Domain Builder pode dizer "não é isso"), se a IA explica as diferenças entre o que foi dito e o que foi formalizado, ou se há um formato visual simplificado para tornar SBVR legível para não-técnicos. A seção 10 (Direções para Prototipação), item 6, reconhece explicitamente que isso precisa ser validado empiricamente: se a IA consegue traduzir com fidelidade, se o Domain Builder consegue compreender e validar, e se o efeito rubber stamp pode ser mitigado.

User: o documento que o aprovador le não deveria estar no formato sbe? e o sbvr apenas para validar?

GitHub Copilot: Sim, essa é uma observação forte e que resolve um problema que o próprio documento reconhece.

**O argumento:** SBVR é abstrato e declarativo — *"É obrigatório que cada Pedido cujo Status é 'Pendente' possa ser cancelado pelo Cliente titular"*. SBE é concreto — *"Dado um Pedido com status 'Pendente' do Cliente João, Quando João solicita cancelamento, Então o status muda para 'Cancelado'"*. Um Domain Expert valida com muito mais segurança um cenário concreto do que uma regra com quantificadores formais.

**O que mudaria no modelo:**

1. **SBVR → camada de validação interna da IA.** A IA traduz o input em linguagem natural para SBVR internamente, usa isso para confrontar com a Product Canon (detectar contradições, gaps, termos inconsistentes), mas não apresenta SBVR como artefato primário para o humano aprovar.

2. **SBE → artefato de aprovação.** O que o Domain Expert e o Domain Builder leem e aprovam são os cenários concretos com dados exemplificados. Isso é o que vai no Canonical Change Plan (`specification-plan`) como artefato legível.

3. **SBVR fica persistido na Product Canon** como representação formal das regras — é o que a IA consulta em ciclos futuros para validação de consistência. Mas o humano não precisa interagir diretamente com ele.

**O que isso resolve:**
- O risco de "rubber stamp" da seção 9.6 é significativamente reduzido — o aprovador lê algo que ele sabe validar (exemplos concretos do domínio dele), não uma formalização que ele pode apenas aceitar passivamente
- A inclusão do Domain Builder se fortalece — ele nunca precisa entender notação SBVR
- A rigorosidade formal se mantém — SBVR continua existindo, mas como infraestrutura de consistência operada pela IA

**O fluxo ficaria:**

```
Domain Builder fala → IA traduz internamente para SBVR → 
IA valida contra Product Canon → IA gera cenários SBE → 
Domain Builder/Expert valida os cenários SBE → 
SBVR é persistido na Canon como regra formal
```

Atualmente o documento descreve o fluxo como "IA traduz para SBVR → apresenta SBVR para validação do Domain Builder". A sua proposta inverte a superfície de interação: SBVR vira infraestrutura, SBE vira interface. O modelo ganha em acessibilidade sem perder em rigor.

User: Quais os pros e contras dessa mudança ela é aderente a filosofia central do modelo ou impacta na direção de volução quais os tradeoff?

GitHub Copilot: ## Análise: SBVR como infraestrutura, SBE como interface de aprovação

### Aderência à filosofia central

A mudança é **altamente aderente** a três princípios de design do modelo:

- **Separação de autoridade** — cada papel interage com o artefato que consegue validar com competência real. O Domain Expert valida cenários concretos (SBE), não formalização lógica. Isso fortalece a separação em vez de enfraquecê-la.
- **IA sem autonomia decisória** — a IA continua propondo (traduz para SBVR, gera cenários SBE), humanos continuam decidindo. A mudança é sobre *qual artefato* o humano valida, não sobre *quem decide*.
- **Prevenção sobre detecção** — SBVR como camada de validação interna da IA torna a prevenção mais robusta. Hoje o SBVR depende do humano lê-lo e validá-lo (risco de rubber stamp). Com a mudança, o SBVR é operado pela IA para detectar inconsistências, e o humano valida via cenários que ele de fato entende.

### Prós

1. **Elimina o risco mais grave do modelo atual (seção 9.6).** O efeito rubber stamp não é um risco menor — ele invalida a premissa de inclusão do Domain Builder. Se o aprovador não entende o que aprova, o gate é teatro.

2. **Fortalece o diferencial de inclusão.** O Domain Builder nunca precisa ver notação formal. Ele fala, a IA processa, ele valida cenários com dados do domínio dele. A barreira de entrada cai.

3. **SBE é naturalmente verificável.** Cenários concretos podem ser transformados em testes automatizados. SBVR não tem esse caminho direto. Isso cria um benefício colateral: os artefatos de aprovação são também artefatos de teste.

4. **SBVR ganha mais valor, não menos.** Livre da necessidade de ser legível para humanos, SBVR pode ser mais rigoroso. A IA pode usar formalização completa (com quantificadores, predicados compostos) sem preocupação com acessibilidade.

### Contras

1. **Opacidade da camada formal.** Se SBVR é infraestrutura invisível, o humano perde visibilidade sobre *como* a IA está representando formalmente suas regras. Se a tradução SBVR estiver errada, o cenário SBE gerado a partir dela pode parecer correto mas carregar um erro de formalização que só se manifesta em edge cases não cobertos pelos exemplos.

   > Exemplo: o SBVR formaliza "cada Pedido **pode** ser cancelado" quando o Domain Builder disse "**deve** poder ser cancelado". Os cenários SBE do caminho feliz passam, mas a modalidade errada (permissão vs. obrigação) pode gerar código que não impõe o cancelamento como direito garantido.

2. **SBE tem um problema de cobertura.** Cenários são concretos por definição — cobrem casos específicos, não regras universais. SBVR expressa invariantes ("É proibido que X"). SBE demonstra instâncias ("Dado X, Quando Y, Então Z"). Se o aprovador só vê instâncias, ele pode aprovar algo que cobre os exemplos mostrados mas não captura a regra completa.

3. **Dependência aumentada na qualidade da IA.** Hoje, se a tradução SBVR está errada, o humano pode (em tese) detectar. Com a mudança, o humano só vê SBE — a qualidade da formalização SBVR depende inteiramente da IA. Isso intensifica o risco da seção 9.1 (qualidade do guardrail de conformidade).

4. **Perda de rastreabilidade para o Architect.** O Architect na aprovação secundária pode querer ver a formalização SBVR, não apenas os cenários. Ele tem competência para validá-la. Tornar SBVR invisível para todos os papéis pode ser excessivo.

### Tradeoffs centrais

| Dimensão | Com a mudança | Sem a mudança |
|----------|--------------|---------------|
| Inclusão do Domain Builder | Maximizada — nunca vê SBVR | Comprometida pelo rubber stamp |
| Rigor formal | Depende inteiramente da IA | Tem checkpoint humano (mesmo que frágil) |
| Cobertura de validação | Limitada aos cenários SBE gerados | SBVR expressa regras universais, mas humano pode não entendê-las |
| Risco de erro silencioso | Erro na tradução SBVR não tem checkpoint | Erro na tradução SBVR tem checkpoint (frágil) |
| Complexidade do modelo | Mais simples para o usuário, mais complexa internamente | Mais complexa para o usuário, mais simples internamente |

### Impacto na direção de evolução

A mudança **não** altera a arquitetura do modelo — as três etapas, os quatro papéis, os Canonical Change Plans, os gates, tudo se mantém. Ela altera a **superfície de interação** da Requirements Specification Session.

O risco de evolução é: se o modelo seguir nessa direção, ele precisa resolver o problema de cobertura do SBE. Uma possível mitigação é a IA gerar cenários SBE **derivados** do SBVR de forma sistemática — incluindo cenários negativos, edge cases e violações — em vez de gerar apenas o caminho feliz. Mas isso precisa ser validado na prototipação.

### Sugestão de meio-termo

Em vez de tornar SBVR completamente invisível:

- **Domain Builder e Domain Expert** — veem apenas SBE (cenários concretos)
- **Architect** — tem acesso ao SBVR formalizado como artefato de referência (não como artefato de aprovação primária, mas como recurso de inspeção)
- **Product Canon** — persiste ambos: SBVR como representação formal, SBE como representação verificável

Isso preserva a inclusão sem eliminar completamente a rastreabilidade formal.

User: e se apresentarmos os dois pra ele tanto o sbvr e sbe, um não deveria complementar o outro na aprovação oque acha?

GitHub Copilot: Essa é provavelmente a posição mais robusta das três. Veja por quê:

**O problema das duas alternativas anteriores é que cada uma descarta informação:**

- Só SBVR → o aprovador vê a regra universal mas não tem certeza de que entendeu o que ela significa na prática
- Só SBE → o aprovador vê exemplos concretos mas não sabe se eles capturam a regra completa

Apresentar os dois cria um **mecanismo de verificação cruzada** que nenhum dos dois sozinho oferece. O aprovador lê o cenário SBE e entende *o que acontece*. Lê o SBVR e entende *a regra que governa*. Se os dois não casam na cabeça dele, ele sinaliza.

**Exemplo concreto:**

```
REGRA (SBVR):
  "É obrigatório que cada Pedido cujo Status é 'Pendente' 
   ou 'Confirmado' possa ser cancelado pelo Cliente titular.
   É proibido que um Pedido cujo Status é 'Faturado' 
   seja cancelado."

CENÁRIOS (SBE):
  Dado um Pedido #1234 com status "Pendente" do Cliente João
  Quando João solicita cancelamento
  Então o status muda para "Cancelado"

  Dado um Pedido #5678 com status "Faturado" do Cliente Maria  
  Quando Maria solicita cancelamento
  Então o sistema rejeita com mensagem "Pedidos faturados 
    não podem ser cancelados. Deseja solicitar devolução?"
```

O Domain Expert lê os cenários e pensa: "sim, é assim que funciona". Lê a regra SBVR e pensa: "espera — a regra diz 'Pendente' ou 'Confirmado', mas e o status 'Em Separação'? O cliente pode cancelar nesse momento?" O cenário SBE não cobriu esse caso. A regra SBVR, por ser universal, torna a ausência visível.

**O que isso resolve que as outras opções não resolvem:**

- Elimina o rubber stamp — o aprovador tem dois formatos diferentes para contrastar, não um formato opaco para aceitar
- Preserva a cobertura universal do SBVR — edge cases não cobertos pelos exemplos ficam visíveis na regra formal
- Mantém a acessibilidade do SBE — o Domain Builder que não entende SBVR ainda tem os cenários como âncora
- O Architect se beneficia dos dois — SBVR para validar precisão formal, SBE para validar que a formalização corresponde à intenção

**O tradeoff real:**

O custo é **volume do artefato de aprovação**. O Canonical Change Plan (`specification-plan`) fica mais denso — cada requisito tem tanto a regra formal quanto os cenários. Em um Change Plan com 15-20 requisitos, isso pode tornar o artefato extenso e reduzir a atenção do aprovador. Mas esse é um problema de apresentação (colapsável, organizado por bounded context), não de modelo.

**Como isso se encaixa no modelo:**

A seção 2.2.3 mudaria de "a IA traduz para SBVR e apresenta para validação" para algo como:

> A IA traduz o input em linguagem natural para SBVR controlado (regra formal) e gera cenários SBE correspondentes (exemplos concretos). Ambos são apresentados ao Domain Builder como par complementar: a regra declara a invariante, os cenários demonstram-na. O Domain Builder valida se os cenários refletem a realidade do domínio e se a regra formal captura a intenção completa. A verificação cruzada entre os dois formatos reduz tanto o risco de rubber stamp (o aprovador tem material concreto para ancorar) quanto o risco de cobertura insuficiente (a regra universal torna visíveis os cenários ausentes).

A Product Canon persiste ambos — SBVR como representação formal consumível pela IA para validação de consistência, SBE como representação verificável que pode ser transformada em testes automatizados. Ambos servem a funções distintas no ciclo.

Essa opção é a mais coerente com o princípio de **prevenção sobre detecção** — mais superfícies de validação antes do código, sem eliminar nenhuma.

User: escreva um texto simples propondo mudanças no modelo especiamente na fase de requisitos, conforme conversamos nesta sessao

GitHub Copilot: 

Aqui está o texto:

---

## Proposta: Par Complementar SBVR + SBE na Requirements Specification Session

### Contexto

Na versão atual do modelo (v0.5), a Requirements Specification Session descreve o fluxo de formalização de requisitos da seguinte forma: o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e apresenta a formalização SBVR para validação do Domain Builder. SBE é mencionado como complemento para critérios de aceitação verificáveis, mas o artefato primário de validação é o SBVR.

Essa abordagem tem um problema reconhecido pelo próprio modelo na seção 9.6: o risco de "rubber stamp". O Domain Builder pode aprovar mecanicamente uma formalização SBVR que ele não escreveu e que pode não compreender plenamente. Se isso acontece, o gate de aprovação perde valor real — o aprovador valida sem entender, e o diferencial de inclusão do modelo é comprometido.

### Mudança proposta

Redefinir o papel de SBVR e SBE na Requirements Specification Session e na Product Canon, estabelecendo-os como par complementar com funções distintas:

**SBVR — representação formal (regra universal).** A IA traduz o input em linguagem natural para SBVR controlado. O SBVR expressa invariantes e restrições com quantificadores formais ("É obrigatório que cada Pedido cujo Status é 'Pendente' ou 'Confirmado' possa ser cancelado pelo Cliente titular"). É persistido na Product Canon como representação formal das regras de negócio, consumível pela IA para validação de consistência em ciclos futuros.

**SBE — representação verificável (cenário concreto).** A IA gera cenários SBE derivados do SBVR formalizado, incluindo caminhos positivos, negativos e edge cases. Os cenários demonstram a regra com dados concretos do domínio ("Dado um Pedido #1234 com status 'Pendente' do Cliente João, Quando João solicita cancelamento, Então o status muda para 'Cancelado'"). São persistidos na Product Canon como representação verificável, transformável em testes automatizados.

**Ambos são apresentados ao aprovador como par.** O Domain Builder e o Domain Expert recebem tanto a regra formal (SBVR) quanto os cenários concretos (SBE). A verificação cruzada entre os dois formatos permite que o aprovador:

- Leia os cenários SBE e entenda *o que acontece na prática*
- Leia a regra SBVR e entenda *qual invariante governa o comportamento*
- Identifique, pela tensão entre os dois, cenários ausentes que a regra cobre mas os exemplos não demonstraram

O Architect, na aprovação secundária, se beneficia especialmente do SBVR para validar precisão formal e do SBE para confirmar que a formalização corresponde à intenção de negócio.

### O que muda no fluxo da cerimônia

**Antes (v0.5):**
```
Domain Builder fala → IA traduz para SBVR → 
apresenta SBVR para validação → Domain Builder aprova
```

**Depois:**
```
Domain Builder fala → IA traduz internamente para SBVR → 
IA valida SBVR contra Product Canon (consistência) → 
IA gera cenários SBE derivados do SBVR →
IA apresenta par SBVR + SBE para validação →
Domain Builder/Expert valida usando verificação cruzada → 
ambos são persistidos na Product Canon
```

### O que muda na Product Canon

A seção 5 (Estrutura de Artefatos) passa a refletir explicitamente a dualidade:

- **Regras de negócio (SBVR)**: representação formal das invariantes, usada pela IA como infraestrutura de validação de consistência
- **Cenários de aceitação (SBE)**: representação verificável derivada das regras SBVR, usada por humanos como superfície primária de validação e por ferramentas como base para testes automatizados

### O que muda no Canonical Change Plan (specification-plan)

Cada requisito no Change Plan passa a conter ambas as representações, organizadas como par:

```
REQUISITO: Cancelamento de Pedido
──────────────────────────────────

  REGRA (SBVR):
    É obrigatório que cada Pedido cujo Status é 'Pendente' 
    ou 'Confirmado' possa ser cancelado pelo Cliente titular.
    É proibido que um Pedido cujo Status é 'Faturado' 
    seja cancelado.

  CENÁRIOS (SBE):
    Dado um Pedido #1234 com status "Pendente" do Cliente João
    Quando João solicita cancelamento
    Então o status muda para "Cancelado"
    E o evento PedidoCancelado é emitido

    Dado um Pedido #5678 com status "Faturado" do Cliente Maria
    Quando Maria solicita cancelamento
    Então o sistema rejeita com mensagem 
      "Pedidos faturados não podem ser cancelados. 
       Deseja solicitar devolução?"
```

### O que muda na seção de riscos

A seção 9.6 (Curva de aprendizado SBVR) é reformulada. O risco de rubber stamp é significativamente reduzido — não eliminado — porque o aprovador agora tem dois formatos complementares para contrastar, em vez de um formato opaco para aceitar. O risco residual migra para: (a) volume do artefato de aprovação, que pode reduzir atenção do aprovador quando há muitos requisitos; e (b) qualidade da geração de cenários SBE pela IA, que pode não cobrir edge cases relevantes. A mitigação para (a) é organização do Change Plan por bounded context com seções colapsáveis. A mitigação para (b) é a própria verificação cruzada — a regra SBVR torna visíveis as lacunas dos cenários.

### Impacto no modelo

A mudança não altera a arquitetura do ZionKit — as três etapas, os quatro papéis, os Canonical Change Plans, os gates e os guardrails se mantêm. O que muda é a superfície de interação da Requirements Specification Session e o formato dos artefatos de requisitos na Product Canon e nos Change Plans. A mudança é coerente com os princípios de design existentes: fortalece a prevenção sobre detecção (mais superfícies de validação), respeita a separação de autoridade (cada papel valida no formato que melhor compreende), e mantém a IA sem autonomia decisória (ela gera ambos os artefatos, humanos validam).

---

Quer que eu aplique essas mudanças diretamente no documento do modelo?

User: Reescreva o texto adicionando os seguintes escopos a mudança:

O Domain Expert é um papel que alem de validação pode tamber estar no processo de licitação, no processo de aprovação ele pode escrever no documento de volta, marcar hotspots e alem disso deve existir um processo novo pra que ele possa editar os artefatos diretos na product canon (somente da camada de negocio) o processo de edição dele não ira envolver ia para editar, porem suas alteração devem ser passadas pelos guardrails de clarificação e validação antes de gerar um Canonical Change Plans, seu Canonical Change Plans deve ser avaliado e aprovado obrigatoriamente pelo arquiteto, e sua caninização deve passar pelo processo de guardrails responsavel pelo versionamento. 
o processo deve ser tratado pelo modelo como extremamento sensivel e não deve substituir o processo de licitação classico do modelo.

GitHub Copilot: Aqui está o texto reescrito com ambos os escopos integrados:

---

## Proposta de Evolução do Modelo — v0.6

### 1. Par Complementar SBVR + SBE na Requirements Specification Session

#### Contexto

Na versão v0.5, a Requirements Specification Session descreve o seguinte fluxo: o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e apresenta a formalização SBVR para validação. SBE é mencionado como complemento para critérios de aceitação, mas o artefato primário de validação é o SBVR.

Essa abordagem tem um problema reconhecido na seção 9.6: o risco de "rubber stamp". O Domain Builder pode aprovar mecanicamente uma formalização que não compreende. Se isso acontece, o gate de aprovação perde valor real e o diferencial de inclusão do modelo é comprometido.

#### Mudança proposta

Redefinir SBVR e SBE como par complementar com funções distintas e apresentação conjunta.

**SBVR — representação formal (regra universal).** A IA traduz o input em linguagem natural para SBVR controlado. O SBVR expressa invariantes e restrições com quantificadores formais. É persistido na Product Canon como representação formal das regras de negócio, consumível pela IA para validação de consistência em ciclos futuros.

**SBE — representação verificável (cenário concreto).** A IA gera cenários SBE derivados do SBVR formalizado, incluindo caminhos positivos, negativos e edge cases. Os cenários demonstram a regra com dados concretos do domínio. São persistidos na Product Canon como representação verificável, transformável em testes automatizados.

**Ambos são apresentados ao aprovador como par.** A verificação cruzada entre os dois formatos permite que o aprovador: leia os cenários SBE e entenda o que acontece na prática; leia a regra SBVR e entenda qual invariante governa o comportamento; identifique, pela tensão entre os dois, cenários ausentes que a regra cobre mas os exemplos não demonstraram.

#### Fluxo revisado da cerimônia

```
Domain Builder fala → IA traduz internamente para SBVR → 
IA valida SBVR contra Product Canon (consistência) → 
IA gera cenários SBE derivados do SBVR →
IA apresenta par SBVR + SBE para validação →
Domain Builder/Expert valida usando verificação cruzada → 
ambos são persistidos na Product Canon
```

#### Impacto na Product Canon

A seção de Estrutura de Artefatos passa a refletir a dualidade:

- **Regras de negócio (SBVR)**: representação formal das invariantes, usada pela IA como infraestrutura de validação de consistência
- **Cenários de aceitação (SBE)**: representação verificável derivada das regras SBVR, usada por humanos como superfície primária de validação e por ferramentas como base para testes automatizados

#### Formato no Canonical Change Plan (specification-plan)

Cada requisito no Change Plan contém ambas as representações, organizadas como par:

```
REQUISITO: Cancelamento de Pedido
──────────────────────────────────

  REGRA (SBVR):
    É obrigatório que cada Pedido cujo Status é 'Pendente' 
    ou 'Confirmado' possa ser cancelado pelo Cliente titular.
    É proibido que um Pedido cujo Status é 'Faturado' 
    seja cancelado.

  CENÁRIOS (SBE):
    Dado um Pedido #1234 com status "Pendente" do Cliente João
    Quando João solicita cancelamento
    Então o status muda para "Cancelado"
    E o evento PedidoCancelado é emitido

    Dado um Pedido #5678 com status "Faturado" do Cliente Maria
    Quando Maria solicita cancelamento
    Então o sistema rejeita com mensagem 
      "Pedidos faturados não podem ser cancelados. 
       Deseja solicitar devolução?"
```

#### Impacto na seção de riscos

A seção 9.6 é reformulada. O risco de rubber stamp é significativamente reduzido porque o aprovador tem dois formatos complementares para contrastar. O risco residual migra para: (a) volume do artefato de aprovação, mitigado por organização por bounded context; e (b) qualidade da geração de cenários SBE pela IA, mitigado pela verificação cruzada — a regra SBVR torna visíveis as lacunas dos cenários.

---

### 2. Expansão do Papel do Domain Expert: Aprovação Ativa e Edição Direta

#### Contexto

Na versão v0.5, o Domain Expert é definido como guardião semântico passivo: aprova ou veta Canonical Change Plans, mas não participa diretamente das cerimônias nem edita artefatos. Sua interação com a Product Canon é exclusivamente mediada pelos gates de aprovação.

Essa definição subestima o valor do Domain Expert no ciclo. Na prática, a validação semântica frequentemente produz insights que precisam ser capturados no momento — termos que precisam de nuance, regras que precisam de ressalva, áreas de risco que precisam ser sinalizadas. Forçar esses insights a fluir exclusivamente pelas cerimônias formais cria atrito desnecessário e risco de perda de conhecimento.

#### 2.1 Aprovação Ativa com Anotações

A mudança redefine a aprovação do Domain Expert como processo ativo, não binário. Durante a avaliação de qualquer Canonical Change Plan (nos gates das cerimônias ou na Etapa 2), o Domain Expert pode:

**Anotar o artefato.** Escrever observações, ressalvas ou complementos diretamente no documento sob revisão. Essas anotações ficam registradas como parte do histórico de aprovação e podem influenciar a formalização final.

**Marcar hotspots.** Sinalizar trechos como áreas de risco, ambiguidade residual ou conhecimento incompleto. Hotspots são metadados visíveis que acompanham o artefato na Product Canon e alertam qualquer pessoa que trabalhe com aquele trecho no futuro. Um hotspot não impede a aprovação — ele registra formalmente que existe incerteza reconhecida naquele ponto.

**Exemplo de hotspot:**

```
REGRA (SBVR):
  É obrigatório que cada Reembolso cujo valor excede R$ 500 
  seja aprovado pelo Gerente de operações.

  ⚠ HOTSPOT (Domain Expert, 2026-04-07):
  "Limite de R$ 500 está defasado — será revisado no Q3. 
   Regra válida até renegociação contratual com operadoras."
```

Hotspots são artefatos rastreáveis: têm autor, data e descrição. A IA pode sinalizá-los quando uma especificação futura tocar o trecho marcado, alertando o autor da spec sobre a incerteza registrada.

#### 2.2 Edição Direta da Product Canon pelo Domain Expert

Além da aprovação ativa, o Domain Expert ganha a capacidade de editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal.

**Este é um processo extremamente sensível.** A edição direta existe para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Ela **não substitui o processo de elicitação clássico do modelo**. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais (Domain Discovery, Requirements Specification). A edição direta é um canal complementar de manutenção, não uma via alternativa de construção.

**Restrições da edição direta:**

1. **Escopo limitado à camada de negócio.** O Domain Expert não edita artefatos da camada de arquitetura (princípios técnicos constitucionais, eventos de domínio, schemas, context maps, ADRs). A autoridade sobre a camada técnica permanece exclusivamente com o Architect.

2. **Sem mediação da IA para a edição.** O Domain Expert escreve diretamente nos artefatos, em linguagem natural ou SBVR (se tiver proficiência). A IA não participa da redação — a autoria é integralmente do Domain Expert.

3. **Guardrails obrigatórios pós-edição.** As alterações do Domain Expert, antes de gerar um Canonical Change Plan, são submetidas automaticamente aos guardrails da Product Canon:
   - **Clarificação de Conformidade**: a IA verifica se os termos utilizados são consistentes com o glossário de linguagem ubíqua existente. Se o Domain Expert usa "usuário" onde a Canon define "titular da conta", a divergência é sinalizada e precisa ser resolvida.
   - **Validação de Consistência**: a IA confronta as alterações com o estado atual da Product Canon — tanto as regras de negócio existentes quanto os princípios técnicos constitucionais. Contradições são identificadas e devem ser resolvidas antes do Change Plan ser gerado.

4. **Canonical Change Plan obrigatório.** Após passar pelos guardrails, as alterações são empacotadas em um Canonical Change Plan tipado como `expert-edit-plan`. Este tipo distingue formalmente edições diretas de artefatos produzidos por cerimônias, preservando rastreabilidade sobre a origem de cada mudança.

5. **Aprovação obrigatória pelo Architect.** O Canonical Change Plan do Domain Expert requer aprovação obrigatória do Architect — mesmo que as alterações sejam exclusivamente na camada de negócio. Essa exigência é deliberadamente mais restritiva que os gates das cerimônias (onde o Architect é aprovador secundário). A justificativa: edições diretas não passaram pelo processo de elicitação completo — não houve sessão de descoberta, não houve mediação pela IA durante a construção, não houve verificação cruzada com outros participantes. A aprovação obrigatória do Architect compensa a ausência dessas camadas de validação, funcionando como checkpoint técnico que garante que uma alteração na camada de negócio não tem implicações arquiteturais não percebidas pelo Domain Expert.

6. **Versionamento por Estrangulamento.** A canonização das alterações aprovadas segue o mesmo mecanismo de Versionamento Gradual por Estrangulamento que governa todas as outras mudanças na Product Canon. Alterações pontuais (ajuste de definição, correção factual) podem ser integradas diretamente à versão current. Alterações com impacto mais amplo (redefinição de conceito usado em múltiplos contextos, mudança de regra com dependências) devem ser versionadas como transição (next), seguindo os mesmos critérios de criticidade aplicados às cerimônias formais.

#### Fluxo da edição direta

```
Domain Expert edita artefato da camada de negócio →
Guardrail: Clarificação de Conformidade (termos) →
Guardrail: Validação de Consistência (regras + princípios) →
  Se divergências: Domain Expert resolve antes de prosseguir →
Canonical Change Plan (expert-edit-plan) é gerado →
Architect avalia e aprova (obrigatório) →
  Se aprovado: canonização via Versionamento por Estrangulamento →
  Se rejeitado: Architect justifica; Domain Expert pode 
    ajustar e resubmeter ou escalar para cerimônia formal
```

#### Salvaguardas contra uso indevido

O modelo trata a edição direta como canal de exceção, não de rotina, através de mecanismos que preservam a primazia das cerimônias formais:

- **Tipagem distinta do Change Plan** (`expert-edit-plan`): permite auditoria e análise de frequência. Se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal de que o processo de elicitação está sendo contornado.
- **Aprovação do Architect obrigatória e não delegável**: diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente. Isso introduz fricção deliberada — suficiente para desencorajar uso casual, insuficiente para impedir correções legítimas.
- **Ausência de mediação da IA na redação**: o Domain Expert assume responsabilidade integral pelo conteúdo. Não há "tradução assistida" como nas cerimônias. Isso é tanto uma restrição (maior risco de imprecisão) quanto uma salvaguarda (o Domain Expert não pode delegar a autoria para a IA fora do contexto formal).

#### Exemplo — edição direta legítima

O Banco Central publica nova regulamentação: reembolsos de PIX passam a ter prazo máximo de 72 horas (antes era 48 horas). O Domain Expert da área de Pagamentos atualiza diretamente a regra de negócio na Product Canon:

```
[ANTES]
  "Reembolsos de transações PIX devem ser processados 
   em até 48 horas após a solicitação."

[DEPOIS]
  "Reembolsos de transações PIX devem ser processados 
   em até 72 horas após a solicitação."
```

A IA valida que o termo "reembolso" está conforme o glossário, que a alteração não contradiz outras regras, e que não há impacto nos princípios técnicos constitucionais. O Change Plan (`expert-edit-plan`) é gerado e submetido ao Architect. O Architect verifica que a mudança de prazo pode impactar timeouts configurados no sistema e aprova com nota: "Verificar configuração de timeout no serviço de reembolso PIX — pode exigir ADR."

#### Exemplo — edição direta que deve ser redirecionada para cerimônia

O Domain Expert tenta adicionar um novo conceito: "Reembolso Parcial por Item" — uma modalidade que não existe na Product Canon. O guardrail de Validação de Consistência identifica que esse conceito introduz um novo tipo de reembolso com implicações em múltiplos bounded contexts (Pedidos, Pagamentos, Faturamento). O Change Plan é gerado, mas o Architect rejeita com justificativa: "Conceito novo com impacto cross-context. Requer Domain Discovery Session para mapeamento completo." A alteração é redirecionada para o fluxo de cerimônias.

#### Impacto no papel do Domain Expert

A tabela de atuação por etapa (seção 4) é atualizada:

| Papel | Etapa 1 — Canon Building | Etapa 2 — Especificação | Etapa 3 — Retroalimentação | Edição Direta |
|-------|------------------------|------------------------|---------------------------|---------------|
| Domain Expert | Aprova primariamente Discovery e Specification (com anotações e hotspots); aprova secundariamente Constitution | Aprova camada de negócio do Canonical Change Plan incremental (com anotações e hotspots) | — | Edita artefatos da camada de negócio; alterações passam por guardrails e aprovação obrigatória do Architect |

#### Impacto nos riscos

**Novo risco: erosão das cerimônias.** Se a edição direta for usada excessivamente, o valor das cerimônias formais degrada. A tipagem distinta (`expert-edit-plan`) e a aprovação obrigatória do Architect são mitigações estruturais. A frequência de uso deve ser monitorada na prototipação.

**Novo risco: inconsistência por autoria não mediada.** Sem mediação da IA na redação, o Domain Expert pode introduzir imprecisões terminológicas que os guardrails pós-edição não detectem completamente. Mitigação: os guardrails de Clarificação de Conformidade operam sobre o texto editado, e o Architect funciona como checkpoint adicional.

---

### 3. Resumo das Mudanças

| Aspecto | v0.5 | Proposta v0.6 |
|---------|------|---------------|
| Artefato de aprovação na Requirements Specification | SBVR apresentado isoladamente | Par SBVR + SBE apresentado conjuntamente para verificação cruzada |
| Persistência na Product Canon | SBVR e SBE como artefatos separados e fracamente conectados | SBVR e SBE como par complementar: regra formal + cenários derivados |
| Papel do Domain Expert na aprovação | Binário (aprova/veta) | Ativo: anota, complementa e marca hotspots |
| Acesso do Domain Expert à Product Canon | Somente via gates de aprovação | Edição direta da camada de negócio com guardrails e aprovação obrigatória do Architect |
| Tipos de Canonical Change Plan | `discovery-plan`, `constitution-plan`, `specification-plan` | Adição de `expert-edit-plan` |
| Risco de rubber stamp (seção 9.6) | Mitigado apenas pela mediação da IA | Reduzido pela verificação cruzada SBVR+SBE e pela aprovação ativa com anotações |

### 4. Coerência com os Princípios de Design

**Prevenção sobre detecção** — ambas as mudanças adicionam superfícies de validação antes do código. O par SBVR+SBE permite detecção de gaps pela verificação cruzada. Hotspots registram formalmente incertezas antes que se tornem defeitos.

**Separação de autoridade** — a edição direta respeita a fronteira: Domain Expert edita somente a camada de negócio, Architect mantém autoridade sobre a camada técnica e funciona como checkpoint obrigatório. Nenhum papel absorve responsabilidade do outro.

**IA sem autonomia decisória** — na edição direta, a IA opera exclusivamente nos guardrails pós-edição (sinaliza divergências, identifica contradições), nunca na redação. A autoria é integralmente humana. Nas cerimônias, a IA continua mediando mas não decidindo.

**Governança por cerimônia** — a edição direta não viola este princípio porque é tratada como canal complementar com fricção deliberada, não como via alternativa de construção. A tipagem distinta do Change Plan (`expert-edit-plan`) e a aprovação obrigatória do Architect preservam a rastreabilidade e a governança. As cerimônias permanecem como processo primário e preferencial.

---

*Proposta de evolução para a versão 0.6 do modelo conceitual ZionKit.*

User: Reescreva o texto adicionando os seguintes escopos a mudança:

No novo processo onde o domain expert pode editar diretamente na product canon, esclareça que a clarificação e validação ira ocorrer antes de gerar o Caninical Change Plan, por tanto a cada edição o Domain expert tera a oportunidade de ajustar manualmente porem sendo guiado por um relatorio ou até mesmo processo conversacional que sugira mudanças e não que as faça, dado que neste processo o domain expert esta no controle.

GitHub Copilot: Aqui está o texto completo reescrito:

---

## Proposta de Evolução do Modelo — v0.6

### 1. Par Complementar SBVR + SBE na Requirements Specification Session

#### Contexto

Na versão v0.5, a Requirements Specification Session descreve o seguinte fluxo: o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e apresenta a formalização SBVR para validação. SBE é mencionado como complemento para critérios de aceitação, mas o artefato primário de validação é o SBVR.

Essa abordagem tem um problema reconhecido na seção 9.6: o risco de "rubber stamp". O Domain Builder pode aprovar mecanicamente uma formalização que não compreende. Se isso acontece, o gate de aprovação perde valor real e o diferencial de inclusão do modelo é comprometido.

#### Mudança proposta

Redefinir SBVR e SBE como par complementar com funções distintas e apresentação conjunta.

**SBVR — representação formal (regra universal).** A IA traduz o input em linguagem natural para SBVR controlado. O SBVR expressa invariantes e restrições com quantificadores formais. É persistido na Product Canon como representação formal das regras de negócio, consumível pela IA para validação de consistência em ciclos futuros.

**SBE — representação verificável (cenário concreto).** A IA gera cenários SBE derivados do SBVR formalizado, incluindo caminhos positivos, negativos e edge cases. Os cenários demonstram a regra com dados concretos do domínio. São persistidos na Product Canon como representação verificável, transformável em testes automatizados.

**Ambos são apresentados ao aprovador como par.** A verificação cruzada entre os dois formatos permite que o aprovador: leia os cenários SBE e entenda o que acontece na prática; leia a regra SBVR e entenda qual invariante governa o comportamento; identifique, pela tensão entre os dois, cenários ausentes que a regra cobre mas os exemplos não demonstraram.

#### Fluxo revisado da cerimônia

```
Domain Builder fala → IA traduz internamente para SBVR → 
IA valida SBVR contra Product Canon (consistência) → 
IA gera cenários SBE derivados do SBVR →
IA apresenta par SBVR + SBE para validação →
Domain Builder/Expert valida usando verificação cruzada → 
ambos são persistidos na Product Canon
```

#### Impacto na Product Canon

A seção de Estrutura de Artefatos passa a refletir a dualidade:

- **Regras de negócio (SBVR)**: representação formal das invariantes, usada pela IA como infraestrutura de validação de consistência
- **Cenários de aceitação (SBE)**: representação verificável derivada das regras SBVR, usada por humanos como superfície primária de validação e por ferramentas como base para testes automatizados

#### Formato no Canonical Change Plan (specification-plan)

Cada requisito no Change Plan contém ambas as representações, organizadas como par:

```
REQUISITO: Cancelamento de Pedido
──────────────────────────────────

  REGRA (SBVR):
    É obrigatório que cada Pedido cujo Status é 'Pendente' 
    ou 'Confirmado' possa ser cancelado pelo Cliente titular.
    É proibido que um Pedido cujo Status é 'Faturado' 
    seja cancelado.

  CENÁRIOS (SBE):
    Dado um Pedido #1234 com status "Pendente" do Cliente João
    Quando João solicita cancelamento
    Então o status muda para "Cancelado"
    E o evento PedidoCancelado é emitido

    Dado um Pedido #5678 com status "Faturado" do Cliente Maria
    Quando Maria solicita cancelamento
    Então o sistema rejeita com mensagem 
      "Pedidos faturados não podem ser cancelados. 
       Deseja solicitar devolução?"
```

#### Impacto na seção de riscos

A seção 9.6 é reformulada. O risco de rubber stamp é significativamente reduzido porque o aprovador tem dois formatos complementares para contrastar. O risco residual migra para: (a) volume do artefato de aprovação, mitigado por organização por bounded context; e (b) qualidade da geração de cenários SBE pela IA, mitigado pela verificação cruzada — a regra SBVR torna visíveis as lacunas dos cenários.

---

### 2. Expansão do Papel do Domain Expert: Aprovação Ativa e Edição Direta

#### Contexto

Na versão v0.5, o Domain Expert é definido como guardião semântico passivo: aprova ou veta Canonical Change Plans, mas não participa diretamente das cerimônias nem edita artefatos. Sua interação com a Product Canon é exclusivamente mediada pelos gates de aprovação.

Essa definição subestima o valor do Domain Expert no ciclo. Na prática, a validação semântica frequentemente produz insights que precisam ser capturados no momento — termos que precisam de nuance, regras que precisam de ressalva, áreas de risco que precisam ser sinalizadas. Forçar esses insights a fluir exclusivamente pelas cerimônias formais cria atrito desnecessário e risco de perda de conhecimento.

#### 2.1 Aprovação Ativa com Anotações

A mudança redefine a aprovação do Domain Expert como processo ativo, não binário. Durante a avaliação de qualquer Canonical Change Plan (nos gates das cerimônias ou na Etapa 2), o Domain Expert pode:

**Anotar o artefato.** Escrever observações, ressalvas ou complementos diretamente no documento sob revisão. Essas anotações ficam registradas como parte do histórico de aprovação e podem influenciar a formalização final.

**Marcar hotspots.** Sinalizar trechos como áreas de risco, ambiguidade residual ou conhecimento incompleto. Hotspots são metadados visíveis que acompanham o artefato na Product Canon e alertam qualquer pessoa que trabalhe com aquele trecho no futuro. Um hotspot não impede a aprovação — ele registra formalmente que existe incerteza reconhecida naquele ponto.

**Exemplo de hotspot:**

```
REGRA (SBVR):
  É obrigatório que cada Reembolso cujo valor excede R$ 500 
  seja aprovado pelo Gerente de operações.

  ⚠ HOTSPOT (Domain Expert, 2026-04-07):
  "Limite de R$ 500 está defasado — será revisado no Q3. 
   Regra válida até renegociação contratual com operadoras."
```

Hotspots são artefatos rastreáveis: têm autor, data e descrição. A IA pode sinalizá-los quando uma especificação futura tocar o trecho marcado, alertando o autor da spec sobre a incerteza registrada.

#### 2.2 Edição Direta da Product Canon pelo Domain Expert

Além da aprovação ativa, o Domain Expert ganha a capacidade de editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal.

**Este é um processo extremamente sensível.** A edição direta existe para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Ela **não substitui o processo de elicitação clássico do modelo**. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais (Domain Discovery, Requirements Specification). A edição direta é um canal complementar de manutenção, não uma via alternativa de construção.

**Restrições da edição direta:**

1. **Escopo limitado à camada de negócio.** O Domain Expert não edita artefatos da camada de arquitetura (princípios técnicos constitucionais, eventos de domínio, schemas, context maps, ADRs). A autoridade sobre a camada técnica permanece exclusivamente com o Architect.

2. **Sem mediação da IA para a edição.** O Domain Expert escreve diretamente nos artefatos, em linguagem natural ou SBVR (se tiver proficiência). A IA não participa da redação — a autoria é integralmente do Domain Expert.

3. **Guardrails obrigatórios pós-edição, antes do Change Plan.** As alterações do Domain Expert são submetidas aos guardrails da Product Canon **antes** de gerar qualquer Canonical Change Plan. A IA não aplica correções automaticamente — ela produz um **relatório de conformidade** que sinaliza divergências e sugere ajustes, devolvendo o controle ao Domain Expert para que ele decida como resolver cada ponto.

   O relatório de conformidade pode assumir duas formas, conforme preferência do Domain Expert:

   - **Relatório estático.** Um documento estruturado listando cada divergência encontrada, com a localização no artefato editado, a regra ou termo da Product Canon que foi tocado, e uma sugestão de ajuste. O Domain Expert lê, ajusta manualmente o que julgar necessário, e solicita nova validação. O ciclo se repete até que o relatório não contenha divergências bloqueantes.

   - **Processo conversacional.** Uma sessão interativa onde a IA apresenta cada divergência uma a uma, explica o motivo da sinalização, e propõe alternativas. O Domain Expert decide sobre cada ponto — aceita a sugestão e edita o artefato ele mesmo, rejeita com justificativa, ou reformula de outra forma. A IA nunca edita o artefato diretamente; ela guia o Domain Expert através das divergências, e ele aplica as correções com suas próprias mãos.

   Em ambas as formas, o princípio é o mesmo: **a IA sinaliza e sugere, o Domain Expert edita**. Isso preserva a autoria integral do Domain Expert sobre o conteúdo e evita que a IA introduza alterações silenciosas em um processo onde ela não tem autonomia de redação.

   Os guardrails que operam nesta fase são:

   - **Clarificação de Conformidade**: a IA verifica se os termos utilizados são consistentes com o glossário de linguagem ubíqua existente. Se o Domain Expert usa "usuário" onde a Canon define "titular da conta", a divergência é sinalizada no relatório. O Domain Expert decide se alinha ao termo existente, se propõe um novo termo ao glossário, ou se justifica o uso divergente.
   - **Validação de Consistência**: a IA confronta as alterações com o estado atual da Product Canon — regras de negócio existentes e princípios técnicos constitucionais. Contradições são identificadas e apresentadas no relatório. O Domain Expert ajusta o artefato ou reconhece que a contradição é intencional (neste caso, ela será explicitada no Change Plan para avaliação do Architect).

4. **Canonical Change Plan obrigatório.** Somente após o Domain Expert resolver as divergências sinalizadas pelos guardrails — ou declarar explicitamente que divergências remanescentes são intencionais — as alterações são empacotadas em um Canonical Change Plan tipado como `expert-edit-plan`. Este tipo distingue formalmente edições diretas de artefatos produzidos por cerimônias, preservando rastreabilidade sobre a origem de cada mudança. Divergências intencionais não resolvidas constam no Change Plan como itens sinalizados, tornando-as visíveis para o Architect na aprovação.

5. **Aprovação obrigatória pelo Architect.** O Canonical Change Plan do Domain Expert requer aprovação obrigatória do Architect — mesmo que as alterações sejam exclusivamente na camada de negócio. Essa exigência é deliberadamente mais restritiva que os gates das cerimônias (onde o Architect é aprovador secundário). A justificativa: edições diretas não passaram pelo processo de elicitação completo — não houve sessão de descoberta, não houve mediação pela IA durante a construção, não houve verificação cruzada com outros participantes. A aprovação obrigatória do Architect compensa a ausência dessas camadas de validação, funcionando como checkpoint técnico que garante que uma alteração na camada de negócio não tem implicações arquiteturais não percebidas pelo Domain Expert.

6. **Versionamento por Estrangulamento.** A canonização das alterações aprovadas segue o mesmo mecanismo de Versionamento Gradual por Estrangulamento que governa todas as outras mudanças na Product Canon. Alterações pontuais (ajuste de definição, correção factual) podem ser integradas diretamente à versão current. Alterações com impacto mais amplo (redefinição de conceito usado em múltiplos contextos, mudança de regra com dependências) devem ser versionadas como transição (next), seguindo os mesmos critérios de criticidade aplicados às cerimônias formais.

#### Fluxo da edição direta

```
Domain Expert edita artefato da camada de negócio →
IA executa guardrails sobre as alterações →
IA produz relatório de conformidade (estático ou conversacional) →
  Relatório sinaliza divergências e sugere ajustes →
  Domain Expert ajusta manualmente ou justifica divergência →
  IA revalida (ciclo até conformidade ou justificativa explícita) →
Canonical Change Plan (expert-edit-plan) é gerado →
  Divergências intencionais constam como itens sinalizados →
Architect avalia e aprova (obrigatório) →
  Se aprovado: canonização via Versionamento por Estrangulamento →
  Se rejeitado: Architect justifica; Domain Expert pode 
    ajustar e resubmeter ou escalar para cerimônia formal
```

#### Salvaguardas contra uso indevido

O modelo trata a edição direta como canal de exceção, não de rotina, através de mecanismos que preservam a primazia das cerimônias formais:

- **Tipagem distinta do Change Plan** (`expert-edit-plan`): permite auditoria e análise de frequência. Se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal de que o processo de elicitação está sendo contornado.
- **Aprovação do Architect obrigatória e não delegável**: diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente. Isso introduz fricção deliberada — suficiente para desencorajar uso casual, insuficiente para impedir correções legítimas.
- **Ausência de mediação da IA na redação**: o Domain Expert assume responsabilidade integral pelo conteúdo. Não há "tradução assistida" como nas cerimônias. Isso é tanto uma restrição (maior risco de imprecisão) quanto uma salvaguarda (o Domain Expert não pode delegar a autoria para a IA fora do contexto formal).
- **Guardrails antes do Change Plan, não depois**: as divergências são resolvidas antes de o artefato ser empacotado para aprovação. O Architect recebe um Change Plan já conformado — ou com divergências explicitamente declaradas — nunca um artefato com inconsistências silenciosas.

#### Exemplo — edição direta legítima

O Banco Central publica nova regulamentação: reembolsos de PIX passam a ter prazo máximo de 72 horas (antes era 48 horas). O Domain Expert da área de Pagamentos atualiza diretamente a regra de negócio na Product Canon:

```
[ANTES]
  "Reembolsos de transações PIX devem ser processados 
   em até 48 horas após a solicitação."

[DEPOIS]
  "Reembolsos de transações PIX devem ser processados 
   em até 72 horas após a solicitação."
```

A IA executa os guardrails e produz o relatório de conformidade:

```
RELATÓRIO DE CONFORMIDADE — Edição Direta
==========================================

✓ TERMOS: "Reembolso", "transações PIX", "solicitação" — 
  conformes com glossário do contexto Pagamentos.

✓ CONSISTÊNCIA (camada de negócio): sem contradição com 
  regras de negócio existentes.

⚠ CONSISTÊNCIA (camada de arquitetura): a regra anterior 
  (48h) pode estar refletida em configurações de timeout 
  do serviço de reembolso PIX. Sugestão: sinalizar no 
  Change Plan para avaliação do Architect.

RESULTADO: 0 divergências bloqueantes, 1 observação técnica.
```

O Domain Expert lê o relatório, reconhece a observação técnica, e o Change Plan (`expert-edit-plan`) é gerado com a observação inclusa. O Architect aprova com nota: "Verificar configuração de timeout no serviço de reembolso PIX — pode exigir ADR."

#### Exemplo — edição com divergências resolvidas conversacionalmente

O Domain Expert do contexto Faturamento quer ajustar a definição de "fatura recorrente" no glossário. Ele edita:

```
[ANTES]
  "Fatura Recorrente — documento de cobrança gerado 
   automaticamente a cada 30 dias para assinaturas ativas."

[DEPOIS]
  "Fatura Recorrente — documento de cobrança gerado 
   automaticamente conforme o ciclo de billing da assinatura."
```

A IA inicia o processo conversacional:

> **IA:** A edição remove a referência explícita a "30 dias" e introduz o termo "ciclo de billing", que não consta no glossário do contexto Faturamento. Duas opções: (1) adicionar "ciclo de billing" ao glossário com definição formal, ou (2) substituir por um termo existente. Há o termo "período de cobrança" já definido como "intervalo entre emissões de fatura, configurável por plano." Ele atende?

> **Domain Expert:** "Período de cobrança" atende. Vou usar esse termo.

O Domain Expert ajusta manualmente:

```
[REVISADO]
  "Fatura Recorrente — documento de cobrança gerado 
   automaticamente conforme o período de cobrança da assinatura."
```

A IA revalida: termos conformes, sem contradições. O Change Plan é gerado sem divergências.

#### Exemplo — edição direta que deve ser redirecionada para cerimônia

O Domain Expert tenta adicionar um novo conceito: "Reembolso Parcial por Item" — uma modalidade que não existe na Product Canon. O relatório de conformidade identifica que esse conceito introduz um novo tipo de reembolso com implicações em múltiplos bounded contexts (Pedidos, Pagamentos, Faturamento). O Change Plan é gerado com as divergências sinalizadas, mas o Architect rejeita com justificativa: "Conceito novo com impacto cross-context. Requer Domain Discovery Session para mapeamento completo." A alteração é redirecionada para o fluxo de cerimônias.

#### Impacto no papel do Domain Expert

A tabela de atuação por etapa (seção 4) é atualizada:

| Papel | Etapa 1 — Canon Building | Etapa 2 — Especificação | Etapa 3 — Retroalimentação | Edição Direta |
|-------|------------------------|------------------------|---------------------------|---------------|
| Domain Expert | Aprova primariamente Discovery e Specification (com anotações e hotspots); aprova secundariamente Constitution | Aprova camada de negócio do Canonical Change Plan incremental (com anotações e hotspots) | — | Edita artefatos da camada de negócio; resolve divergências guiado por relatório/conversa com IA; alterações passam por aprovação obrigatória do Architect |

#### Impacto nos riscos

**Novo risco: erosão das cerimônias.** Se a edição direta for usada excessivamente, o valor das cerimônias formais degrada. A tipagem distinta (`expert-edit-plan`) e a aprovação obrigatória do Architect são mitigações estruturais. A frequência de uso deve ser monitorada na prototipação.

**Novo risco: inconsistência por autoria não mediada.** Sem mediação da IA na redação, o Domain Expert pode introduzir imprecisões que os guardrails pós-edição não detectem completamente. Mitigação: o ciclo de relatório/ajuste/revalidação reduz esse risco iterativamente, e o Architect funciona como checkpoint adicional.

---

### 3. Resumo das Mudanças

| Aspecto | v0.5 | Proposta v0.6 |
|---------|------|---------------|
| Artefato de aprovação na Requirements Specification | SBVR apresentado isoladamente | Par SBVR + SBE apresentado conjuntamente para verificação cruzada |
| Persistência na Product Canon | SBVR e SBE como artefatos separados e fracamente conectados | SBVR e SBE como par complementar: regra formal + cenários derivados |
| Papel do Domain Expert na aprovação | Binário (aprova/veta) | Ativo: anota, complementa e marca hotspots |
| Acesso do Domain Expert à Product Canon | Somente via gates de aprovação | Edição direta da camada de negócio com guardrails iterativos (relatório ou conversa), resolução guiada pelo Domain Expert, e aprovação obrigatória do Architect |
| Guardrails na edição direta | Não aplicável | Executados antes do Change Plan; IA sinaliza e sugere, Domain Expert edita; ciclo iterativo até conformidade ou justificativa explícita |
| Tipos de Canonical Change Plan | `discovery-plan`, `constitution-plan`, `specification-plan` | Adição de `expert-edit-plan` |
| Risco de rubber stamp (seção 9.6) | Mitigado apenas pela mediação da IA | Reduzido pela verificação cruzada SBVR+SBE e pela aprovação ativa com anotações |

### 4. Coerência com os Princípios de Design

**Prevenção sobre detecção** — ambas as mudanças adicionam superfícies de validação antes do código. O par SBVR+SBE permite detecção de gaps pela verificação cruzada. Hotspots registram formalmente incertezas antes que se tornem defeitos. Na edição direta, os guardrails operam antes do Change Plan, não depois — as inconsistências são resolvidas no ponto mais barato.

**Separação de autoridade** — a edição direta respeita a fronteira: Domain Expert edita somente a camada de negócio, Architect mantém autoridade sobre a camada técnica e funciona como checkpoint obrigatório. Na resolução de divergências, a IA sugere mas não edita — o Domain Expert mantém controle integral sobre o conteúdo. Nenhum papel absorve responsabilidade do outro.

**IA sem autonomia decisória** — na edição direta, a IA opera exclusivamente nos guardrails pós-edição: sinaliza divergências, sugere ajustes, mas nunca aplica correções. A autoria é integralmente humana. O relatório de conformidade e o processo conversacional são mecanismos de orientação, não de intervenção. Nas cerimônias, a IA continua mediando mas não decidindo.

**Governança por cerimônia** — a edição direta não viola este princípio porque é tratada como canal complementar com fricção deliberada, não como via alternativa de construção. A tipagem distinta do Change Plan (`expert-edit-plan`), a aprovação obrigatória do Architect, e o ciclo iterativo de guardrails preservam a rastreabilidade e a governança. As cerimônias permanecem como processo primário e preferencial.

---

*Proposta de evolução para a versão 0.6 do modelo conceitual ZionKit.*

User: Reescreva o texto adicionando os seguintes escopos a mudança:

No novo processo onde o domain expert pode editar diretamente na product canon, esclareça que a clarificação e validação ira ocorrer antes de gerar o Caninical Change Plan, por tanto a cada edição o Domain expert tera a oportunidade de ajustar manualmente porem sendo guiado por um relatorio ou até mesmo processo conversacional que sugira mudanças e não que as faça, no primeiro momento dado que neste momento o domain expert esta no controle mas ele precisa tambem ter suas ações conduzidas pela ia, o relatorio gerado pela ia precisa propor alterações nos requisitos editados pelo domain expert porem reescrevendo no formato oficial utilizado pela product canon não permitindo o domain expert escrever direto na product canon.
Portanto pra que isso fique mais coerente devemos criar um novo guardrails com a responsabilidade unica de garantir que a escrita na product canon esteja sendo feita dentro do padrão aderido pelo modelo zionkit, tal como definimos no inicio da conversa SBVR + SBE.

GitHub Copilot: Compacted conversation## Proposta de Evolução do Modelo — v0.6

---

### Escopo 1 — Par Complementar SBVR + SBE na Requirements Specification Session

**Contexto.** O modelo v0.5 descreve a Requirements Specification Session como mediação SBVR, onde o Domain Builder fala em linguagem natural e a IA traduz para SBVR controlado. O risco 9.6 reconhece que o Domain Builder pode "rubber stamp" a formalização SBVR sem compreendê-la. A proposta é explicitar que SBVR e SBE operam como par complementar — não como artefatos independentes.

**Mudança.** Na Requirements Specification Session, cada requisito formalizado é apresentado ao Domain Builder em dois formatos simultâneos:

- **SBVR** — representação formal com quantificadores e predicados, usada pela IA como infraestrutura de validação de consistência contra a Product Canon.
- **SBE** — cenários concretos (Dado/Quando/Então) que tornam a regra tangível e verificável pelo Domain Builder.

O Domain Builder valida primariamente pelo SBE (que ele compreende intuitivamente) enquanto o SBVR serve como âncora formal para a IA verificar contradições, redundâncias e lacunas. O Domain Expert, na aprovação, recebe ambos os formatos para cross-verificação: se o SBVR diz uma coisa e o SBE ilustra outra, há divergência que precisa ser resolvida antes da aprovação.

**Fluxo revisado da seção 2.2.3:**

1. Domain Builder descreve requisito em linguagem natural
2. IA traduz para SBVR controlado + gera cenários SBE correspondentes
3. IA confronta o par SBVR+SBE com a Product Canon (regras existentes, glossário, princípios)
4. Domain Builder valida pelos cenários SBE; IA sinaliza divergências SBVR↔SBE
5. Par SBVR+SBE aprovado entra no Canonical Change Plan (`specification-plan`)
6. Domain Expert valida o par completo; Architect valida viabilidade técnica

**Impacto na Product Canon.** Os requisitos armazenados na Product Canon passam a conter explicitamente ambos os formatos: a regra formal (SBVR) e os cenários de verificação (SBE). Isso estabelece o **padrão oficial de escrita** da Product Canon para requisitos.

**Impacto no risco 9.6.** O risco de "rubber stamp" é reduzido porque o Domain Builder valida pelos cenários concretos (SBE), não pela notação formal (SBVR). A divergência entre os dois formatos funciona como detector de falhas de compreensão.

---

### Escopo 2 — Expansão do Papel do Domain Expert

**Contexto.** No modelo v0.5, o Domain Expert atua exclusivamente como aprovador — valida ou veta artefatos produzidos por outros. Seus insights sobre o domínio só entram no modelo se outro participante os captura. A proposta introduz três capacidades que tornam o Domain Expert um participante ativo sem quebrar a separação de autoridade.

#### 2.1 Aprovação com Anotações

O Domain Expert, ao avaliar um Canonical Change Plan, pode não apenas aprovar ou vetar, mas **anotar** artefatos específicos com observações semânticas. Anotações são insumos formais — a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Exemplo.** Domain Expert aprova o `specification-plan` de "reembolso parcial" mas anota: *"Atenção: 'reembolso parcial por valor' e 'reembolso parcial por item' têm regras tributárias completamente diferentes — tratar como conceitos separados."* A anotação fica registrada no Change Plan aprovado e é sinalizada pela IA na próxima Requirements Specification Session como candidata a formalização SBVR+SBE.

#### 2.2 Hotspots de Domínio

O Domain Expert pode marcar áreas da Product Canon como **hotspots** — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. A IA prioriza esses pontos na Clarificação de Conformidade.

**Exemplo.** Domain Expert marca o conceito "cliente inativo" como hotspot com a nota: *"Definição confundida frequentemente com 'cliente churned'. São conceitos distintos com regras diferentes."* Toda vez que uma especificação mencionar "cliente inativo", a IA exibe proativamente a definição precisa e a distinção com "churned".

#### 2.3 Edição Direta na Camada de Negócio (com Guardrails)

Capacidade mais sensível da proposta. O Domain Expert pode editar diretamente artefatos da **camada de negócio** da Product Canon — glossário, regras de negócio e requisitos — sem passar por uma cerimônia completa de Canon Building.

##### Restrições

- **Escopo**: apenas camada de negócio. Artefatos de arquitetura permanecem exclusivos do Architect.
- **Natureza**: refinamentos e correções de artefatos existentes. Criação de conceitos inteiramente novos requer cerimônia completa.
- **Formato**: o Domain Expert **não escreve diretamente na Product Canon**. Ele edita em linguagem natural ou formato livre. A IA é responsável por reescrever as edições no formato oficial da Product Canon (SBVR + SBE), produzindo uma versão formalizada que o Domain Expert revisa e aprova antes da integração.
- **Aprovação**: toda edição direta requer aprovação do Architect antes de ser integrada à Product Canon, compensando a ausência do processo completo de elicitação.

##### Fluxo — Edição com Guardrails Pré-Change Plan

O processo de guardrails ocorre **antes** da geração do Canonical Change Plan. A cada edição, o Domain Expert é guiado por um ciclo iterativo de conformidade:

**Passo 1 — Edição pelo Domain Expert.** O Domain Expert propõe uma alteração em linguagem natural ou formato livre. Ele descreve o que quer mudar, sem preocupação com a notação formal.

**Passo 2 — Guardrail de Padronização Canônica (novo guardrail).** A IA recebe a edição e executa o **Guardrail de Padronização Canônica** — um guardrail com responsabilidade única de garantir que toda escrita na Product Canon esteja no padrão aderido pelo modelo ZionKit. Concretamente, a IA:

- Reescreve a edição do Domain Expert no formato oficial SBVR + SBE
- Apresenta a versão formalizada como **proposta**, não como alteração consumada
- Sinaliza onde a linguagem original do Domain Expert diverge das definições existentes na Product Canon

A IA **não aplica** a edição. Ela produz uma versão candidata no formato canônico e a apresenta ao Domain Expert.

**Passo 3 — Guardrail de Conformidade Semântica.** Simultaneamente, a IA executa validação de conformidade contra a Product Canon existente, verificando:

- Consistência com o glossário de linguagem ubíqua
- Contradições com regras de negócio existentes
- Impacto em bounded contexts adjacentes
- Coerência entre a formalização SBVR e os cenários SBE gerados

O resultado é um **Relatório de Conformidade** que consolida tanto a padronização canônica quanto a validação semântica.

**Passo 4 — Revisão guiada pelo Domain Expert.** O Domain Expert recebe:

1. A versão formalizada em SBVR + SBE (proposta pela IA)
2. O Relatório de Conformidade (divergências, contradições, impactos adjacentes)
3. Sugestões de ajuste (quando aplicável)

O Domain Expert **está no controle**: ele pode aceitar a formalização proposta, solicitar ajustes na reescrita, ou reescrever sua edição original e submeter novamente. A IA sinaliza e sugere — o Domain Expert decide e ajusta.

**Passo 5 — Ciclo iterativo.** Os passos 1-4 se repetem até que:

- O Domain Expert aceite a versão formalizada em SBVR + SBE
- O Relatório de Conformidade não apresente divergências críticas (ou o Domain Expert justifique explicitamente as divergências intencionais)

Divergências intencionais — casos onde o Domain Expert conscientemente diverge de uma regra existente — são registradas como itens flagrados que serão visíveis ao Architect na aprovação.

**Passo 6 — Geração do Canonical Change Plan.** Somente após a conclusão do ciclo iterativo de guardrails, a IA gera um Canonical Change Plan tipado como `expert-edit-plan`, contendo:

- A versão final formalizada em SBVR + SBE (já aprovada pelo Domain Expert)
- O Relatório de Conformidade final
- Divergências intencionais flagradas (se houver)
- Impactos em bounded contexts adjacentes

**Passo 7 — Aprovação pelo Architect.** O Architect avalia o `expert-edit-plan` com visibilidade completa: a edição original, a formalização SBVR + SBE, o relatório de conformidade, e os flags de divergência intencional. Aprova, solicita ajustes, ou rejeita (redirecionando para cerimônia completa).

##### O Relatório de Conformidade: duas formas

O Relatório de Conformidade pode operar em duas modalidades, à escolha do Domain Expert:

**Forma estática (relatório).** A IA gera um documento estruturado com a formalização proposta, as divergências encontradas e as sugestões de ajuste. O Domain Expert lê, avalia e responde com sua decisão.

**Forma conversacional (processo guiado).** A IA conduz um diálogo iterativo com o Domain Expert, apresentando cada divergência individualmente, explicando o impacto e perguntando como proceder. Mais adequada para edições complexas com múltiplas implicações.

Em ambas as formas, o princípio é o mesmo: **a IA sinaliza, propõe a formalização em SBVR + SBE, e sugere ajustes — o Domain Expert decide, mas não escreve diretamente no formato canônico da Product Canon.**

##### Exemplos

**Exemplo 1 — Edição simples com padronização.** O Domain Expert quer corrigir a definição de "cliente inativo". Ele escreve: *"Cliente inativo deveria incluir também quem não abriu ticket de suporte nos últimos 6 meses, além dos critérios atuais."*

A IA executa o Guardrail de Padronização Canônica e produz:

```
SBVR:
"É necessário que cada Cliente seja classificado como 'inativo' 
se e somente se o Cliente não realizou Compra nos últimos 12 meses 
E não realizou Login nos últimos 6 meses 
E não abriu Ticket de Suporte nos últimos 6 meses."

SBE:
Cenário: Cliente sem compras, sem login e sem tickets é inativo
  Dado que o Cliente "João" não realiza compras há 13 meses
  E não realiza login há 7 meses
  E não abre ticket de suporte há 7 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente é classificado como "inativo"

Cenário: Cliente com ticket recente não é inativo
  Dado que o Cliente "Maria" não realiza compras há 13 meses
  E não realiza login há 7 meses
  Mas abriu ticket de suporte há 3 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente NÃO é classificado como "inativo"
```

O Relatório de Conformidade sinaliza: *"A base de dados de Suporte pertence ao bounded context 'Atendimento'. A regra atual de inatividade opera apenas com dados do contexto 'Conta'. A nova regra introduz dependência cross-context."*

O Domain Expert aceita a formalização SBVR+SBE e reconhece o impacto cross-context. A IA gera o `expert-edit-plan` com o flag de impacto em "Atendimento". O Architect avalia a implicação técnica da dependência cross-context e decide se aprova ou encaminha para cerimônia completa.

**Exemplo 2 — Edição com divergência intencional (conversacional).** O Domain Expert edita: *"Reembolsos até R$ 200 não precisam de aprovação do gerente."*

IA (Guardrail de Padronização Canônica): *Formalizei sua edição:*

```
SBVR: "É permitido que um Reembolso cujo Valor é menor ou igual 
a R$ 200,00 seja processado sem Aprovação hierárquica."

SBE:
Cenário: Reembolso de R$ 150 processado sem aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 150,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é processado automaticamente

Cenário: Reembolso de R$ 250 requer aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 250,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é encaminhado para aprovação do gerente
```

*Porém, identifiquei uma divergência: a regra atual na Product Canon define que "Reembolsos acima de R$ 500 exigem aprovação do gerente" — implicitamente, reembolsos até R$ 500 já não exigem. Sua edição reduz o limite de R$ 500 para R$ 200, tornando a aprovação mais restritiva. É essa a intenção?*

Domain Expert: *"Sim, política de compliance mudou. Agora o limite é R$ 200."*

IA: *Entendido. Registrarei como divergência intencional da regra atual. A formalização SBVR ajustada ficará:*

```
SBVR: "É obrigatório que cada Reembolso cujo Valor é superior a 
R$ 200,00 seja aprovado pelo Gerente responsável."
```

*Confirma esta formalização para gerar o Change Plan?*

Domain Expert confirma. A IA gera o `expert-edit-plan` com a divergência intencional flagrada e a justificativa do Domain Expert.

---

### Escopo 3 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a introdução da edição direta pelo Domain Expert, torna-se necessário um guardrail dedicado a garantir que toda escrita na Product Canon esteja no padrão oficial.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

Para requisitos e regras de negócio, o formato oficial é o par **SBVR + SBE**: cada regra é expressa como predicado formal SBVR acompanhado de cenários de verificação SBE. Para o glossário, o formato é definição precisa associada ao bounded context de validade. Para eventos de domínio, o formato segue o schema CloudEvents conforme princípios técnicos constitucionais.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando o Domain Builder fala em linguagem natural e a IA traduz para SBVR + SBE, o guardrail está implicitamente ativo.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O Domain Expert revisa e aprova a formalização — ele nunca escreve diretamente no formato canônico da Product Canon.

Este guardrail garante que, independentemente de quem origina a mudança e por qual caminho ela entra, a Product Canon mantém consistência de formato e legibilidade uniforme.

---

### Impacto na Seção 9 — Riscos

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. O risco existe de que, sob pressão, equipes usem edição direta para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes — conceitos novos requerem cerimônia; (b) aprovação obrigatória do Architect funciona como check de adequação do canal; (c) o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para SBVR + SBE. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Mitigação: (a) o Domain Expert revisa e aprova a formalização proposta antes de ela ser aceita; (b) o ciclo iterativo permite correções; (c) o Architect valida o resultado final no `expert-edit-plan`.

---

### Impacto na Seção 10 — Prototipação

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue reescrever corretamente edições em linguagem natural para o formato oficial SBVR + SBE, preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização vs. necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

**Nova prioridade 9 — Edição direta com ciclo iterativo de guardrails.** Testar o fluxo completo: Domain Expert edita em formato livre → Guardrail de Padronização Canônica reescreve em SBVR + SBE → Guardrail de Conformidade Semântica valida → Domain Expert revisa → ciclo iterativo → `expert-edit-plan` gerado → Architect aprova. Avaliar se o processo é percebido como facilitador ou como burocracia pelo Domain Expert. Testar ambas as formas do relatório (estática e conversacional).

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.2.3 | SBVR e SBE como par complementar explícito; SBVR como infraestrutura formal, SBE como superfície de validação humana |
| 2.2.5 | Novo guardrail: **Padronização Canônica** — garante formato oficial (SBVR + SBE) para toda escrita na Product Canon |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta na camada de negócio |
| 5 (Artefatos) | Novo tipo de Change Plan: `expert-edit-plan`; artefatos contêm par SBVR + SBE explícito |
| 9 (Riscos) | Novos riscos 9.8 (edição direta como atalho) e 9.9 (qualidade da formalização automática) |
| 10 (Prototipação) | Novas prioridades 8 (Guardrail de Padronização Canônica) e 9 (edição direta com guardrails) |
| Princípio novo | Domain Expert edita em formato livre; IA formaliza em SBVR + SBE; Domain Expert aprova a formalização — nunca escreve diretamente no formato canônico |

User: Reescreva o texto adicionando os seguintes escopos a mudança:

No novo processo onde o domain expert pode editar diretamente na product canon, esclareça que apos reescrever os requisitos utilziando o guarals de formato de requisito o processo deve gerar canonical change plan e essa caninical change plan tambem deve ter aprovação do domain expert, aqui parece estranho ele edita a ia reescrve e ele aprova o que ele mesmo editou, mas o ponto é mitigar o risco da ia reescrever no formato que mude o requisito, somente apos a aprovação dele o arquiteto aprova a parte dele que envolve validação do impacto tecnico da mudança, o arquiteto aqui não aprova antes do domain expert.

GitHub Copilot: ## Proposta de Evolução do Modelo — v0.6

---

### Escopo 1 — Par Complementar SBVR + SBE na Requirements Specification Session

**Contexto.** O modelo v0.5 descreve a Requirements Specification Session como mediação SBVR, onde o Domain Builder fala em linguagem natural e a IA traduz para SBVR controlado. O risco 9.6 reconhece que o Domain Builder pode "rubber stamp" a formalização SBVR sem compreendê-la. A proposta é explicitar que SBVR e SBE operam como par complementar — não como artefatos independentes.

**Mudança.** Na Requirements Specification Session, cada requisito formalizado é apresentado ao Domain Builder em dois formatos simultâneos:

- **SBVR** — representação formal com quantificadores e predicados, usada pela IA como infraestrutura de validação de consistência contra a Product Canon.
- **SBE** — cenários concretos (Dado/Quando/Então) que tornam a regra tangível e verificável pelo Domain Builder.

O Domain Builder valida primariamente pelo SBE (que ele compreende intuitivamente) enquanto o SBVR serve como âncora formal para a IA verificar contradições, redundâncias e lacunas. O Domain Expert, na aprovação, recebe ambos os formatos para cross-verificação: se o SBVR diz uma coisa e o SBE ilustra outra, há divergência que precisa ser resolvida antes da aprovação.

**Fluxo revisado da seção 2.2.3:**

1. Domain Builder descreve requisito em linguagem natural
2. IA traduz para SBVR controlado + gera cenários SBE correspondentes
3. IA confronta o par SBVR+SBE com a Product Canon (regras existentes, glossário, princípios)
4. Domain Builder valida pelos cenários SBE; IA sinaliza divergências SBVR↔SBE
5. Par SBVR+SBE aprovado entra no Canonical Change Plan (`specification-plan`)
6. Domain Expert valida o par completo; Architect valida viabilidade técnica

**Impacto na Product Canon.** Os requisitos armazenados na Product Canon passam a conter explicitamente ambos os formatos: a regra formal (SBVR) e os cenários de verificação (SBE). Isso estabelece o **padrão oficial de escrita** da Product Canon para requisitos.

**Impacto no risco 9.6.** O risco de "rubber stamp" é reduzido porque o Domain Builder valida pelos cenários concretos (SBE), não pela notação formal (SBVR). A divergência entre os dois formatos funciona como detector de falhas de compreensão.

---

### Escopo 2 — Expansão do Papel do Domain Expert

**Contexto.** No modelo v0.5, o Domain Expert atua exclusivamente como aprovador — valida ou veta artefatos produzidos por outros. Seus insights sobre o domínio só entram no modelo se outro participante os captura. A proposta introduz três capacidades que tornam o Domain Expert um participante ativo sem quebrar a separação de autoridade.

#### 2.1 Aprovação com Anotações

O Domain Expert, ao avaliar um Canonical Change Plan, pode não apenas aprovar ou vetar, mas **anotar** artefatos específicos com observações semânticas. Anotações são insumos formais — a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Exemplo.** Domain Expert aprova o `specification-plan` de "reembolso parcial" mas anota: *"Atenção: 'reembolso parcial por valor' e 'reembolso parcial por item' têm regras tributárias completamente diferentes — tratar como conceitos separados."* A anotação fica registrada no Change Plan aprovado e é sinalizada pela IA na próxima Requirements Specification Session como candidata a formalização SBVR+SBE.

#### 2.2 Hotspots de Domínio

O Domain Expert pode marcar áreas da Product Canon como **hotspots** — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. A IA prioriza esses pontos na Clarificação de Conformidade.

**Exemplo.** Domain Expert marca o conceito "cliente inativo" como hotspot com a nota: *"Definição confundida frequentemente com 'cliente churned'. São conceitos distintos com regras diferentes."* Toda vez que uma especificação mencionar "cliente inativo", a IA exibe proativamente a definição precisa e a distinção com "churned".

#### 2.3 Edição Direta na Camada de Negócio (com Guardrails)

Capacidade mais sensível da proposta. O Domain Expert pode editar diretamente artefatos da **camada de negócio** da Product Canon — glossário, regras de negócio e requisitos — sem passar por uma cerimônia completa de Canon Building.

##### Restrições

- **Escopo**: apenas camada de negócio. Artefatos de arquitetura permanecem exclusivos do Architect.
- **Natureza**: refinamentos e correções de artefatos existentes. Criação de conceitos inteiramente novos requer cerimônia completa.
- **Formato**: o Domain Expert **não escreve diretamente na Product Canon**. Ele edita em linguagem natural ou formato livre. A IA é responsável por reescrever as edições no formato oficial da Product Canon (SBVR + SBE), produzindo uma versão formalizada que o Domain Expert revisa e aprova antes da integração.
- **Aprovação sequencial**: toda edição direta requer primeiro aprovação do Domain Expert sobre a formalização SBVR+SBE (validando que a IA preservou o significado pretendido), e somente após essa aprovação o Architect avalia o impacto técnico da mudança. O Architect nunca aprova antes do Domain Expert.

##### Fluxo — Edição com Guardrails Pré-Change Plan

O processo de guardrails ocorre **antes** da geração do Canonical Change Plan. A cada edição, o Domain Expert é guiado por um ciclo iterativo de conformidade:

**Passo 1 — Edição pelo Domain Expert.** O Domain Expert propõe uma alteração em linguagem natural ou formato livre. Ele descreve o que quer mudar, sem preocupação com a notação formal.

**Passo 2 — Guardrail de Padronização Canônica (novo guardrail).** A IA recebe a edição e executa o **Guardrail de Padronização Canônica** — um guardrail com responsabilidade única de garantir que toda escrita na Product Canon esteja no padrão aderido pelo modelo ZionKit. Concretamente, a IA:

- Reescreve a edição do Domain Expert no formato oficial SBVR + SBE
- Apresenta a versão formalizada como **proposta**, não como alteração consumada
- Sinaliza onde a linguagem original do Domain Expert diverge das definições existentes na Product Canon

A IA **não aplica** a edição. Ela produz uma versão candidata no formato canônico e a apresenta ao Domain Expert.

**Passo 3 — Guardrail de Conformidade Semântica.** Simultaneamente, a IA executa validação de conformidade contra a Product Canon existente, verificando:

- Consistência com o glossário de linguagem ubíqua
- Contradições com regras de negócio existentes
- Impacto em bounded contexts adjacentes
- Coerência entre a formalização SBVR e os cenários SBE gerados

O resultado é um **Relatório de Conformidade** que consolida tanto a padronização canônica quanto a validação semântica.

**Passo 4 — Revisão guiada pelo Domain Expert.** O Domain Expert recebe:

1. A versão formalizada em SBVR + SBE (proposta pela IA)
2. O Relatório de Conformidade (divergências, contradições, impactos adjacentes)
3. Sugestões de ajuste (quando aplicável)

O Domain Expert **está no controle**: ele pode aceitar a formalização proposta, solicitar ajustes na reescrita, ou reescrever sua edição original e submeter novamente. A IA sinaliza e sugere — o Domain Expert decide e ajusta.

**Passo 5 — Ciclo iterativo.** Os passos 1-4 se repetem até que:

- O Domain Expert aceite a versão formalizada em SBVR + SBE
- O Relatório de Conformidade não apresente divergências críticas (ou o Domain Expert justifique explicitamente as divergências intencionais)

Divergências intencionais — casos onde o Domain Expert conscientemente diverge de uma regra existente — são registradas como itens flagrados que serão visíveis ao Architect na aprovação.

**Passo 6 — Geração do Canonical Change Plan.** Somente após a conclusão do ciclo iterativo de guardrails, a IA gera um Canonical Change Plan tipado como `expert-edit-plan`, contendo:

- A versão final formalizada em SBVR + SBE (já revisada pelo Domain Expert durante o ciclo iterativo)
- O Relatório de Conformidade final
- Divergências intencionais flagradas (se houver)
- Impactos em bounded contexts adjacentes

**Passo 7 — Aprovação sequencial: Domain Expert primeiro, Architect depois.**

A aprovação do `expert-edit-plan` é **sequencial com ordem fixa**: o Domain Expert aprova antes do Architect. Essa ordem existe por uma razão específica.

**7a — Aprovação pelo Domain Expert.** O Domain Expert aprova a formalização SBVR+SBE contida no Change Plan. Embora pareça redundante — ele já revisou a formalização no ciclo iterativo (passos 2-5) — a aprovação no Change Plan tem propósito distinto: **mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido.** O ciclo iterativo é um processo incremental de refinamento; o Change Plan é o artefato final consolidado. A aprovação pelo Domain Expert neste ponto é a garantia formal de que o artefato final preserva sua intenção original. Sem essa aprovação, existe o risco de que ajustes de formato introduzidos pela IA na consolidação do Change Plan alterem sutilmente a semântica — e o Architect, que não é o autor da intenção de negócio, não teria como detectar essa distorção.

**7b — Aprovação pelo Architect.** Somente após o Domain Expert aprovar, o Architect avalia o `expert-edit-plan`. O foco do Architect é exclusivamente o **impacto técnico** da mudança: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs. O Architect não valida a semântica de negócio — isso já foi feito pelo Domain Expert. Ele aprova, solicita ajustes técnicos, ou rejeita (redirecionando para cerimônia completa se a mudança tiver escopo técnico que excede o canal de edição direta).

**Por que o Architect não aprova antes do Domain Expert?** Se o Architect aprovasse primeiro, ele avaliaria o impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção. Se o Domain Expert depois rejeitasse a formalização (porque a IA distorceu o significado), o trabalho de avaliação técnica do Architect seria descartado. A ordem sequencial garante que o Architect avalia apenas artefatos com semântica já validada pelo dono do domínio.

##### O Relatório de Conformidade: duas formas

O Relatório de Conformidade pode operar em duas modalidades, à escolha do Domain Expert:

**Forma estática (relatório).** A IA gera um documento estruturado com a formalização proposta, as divergências encontradas e as sugestões de ajuste. O Domain Expert lê, avalia e responde com sua decisão.

**Forma conversacional (processo guiado).** A IA conduz um diálogo iterativo com o Domain Expert, apresentando cada divergência individualmente, explicando o impacto e perguntando como proceder. Mais adequada para edições complexas com múltiplas implicações.

Em ambas as formas, o princípio é o mesmo: **a IA sinaliza, propõe a formalização em SBVR + SBE, e sugere ajustes — o Domain Expert decide, mas não escreve diretamente no formato canônico da Product Canon.**

##### Exemplos

**Exemplo 1 — Edição simples com padronização e aprovação sequencial.** O Domain Expert quer corrigir a definição de "cliente inativo". Ele escreve: *"Cliente inativo deveria incluir também quem não abriu ticket de suporte nos últimos 6 meses, além dos critérios atuais."*

A IA executa o Guardrail de Padronização Canônica e produz:

```
SBVR:
"É necessário que cada Cliente seja classificado como 'inativo' 
se e somente se o Cliente não realizou Compra nos últimos 12 meses 
E não realizou Login nos últimos 6 meses 
E não abriu Ticket de Suporte nos últimos 6 meses."

SBE:
Cenário: Cliente sem compras, sem login e sem tickets é inativo
  Dado que o Cliente "João" não realiza compras há 13 meses
  E não realiza login há 7 meses
  E não abre ticket de suporte há 7 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente é classificado como "inativo"

Cenário: Cliente com ticket recente não é inativo
  Dado que o Cliente "Maria" não realiza compras há 13 meses
  E não realiza login há 7 meses
  Mas abriu ticket de suporte há 3 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente NÃO é classificado como "inativo"
```

O Relatório de Conformidade sinaliza: *"A base de dados de Suporte pertence ao bounded context 'Atendimento'. A regra atual de inatividade opera apenas com dados do contexto 'Conta'. A nova regra introduz dependência cross-context."*

O Domain Expert aceita a formalização no ciclo iterativo. A IA gera o `expert-edit-plan`. O Domain Expert aprova o Change Plan — confirmando que a formalização SBVR+SBE consolidada preserva fielmente sua intenção. Somente então o Architect recebe o `expert-edit-plan` e avalia a implicação técnica da dependência cross-context (Conta → Atendimento). O Architect decide se aprova — registrando a dependência como evento assíncrono conforme princípios constitucionais — ou encaminha para cerimônia completa.

**Exemplo 2 — Edição com divergência intencional (conversacional).** O Domain Expert edita: *"Reembolsos até R$ 200 não precisam de aprovação do gerente."*

IA (Guardrail de Padronização Canônica): *Formalizei sua edição:*

```
SBVR: "É permitido que um Reembolso cujo Valor é menor ou igual 
a R$ 200,00 seja processado sem Aprovação hierárquica."

SBE:
Cenário: Reembolso de R$ 150 processado sem aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 150,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é processado automaticamente

Cenário: Reembolso de R$ 250 requer aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 250,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é encaminhado para aprovação do gerente
```

*Porém, identifiquei uma divergência: a regra atual na Product Canon define que "Reembolsos acima de R$ 500 exigem aprovação do gerente" — implicitamente, reembolsos até R$ 500 já não exigem. Sua edição reduz o limite de R$ 500 para R$ 200, tornando a aprovação mais restritiva. É essa a intenção?*

Domain Expert: *"Sim, política de compliance mudou. Agora o limite é R$ 200."*

IA: *Entendido. Registrarei como divergência intencional da regra atual. A formalização SBVR ajustada ficará:*

```
SBVR: "É obrigatório que cada Reembolso cujo Valor é superior a 
R$ 200,00 seja aprovado pelo Gerente responsável."
```

*Confirma esta formalização para gerar o Change Plan?*

Domain Expert confirma no ciclo iterativo. A IA gera o `expert-edit-plan` com a divergência intencional flagrada e a justificativa. O Domain Expert recebe o Change Plan consolidado e aprova — verificando que "R$ 200" não virou "R$ 2.000" e que a lógica de obrigatoriedade está correta na versão final. Somente após essa aprovação o Architect recebe o plano. O Architect avalia se a mudança de threshold tem impacto em fluxos de processamento automático ou integrações existentes, e aprova ou solicita ajuste técnico.

---

### Escopo 3 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a introdução da edição direta pelo Domain Expert, torna-se necessário um guardrail dedicado a garantir que toda escrita na Product Canon esteja no padrão oficial.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

Para requisitos e regras de negócio, o formato oficial é o par **SBVR + SBE**: cada regra é expressa como predicado formal SBVR acompanhado de cenários de verificação SBE. Para o glossário, o formato é definição precisa associada ao bounded context de validade. Para eventos de domínio, o formato segue o schema CloudEvents conforme princípios técnicos constitucionais.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando o Domain Builder fala em linguagem natural e a IA traduz para SBVR + SBE, o guardrail está implicitamente ativo.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O Domain Expert revisa e aprova a formalização — ele nunca escreve diretamente no formato canônico da Product Canon.

Este guardrail garante que, independentemente de quem origina a mudança e por qual caminho ela entra, a Product Canon mantém consistência de formato e legibilidade uniforme.

---

### Impacto na Seção 9 — Riscos

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. O risco existe de que, sob pressão, equipes usem edição direta para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes — conceitos novos requerem cerimônia; (b) aprovação sequencial obrigatória (Domain Expert + Architect) funciona como check de adequação do canal; (c) o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para SBVR + SBE. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Mitigação: (a) o Domain Expert revisa e aprova a formalização proposta durante o ciclo iterativo; (b) o Domain Expert aprova novamente o Change Plan consolidado — mitigando distorções introduzidas pela IA na consolidação; (c) a aprovação sequencial garante que o Architect avalia apenas artefatos com semântica já confirmada; (d) o ciclo iterativo permite correções antes da geração do Change Plan.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** O Domain Expert aprova a formalização duas vezes: uma no ciclo iterativo (passo 4-5) e outra no Change Plan consolidado (passo 7a). Se as duas aprovações forem percebidas como idênticas, a segunda pode sofrer o efeito "rubber stamp" — exatamente o oposto do pretendido. Mitigação: (a) a segunda aprovação opera sobre o artefato consolidado, não sobre cada edição individual — o Domain Expert vê o resultado final integrado, que pode revelar inconsistências não visíveis no refinamento incremental; (b) tooling pode destacar diferenças entre o que foi aceito no ciclo iterativo e o que aparece no Change Plan final, reduzindo esforço cognitivo; (c) em edições simples com Change Plan trivial, a segunda aprovação pode ser abreviada (confirmação rápida em vez de revisão completa).

---

### Impacto na Seção 10 — Prototipação

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue reescrever corretamente edições em linguagem natural para o formato oficial SBVR + SBE, preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização vs. necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar o fluxo completo: Domain Expert edita em formato livre → Guardrail de Padronização Canônica reescreve em SBVR + SBE → Guardrail de Conformidade Semântica valida → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar especificamente: (a) se a segunda aprovação do Domain Expert (no Change Plan) agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.2.3 | SBVR e SBE como par complementar explícito; SBVR como infraestrutura formal, SBE como superfície de validação humana |
| 2.2.5 | Novo guardrail: **Padronização Canônica** — garante formato oficial (SBVR + SBE) para toda escrita na Product Canon |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta na camada de negócio; aprovação sequencial (Domain Expert → Architect) no `expert-edit-plan` |
| 5 (Artefatos) | Novo tipo de Change Plan: `expert-edit-plan`; artefatos contêm par SBVR + SBE explícito |
| 9 (Riscos) | Novos riscos 9.8 (edição direta como atalho), 9.9 (qualidade da formalização automática) e 9.10 (fadiga de aprovação dupla) |
| 10 (Prototipação) | Novas prioridades 8 (Guardrail de Padronização Canônica) e 9 (edição direta com aprovação sequencial) |
| Princípio novo | Domain Expert edita em formato livre → IA formaliza em SBVR + SBE → Domain Expert aprova formalização no ciclo iterativo → IA gera Change Plan → Domain Expert aprova Change Plan consolidado → Architect aprova impacto técnico |

User: Adicione como escopo da proposta de mudança no modelo:


SBVR para formalizar o vocabulário do domínio e as regras de negócio — eliminando ambiguidade na raiz, já que a expressão de requisitos em qualquer linguagem humana é inevitavelmente ambígua e na maioria das vezes incompleta. 
IEEE 29148 para estruturar o documento de requisitos como um todo, incluindo requisitos não-funcionais, interfaces, restrições de design e critérios de qualidade — coisas que o SBVR não cobre.

insira IEEE 29148 como padrão oficial

GitHub Copilot: ## Proposta de Evolução do Modelo — v0.6

---

### Escopo 1 — Par Complementar SBVR + SBE na Requirements Specification Session

**Contexto.** O modelo v0.5 descreve a Requirements Specification Session como mediação SBVR, onde o Domain Builder fala em linguagem natural e a IA traduz para SBVR controlado. O risco 9.6 reconhece que o Domain Builder pode "rubber stamp" a formalização SBVR sem compreendê-la. A proposta é explicitar que SBVR e SBE operam como par complementar — não como artefatos independentes.

**Mudança.** Na Requirements Specification Session, cada requisito formalizado é apresentado ao Domain Builder em dois formatos simultâneos:

- **SBVR** — representação formal com quantificadores e predicados, usada pela IA como infraestrutura de validação de consistência contra a Product Canon.
- **SBE** — cenários concretos (Dado/Quando/Então) que tornam a regra tangível e verificável pelo Domain Builder.

O Domain Builder valida primariamente pelo SBE (que ele compreende intuitivamente) enquanto o SBVR serve como âncora formal para a IA verificar contradições, redundâncias e lacunas. O Domain Expert, na aprovação, recebe ambos os formatos para cross-verificação: se o SBVR diz uma coisa e o SBE ilustra outra, há divergência que precisa ser resolvida antes da aprovação.

**Fluxo revisado da seção 2.2.3:**

1. Domain Builder descreve requisito em linguagem natural
2. IA traduz para SBVR controlado + gera cenários SBE correspondentes
3. IA confronta o par SBVR+SBE com a Product Canon (regras existentes, glossário, princípios)
4. Domain Builder valida pelos cenários SBE; IA sinaliza divergências SBVR↔SBE
5. Par SBVR+SBE aprovado entra no Canonical Change Plan (`specification-plan`)
6. Domain Expert valida o par completo; Architect valida viabilidade técnica

**Impacto na Product Canon.** Os requisitos armazenados na Product Canon passam a conter explicitamente ambos os formatos: a regra formal (SBVR) e os cenários de verificação (SBE). Isso estabelece o **padrão oficial de escrita** da Product Canon para requisitos.

**Impacto no risco 9.6.** O risco de "rubber stamp" é reduzido porque o Domain Builder valida pelos cenários concretos (SBE), não pela notação formal (SBVR). A divergência entre os dois formatos funciona como detector de falhas de compreensão.

---

### Escopo 2 — IEEE 29148 como Padrão Estrutural de Requisitos

**Contexto.** O modelo v0.5 utiliza SBVR para formalizar vocabulário e regras de negócio, e SBE para critérios de aceitação verificáveis. No entanto, SBVR opera no nível de **regras individuais** — ele formaliza predicados, quantificadores e restrições sobre conceitos de domínio. Há uma dimensão que SBVR não cobre: a **estrutura documental** do conjunto de requisitos como um todo. Requisitos não-funcionais (performance, disponibilidade, segurança), especificações de interface, restrições de design e critérios de qualidade não são expressos como regras de negócio SBVR — são categorias estruturais que precisam de um framework organizacional.

**O problema que IEEE 29148 resolve.** A expressão de requisitos em qualquer linguagem humana é inevitavelmente ambígua e na maioria das vezes incompleta. SBVR ataca a ambiguidade na raiz — formaliza o vocabulário do domínio e transforma regras de negócio em predicados verificáveis, eliminando interpretações divergentes. Porém, SBVR não responde perguntas como: "Quais categorias de requisitos o documento precisa cobrir?", "Onde documentar que o sistema deve suportar 10.000 transações por segundo?", "Como registrar restrições de interface com sistemas externos?" ou "Qual a estrutura mínima de um documento de requisitos completo?"

IEEE 29148 (ISO/IEC/IEEE 29148:2018 — *Systems and software engineering — Life cycle processes — Requirements engineering*) é o padrão internacional que responde essas perguntas. Ele define a estrutura, os tipos e as características que um documento de requisitos deve ter — incluindo requisitos funcionais, não-funcionais, de interface, de design, e critérios de qualidade como rastreabilidade e verificabilidade.

**Mudança.** O ZionKit adota IEEE 29148 como **padrão oficial para estruturação de documentos de requisitos**, complementando SBVR e SBE na tríade de padrões do modelo:

| Padrão | Papel no ZionKit | O que cobre |
|--------|-----------------|-------------|
| **SBVR** | Formalização semântica | Vocabulário de domínio, regras de negócio declarativas, predicados com quantificadores — elimina ambiguidade na expressão de requisitos funcionais |
| **IEEE 29148** | Estrutura documental | Organização do documento de requisitos, taxonomia de tipos (funcionais, não-funcionais, interface, design), atributos de qualidade (rastreabilidade, verificabilidade, consistência), critérios de completude |
| **SBE** | Verificação concreta | Cenários de aceitação Dado/Quando/Então — tornam cada requisito testável e compreensível por pessoas de negócio |

**Como a tríade opera na prática.** Quando a Requirements Specification Session produz requisitos, eles são organizados seguindo a taxonomia IEEE 29148:

- **Requisitos funcionais** (regras de negócio, comportamentos do sistema) → formalizados em SBVR + verificados via SBE
- **Requisitos não-funcionais** (performance, disponibilidade, escalabilidade) → estruturados segundo IEEE 29148, com métricas verificáveis. Exemplo: "O sistema deve processar 95% das transações PIX em menos de 2 segundos" — não é uma regra SBVR (não opera sobre vocabulário de domínio), mas é um requisito que IEEE 29148 sabe classificar, estruturar e rastrear
- **Requisitos de interface** (integrações com sistemas externos, APIs, protocolos) → categorizados por IEEE 29148, com contratos formais
- **Restrições de design** (tecnologias obrigatórias, padrões arquiteturais mandatórios) → conectam-se diretamente aos princípios técnicos constitucionais da Product Canon
- **Atributos de qualidade de requisitos** (rastreabilidade, verificabilidade, não-ambiguidade) → IEEE 29148 define critérios que a IA aplica como checklist de validação sobre cada requisito produzido

**Impacto na Product Canon.** A seção de requisitos da Product Canon passa a ser estruturada segundo IEEE 29148. Isso significa que a Product Canon não contém apenas regras SBVR e cenários SBE — ela contém um **documento de requisitos completo** com seções para requisitos não-funcionais, interfaces, restrições e rastreabilidade. A IA, ao mediar a Requirements Specification Session, guia o Domain Builder e o Architect pela taxonomia IEEE 29148, garantindo que categorias não sejam omitidas.

**Impacto no Guardrail de Padronização Canônica.** O guardrail de Padronização Canônica (Escopo 4) ganha uma terceira dimensão de validação: além de verificar formato SBVR e cenários SBE, valida que o documento de requisitos segue a estrutura IEEE 29148 — todas as seções obrigatórias estão presentes, cada requisito tem atributos de rastreabilidade, requisitos não-funcionais possuem métricas verificáveis.

**Impacto na Requirements Specification Session.** A cerimônia passa a operar em dois níveis:

1. **Nível de regras individuais** — SBVR + SBE (como descrito no Escopo 1): cada regra de negócio é formalizada como predicado SBVR e verificada com cenários SBE.
2. **Nível de documento** — IEEE 29148: a IA verifica completude estrutural do conjunto de requisitos. Ao final da sessão, sinaliza categorias não cobertas: "Os requisitos funcionais de Pagamentos estão formalizados, mas não há requisitos de performance definidos para transações PIX. IEEE 29148 recomenda especificação de tempo de resposta, throughput e disponibilidade."

**Exemplo — preenchendo o gap que SBVR não cobre.** Na Requirements Specification Session para o bounded context de Pagamentos:

O Domain Builder descreve as regras de negócio (domínio SBVR):
- "Transações PIX acima de R$ 1.000 em horário noturno requerem confirmação adicional" → formalizado em SBVR + SBE

A IA, guiada pela taxonomia IEEE 29148, identifica categorias pendentes e conduz o Domain Builder e o Architect a declarar:
- **Requisito de performance**: "95% das transações PIX devem ser processadas em menos de 2 segundos"
- **Requisito de disponibilidade**: "O módulo de pagamentos PIX deve ter disponibilidade de 99,95%"
- **Requisito de interface**: "A integração com o sistema PIX do Banco Central segue o protocolo SPI versão 3.2"
- **Restrição de design**: "Transações PIX devem ser idempotentes — reprocessamento não gera duplicidade"

Esses requisitos não são regras SBVR — são categorias estruturais que IEEE 29148 sabe nomear, classificar e validar completude.

---

### Escopo 3 — Expansão do Papel do Domain Expert

**Contexto.** No modelo v0.5, o Domain Expert atua exclusivamente como aprovador — valida ou veta artefatos produzidos por outros. Seus insights sobre o domínio só entram no modelo se outro participante os captura. A proposta introduz três capacidades que tornam o Domain Expert um participante ativo sem quebrar a separação de autoridade.

#### 3.1 Aprovação com Anotações

O Domain Expert, ao avaliar um Canonical Change Plan, pode não apenas aprovar ou vetar, mas **anotar** artefatos específicos com observações semânticas. Anotações são insumos formais — a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Exemplo.** Domain Expert aprova o `specification-plan` de "reembolso parcial" mas anota: *"Atenção: 'reembolso parcial por valor' e 'reembolso parcial por item' têm regras tributárias completamente diferentes — tratar como conceitos separados."* A anotação fica registrada no Change Plan aprovado e é sinalizada pela IA na próxima Requirements Specification Session como candidata a formalização SBVR+SBE.

#### 3.2 Hotspots de Domínio

O Domain Expert pode marcar áreas da Product Canon como **hotspots** — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. A IA prioriza esses pontos na Clarificação de Conformidade.

**Exemplo.** Domain Expert marca o conceito "cliente inativo" como hotspot com a nota: *"Definição confundida frequentemente com 'cliente churned'. São conceitos distintos com regras diferentes."* Toda vez que uma especificação mencionar "cliente inativo", a IA exibe proativamente a definição precisa e a distinção com "churned".

#### 3.3 Edição Direta na Camada de Negócio (com Guardrails)

Capacidade mais sensível da proposta. O Domain Expert pode editar diretamente artefatos da **camada de negócio** da Product Canon — glossário, regras de negócio e requisitos — sem passar por uma cerimônia completa de Canon Building.

##### Restrições

- **Escopo**: apenas camada de negócio. Artefatos de arquitetura permanecem exclusivos do Architect.
- **Natureza**: refinamentos e correções de artefatos existentes. Criação de conceitos inteiramente novos requer cerimônia completa.
- **Formato**: o Domain Expert **não escreve diretamente na Product Canon**. Ele edita em linguagem natural ou formato livre. A IA é responsável por reescrever as edições no formato oficial da Product Canon (SBVR + SBE, estruturado conforme IEEE 29148), produzindo uma versão formalizada que o Domain Expert revisa e aprova antes da integração.
- **Aprovação sequencial**: toda edição direta requer primeiro aprovação do Domain Expert sobre a formalização SBVR+SBE (validando que a IA preservou o significado pretendido), e somente após essa aprovação o Architect avalia o impacto técnico da mudança. O Architect nunca aprova antes do Domain Expert.

##### Fluxo — Edição com Guardrails Pré-Change Plan

O processo de guardrails ocorre **antes** da geração do Canonical Change Plan. A cada edição, o Domain Expert é guiado por um ciclo iterativo de conformidade:

**Passo 1 — Edição pelo Domain Expert.** O Domain Expert propõe uma alteração em linguagem natural ou formato livre. Ele descreve o que quer mudar, sem preocupação com a notação formal.

**Passo 2 — Guardrail de Padronização Canônica (novo guardrail).** A IA recebe a edição e executa o **Guardrail de Padronização Canônica** — um guardrail com responsabilidade única de garantir que toda escrita na Product Canon esteja no padrão aderido pelo modelo ZionKit. Concretamente, a IA:

- Reescreve a edição do Domain Expert no formato oficial SBVR + SBE
- Verifica aderência à estrutura IEEE 29148 (categoria do requisito, atributos de rastreabilidade, métricas quando aplicável)
- Apresenta a versão formalizada como **proposta**, não como alteração consumada
- Sinaliza onde a linguagem original do Domain Expert diverge das definições existentes na Product Canon

A IA **não aplica** a edição. Ela produz uma versão candidata no formato canônico e a apresenta ao Domain Expert.

**Passo 3 — Guardrail de Conformidade Semântica.** Simultaneamente, a IA executa validação de conformidade contra a Product Canon existente, verificando:

- Consistência com o glossário de linguagem ubíqua
- Contradições com regras de negócio existentes
- Impacto em bounded contexts adjacentes
- Coerência entre a formalização SBVR e os cenários SBE gerados
- Completude estrutural segundo IEEE 29148 (se a mudança afeta requisitos não-funcionais ou interfaces relacionadas)

O resultado é um **Relatório de Conformidade** que consolida tanto a padronização canônica quanto a validação semântica.

**Passo 4 — Revisão guiada pelo Domain Expert.** O Domain Expert recebe:

1. A versão formalizada em SBVR + SBE (proposta pela IA)
2. O Relatório de Conformidade (divergências, contradições, impactos adjacentes)
3. Sugestões de ajuste (quando aplicável)

O Domain Expert **está no controle**: ele pode aceitar a formalização proposta, solicitar ajustes na reescrita, ou reescrever sua edição original e submeter novamente. A IA sinaliza e sugere — o Domain Expert decide e ajusta.

**Passo 5 — Ciclo iterativo.** Os passos 1-4 se repetem até que:

- O Domain Expert aceite a versão formalizada em SBVR + SBE
- O Relatório de Conformidade não apresente divergências críticas (ou o Domain Expert justifique explicitamente as divergências intencionais)

Divergências intencionais — casos onde o Domain Expert conscientemente diverge de uma regra existente — são registradas como itens flagrados que serão visíveis ao Architect na aprovação.

**Passo 6 — Geração do Canonical Change Plan.** Somente após a conclusão do ciclo iterativo de guardrails, a IA gera um Canonical Change Plan tipado como `expert-edit-plan`, contendo:

- A versão final formalizada em SBVR + SBE (já revisada pelo Domain Expert durante o ciclo iterativo)
- O Relatório de Conformidade final
- Divergências intencionais flagradas (se houver)
- Impactos em bounded contexts adjacentes

**Passo 7 — Aprovação sequencial: Domain Expert primeiro, Architect depois.**

A aprovação do `expert-edit-plan` é **sequencial com ordem fixa**: o Domain Expert aprova antes do Architect. Essa ordem existe por uma razão específica.

**7a — Aprovação pelo Domain Expert.** O Domain Expert aprova a formalização SBVR+SBE contida no Change Plan. Embora pareça redundante — ele já revisou a formalização no ciclo iterativo (passos 2-5) — a aprovação no Change Plan tem propósito distinto: **mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido.** O ciclo iterativo é um processo incremental de refinamento; o Change Plan é o artefato final consolidado. A aprovação pelo Domain Expert neste ponto é a garantia formal de que o artefato final preserva sua intenção original. Sem essa aprovação, existe o risco de que ajustes de formato introduzidos pela IA na consolidação do Change Plan alterem sutilmente a semântica — e o Architect, que não é o autor da intenção de negócio, não teria como detectar essa distorção.

**7b — Aprovação pelo Architect.** Somente após o Domain Expert aprovar, o Architect avalia o `expert-edit-plan`. O foco do Architect é exclusivamente o **impacto técnico** da mudança: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais (performance, disponibilidade, segurança) categorizados via IEEE 29148. O Architect não valida a semântica de negócio — isso já foi feito pelo Domain Expert. Ele aprova, solicita ajustes técnicos, ou rejeita (redirecionando para cerimônia completa se a mudança tiver escopo técnico que excede o canal de edição direta).

**Por que o Architect não aprova antes do Domain Expert?** Se o Architect aprovasse primeiro, ele avaliaria o impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção. Se o Domain Expert depois rejeitasse a formalização (porque a IA distorceu o significado), o trabalho de avaliação técnica do Architect seria descartado. A ordem sequencial garante que o Architect avalia apenas artefatos com semântica já validada pelo dono do domínio.

##### O Relatório de Conformidade: duas formas

O Relatório de Conformidade pode operar em duas modalidades, à escolha do Domain Expert:

**Forma estática (relatório).** A IA gera um documento estruturado com a formalização proposta, as divergências encontradas e as sugestões de ajuste. O Domain Expert lê, avalia e responde com sua decisão.

**Forma conversacional (processo guiado).** A IA conduz um diálogo iterativo com o Domain Expert, apresentando cada divergência individualmente, explicando o impacto e perguntando como proceder. Mais adequada para edições complexas com múltiplas implicações.

Em ambas as formas, o princípio é o mesmo: **a IA sinaliza, propõe a formalização em SBVR + SBE, e sugere ajustes — o Domain Expert decide, mas não escreve diretamente no formato canônico da Product Canon.**

##### Exemplos

**Exemplo 1 — Edição simples com padronização e aprovação sequencial.** O Domain Expert quer corrigir a definição de "cliente inativo". Ele escreve: *"Cliente inativo deveria incluir também quem não abriu ticket de suporte nos últimos 6 meses, além dos critérios atuais."*

A IA executa o Guardrail de Padronização Canônica e produz:

```
SBVR:
"É necessário que cada Cliente seja classificado como 'inativo' 
se e somente se o Cliente não realizou Compra nos últimos 12 meses 
E não realizou Login nos últimos 6 meses 
E não abriu Ticket de Suporte nos últimos 6 meses."

SBE:
Cenário: Cliente sem compras, sem login e sem tickets é inativo
  Dado que o Cliente "João" não realiza compras há 13 meses
  E não realiza login há 7 meses
  E não abre ticket de suporte há 7 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente é classificado como "inativo"

Cenário: Cliente com ticket recente não é inativo
  Dado que o Cliente "Maria" não realiza compras há 13 meses
  E não realiza login há 7 meses
  Mas abriu ticket de suporte há 3 meses
  Quando o sistema avalia o status do Cliente
  Então o Cliente NÃO é classificado como "inativo"

IEEE 29148 — Classificação:
  Tipo: Requisito funcional (regra de negócio)
  Rastreabilidade: altera REQ-CONTA-017
  Verificabilidade: cenários SBE acima
```

O Relatório de Conformidade sinaliza: *"A base de dados de Suporte pertence ao bounded context 'Atendimento'. A regra atual de inatividade opera apenas com dados do contexto 'Conta'. A nova regra introduz dependência cross-context."*

O Domain Expert aceita a formalização no ciclo iterativo. A IA gera o `expert-edit-plan`. O Domain Expert aprova o Change Plan — confirmando que a formalização SBVR+SBE consolidada preserva fielmente sua intenção. Somente então o Architect recebe o `expert-edit-plan` e avalia a implicação técnica da dependência cross-context (Conta → Atendimento). O Architect decide se aprova — registrando a dependência como evento assíncrono conforme princípios constitucionais — ou encaminha para cerimônia completa.

**Exemplo 2 — Edição com divergência intencional (conversacional).** O Domain Expert edita: *"Reembolsos até R$ 200 não precisam de aprovação do gerente."*

IA (Guardrail de Padronização Canônica): *Formalizei sua edição:*

```
SBVR: "É permitido que um Reembolso cujo Valor é menor ou igual 
a R$ 200,00 seja processado sem Aprovação hierárquica."

SBE:
Cenário: Reembolso de R$ 150 processado sem aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 150,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é processado automaticamente

Cenário: Reembolso de R$ 250 requer aprovação
  Dado que um Pedido possui Reembolso solicitado de R$ 250,00
  Quando o sistema avalia a necessidade de aprovação
  Então o Reembolso é encaminhado para aprovação do gerente
```

*Porém, identifiquei uma divergência: a regra atual na Product Canon define que "Reembolsos acima de R$ 500 exigem aprovação do gerente" — implicitamente, reembolsos até R$ 500 já não exigem. Sua edição reduz o limite de R$ 500 para R$ 200, tornando a aprovação mais restritiva. É essa a intenção?*

Domain Expert: *"Sim, política de compliance mudou. Agora o limite é R$ 200."*

IA: *Entendido. Registrarei como divergência intencional da regra atual. A formalização SBVR ajustada ficará:*

```
SBVR: "É obrigatório que cada Reembolso cujo Valor é superior a 
R$ 200,00 seja aprovado pelo Gerente responsável."
```

*Confirma esta formalização para gerar o Change Plan?*

Domain Expert confirma no ciclo iterativo. A IA gera o `expert-edit-plan` com a divergência intencional flagrada e a justificativa. O Domain Expert recebe o Change Plan consolidado e aprova — verificando que "R$ 200" não virou "R$ 2.000" e que a lógica de obrigatoriedade está correta na versão final. Somente após essa aprovação o Architect recebe o plano. O Architect avalia se a mudança de threshold tem impacto em fluxos de processamento automático ou integrações existentes, e aprova ou solicita ajuste técnico.

---

### Escopo 4 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a introdução da edição direta pelo Domain Expert e a adoção de IEEE 29148, torna-se necessário um guardrail dedicado a garantir que toda escrita na Product Canon esteja no padrão oficial.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

O guardrail valida três dimensões:

1. **SBVR** — regras de negócio e vocabulário de domínio estão formalizados como predicados com quantificadores, eliminando ambiguidade na expressão de requisitos funcionais.
2. **SBE** — cada regra possui cenários de verificação concretos (Dado/Quando/Então) que a tornam testável e compreensível por pessoas de negócio.
3. **IEEE 29148** — o documento de requisitos está estruturado com as categorias obrigatórias (funcionais, não-funcionais, interface, design), cada requisito possui atributos de rastreabilidade e verificabilidade, e requisitos não-funcionais possuem métricas verificáveis.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando o Domain Builder fala em linguagem natural e a IA traduz para SBVR + SBE, o guardrail está implicitamente ativo. A IA também verifica completude estrutural IEEE 29148 ao final de cada sessão.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O Domain Expert revisa e aprova a formalização — ele nunca escreve diretamente no formato canônico da Product Canon.

Este guardrail garante que, independentemente de quem origina a mudança e por qual caminho ela entra, a Product Canon mantém consistência de formato e legibilidade uniforme.

---

### Impacto na Seção 9 — Riscos

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. O risco existe de que, sob pressão, equipes usem edição direta para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes — conceitos novos requerem cerimônia; (b) aprovação sequencial obrigatória (Domain Expert + Architect) funciona como check de adequação do canal; (c) o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para SBVR + SBE com estrutura IEEE 29148. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Mitigação: (a) o Domain Expert revisa e aprova a formalização proposta durante o ciclo iterativo; (b) o Domain Expert aprova novamente o Change Plan consolidado — mitigando distorções introduzidas pela IA na consolidação; (c) a aprovação sequencial garante que o Architect avalia apenas artefatos com semântica já confirmada; (d) o ciclo iterativo permite correções antes da geração do Change Plan.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** O Domain Expert aprova a formalização duas vezes: uma no ciclo iterativo (passo 4-5) e outra no Change Plan consolidado (passo 7a). Se as duas aprovações forem percebidas como idênticas, a segunda pode sofrer o efeito "rubber stamp" — exatamente o oposto do pretendido. Mitigação: (a) a segunda aprovação opera sobre o artefato consolidado, não sobre cada edição individual — o Domain Expert vê o resultado final integrado, que pode revelar inconsistências não visíveis no refinamento incremental; (b) tooling pode destacar diferenças entre o que foi aceito no ciclo iterativo e o que aparece no Change Plan final, reduzindo esforço cognitivo; (c) em edições simples com Change Plan trivial, a segunda aprovação pode ser abreviada (confirmação rápida em vez de revisão completa).

**Novo risco 9.11 — Excesso de formalismo por IEEE 29148.** A adoção integral de IEEE 29148 pode introduzir burocracia documental incompatível com a filosofia de agilidade do modelo. Mitigação: o ZionKit adota IEEE 29148 como **guia de taxonomia e completude**, não como template rígido. A IA usa a taxonomia para sinalizar categorias não cobertas — não para exigir preenchimento de todos os campos do padrão. A aderência é adaptativa: projetos em fase inicial podem ter seções IEEE 29148 marcadas como "pendente de definição"; projetos maduros devem ter cobertura completa. O nível de rigor é uma decisão do Architect, não uma imposição do modelo.

---

### Impacto na Seção 10 — Prototipação

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue reescrever corretamente edições em linguagem natural para o formato oficial SBVR + SBE com classificação IEEE 29148, preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização vs. necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar o fluxo completo: Domain Expert edita em formato livre → Guardrail de Padronização Canônica reescreve em SBVR + SBE → Guardrail de Conformidade Semântica valida → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar especificamente: (a) se a segunda aprovação do Domain Expert (no Change Plan) agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final.

**Nova prioridade 10 — Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se: (a) a IA consegue guiar Domain Builder e Architect pelas categorias IEEE 29148 sem que o processo pareça burocrático; (b) a sinalização de categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) produz requisitos que teriam sido omitidos sem o guia; (c) a aderência adaptativa funciona na prática — projetos em fase inicial aceitam seções "pendente" sem pressão artificial de preenchimento.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.1 (Product Canon) | Requisitos na camada de negócio armazenados como tríade SBVR + SBE + estrutura IEEE 29148 |
| 2.2.3 | SBVR e SBE como par complementar explícito; IEEE 29148 como guia de completude estrutural; a sessão opera em dois níveis (regras individuais + documento) |
| 2.2.5 | Novo guardrail: **Padronização Canônica** — valida SBVR + SBE + IEEE 29148 para toda escrita na Product Canon |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta na camada de negócio; aprovação sequencial (Domain Expert → Architect) no `expert-edit-plan` |
| 5 (Artefatos) | Novo tipo de Change Plan: `expert-edit-plan`; requisitos estruturados conforme IEEE 29148 com par SBVR + SBE; novo padrão oficial adotado: IEEE 29148 |
| 9 (Riscos) | Novos riscos 9.8 (edição direta como atalho), 9.9 (qualidade da formalização automática), 9.10 (fadiga de aprovação dupla), 9.11 (excesso de formalismo IEEE 29148) |
| 10 (Prototipação) | Novas prioridades 8 (Guardrail de Padronização Canônica), 9 (edição direta com aprovação sequencial), 10 (taxonomia IEEE 29148) |

**Tríade de padrões oficiais do ZionKit v0.6:**

| Padrão | Responsabilidade |
|--------|-----------------|
| **SBVR** | Eliminar ambiguidade — formaliza vocabulário de domínio e regras de negócio como predicados verificáveis |
| **IEEE 29148** | Garantir completude — estrutura o documento de requisitos com todas as categorias (funcionais, não-funcionais, interface, design, qualidade) |
| **SBE** | Tornar verificável — transforma cada requisito em cenários concretos compreensíveis por pessoas de negócio e executáveis como testes |*Confirma esta formalização para gerar o Change Plan?*

Domain Expert confirma no ciclo iterativo. A IA gera o `expert-edit-plan` com a divergência intencional flagrada e a justificativa. O Domain Expert recebe o Change Plan consolidado e aprova — verificando que "R$ 200" não virou "R$ 2.000" e que a lógica de obrigatoriedade está correta na versão final. Somente após essa aprovação o Architect recebe o plano. O Architect avalia se a mudança de threshold tem impacto em fluxos de processamento automático ou integrações existentes, e aprova ou solicita ajuste técnico.

---

### Escopo 4 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a introdução da edição direta pelo Domain Expert e a adoção de IEEE 29148, torna-se necessário um guardrail dedicado a garantir que toda escrita na Product Canon esteja no padrão oficial.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

O guardrail valida três dimensões:

1. **SBVR** — regras de negócio e vocabulário de domínio estão formalizados como predicados com quantificadores, eliminando ambiguidade na expressão de requisitos funcionais.
2. **SBE** — cada regra possui cenários de verificação concretos (Dado/Quando/Então) que a tornam testável e compreensível por pessoas de negócio.
3. **IEEE 29148** — o documento de requisitos está estruturado com as categorias obrigatórias (funcionais, não-funcionais, interface, design), cada requisito possui atributos de rastreabilidade e verificabilidade, e requisitos não-funcionais possuem métricas verificáveis.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando o Domain Builder fala em linguagem natural e a IA traduz para SBVR + SBE, o guardrail está implicitamente ativo. A IA também verifica completude estrutural IEEE 29148 ao final de cada sessão.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O Domain Expert revisa e aprova a formalização — ele nunca escreve diretamente no formato canônico da Product Canon.

Este guardrail garante que, independentemente de quem origina a mudança e por qual caminho ela entra, a Product Canon mantém consistência de formato e legibilidade uniforme.

---

### Impacto na Seção 9 — Riscos

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. O risco existe de que, sob pressão, equipes usem edição direta para evitar o custo de uma Domain Discovery ou Requirements Specification Session completa, degradando a qualidade da Product Canon. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes — conceitos novos requerem cerimônia; (b) aprovação sequencial obrigatória (Domain Expert + Architect) funciona como check de adequação do canal; (c) o Guardrail de Padronização Canônica impede que edições mal-formatadas contaminem a Product Canon.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para SBVR + SBE com estrutura IEEE 29148. Traduções imprecisas podem alterar o significado pretendido pelo Domain Expert. Mitigação: (a) o Domain Expert revisa e aprova a formalização proposta durante o ciclo iterativo; (b) o Domain Expert aprova novamente o Change Plan consolidado — mitigando distorções introduzidas pela IA na consolidação; (c) a aprovação sequencial garante que o Architect avalia apenas artefatos com semântica já confirmada; (d) o ciclo iterativo permite correções antes da geração do Change Plan.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** O Domain Expert aprova a formalização duas vezes: uma no ciclo iterativo (passo 4-5) e outra no Change Plan consolidado (passo 7a). Se as duas aprovações forem percebidas como idênticas, a segunda pode sofrer o efeito "rubber stamp" — exatamente o oposto do pretendido. Mitigação: (a) a segunda aprovação opera sobre o artefato consolidado, não sobre cada edição individual — o Domain Expert vê o resultado final integrado, que pode revelar inconsistências não visíveis no refinamento incremental; (b) tooling pode destacar diferenças entre o que foi aceito no ciclo iterativo e o que aparece no Change Plan final, reduzindo esforço cognitivo; (c) em edições simples com Change Plan trivial, a segunda aprovação pode ser abreviada (confirmação rápida em vez de revisão completa).

**Novo risco 9.11 — Excesso de formalismo por IEEE 29148.** A adoção integral de IEEE 29148 pode introduzir burocracia documental incompatível com a filosofia de agilidade do modelo. Mitigação: o ZionKit adota IEEE 29148 como **guia de taxonomia e completude**, não como template rígido. A IA usa a taxonomia para sinalizar categorias não cobertas — não para exigir preenchimento de todos os campos do padrão. A aderência é adaptativa: projetos em fase inicial podem ter seções IEEE 29148 marcadas como "pendente de definição"; projetos maduros devem ter cobertura completa. O nível de rigor é uma decisão do Architect, não uma imposição do modelo.

---

### Impacto na Seção 10 — Prototipação

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue reescrever corretamente edições em linguagem natural para o formato oficial SBVR + SBE com classificação IEEE 29148, preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização vs. necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito).

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar o fluxo completo: Domain Expert edita em formato livre → Guardrail de Padronização Canônica reescreve em SBVR + SBE → Guardrail de Conformidade Semântica valida → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar especificamente: (a) se a segunda aprovação do Domain Expert (no Change Plan) agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final.

**Nova prioridade 10 — Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se: (a) a IA consegue guiar Domain Builder e Architect pelas categorias IEEE 29148 sem que o processo pareça burocrático; (b) a sinalização de categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) produz requisitos que teriam sido omitidos sem o guia; (c) a aderência adaptativa funciona na prática — projetos em fase inicial aceitam seções "pendente" sem pressão artificial de preenchimento.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.1 (Product Canon) | Requisitos na camada de negócio armazenados como tríade SBVR + SBE + estrutura IEEE 29148 |
| 2.2.3 | SBVR e SBE como par complementar explícito; IEEE 29148 como guia de completude estrutural; a sessão opera em dois níveis (regras individuais + documento) |
| 2.2.5 | Novo guardrail: **Padronização Canônica** — valida SBVR + SBE + IEEE 29148 para toda escrita na Product Canon |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta na camada de negócio; aprovação sequencial (Domain Expert → Architect) no `expert-edit-plan` |
| 5 (Artefatos) | Novo tipo de Change Plan: `expert-edit-plan`; requisitos estruturados conforme IEEE 29148 com par SBVR + SBE; novo padrão oficial adotado: IEEE 29148 |
| 9 (Riscos) | Novos riscos 9.8 (edição direta como atalho), 9.9 (qualidade da formalização automática), 9.10 (fadiga de aprovação dupla), 9.11 (excesso de formalismo IEEE 29148) |
| 10 (Prototipação) | Novas prioridades 8 (Guardrail de Padronização Canônica), 9 (edição direta com aprovação sequencial), 10 (taxonomia IEEE 29148) |

**Tríade de padrões oficiais do ZionKit v0.6:**

| Padrão | Responsabilidade |
|--------|-----------------|
| **SBVR** | Eliminar ambiguidade — formaliza vocabulário de domínio e regras de negócio como predicados verificáveis |
| **IEEE 29148** | Garantir completude — estrutura o documento de requisitos com todas as categorias (funcionais, não-funcionais, interface, design, qualidade) |
| **SBE** | Tornar verificável — transforma cada requisito em cenários concretos compreensíveis por pessoas de negócio e executáveis como testes |

User: Adicione como escopo da proposta de mudança no modelo:

Utilize o SBVR apenas como processo de validação dos requisitos escritos pelo dos usuarios a ia utiliza a metodologia como ferramenta pra ajudar o usuario a clarificar seu requisito mas na hora de escreve-lo canicamente o padrao ieee 29148 + SBE deve ser utilizado
a linguagem SBVr não deve aparecer no canonical change plan, usuario escreve o requisito ia utiliza sbvr como ferramenta de validação para que o processo de clarificação guie o usuario a melhorar o requisito.

GitHub Copilot: ## Proposta de Evolução do Modelo — v0.6

---

### Escopo 1 — SBVR como Ferramenta de Validação Interna, IEEE 29148 + SBE como Formato Canônico

**Contexto.** O modelo v0.5 descreve SBVR como formato de escrita visível na Product Canon — o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e a formalização SBVR é apresentada, armazenada e aprovada. O risco 9.6 reconhece que o Domain Builder pode "rubber stamp" a notação SBVR sem compreendê-la. A proposta anterior (Escopo 1 da v0.6) tentava mitigar isso com o par SBVR+SBE. No entanto, uma análise mais precisa revela que o problema é mais fundamental: **SBVR não deveria ser formato de escrita visível — deveria ser ferramenta de processo.**

**O problema que esta mudança resolve.** A expressão de requisitos em qualquer linguagem humana é inevitavelmente ambígua e na maioria das vezes incompleta. SBVR — com seus quantificadores, predicados e vocabulário controlado — é extremamente eficaz para **detectar** essa ambiguidade e incompletude. Porém, apresentar a notação SBVR ao usuário final (Domain Builder ou Domain Expert) cria dois problemas: (a) o usuário precisa validar um formato que não escreveu e frequentemente não compreende; (b) o artefato armazenado na Product Canon contém uma notação que serve à IA, não às pessoas que consultam o repositório.

**Mudança.** SBVR passa a ser **ferramenta interna de validação da IA**, não formato de escrita canônico. A notação SBVR **não aparece** em Canonical Change Plans, na Product Canon, nem é apresentada para aprovação humana. O formato canônico oficial para requisitos no ZionKit é **IEEE 29148 + SBE**.

**Como SBVR opera como ferramenta de validação.** Quando o Domain Builder descreve um requisito em linguagem natural, a IA internamente traduz para SBVR controlado — predicados com quantificadores, vocabulário formal, restrições explícitas. Essa tradução interna permite à IA:

- Detectar ambiguidades: "clientes inativos não devem receber promoções" — quem é "inativo"? SBVR força a definição precisa.
- Detectar incompletude: "o pedido pode ser cancelado" — por quem? Até quando? SBVR exige todos os participantes e condições.
- Detectar contradições: o novo requisito contradiz regra existente na Product Canon? A comparação SBVR↔SBVR entre o requisito proposto e as regras existentes é mecanicamente precisa.
- Detectar redundâncias: o requisito já está coberto por outra regra? A representação formal permite comparação.

O resultado dessas detecções **não é apresentado em notação SBVR**. A IA traduz os problemas encontrados de volta para linguagem natural e os apresenta como perguntas de clarificação ao Domain Builder. O processo é conversacional — a IA guia o usuário a refinar seu requisito até que a tradução SBVR interna não apresente mais ambiguidades, incompletudes ou contradições.

**O que o usuário vê.** O usuário nunca vê SBVR. Ele vê:

1. Perguntas de clarificação em linguagem natural: *"Quando você diz 'cliente inativo', você se refere a quem não compra há 12 meses E não faz login há 6 meses (conforme definição atual na Product Canon), ou tem outra definição em mente?"*
2. Alertas de contradição em linguagem natural: *"A regra atual diz que reembolsos acima de R$ 500 exigem aprovação. Sua proposta reduz o limite para R$ 200. Confirma a intenção?"*
3. O requisito final formalizado em **IEEE 29148 + SBE** — o formato canônico que será armazenado na Product Canon.

**Fluxo revisado da Requirements Specification Session (seção 2.2.3):**

1. Domain Builder descreve requisito em linguagem natural
2. IA internamente traduz para SBVR controlado (invisível ao usuário)
3. IA usa a representação SBVR para detectar ambiguidades, incompletudes, contradições e redundâncias contra a Product Canon
4. IA apresenta perguntas de clarificação em linguagem natural ao Domain Builder (derivadas das detecções SBVR)
5. Domain Builder refina o requisito — ciclo iterativo até que a validação SBVR interna passe sem problemas
6. IA formaliza o requisito clarificado no formato canônico: **IEEE 29148** (estrutura, classificação, atributos de rastreabilidade) + **SBE** (cenários Dado/Quando/Então)
7. Domain Builder valida o requisito no formato IEEE 29148 + SBE
8. Requisito aprovado entra no Canonical Change Plan (`specification-plan`)
9. Domain Expert valida fidelidade semântica; Architect valida viabilidade técnica

**O que muda nos artefatos:**

- **Product Canon**: requisitos armazenados em IEEE 29148 + SBE. Sem notação SBVR.
- **Canonical Change Plans** (`specification-plan`, `expert-edit-plan`): contêm requisitos em IEEE 29148 + SBE. Sem notação SBVR.
- **Processo de clarificação**: SBVR é o motor interno. O usuário vê perguntas em linguagem natural e respostas em IEEE 29148 + SBE.

**Exemplo — o processo de clarificação SBVR em ação (invisível ao usuário).**

Domain Builder diz: *"O cliente deve poder cancelar um pedido antes do faturamento."*

*Internamente, a IA traduz para SBVR:*
```
[SBVR INTERNO — não visível ao usuário]
"É obrigatório que cada Pedido cujo Status é 'Pendente' ou 
'Confirmado' possa ser cancelado pelo Cliente titular. 
É proibido que um Pedido cujo Status é 'Faturado' seja cancelado."
```

*A IA detecta via SBVR: (a) falta definição de quem pode cancelar (apenas o titular?); (b) existe regra na Product Canon sobre devolução pós-faturamento.*

*O que o Domain Builder vê (linguagem natural):*

IA: *"Duas perguntas sobre essa regra:*
1. *Quem pode cancelar — apenas o cliente titular do pedido, ou um operador de suporte também pode cancelar em nome do cliente?*
2. *A Product Canon já define que pedidos faturados não podem ser cancelados, apenas devolvidos. Devo incluir o caminho de devolução como alternativa pós-faturamento?"*

Domain Builder esclarece. A IA refaz a validação SBVR interna. Quando não há mais problemas detectados, a IA gera o artefato final:

```
IEEE 29148 — Requisito REQ-PEDIDOS-042
═══════════════════════════════════════

Tipo: Funcional (regra de negócio)
Bounded Context: Pedidos
Prioridade: Alta
Rastreabilidade: substitui REQ-PEDIDOS-038

Descrição:
  O Cliente titular ou um Operador de Suporte autorizado pode 
  cancelar um Pedido cujo status seja "Pendente" ou "Confirmado". 
  Pedidos com status "Faturado" não podem ser cancelados; o caminho 
  alternativo é a solicitação de devolução (REQ-PEDIDOS-029).

SBE — Cenários de aceitação:

  Cenário: Cliente cancela pedido pendente
    Dado que o Pedido #1234 possui status "Pendente"
    E o Cliente "João" é titular do Pedido
    Quando o Cliente solicita cancelamento
    Então o Pedido é cancelado com sucesso
    E o status muda para "Cancelado"

  Cenário: Operador cancela pedido confirmado
    Dado que o Pedido #5678 possui status "Confirmado"
    E o Operador "Ana" possui autorização de suporte
    Quando o Operador solicita cancelamento em nome do Cliente
    Então o Pedido é cancelado com sucesso

  Cenário: Cancelamento bloqueado após faturamento
    Dado que o Pedido #9012 possui status "Faturado"
    Quando o Cliente solicita cancelamento
    Então o sistema rejeita o cancelamento
    E sugere solicitação de devolução (REQ-PEDIDOS-029)
```

Note: **SBVR não aparece em nenhum artefato.** Ele operou nos bastidores para detectar que faltava definir quem pode cancelar e para identificar a regra de devolução existente. O resultado é um requisito IEEE 29148 + SBE claro, completo e verificável.

---

### Escopo 2 — IEEE 29148 como Padrão Estrutural de Requisitos

**Contexto.** Com SBVR reposicionado como ferramenta interna de validação, IEEE 29148 assume papel central como framework de **estrutura e escrita** dos requisitos na Product Canon. Não é mais apenas "complemento" — é o padrão oficial de formato.

**O que IEEE 29148 cobre que SBVR e SBE não cobrem.** IEEE 29148 (ISO/IEC/IEEE 29148:2018 — *Systems and software engineering — Life cycle processes — Requirements engineering*) define:

- **Taxonomia de tipos de requisitos**: funcionais, não-funcionais (performance, disponibilidade, segurança), de interface, de design, restrições
- **Atributos obrigatórios por requisito**: identificador único, rastreabilidade (de onde veio, o que afeta), prioridade, verificabilidade
- **Estrutura mínima do documento**: quais seções um documento de requisitos completo deve conter
- **Critérios de qualidade**: cada requisito deve ser não-ambíguo, completo, consistente, verificável e rastreável

**Como IEEE 29148 opera no ZionKit.** Na Requirements Specification Session:

1. **Nível de regras individuais**: cada requisito é escrito conforme IEEE 29148 (tipo, ID, rastreabilidade, descrição) com cenários SBE de verificação. A IA usa SBVR internamente para validar a expressão antes de formalizar.
2. **Nível de documento**: a IA verifica completude estrutural do conjunto de requisitos. Ao final da sessão, sinaliza categorias não cobertas: *"Os requisitos funcionais de Pagamentos estão completos, mas não há requisitos de performance definidos para transações PIX. Recomendo especificar tempo de resposta, throughput e disponibilidade."*

**Requisitos não-funcionais, interfaces e restrições.** Esses tipos não passam pela validação SBVR (não são regras de vocabulário de domínio), mas são classificados e estruturados por IEEE 29148:

- **Requisitos de performance**: "95% das transações PIX devem ser processadas em menos de 2 segundos"
- **Requisitos de disponibilidade**: "O módulo de pagamentos PIX deve ter disponibilidade de 99,95%"
- **Requisitos de interface**: "A integração com o sistema PIX do Banco Central segue o protocolo SPI versão 3.2"
- **Restrições de design**: "Transações PIX devem ser idempotentes — reprocessamento não gera duplicidade"

Esses requisitos se conectam diretamente aos princípios técnicos constitucionais da Product Canon, e sua aprovação é primária pelo Architect.

**Aderência adaptativa.** O ZionKit adota IEEE 29148 como **guia de taxonomia e completude**, não como template rígido. A IA usa a taxonomia para sinalizar categorias não cobertas — não para exigir preenchimento de todos os campos do padrão. Projetos em fase inicial podem ter seções marcadas como "pendente de definição"; projetos maduros devem ter cobertura completa. O nível de rigor é uma decisão do Architect.

---

### Escopo 3 — Expansão do Papel do Domain Expert

**Contexto.** No modelo v0.5, o Domain Expert atua exclusivamente como aprovador — valida ou veta artefatos produzidos por outros. Seus insights sobre o domínio só entram no modelo se outro participante os captura. A proposta introduz três capacidades que tornam o Domain Expert um participante ativo sem quebrar a separação de autoridade.

#### 3.1 Aprovação com Anotações

O Domain Expert, ao avaliar um Canonical Change Plan, pode não apenas aprovar ou vetar, mas **anotar** artefatos específicos com observações semânticas. Anotações são insumos formais — a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Exemplo.** Domain Expert aprova o `specification-plan` de "reembolso parcial" mas anota: *"Atenção: 'reembolso parcial por valor' e 'reembolso parcial por item' têm regras tributárias completamente diferentes — tratar como conceitos separados."* A anotação fica registrada no Change Plan aprovado e é sinalizada pela IA na próxima Requirements Specification Session como candidata a formalização.

#### 3.2 Hotspots de Domínio

O Domain Expert pode marcar áreas da Product Canon como **hotspots** — zonas que requerem atenção especial. Um hotspot sinaliza que determinado conceito, regra ou bounded context é frágil, frequentemente mal interpretado, ou tem histórico de problemas. A IA prioriza esses pontos na Clarificação de Conformidade.

**Exemplo.** Domain Expert marca o conceito "cliente inativo" como hotspot com a nota: *"Definição confundida frequentemente com 'cliente churned'. São conceitos distintos com regras diferentes."* Toda vez que uma especificação mencionar "cliente inativo", a IA exibe proativamente a definição precisa e a distinção com "churned".

#### 3.3 Edição Direta na Camada de Negócio (com Guardrails)

Capacidade mais sensível da proposta. O Domain Expert pode editar diretamente artefatos da **camada de negócio** da Product Canon — glossário, regras de negócio e requisitos — sem passar por uma cerimônia completa de Canon Building.

##### Restrições

- **Escopo**: apenas camada de negócio. Artefatos de arquitetura permanecem exclusivos do Architect.
- **Natureza**: refinamentos e correções de artefatos existentes. Criação de conceitos inteiramente novos requer cerimônia completa.
- **Formato**: o Domain Expert **não escreve diretamente na Product Canon**. Ele edita em linguagem natural ou formato livre. A IA usa SBVR internamente para validar a edição (detectar ambiguidades, contradições, incompletudes), e em seguida formaliza no formato canônico IEEE 29148 + SBE. O Domain Expert revisa e aprova a formalização antes da integração.
- **Aprovação sequencial**: toda edição direta requer primeiro aprovação do Domain Expert sobre a formalização IEEE 29148 + SBE (validando que a IA preservou o significado pretendido), e somente após essa aprovação o Architect avalia o impacto técnico da mudança. O Architect nunca aprova antes do Domain Expert.

##### Fluxo — Edição com Guardrails Pré-Change Plan

O processo de guardrails ocorre **antes** da geração do Canonical Change Plan. A cada edição, o Domain Expert é guiado por um ciclo iterativo de conformidade:

**Passo 1 — Edição pelo Domain Expert.** O Domain Expert propõe uma alteração em linguagem natural ou formato livre. Ele descreve o que quer mudar, sem preocupação com a notação formal.

**Passo 2 — Validação SBVR interna + Guardrail de Padronização Canônica.** A IA recebe a edição e executa dois processos:

- **Validação SBVR interna** (invisível ao Domain Expert): a IA traduz a edição para SBVR controlado e confronta com a Product Canon existente. Detecta ambiguidades, contradições, incompletudes e redundâncias.
- **Guardrail de Padronização Canônica**: a IA reescreve a edição no formato oficial IEEE 29148 + SBE. Verifica aderência à estrutura IEEE 29148 (categoria do requisito, atributos de rastreabilidade, métricas quando aplicável).

A IA apresenta ao Domain Expert:
- Perguntas de clarificação derivadas da validação SBVR (em linguagem natural)
- A versão formalizada em IEEE 29148 + SBE como **proposta**
- O Relatório de Conformidade (divergências, contradições, impactos adjacentes)

A IA **não aplica** a edição. Ela produz uma versão candidata no formato canônico e a apresenta ao Domain Expert.

**Passo 3 — Revisão guiada pelo Domain Expert.** O Domain Expert recebe:

1. Perguntas de clarificação (derivadas da validação SBVR interna, apresentadas em linguagem natural)
2. A versão formalizada em IEEE 29148 + SBE (proposta pela IA)
3. O Relatório de Conformidade (divergências, contradições, impactos adjacentes)
4. Sugestões de ajuste (quando aplicável)

O Domain Expert **está no controle**: ele pode aceitar a formalização proposta, solicitar ajustes na reescrita, responder as perguntas de clarificação, ou reescrever sua edição original e submeter novamente. A IA sinaliza e sugere — o Domain Expert decide e ajusta.

**Passo 4 — Ciclo iterativo.** Os passos 1-3 se repetem até que:

- A validação SBVR interna não detecte mais problemas (ou o Domain Expert justifique explicitamente as divergências intencionais)
- O Domain Expert aceite a versão formalizada em IEEE 29148 + SBE

Divergências intencionais — casos onde o Domain Expert conscientemente diverge de uma regra existente — são registradas como itens flagrados que serão visíveis ao Architect na aprovação.

**Passo 5 — Geração do Canonical Change Plan.** Somente após a conclusão do ciclo iterativo, a IA gera um Canonical Change Plan tipado como `expert-edit-plan`, contendo:

- A versão final formalizada em IEEE 29148 + SBE (sem notação SBVR)
- O Relatório de Conformidade final
- Divergências intencionais flagradas (se houver)
- Impactos em bounded contexts adjacentes

**Passo 6 — Aprovação sequencial: Domain Expert primeiro, Architect depois.**

**6a — Aprovação pelo Domain Expert.** O Domain Expert aprova a formalização IEEE 29148 + SBE contida no Change Plan. Embora pareça redundante — ele já revisou a formalização no ciclo iterativo — a aprovação no Change Plan tem propósito distinto: **mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido.** O ciclo iterativo é um processo incremental de refinamento; o Change Plan é o artefato final consolidado. A aprovação pelo Domain Expert neste ponto é a garantia formal de que o artefato final preserva sua intenção original.

**6b — Aprovação pelo Architect.** Somente após o Domain Expert aprovar, o Architect avalia o `expert-edit-plan`. O foco do Architect é exclusivamente o **impacto técnico** da mudança: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais categorizados via IEEE 29148. O Architect não valida a semântica de negócio — isso já foi feito pelo Domain Expert. Ele aprova, solicita ajustes técnicos, ou rejeita (redirecionando para cerimônia completa se a mudança tiver escopo técnico que excede o canal de edição direta).

**Por que o Architect não aprova antes do Domain Expert?** Se o Architect aprovasse primeiro, ele avaliaria o impacto técnico de um artefato cuja semântica de negócio ainda não foi confirmada pelo autor da intenção. Se o Domain Expert depois rejeitasse a formalização (porque a IA distorceu o significado), o trabalho de avaliação técnica do Architect seria descartado. A ordem sequencial garante que o Architect avalia apenas artefatos com semântica já validada.

##### O Relatório de Conformidade: duas formas

O Relatório de Conformidade pode operar em duas modalidades, à escolha do Domain Expert:

**Forma estática (relatório).** A IA gera um documento estruturado com a formalização proposta, as divergências encontradas e as sugestões de ajuste. O Domain Expert lê, avalia e responde com sua decisão.

**Forma conversacional (processo guiado).** A IA conduz um diálogo iterativo com o Domain Expert, apresentando cada divergência individualmente, explicando o impacto e perguntando como proceder. Mais adequada para edições complexas com múltiplas implicações.

Em ambas as formas, o princípio é o mesmo: **a IA usa SBVR internamente para detectar problemas, apresenta os problemas em linguagem natural, e formaliza o resultado em IEEE 29148 + SBE. O Domain Expert nunca vê notação SBVR.**

##### Exemplos

**Exemplo 1 — Edição com clarificação SBVR invisível.** O Domain Expert quer corrigir a definição de "cliente inativo". Ele escreve: *"Cliente inativo deveria incluir também quem não abriu ticket de suporte nos últimos 6 meses, além dos critérios atuais."*

*Internamente, a IA valida via SBVR e detecta: a nova regra introduz dependência com o bounded context "Atendimento" — o contexto "Conta" precisaria consumir dados de "Atendimento".*

*O que o Domain Expert vê:*

IA: *"Entendi a mudança. Uma observação importante: a definição atual de 'cliente inativo' usa apenas dados do contexto Conta (compras e login). Ao incluir tickets de suporte, que pertencem ao contexto Atendimento, a regra passa a depender de dois contextos diferentes. Confirma a inclusão?"*

Domain Expert confirma. A IA gera:

```
IEEE 29148 — Requisito REQ-CONTA-017 (v2)
══════════════════════════════════════════

Tipo: Funcional (regra de negócio)
Bounded Context: Conta (com dependência: Atendimento)
Prioridade: Alta
Rastreabilidade: altera REQ-CONTA-017 v1
Verificabilidade: cenários SBE abaixo

Descrição:
  Um Cliente é classificado como "inativo" se e somente se 
  não realizou Compra nos últimos 12 meses, não realizou Login 
  nos últimos 6 meses, e não abriu Ticket de Suporte nos últimos 
  6 meses.

SBE — Cenários de aceitação:

  Cenário: Cliente sem atividade em nenhum canal é inativo
    Dado que o Cliente "João" não realiza compras há 13 meses
    E não realiza login há 7 meses
    E não abre ticket de suporte há 7 meses
    Quando o sistema avalia o status do Cliente
    Então o Cliente é classificado como "inativo"

  Cenário: Cliente com ticket recente não é inativo
    Dado que o Cliente "Maria" não realiza compras há 13 meses
    E não realiza login há 7 meses
    Mas abriu ticket de suporte há 3 meses
    Quando o sistema avalia o status do Cliente
    Então o Cliente NÃO é classificado como "inativo"
```

O Domain Expert aceita. A IA gera o `expert-edit-plan`. O Domain Expert aprova o Change Plan — confirmando que a formalização consolidada preserva sua intenção. Somente então o Architect recebe o plano e avalia a dependência cross-context (Conta → Atendimento).

**Exemplo 2 — Clarificação SBVR detecta contradição.** O Domain Expert edita: *"Reembolsos até R$ 200 não precisam de aprovação do gerente."*

*Internamente, a IA valida via SBVR e detecta: a regra atual diz "Reembolsos acima de R$ 500 exigem aprovação." A nova regra reduz o limite para R$ 200.*

*O que o Domain Expert vê:*

IA: *"A regra atual na Product Canon define que reembolsos acima de R$ 500 exigem aprovação do gerente — ou seja, reembolsos até R$ 500 já não exigem. Sua edição reduz o limite para R$ 200, tornando a aprovação mais restritiva. É essa a intenção?"*

Domain Expert: *"Sim, política de compliance mudou. Agora o limite é R$ 200."*

IA gera:

```
IEEE 29148 — Requisito REQ-PAGAMENTOS-011 (v2)
═══════════════════════════════════════════════

Tipo: Funcional (regra de negócio / compliance)
Bounded Context: Pagamentos
Prioridade: Alta
Rastreabilidade: altera REQ-PAGAMENTOS-011 v1
                 origem: política de compliance atualizada
Verificabilidade: cenários SBE abaixo

Descrição:
  Todo Reembolso cujo valor seja superior a R$ 200,00 deve ser 
  aprovado pelo Gerente responsável antes do processamento.

SBE — Cenários de aceitação:

  Cenário: Reembolso abaixo do threshold processado automaticamente
    Dado que um Reembolso de R$ 150,00 foi solicitado
    Quando o sistema avalia a necessidade de aprovação
    Então o Reembolso é processado automaticamente

  Cenário: Reembolso acima do threshold requer aprovação
    Dado que um Reembolso de R$ 250,00 foi solicitado
    Quando o sistema avalia a necessidade de aprovação
    Então o Reembolso é encaminhado para aprovação do Gerente
```

Domain Expert confirma. A IA gera o `expert-edit-plan` com a divergência intencional flagrada. Domain Expert aprova o Change Plan. Architect avalia impacto técnico.

---

### Escopo 4 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a adoção de IEEE 29148 + SBE como formato canônico e o reposicionamento de SBVR como ferramenta interna, torna-se necessário um guardrail dedicado ao formato.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

O guardrail valida duas dimensões:

1. **IEEE 29148** — o requisito está estruturado com os atributos obrigatórios (tipo, ID, rastreabilidade, descrição, verificabilidade), classificado na taxonomia correta (funcional, não-funcional, interface, design), e o documento como um todo cobre as categorias necessárias.
2. **SBE** — cada requisito funcional possui cenários de aceitação concretos (Dado/Quando/Então) que o tornam testável e compreensível por pessoas de negócio.

Nota: SBVR não é validado pelo guardrail de Padronização Canônica porque SBVR não é formato de escrita — é ferramenta interna de validação da IA. O guardrail que valida a qualidade semântica (onde SBVR atua nos bastidores) é o guardrail de **Validação de Consistência** existente, que agora opera com SBVR como motor interno.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando a IA formaliza requisitos após o processo de clarificação, o guardrail verifica formato IEEE 29148 + SBE automaticamente.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer geração de Change Plan.

---

### Impacto Consolidado no Papel de SBVR no Modelo

| Aspecto | v0.5 (atual) | v0.6 (proposta) |
|---------|-------------|----------------|
| **Visibilidade** | Visível — apresentado ao Domain Builder e armazenado na Product Canon | Invisível — ferramenta interna da IA, nunca apresentado ao usuário |
| **Função** | Formato de escrita para regras de negócio | Motor de validação semântica (detecção de ambiguidade, incompletude, contradição, redundância) |
| **Onde aparece** | Product Canon, Canonical Change Plans, tela de aprovação | Nenhum artefato. Opera nos bastidores durante clarificação |
| **Quem interage** | Domain Builder valida, Domain Expert aprova | Apenas a IA — usa internamente para gerar perguntas de clarificação |
| **Risco 9.6 (rubber stamp)** | Mitigado parcialmente pelo par SBVR+SBE | Eliminado — o usuário nunca vê SBVR, valida apenas IEEE 29148 + SBE |

**Padrões oficiais do ZionKit v0.6:**

| Padrão | Papel | Visibilidade |
|--------|-------|-------------|
| **SBVR** | Motor interno de validação — detecta ambiguidade, incompletude, contradição e redundância na expressão de requisitos | Invisível — opera nos bastidores da IA |
| **IEEE 29148** | Formato canônico de estrutura — organiza requisitos com tipo, ID, rastreabilidade, classificação. Cobre categorias que a validação SBVR não alcança: requisitos não-funcionais, interfaces, restrições de design | Visível — formato de escrita na Product Canon e Canonical Change Plans |
| **SBE** | Formato canônico de verificação — cenários concretos Dado/Quando/Então que tornam cada requisito testável e compreensível por pessoas de negócio | Visível — acompanha cada requisito na Product Canon e Canonical Change Plans |

---

### Impacto na Seção 9 — Riscos

**Risco 9.6 revisado — SBVR como ferramenta interna.** O risco original ("Domain Builder pode rubber stamp a notação SBVR") é eliminado pelo reposicionamento: SBVR nunca é apresentado ao usuário. Risco residual migra para um novo vetor: **a qualidade da tradução SBVR→perguntas de clarificação**. Se a IA não consegue traduzir os problemas detectados pela validação SBVR em perguntas claras e acionáveis em linguagem natural, o benefício da validação se perde. Mitigação: as perguntas de clarificação são o principal ponto de teste na prototipação (prioridade 6 revisada).

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes; (b) aprovação sequencial obrigatória (Domain Expert + Architect); (c) Guardrail de Padronização Canônica impede edições mal-formatadas.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para IEEE 29148 + SBE. Mitigação: (a) Domain Expert revisa no ciclo iterativo; (b) Domain Expert aprova Change Plan consolidado; (c) ciclo iterativo permite correções.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** O Domain Expert aprova a formalização duas vezes: no ciclo iterativo e no Change Plan. Mitigação: (a) segunda aprovação opera sobre artefato consolidado; (b) tooling pode destacar diferenças; (c) edições simples permitem confirmação abreviada.

**Novo risco 9.11 — Excesso de formalismo por IEEE 29148.** Mitigação: aderência adaptativa — guia de taxonomia e completude, não template rígido. Nível de rigor é decisão do Architect.

---

### Impacto na Seção 10 — Prototipação

**Prioridade 6 revisada — Validação SBVR como motor interno de clarificação.** Testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradições em requisitos descritos em linguagem natural; (b) a IA consegue traduzir os problemas detectados pela validação SBVR em perguntas de clarificação claras e acionáveis em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE significativamente mais completos e consistentes do que sem a validação SBVR. Métrica principal: taxa de problemas detectados pela validação SBVR que resultam em mudanças efetivas no requisito final.

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue formalizar edições em linguagem natural para IEEE 29148 + SBE preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa.

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar fluxo completo incluindo a segunda aprovação do Domain Expert no Change Plan consolidado. Avaliar se agrega valor real.

**Nova prioridade 10 — Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se a sinalização de categorias não cobertas produz requisitos que teriam sido omitidos sem o guia.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.1 (Product Canon) | Requisitos armazenados em IEEE 29148 + SBE. SBVR removido dos artefatos visíveis |
| 2.2.3 | SBVR torna-se motor interno de validação/clarificação. Formato de saída é IEEE 29148 + SBE. Sessão opera em dois níveis (regras individuais + documento) |
| 2.2.5 | Novo guardrail: **Padronização Canônica** (IEEE 29148 + SBE). Validação de Consistência passa a usar SBVR como motor interno |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta; aprovação sequencial (Domain Expert → Architect). IA ganha ato operacional: "usar SBVR internamente para validação" |
| 5 (Artefatos) | Novo tipo: `expert-edit-plan`. Requisitos em IEEE 29148 + SBE (sem SBVR). Padrões oficiais: IEEE 29148 (estrutura) + SBE (verificação) + SBVR (validação interna) |
| 9 (Riscos) | 9.6 revisado (SBVR como tool interno). Novos: 9.8, 9.9, 9.10, 9.11 |
| 10 (Prototipação) | Prioridade 6 revisada (SBVR como motor de clarificação). Novas: 8, 9, 10 |Domain Expert confirma. A IA gera o `expert-edit-plan` com a divergência intencional flagrada. Domain Expert aprova o Change Plan. Architect avalia impacto técnico.

---

### Escopo 4 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 define dois guardrails na seção 2.2.5: Clarificação de Conformidade (vocabulário) e Validação de Consistência (contradições). Nenhum dos dois trata do **formato de escrita** dos artefatos na Product Canon. Com a adoção de IEEE 29148 + SBE como formato canônico e o reposicionamento de SBVR como ferramenta interna, torna-se necessário um guardrail dedicado ao formato.

**Mudança.** Adicionar à seção 2.2.5 um novo guardrail:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon — seja produzido por cerimônia, por edição direta ou por retroalimentação — passa pelo guardrail de Padronização Canônica. A responsabilidade deste guardrail é única: garantir que a escrita esteja no formato oficial aderido pelo modelo ZionKit.

O guardrail valida duas dimensões:

1. **IEEE 29148** — o requisito está estruturado com os atributos obrigatórios (tipo, ID, rastreabilidade, descrição, verificabilidade), classificado na taxonomia correta (funcional, não-funcional, interface, design), e o documento como um todo cobre as categorias necessárias.
2. **SBE** — cada requisito funcional possui cenários de aceitação concretos (Dado/Quando/Então) que o tornam testável e compreensível por pessoas de negócio.

Nota: SBVR não é validado pelo guardrail de Padronização Canônica porque SBVR não é formato de escrita — é ferramenta interna de validação da IA. O guardrail que valida a qualidade semântica (onde SBVR atua nos bastidores) é o guardrail de **Validação de Consistência** existente, que agora opera com SBVR como motor interno.

O guardrail opera em dois modos:

- **Nas cerimônias de Canon Building**: a padronização é parte integrante da mediação da IA. Quando a IA formaliza requisitos após o processo de clarificação, o guardrail verifica formato IEEE 29148 + SBE automaticamente.
- **Na edição direta pelo Domain Expert**: o guardrail é explícito. O Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer geração de Change Plan.

---

### Impacto Consolidado no Papel de SBVR no Modelo

| Aspecto | v0.5 (atual) | v0.6 (proposta) |
|---------|-------------|----------------|
| **Visibilidade** | Visível — apresentado ao Domain Builder e armazenado na Product Canon | Invisível — ferramenta interna da IA, nunca apresentado ao usuário |
| **Função** | Formato de escrita para regras de negócio | Motor de validação semântica (detecção de ambiguidade, incompletude, contradição, redundância) |
| **Onde aparece** | Product Canon, Canonical Change Plans, tela de aprovação | Nenhum artefato. Opera nos bastidores durante clarificação |
| **Quem interage** | Domain Builder valida, Domain Expert aprova | Apenas a IA — usa internamente para gerar perguntas de clarificação |
| **Risco 9.6 (rubber stamp)** | Mitigado parcialmente pelo par SBVR+SBE | Eliminado — o usuário nunca vê SBVR, valida apenas IEEE 29148 + SBE |

**Padrões oficiais do ZionKit v0.6:**

| Padrão | Papel | Visibilidade |
|--------|-------|-------------|
| **SBVR** | Motor interno de validação — detecta ambiguidade, incompletude, contradição e redundância na expressão de requisitos | Invisível — opera nos bastidores da IA |
| **IEEE 29148** | Formato canônico de estrutura — organiza requisitos com tipo, ID, rastreabilidade, classificação. Cobre categorias que a validação SBVR não alcança: requisitos não-funcionais, interfaces, restrições de design | Visível — formato de escrita na Product Canon e Canonical Change Plans |
| **SBE** | Formato canônico de verificação — cenários concretos Dado/Quando/Então que tornam cada requisito testável e compreensível por pessoas de negócio | Visível — acompanha cada requisito na Product Canon e Canonical Change Plans |

---

### Impacto na Seção 9 — Riscos

**Risco 9.6 revisado — SBVR como ferramenta interna.** O risco original ("Domain Builder pode rubber stamp a notação SBVR") é eliminado pelo reposicionamento: SBVR nunca é apresentado ao usuário. Risco residual migra para um novo vetor: **a qualidade da tradução SBVR→perguntas de clarificação**. Se a IA não consegue traduzir os problemas detectados pela validação SBVR em perguntas claras e acionáveis em linguagem natural, o benefício da validação se perde. Mitigação: as perguntas de clarificação são o principal ponto de teste na prototipação (prioridade 6 revisada).

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** A edição direta pelo Domain Expert é explicitamente um complemento, não um substituto para cerimônias. Mitigação: (a) escopo restrito a refinamentos de artefatos existentes; (b) aprovação sequencial obrigatória (Domain Expert + Architect); (c) Guardrail de Padronização Canônica impede edições mal-formatadas.

**Novo risco 9.9 — Qualidade da formalização automática.** O Guardrail de Padronização Canônica depende da capacidade da IA de reescrever corretamente edições em linguagem natural para IEEE 29148 + SBE. Mitigação: (a) Domain Expert revisa no ciclo iterativo; (b) Domain Expert aprova Change Plan consolidado; (c) ciclo iterativo permite correções.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** O Domain Expert aprova a formalização duas vezes: no ciclo iterativo e no Change Plan. Mitigação: (a) segunda aprovação opera sobre artefato consolidado; (b) tooling pode destacar diferenças; (c) edições simples permitem confirmação abreviada.

**Novo risco 9.11 — Excesso de formalismo por IEEE 29148.** Mitigação: aderência adaptativa — guia de taxonomia e completude, não template rígido. Nível de rigor é decisão do Architect.

---

### Impacto na Seção 10 — Prototipação

**Prioridade 6 revisada — Validação SBVR como motor interno de clarificação.** Testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradições em requisitos descritos em linguagem natural; (b) a IA consegue traduzir os problemas detectados pela validação SBVR em perguntas de clarificação claras e acionáveis em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE significativamente mais completos e consistentes do que sem a validação SBVR. Métrica principal: taxa de problemas detectados pela validação SBVR que resultam em mudanças efetivas no requisito final.

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue formalizar edições em linguagem natural para IEEE 29148 + SBE preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa.

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar fluxo completo incluindo a segunda aprovação do Domain Expert no Change Plan consolidado. Avaliar se agrega valor real.

**Nova prioridade 10 — Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se a sinalização de categorias não cobertas produz requisitos que teriam sido omitidos sem o guia.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.1 (Product Canon) | Requisitos armazenados em IEEE 29148 + SBE. SBVR removido dos artefatos visíveis |
| 2.2.3 | SBVR torna-se motor interno de validação/clarificação. Formato de saída é IEEE 29148 + SBE. Sessão opera em dois níveis (regras individuais + documento) |
| 2.2.5 | Novo guardrail: **Padronização Canônica** (IEEE 29148 + SBE). Validação de Consistência passa a usar SBVR como motor interno |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta; aprovação sequencial (Domain Expert → Architect). IA ganha ato operacional: "usar SBVR internamente para validação" |
| 5 (Artefatos) | Novo tipo: `expert-edit-plan`. Requisitos em IEEE 29148 + SBE (sem SBVR). Padrões oficiais: IEEE 29148 (estrutura) + SBE (verificação) + SBVR (validação interna) |
| 9 (Riscos) | 9.6 revisado (SBVR como tool interno). Novos: 9.8, 9.9, 9.10, 9.11 |
| 10 (Prototipação) | Prioridade 6 revisada (SBVR como motor de clarificação). Novas: 8, 9, 10 |

User: Adicione como escopo da proposta de mudança no modelo:

Esclareça que na validação SBVR é uma das metodologias que sera utilizada não a unica, sbvr deve ser agregada ao modo de validaão atual do modelo nao substitui-lo.

GitHub Copilot: ## Proposta de Evolução do Modelo — v0.6

---

### Escopo 1 — SBVR como Uma das Ferramentas de Validação Interna, IEEE 29148 + SBE como Formato Canônico

**Contexto.** O modelo v0.5 descreve SBVR como formato de escrita visível na Product Canon — o Domain Builder fala em linguagem natural, a IA traduz para SBVR controlado, e a formalização SBVR é apresentada, armazenada e aprovada. O risco 9.6 reconhece que o Domain Builder pode "rubber stamp" a notação SBVR sem compreendê-la.

**O problema.** A expressão de requisitos em qualquer linguagem humana é inevitavelmente ambígua e na maioria das vezes incompleta. SBVR — com seus quantificadores, predicados e vocabulário controlado — é extremamente eficaz para **detectar** certos tipos de ambiguidade e incompletude, especialmente em regras de negócio declarativas. Porém, apresentar a notação SBVR ao usuário final cria dois problemas: (a) o usuário precisa validar um formato que não escreveu e frequentemente não compreende; (b) o artefato armazenado na Product Canon contém uma notação que serve à IA, não às pessoas que consultam o repositório.

**Mudança.** SBVR passa a ser **uma das ferramentas internas de validação da IA**, não formato de escrita canônico. A notação SBVR **não aparece** em Canonical Change Plans, na Product Canon, nem é apresentada para aprovação humana. O formato canônico oficial para requisitos no ZionKit é **IEEE 29148 + SBE**.

**Esclarecimento fundamental: SBVR agrega, não substitui.** SBVR é adicionado ao arsenal de validação da IA como ferramenta complementar aos guardrails já existentes no modelo — Clarificação de Conformidade, Validação de Consistência e Versionamento Gradual por Estrangulamento. Cada mecanismo cobre um vetor diferente de falha:

| Mecanismo de validação | O que detecta | Escopo |
|---|---|---|
| **Clarificação de Conformidade** (guardrail existente) | Termos que divergem do vocabulário formalizado na Product Canon | Alinhamento terminológico — o participante está usando as palavras certas? |
| **Validação de Consistência** (guardrail existente) | Contradições entre novos requisitos e o estado atual da Product Canon (regras de negócio + princípios técnicos) | Coerência global — o novo requisito contradiz algo que já existe? |
| **Validação SBVR** (novo — ferramenta interna) | Ambiguidade estrutural, incompletude de predicados, falta de quantificadores, indefinição de participantes e condições | Precisão da expressão individual — o requisito, como está escrito, admite mais de uma interpretação? Faltam condições? Faltam atores? |
| **Versionamento por Estrangulamento** (guardrail existente) | Mudanças estruturais que devem ser aplicadas gradualmente | Impacto de transição — a mudança é grande demais para ser aplicada de uma vez? |

SBVR é particularmente forte em algo que os guardrails existentes não cobrem: a **análise da expressão individual de um requisito**. A Clarificação de Conformidade verifica se os termos estão corretos; a Validação de Consistência verifica se o requisito contradiz regras existentes. Mas nenhum dos dois analisa se a **forma como o requisito foi escrito** é ambígua, incompleta ou admite múltiplas interpretações. SBVR preenche essa lacuna — forçando internamente a decomposição do requisito em predicados formais, a IA consegue detectar gaps que passariam despercebidos na validação puramente terminológica ou por contradição.

**A IA pode (e deve) usar outras metodologias de validação além de SBVR.** O modelo não prescreve que SBVR seja a única ferramenta interna. A IA pode empregar análise de dependências entre bounded contexts, verificação de completude de fluxos (todos os caminhos alternativos foram cobertos?), análise de cobertura de cenários de erro, ou qualquer outra técnica que melhore a qualidade da clarificação — desde que o resultado siga o mesmo princípio: **a IA apresenta problemas detectados como perguntas de clarificação em linguagem natural, nunca como notação formal visível ao usuário.**

**Como SBVR opera como ferramenta interna (junto com os demais mecanismos).** Quando o Domain Builder descreve um requisito em linguagem natural, a IA ativa simultaneamente todos os mecanismos de validação:

1. **Clarificação de Conformidade** verifica se os termos usados estão alinhados com o glossário da Product Canon
2. **Validação SBVR** traduz internamente o requisito para predicados formais e detecta ambiguidades estruturais, participantes indefinidos e condições faltantes
3. **Validação de Consistência** confronta o novo requisito com regras existentes na Product Canon
4. **Outros mecanismos** aplicáveis ao contexto (análise de fluxo, cobertura de cenários, etc.)

Os problemas detectados por qualquer mecanismo são consolidados e apresentados ao Domain Builder como **perguntas de clarificação em linguagem natural**. O Domain Builder não sabe (e não precisa saber) qual mecanismo interno detectou qual problema. Ele vê um processo conversacional de refinamento onde a IA o ajuda a expressar seu requisito com precisão crescente.

**O que o usuário vê.** O usuário nunca vê SBVR nem qualquer outra notação formal interna. Ele vê:

1. Perguntas de clarificação em linguagem natural: *"Quando você diz 'cliente inativo', você se refere a quem não compra há 12 meses E não faz login há 6 meses (conforme definição atual na Product Canon), ou tem outra definição em mente?"* (detectado pela Clarificação de Conformidade)
2. Alertas de incompletude: *"Quem pode cancelar o pedido — apenas o cliente titular, ou um operador de suporte também?"* (detectado pela validação SBVR — falta de definição do ator)
3. Alertas de contradição: *"A regra atual diz que reembolsos acima de R$ 500 exigem aprovação. Sua proposta reduz o limite para R$ 200. Confirma a intenção?"* (detectado pela Validação de Consistência)
4. O requisito final formalizado em **IEEE 29148 + SBE** — o formato canônico que será armazenado na Product Canon.

**Fluxo revisado da Requirements Specification Session (seção 2.2.3):**

1. Domain Builder descreve requisito em linguagem natural
2. IA ativa todos os mecanismos de validação simultaneamente (Clarificação de Conformidade + SBVR + Consistência + outros)
3. IA consolida problemas detectados e apresenta perguntas de clarificação em linguagem natural
4. Domain Builder refina o requisito — ciclo iterativo até que os mecanismos de validação passem sem problemas
5. IA formaliza o requisito clarificado no formato canônico: **IEEE 29148** (estrutura, classificação, atributos de rastreabilidade) + **SBE** (cenários Dado/Quando/Então)
6. Domain Builder valida o requisito no formato IEEE 29148 + SBE
7. Requisito aprovado entra no Canonical Change Plan (`specification-plan`)
8. Domain Expert valida fidelidade semântica; Architect valida viabilidade técnica

**O que muda nos artefatos:**

- **Product Canon**: requisitos armazenados em IEEE 29148 + SBE. Sem notação SBVR.
- **Canonical Change Plans**: contêm requisitos em IEEE 29148 + SBE. Sem notação SBVR.
- **Processo de clarificação**: SBVR é um dos motores internos, junto com os guardrails existentes. O usuário vê perguntas consolidadas em linguagem natural e respostas em IEEE 29148 + SBE.

**Exemplo — o processo de clarificação com múltiplos mecanismos (todos invisíveis ao usuário).**

Domain Builder diz: *"O cliente deve poder cancelar um pedido antes do faturamento."*

*Internamente, a IA ativa três mecanismos:*

- *Clarificação de Conformidade: "cliente" está no glossário como "titular da conta" — alinhado ✓*
- *Validação SBVR: traduz para predicado formal → detecta (a) ator indefinido — "apenas o titular?"; (b) condição de fronteira — "e se o pedido está em processamento, entre confirmado e faturado?"*
- *Validação de Consistência: existe regra na Product Canon sobre devolução pós-faturamento — complementar ✓*

*O que o Domain Builder vê (perguntas consolidadas em linguagem natural):*

IA: *"Três pontos sobre essa regra:*
1. *Quem pode cancelar — apenas o cliente titular do pedido, ou um operador de suporte também pode cancelar em nome do cliente?*
2. *Se o pedido está em processamento (entre 'Confirmado' e 'Faturado'), ele ainda pode ser cancelado?*
3. *A Product Canon já define que pedidos faturados não podem ser cancelados, apenas devolvidos. Devo incluir o caminho de devolução como alternativa pós-faturamento?"*

Domain Builder esclarece. A IA revalida com todos os mecanismos. Quando não há mais problemas, gera o artefato final:

```
IEEE 29148 — Requisito REQ-PEDIDOS-042
═══════════════════════════════════════

Tipo: Funcional (regra de negócio)
Bounded Context: Pedidos
Prioridade: Alta
Rastreabilidade: substitui REQ-PEDIDOS-038

Descrição:
  O Cliente titular ou um Operador de Suporte autorizado pode 
  cancelar um Pedido cujo status seja "Pendente" ou "Confirmado". 
  Pedidos com status "Em Processamento" ou "Faturado" não podem 
  ser cancelados; o caminho alternativo para pedidos faturados é 
  a solicitação de devolução (REQ-PEDIDOS-029).

SBE — Cenários de aceitação:

  Cenário: Cliente cancela pedido pendente
    Dado que o Pedido #1234 possui status "Pendente"
    E o Cliente "João" é titular do Pedido
    Quando o Cliente solicita cancelamento
    Então o Pedido é cancelado com sucesso
    E o status muda para "Cancelado"

  Cenário: Operador cancela pedido confirmado
    Dado que o Pedido #5678 possui status "Confirmado"
    E o Operador "Ana" possui autorização de suporte
    Quando o Operador solicita cancelamento em nome do Cliente
    Então o Pedido é cancelado com sucesso

  Cenário: Cancelamento bloqueado em processamento
    Dado que o Pedido #3456 possui status "Em Processamento"
    Quando o Cliente solicita cancelamento
    Então o sistema rejeita o cancelamento
    E informa que o pedido está em processamento

  Cenário: Cancelamento bloqueado após faturamento
    Dado que o Pedido #9012 possui status "Faturado"
    Quando o Cliente solicita cancelamento
    Então o sistema rejeita o cancelamento
    E sugere solicitação de devolução (REQ-PEDIDOS-029)
```

Note: a validação SBVR detectou o ator indefinido e a condição de fronteira ("Em Processamento"). A Validação de Consistência detectou a regra de devolução existente. A Clarificação de Conformidade confirmou o vocabulário. **Nenhuma notação formal apareceu** — o Domain Builder viu perguntas claras e o resultado é IEEE 29148 + SBE.

---

### Escopo 2 — IEEE 29148 como Padrão Estrutural de Requisitos

**Contexto.** Com SBVR reposicionado como uma das ferramentas internas de validação, IEEE 29148 assume papel central como framework de **estrutura e escrita** dos requisitos na Product Canon.

**O que IEEE 29148 cobre.** IEEE 29148 (ISO/IEC/IEEE 29148:2018 — *Systems and software engineering — Life cycle processes — Requirements engineering*) define:

- **Taxonomia de tipos de requisitos**: funcionais, não-funcionais (performance, disponibilidade, segurança), de interface, de design, restrições
- **Atributos obrigatórios por requisito**: identificador único, rastreabilidade (de onde veio, o que afeta), prioridade, verificabilidade
- **Estrutura mínima do documento**: quais seções um documento de requisitos completo deve conter
- **Critérios de qualidade**: cada requisito deve ser não-ambíguo, completo, consistente, verificável e rastreável

**Requisitos não-funcionais, interfaces e restrições.** Esses tipos não passam pela validação SBVR (não são regras de vocabulário de domínio), mas são classificados e estruturados por IEEE 29148:

- **Requisitos de performance**: "95% das transações PIX devem ser processadas em menos de 2 segundos"
- **Requisitos de disponibilidade**: "O módulo de pagamentos PIX deve ter disponibilidade de 99,95%"
- **Requisitos de interface**: "A integração com o sistema PIX do Banco Central segue o protocolo SPI versão 3.2"
- **Restrições de design**: "Transações PIX devem ser idempotentes — reprocessamento não gera duplicidade"

Esses requisitos se conectam diretamente aos princípios técnicos constitucionais da Product Canon, e sua aprovação é primária pelo Architect.

**Nível de documento na Requirements Specification Session.** A IA verifica completude estrutural do conjunto de requisitos ao final da sessão: *"Os requisitos funcionais de Pagamentos estão completos, mas não há requisitos de performance definidos para transações PIX. Recomendo especificar tempo de resposta, throughput e disponibilidade."*

**Aderência adaptativa.** IEEE 29148 é adotado como **guia de taxonomia e completude**, não como template rígido. Projetos em fase inicial podem ter seções marcadas como "pendente de definição"; projetos maduros devem ter cobertura completa. O nível de rigor é uma decisão do Architect.

---

### Escopo 3 — Expansão do Papel do Domain Expert

**Contexto.** No modelo v0.5, o Domain Expert atua exclusivamente como aprovador. A proposta introduz três capacidades que o tornam participante ativo sem quebrar a separação de autoridade.

#### 3.1 Aprovação com Anotações

O Domain Expert, ao avaliar um Canonical Change Plan, pode **anotar** artefatos específicos com observações semânticas. Anotações são insumos formais — a IA as incorpora no próximo ciclo de Canon Building como candidatos a formalização.

**Exemplo.** Domain Expert aprova o `specification-plan` de "reembolso parcial" mas anota: *"Atenção: 'reembolso parcial por valor' e 'reembolso parcial por item' têm regras tributárias completamente diferentes — tratar como conceitos separados."*

#### 3.2 Hotspots de Domínio

O Domain Expert pode marcar áreas da Product Canon como **hotspots** — zonas frágeis, frequentemente mal interpretadas, ou com histórico de problemas. A IA prioriza esses pontos na Clarificação de Conformidade.

**Exemplo.** Domain Expert marca "cliente inativo" como hotspot: *"Confundido frequentemente com 'cliente churned'. São conceitos distintos."* Toda menção a "cliente inativo" dispara exibição proativa da distinção.

#### 3.3 Edição Direta na Camada de Negócio (com Guardrails)

O Domain Expert pode editar diretamente artefatos da **camada de negócio** da Product Canon — glossário, regras de negócio e requisitos — sem cerimônia completa.

##### Restrições

- **Escopo**: apenas camada de negócio.
- **Natureza**: refinamentos e correções de artefatos existentes. Conceitos novos requerem cerimônia completa.
- **Formato**: o Domain Expert edita em linguagem natural. A IA valida internamente (Conformidade + SBVR + Consistência + outros mecanismos) e formaliza no formato canônico IEEE 29148 + SBE.
- **Aprovação sequencial**: Domain Expert aprova a formalização primeiro, Architect avalia impacto técnico depois.

##### Fluxo — Edição com Guardrails Pré-Change Plan

**Passo 1 — Edição pelo Domain Expert.** Propõe alteração em linguagem natural ou formato livre.

**Passo 2 — Validação interna + Guardrail de Padronização Canônica.** A IA executa:

- **Todos os mecanismos de validação** (Conformidade + SBVR + Consistência + outros) — detecta problemas na edição
- **Guardrail de Padronização Canônica** — reescreve a edição no formato oficial IEEE 29148 + SBE

A IA apresenta ao Domain Expert: perguntas de clarificação (derivadas dos mecanismos de validação, em linguagem natural), a versão formalizada em IEEE 29148 + SBE como proposta, e o Relatório de Conformidade.

**Passo 3 — Revisão guiada pelo Domain Expert.** O Domain Expert pode aceitar a formalização, solicitar ajustes, responder perguntas de clarificação, ou reescrever a edição. A IA sinaliza e sugere — o Domain Expert decide.

**Passo 4 — Ciclo iterativo.** Repete até que os mecanismos de validação não detectem mais problemas (ou o Domain Expert justifique divergências intencionais) e o Domain Expert aceite a versão IEEE 29148 + SBE.

**Passo 5 — Geração do Canonical Change Plan.** Somente após a conclusão do ciclo iterativo, a IA gera um `expert-edit-plan` contendo: versão final em IEEE 29148 + SBE, Relatório de Conformidade final, divergências intencionais flagradas, impactos em bounded contexts adjacentes. Sem notação SBVR.

**Passo 6 — Aprovação sequencial: Domain Expert primeiro, Architect depois.**

**6a — Aprovação pelo Domain Expert.** Aprova a formalização IEEE 29148 + SBE contida no Change Plan. Propósito: **mitigar o risco de que a IA, ao consolidar o `expert-edit-plan`, tenha reescrito ou reorganizado os requisitos de forma que altere o significado pretendido.** O ciclo iterativo é refinamento incremental; o Change Plan é o artefato final consolidado. Sem essa aprovação, ajustes de formato introduzidos na consolidação podem alterar sutilmente a semântica, e o Architect não teria como detectar.

**6b — Aprovação pelo Architect.** Somente após o Domain Expert aprovar. Foco exclusivo no **impacto técnico**: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, impacto em requisitos não-funcionais. Não valida semântica de negócio — já feito pelo Domain Expert. Aprova, solicita ajustes técnicos, ou rejeita (redirecionando para cerimônia completa).

**Por que o Architect não aprova antes do Domain Expert?** Se aprovasse primeiro, avaliaria impacto técnico de artefato com semântica não confirmada. Se o Domain Expert depois rejeitasse, o trabalho do Architect seria descartado. A ordem sequencial garante que o Architect avalia apenas artefatos com semântica já validada.

##### O Relatório de Conformidade: duas formas

**Forma estática (relatório).** Documento estruturado com formalização proposta, divergências e sugestões.

**Forma conversacional (processo guiado).** Diálogo iterativo apresentando cada divergência individualmente. Mais adequado para edições complexas.

Em ambas: **a IA usa seus mecanismos de validação internamente, apresenta problemas em linguagem natural, e formaliza o resultado em IEEE 29148 + SBE. Nenhuma notação formal interna é visível ao Domain Expert.**

##### Exemplos

**Exemplo 1 — Edição com clarificação por múltiplos mecanismos.** O Domain Expert escreve: *"Cliente inativo deveria incluir também quem não abriu ticket de suporte nos últimos 6 meses."*

*Internamente: Clarificação de Conformidade confirma "cliente inativo" no glossário ✓; Validação SBVR detecta que a condição original era conjuntiva (A E B) e a nova adiciona (A E B E C) — sem ambiguidade ✓; Validação de Consistência detecta dependência cross-context (Conta → Atendimento) — flag.*

*O que o Domain Expert vê:*

IA: *"A definição atual de 'cliente inativo' usa apenas dados do contexto Conta (compras e login). Ao incluir tickets de suporte, que pertencem ao contexto Atendimento, a regra passa a depender de dois contextos diferentes. Confirma a inclusão?"*

Domain Expert confirma. A IA gera:

```
IEEE 29148 — Requisito REQ-CONTA-017 (v2)
══════════════════════════════════════════

Tipo: Funcional (regra de negócio)
Bounded Context: Conta (com dependência: Atendimento)
Prioridade: Alta
Rastreabilidade: altera REQ-CONTA-017 v1
Verificabilidade: cenários SBE abaixo

Descrição:
  Um Cliente é classificado como "inativo" se e somente se 
  não realizou Compra nos últimos 12 meses, não realizou Login 
  nos últimos 6 meses, e não abriu Ticket de Suporte nos últimos 
  6 meses.

SBE — Cenários de aceitação:

  Cenário: Cliente sem atividade em nenhum canal é inativo
    Dado que o Cliente "João" não realiza compras há 13 meses
    E não realiza login há 7 meses
    E não abre ticket de suporte há 7 meses
    Quando o sistema avalia o status do Cliente
    Então o Cliente é classificado como "inativo"

  Cenário: Cliente com ticket recente não é inativo
    Dado que o Cliente "Maria" não realiza compras há 13 meses
    E não realiza login há 7 meses
    Mas abriu ticket de suporte há 3 meses
    Quando o sistema avalia o status do Cliente
    Então o Cliente NÃO é classificado como "inativo"
```

Domain Expert aceita. `expert-edit-plan` gerado. Domain Expert aprova o Change Plan. Architect avalia dependência cross-context.

**Exemplo 2 — Contradição detectada pela Validação de Consistência.** O Domain Expert edita: *"Reembolsos até R$ 200 não precisam de aprovação do gerente."*

*Internamente: Validação de Consistência detecta contradição com regra existente. Validação SBVR confirma predicado bem formado ✓. Clarificação de Conformidade confirma termos ✓.*

IA: *"A regra atual define que reembolsos acima de R$ 500 exigem aprovação — ou seja, até R$ 500 já não exigem. Sua edição reduz o limite para R$ 200, tornando a aprovação mais restritiva. É essa a intenção?"*

Domain Expert: *"Sim, política de compliance mudou."*

IA gera requisito IEEE 29148 + SBE. Domain Expert confirma no ciclo iterativo. `expert-edit-plan` com divergência intencional flagrada. Domain Expert aprova. Architect avalia impacto técnico.

---

### Escopo 4 — Novo Guardrail: Padronização Canônica

**Contexto.** O modelo v0.5 não trata do **formato de escrita** dos artefatos na Product Canon. Com a adoção de IEEE 29148 + SBE como formato canônico, torna-se necessário um guardrail dedicado.

**Mudança.** Adicionar à seção 2.2.5:

**Padronização Canônica (Canonical Formatting).** Todo artefato que entra na Product Canon passa por este guardrail. Responsabilidade única: garantir que a escrita esteja no formato oficial.

O guardrail valida duas dimensões:

1. **IEEE 29148** — requisito estruturado com atributos obrigatórios (tipo, ID, rastreabilidade, descrição, verificabilidade), classificado na taxonomia correta, documento com categorias necessárias.
2. **SBE** — cada requisito funcional possui cenários de aceitação concretos (Dado/Quando/Então).

Nota: SBVR não é validado por este guardrail porque não é formato de escrita — é uma das ferramentas internas de validação da IA. A qualidade semântica (onde SBVR e outros mecanismos atuam nos bastidores) é responsabilidade dos guardrails de Clarificação de Conformidade e Validação de Consistência, expandidos com as ferramentas internas.

Dois modos de operação:

- **Nas cerimônias**: padronização implícita na mediação da IA.
- **Na edição direta**: padronização explícita — Domain Expert propõe em formato livre, IA reescreve em IEEE 29148 + SBE.

---

### Impacto Consolidado no Papel de SBVR no Modelo

| Aspecto | v0.5 (atual) | v0.6 (proposta) |
|---------|-------------|----------------|
| **Visibilidade** | Visível — apresentado ao Domain Builder e armazenado na Product Canon | Invisível — uma das ferramentas internas da IA |
| **Função** | Formato de escrita para regras de negócio | Uma das metodologias de validação semântica (detecção de ambiguidade, incompletude, indefinição de predicados) |
| **Relação com guardrails existentes** | Substitui a validação existente | **Agrega** aos mecanismos existentes (Conformidade, Consistência, Estrangulamento) — não substitui nenhum |
| **Onde aparece** | Product Canon, Canonical Change Plans, tela de aprovação | Nenhum artefato. Opera nos bastidores |
| **Quem interage** | Domain Builder valida, Domain Expert aprova | Apenas a IA — usa internamente para gerar perguntas de clarificação |
| **Exclusividade** | Metodologia única de formalização | Uma entre várias — a IA pode usar SBVR, análise de fluxo, cobertura de cenários, ou qualquer técnica adequada |
| **Risco 9.6 (rubber stamp)** | Risco ativo | Eliminado — o usuário nunca vê SBVR |

**Padrões oficiais do ZionKit v0.6:**

| Padrão | Papel | Visibilidade |
|--------|-------|-------------|
| **SBVR** | Uma das ferramentas internas de validação — detecta ambiguidade estrutural, incompletude de predicados, indefinição de participantes e condições. **Agrega** aos guardrails existentes, não os substitui | Invisível — opera nos bastidores da IA |
| **IEEE 29148** | Formato canônico de estrutura — organiza requisitos com tipo, ID, rastreabilidade, classificação. Cobre categorias que nenhuma ferramenta de validação alcança: requisitos não-funcionais, interfaces, restrições de design | Visível — escrita na Product Canon e Canonical Change Plans |
| **SBE** | Formato canônico de verificação — cenários concretos Dado/Quando/Então que tornam cada requisito testável e compreensível por pessoas de negócio | Visível — acompanha cada requisito |

---

### Impacto na Seção 9 — Riscos

**Risco 9.6 revisado — SBVR como ferramenta interna.** O risco original ("Domain Builder pode rubber stamp a notação SBVR") é eliminado pelo reposicionamento: SBVR nunca é apresentado ao usuário. Risco residual migra para: **a qualidade da tradução dos problemas detectados (por SBVR e outros mecanismos) em perguntas de clarificação acionáveis em linguagem natural**. Se a IA detecta um problema mas não consegue expressá-lo de forma clara ao Domain Builder, o benefício da validação se perde. Mitigação: as perguntas de clarificação são o principal ponto de teste na prototipação.

**Novo risco 9.8 — Edição direta como atalho para cerimônias.** Mitigação: escopo restrito a refinamentos; aprovação sequencial obrigatória; Guardrail de Padronização Canônica.

**Novo risco 9.9 — Qualidade da formalização automática.** Mitigação: Domain Expert revisa no ciclo iterativo; aprova Change Plan consolidado; ciclo iterativo permite correções.

**Novo risco 9.10 — Fadiga de aprovação dupla do Domain Expert.** Mitigação: segunda aprovação opera sobre artefato consolidado; tooling pode destacar diferenças; edições simples permitem confirmação abreviada.

**Novo risco 9.11 — Excesso de formalismo por IEEE 29148.** Mitigação: aderência adaptativa — guia de taxonomia, não template rígido. Nível de rigor é decisão do Architect.

**Novo risco 9.12 — Opacidade dos mecanismos de validação interna.** Com SBVR (e outros mecanismos) operando nos bastidores, existe o risco de que a IA detecte um problema real mas não consiga explicá-lo de forma compreensível, fazendo o Domain Builder ignorar um alerta que merecia atenção. Mitigação: (a) a IA deve sempre explicar o **porquê** da pergunta, não apenas fazê-la; (b) divergências não resolvidas são registradas no Relatório de Conformidade e visíveis ao Architect; (c) a prototipação deve medir taxa de perguntas de clarificação ignoradas vs. perguntas que resultaram em mudanças efetivas.

---

### Impacto na Seção 10 — Prototipação

**Prioridade 6 revisada — Validação interna como motor de clarificação.** Testar se: (a) a IA consegue usar SBVR e outros mecanismos internamente para detectar ambiguidades, incompletudes e contradições; (b) a IA consegue traduzir problemas detectados em perguntas de clarificação claras em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE significativamente mais completos e consistentes do que sem a validação interna; (d) o Domain Builder não precisa saber quais mecanismos estão operando — o processo é percebido como conversa natural. Métrica principal: taxa de problemas detectados que resultam em mudanças efetivas no requisito final.

**Nova prioridade 8 — Guardrail de Padronização Canônica.** Testar se a IA consegue formalizar edições em linguagem natural para IEEE 29148 + SBE preservando o significado original.

**Nova prioridade 9 — Edição direta com aprovação sequencial.** Testar fluxo completo incluindo segunda aprovação do Domain Expert no Change Plan consolidado. Avaliar se agrega valor real.

**Nova prioridade 10 — Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se sinalização de categorias não cobertas produz requisitos que teriam sido omitidos sem o guia.

---

### Resumo das Alterações

| Seção afetada | Mudança |
|---|---|
| 2.1 (Product Canon) | Requisitos armazenados em IEEE 29148 + SBE. SBVR removido dos artefatos visíveis |
| 2.2.3 | SBVR torna-se uma das ferramentas internas de validação (não a única). Formato de saída: IEEE 29148 + SBE. Mecanismos de validação operam em conjunto: Conformidade + SBVR + Consistência + outros |
| 2.2.5 | Novo guardrail: **Padronização Canônica** (IEEE 29148 + SBE). Guardails existentes expandidos com SBVR como ferramenta interna adicional |
| 4 (Papéis) | Domain Expert ganha anotações, hotspots e edição direta; aprovação sequencial. IA ganha ato operacional: "usar SBVR e outros mecanismos internamente para validação" |
| 5 (Artefatos) | Novo tipo: `expert-edit-plan`. Requisitos em IEEE 29148 + SBE (sem SBVR). Padrões oficiais: IEEE 29148 + SBE (visíveis) + SBVR (uma das ferramentas internas) |
| 9 (Riscos) | 9.6 revisado. Novos: 9.8 a 9.12 |
| 10 (Prototipação) | Prioridade 6 revisada. Novas: 8 a 10 |

**Princípio de design implícito:** A IA pode usar qualquer metodologia de validação que melhore a qualidade da clarificação de requisitos — SBVR, análise de fluxo, cobertura de cenários, entre outras. O modelo não prescreve nem restringe o arsenal interno. O que o modelo prescreve é o **formato de saída** (IEEE 29148 + SBE) e o **princípio de interação** (problemas são apresentados como perguntas em linguagem natural, nunca como notação formal). As ferramentas são internas e evolutivas; o contrato com o usuário é estável.

User: Adicione como escopo da proposta de mudança no modelo:

o padrão  IEEE 29148 deve ter natualeza adaptativa e não forçar um formato formal cansativo o motivo do uso é a perfomance da ia no padrao e a maturidade

GitHub Copilot: ## Escopo Adicional — Natureza Adaptativa do IEEE 29148

**Contexto.** A proposta v0.6 adota IEEE 29148 como padrão oficial de estrutura de requisitos. No entanto, a adoção literal de um padrão ISO pode criar a impressão de que o modelo exige templates formais extensos, com seções burocráticas obrigatórias e preenchimento exaustivo. Isso contradiz a filosofia do ZionKit, que prioriza acessibilidade e participação de pessoas não-técnicas.

**Esclarecimento: por que IEEE 29148.** O ZionKit não adota IEEE 29148 por formalismo institucional. Adota por dois motivos pragmáticos:

1. **Performance da IA.** Modelos de linguagem produzem requisitos significativamente mais consistentes, completos e estruturados quando operam com a taxonomia IEEE 29148 como referência. A IA "sabe" o que é um requisito funcional vs. não-funcional, sabe que precisa declarar rastreabilidade, sabe que requisitos de performance precisam de métricas verificáveis — porque IEEE 29148 é parte do corpus de treinamento. Usar um framework ad hoc inventado pelo modelo forçaria a IA a aprender uma taxonomia nova a cada sessão. Usar IEEE 29148 aproveita conhecimento que a IA já possui, melhorando a qualidade da mediação e da formalização automática.

2. **Maturidade.** IEEE 29148 é um padrão com décadas de refinamento pela indústria de engenharia de software. As categorias que ele define (funcional, não-funcional, interface, design, restrição) e os atributos que exige (rastreabilidade, verificabilidade, não-ambiguidade) não são arbitrários — são o resultado de prática acumulada sobre o que faz um documento de requisitos ser útil. O ZionKit não precisa reinventar essa taxonomia.

**Mudança: natureza adaptativa, não prescritiva.**

O ZionKit adota IEEE 29148 como **vocabulário estrutural e guia de completude**, não como template rígido. Na prática, isso significa:

**O que IEEE 29148 dá ao modelo:**
- Uma taxonomia compartilhada entre a IA e os participantes humanos — "requisito funcional", "requisito de performance", "requisito de interface" são categorias que todos entendem da mesma forma
- Um checklist de completude — a IA pode sinalizar "não há requisitos de performance definidos para este contexto" porque IEEE 29148 define que essa categoria existe
- Atributos de qualidade por requisito — cada requisito tem ID, rastreabilidade e verificabilidade, sem que isso precise ser preenchido manualmente (a IA preenche)

**O que IEEE 29148 NÃO impõe no modelo:**
- Não há template fixo com seções obrigatórias a preencher
- Não há formato documental rígido (o "SRS" clássico com 30 seções numeradas)
- Não há exigência de cobertura completa desde o início — projetos em fase inicial podem ter categorias inteiras marcadas como "não definido" sem que isso bloqueie o fluxo
- Não há linguagem burocraticamente formal — os requisitos são escritos em linguagem natural estruturada, não em "shall statements" estéreis

**Como a adaptatividade funciona na prática.** O nível de aderência ao IEEE 29148 é proporcional à maturidade do produto e do contexto:

| Maturidade | Aderência IEEE 29148 | Exemplo |
|---|---|---|
| **Produto novo (bootstrap)** | Mínima — apenas categorização básica (funcional/não-funcional) e ID de requisito. IA sinaliza categorias faltantes como informação, não como bloqueio | Startup validando MVP: requisitos funcionais formalizados, requisitos de performance marcados como "a definir após validação de carga" |
| **Produto em crescimento** | Moderada — categorias principais cobertas, rastreabilidade entre requisitos, requisitos não-funcionais com métricas quando críticos | Produto com 3-5 bounded contexts: requisitos de performance definidos para fluxos críticos, interfaces com sistemas externos documentadas |
| **Produto maduro** | Completa — todas as categorias cobertas, rastreabilidade bidirecional, métricas verificáveis para todos os requisitos não-funcionais | Sistema regulado (saúde, financeiro): cobertura completa exigida por compliance |

A decisão sobre o nível de aderência é do **Architect**, que avalia o contexto do projeto e define quais categorias IEEE 29148 são obrigatórias vs. recomendadas vs. opcionais para aquele estágio. A IA respeita essa configuração — sinaliza categorias faltantes de acordo com o nível definido, sem forçar preenchimento que não agrega valor naquele momento.

**Exemplo — aderência mínima vs. completa para o mesmo requisito.**

*Aderência mínima (bootstrap):*

```
REQ-PEDIDOS-042 [Funcional]

Descrição:
  O Cliente titular ou Operador de Suporte pode cancelar um 
  Pedido com status "Pendente" ou "Confirmado". Pedidos faturados 
  não podem ser cancelados — caminho alternativo é devolução.

SBE:
  Cenário: Cliente cancela pedido pendente
    Dado que Pedido #1234 possui status "Pendente"
    Quando o Cliente solicita cancelamento
    Então o Pedido é cancelado
```

*Aderência completa (produto maduro):*

```
IEEE 29148 — Requisito REQ-PEDIDOS-042 (v2)
═══════════════════════════════════════════

Tipo: Funcional (regra de negócio)
Bounded Context: Pedidos
Prioridade: Alta
Rastreabilidade: 
  - Origem: Domain Expert — sessão 2026-03-15
  - Substitui: REQ-PEDIDOS-038 v1
  - Dependências: REQ-PEDIDOS-029 (devolução)
  - Impacta: EVT-PedidoCancelado (schema)
Verificabilidade: cenários SBE abaixo

Descrição:
  O Cliente titular ou um Operador de Suporte autorizado pode 
  cancelar um Pedido cujo status seja "Pendente" ou "Confirmado". 
  Pedidos com status "Em Processamento" ou "Faturado" não podem 
  ser cancelados; o caminho alternativo para pedidos faturados é 
  a solicitação de devolução (REQ-PEDIDOS-029).

SBE — Cenários de aceitação:
  [4 cenários detalhados...]

Requisitos não-funcionais associados:
  REQ-PEDIDOS-042-PERF: Cancelamento processado em < 500ms
  REQ-PEDIDOS-042-AUDIT: Toda operação de cancelamento registrada 
    em log de auditoria com timestamp, ator e justificativa
```

**Ambos são válidos.** A diferença é o nível de detalhe estrutural, não a qualidade do requisito. A versão mínima já é não-ambígua (graças à clarificação SBVR nos bastidores) e verificável (graças ao SBE). A versão completa adiciona rastreabilidade, métricas de performance e auditoria — coisas que um produto maduro precisa e um MVP não.

**Impacto no Guardrail de Padronização Canônica.** O guardrail de Padronização Canônica (Escopo 4) passa a validar IEEE 29148 de forma adaptativa: verifica os atributos obrigatórios conforme o nível de aderência definido pelo Architect, não conforme o padrão completo. Em nível mínimo, valida apenas categorização e ID. Em nível completo, valida rastreabilidade bidirecional, métricas não-funcionais e cobertura de todas as categorias.

**Impacto no risco 9.11.** O risco de "excesso de formalismo por IEEE 29148" é diretamente endereçado pela natureza adaptativa. O modelo **não pode** ser percebido como burocrático se o nível de aderência é calibrado pelo Architect para cada contexto. Se a equipe sente que o formato está pesado, o Architect pode reduzir o nível — sem quebrar o modelo, porque o contrato mínimo (categorização + ID + SBE) se mantém.

**Impacto na prototipação (prioridade 10 revisada).** Testar se: (a) a IA produz requisitos de melhor qualidade quando usa a taxonomia IEEE 29148 como referência vs. formato livre; (b) os três níveis de aderência (mínimo, moderado, completo) são percebidos como proporcionais ao contexto, não como burocracia graduada; (c) o Architect consegue definir e ajustar o nível de aderência de forma natural, sem overhead de configuração; (d) a transição entre níveis (bootstrap → crescimento → maduro) ocorre organicamente à medida que a Product Canon evolui.

---

### Atualização na Tabela de Padrões Oficiais

| Padrão | Papel | Visibilidade | Natureza |
|--------|-------|-------------|----------|
| **SBVR** | Uma das ferramentas internas de validação — detecta ambiguidade, incompletude, indefinição de participantes e condições. Agrega aos guardrails existentes | Invisível — opera nos bastidores da IA | Ferramenta de processo |
| **IEEE 29148** | Formato canônico de estrutura — taxonomia de tipos de requisitos, atributos de qualidade, guia de completude. Adotado por performance da IA com o padrão e maturidade acumulada da indústria | Visível — escrita na Product Canon e Canonical Change Plans | **Adaptativo** — nível de aderência proporcional à maturidade do produto, definido pelo Architect |
| **SBE** | Formato canônico de verificação — cenários concretos Dado/Quando/Então | Visível — acompanha cada requisito | Obrigatório em todos os níveis |

User: crie um arquivo na pasta docs chamado plan-refin-change-zionkit.md contendo todo o conteudo bruto da nossa conversa ate aqui, você nao deve compactar nada, e sim colocar tudo. esse conteudo sera refinado, garanta que todo conteudo conversdo nessa janela esteja no arquivo.



GitHub Copilot: Compacted conversationLet me first read the current model file that was the base for all discussion, then create the comprehensive document. 

Read [](file:///c%3A/Users/tvini/projects/personal/zion-kit/docs/zionkit-model.md#1-1), lines 1 to 500

Read [](file:///c%3A/Users/tvini/projects/personal/zion-kit/docs/zionkit-model.md#501-501), lines 501 to 538

Now I'll create the comprehensive document with all the conversation content reconstructed from our session. 

Created [](file:///c%3A/Users/tvini/projects/personal/zion-kit/docs/plan-refin-change-zionkit.md)

Arquivo criado em plan-refin-change-zionkit.md.

**Importante:** Como o contexto da conversa foi comprimido em um resumo (devido ao limite de tokens), o conteúdo foi reconstruído a partir do resumo detalhado da sessão. Todo o conteúdo dos 5 escopos está presente — decisões, exemplos, tabelas, riscos, impactos, justificativas e prioridades de prototipação. Se houver algum detalhe específico que você lembra ter discutido e não encontrar no arquivo, me avise para complementar.

Made changes.