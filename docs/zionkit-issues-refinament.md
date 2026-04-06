# ZionKit — Refinamento de Lacunas Conceituais para Prototipação

**Documento de clarificação — Abril 2026**
**Base**: zionkit-model.md v0.5 + zionkit-model-analysis.md

---

## Lacuna 1.1 — Semântica de Conflito entre Change Plans Concorrentes

### Contexto e Análise

O modelo descreve três tipos de Change Plans na Etapa 1 (discovery, constitution, specification) e um incremental na Etapa 2, todos convergindo para a Product Canon. O fluxo sequencial com gates (seção 2.2) garante serialização *dentro* de um ciclo de Canon Building, mas o modelo não endereça o cenário em que dois ciclos de Canon Building — ou dois Change Plans incrementais da Etapa 2 — são aprovados em paralelo por equipes operando em bounded contexts adjacentes.

O Versionamento por Estrangulamento (seção 2.2.5) trata migrações graduais *planejadas*, não colisões *emergentes*. A distinção é fundamental: no estrangulamento, a coexistência de `current` e `next` é intencional e declarada; num conflito entre Change Plans concorrentes, a colisão é acidental e não detectada até o momento de integração.

**Padrões relevantes da indústria:**

- **Git/three-way merge**: detecta conflitos comparando cada branch contra o ancestral comum. A analogia para a Canon seria comparar cada Change Plan contra o estado base da Canon no momento da submissão, não contra o outro Change Plan.
- **Semantic merge**: diferentemente do merge textual, opera sobre uma estrutura de modelo (AST, grafo de conceitos). Ferramentas como SemanticMerge detectam conflitos no nível de unidades semânticas, não de linhas de texto.
- **ITIL/CAB**: usa declaração de escopo de impacto (quais Configuration Items são afetados) para detecção antecipada de colisão entre change requests concorrentes.
- **DDD Context Mapping**: usa Published Language e Anti-Corruption Layers para isolar bounded contexts, reduzindo a superfície de conflito entre equipes.

A tensão central é **autonomia vs. consistência**: permitir aprovação paralela maximiza throughput mas arrisca conflitos semânticos silenciosos; serializar tudo garante consistência mas cria gargalos — exatamente o problema que a seção 9.5 já reconhece.

### Avaliação de Maturidade

**É o momento certo para definir isso?** Parcialmente. O protótipo inicial provavelmente operará em modo single-writer de facto (um único time, um único domínio pequeno). A semântica de conflito completa pode ser adiada. No entanto, é necessário ao menos *declarar* como o modelo lida com concorrência para que o protótipo não cristalize implicitamente um design single-writer que depois é difícil de estender. A definição mínima necessária é: qual é a *unidade de conflito* (o que constitui uma colisão) e qual é o *momento de detecção* (quando a colisão é identificada).

### Opções de Clarificação

#### Opção A — Serialização Explícita com Lock Semântico
- [ ] Selecionada

Cada Change Plan, ao ser submetido para aprovação, declara explicitamente quais artefatos da Product Canon afeta (termos do glossário, eventos, regras, bounded contexts). Enquanto um Change Plan que afeta um artefato X estiver em aprovação, nenhum outro Change Plan que afete X pode ser submetido — ele entra em fila. O lock é no nível do artefato, não da Canon inteira.

**Tradeoffs:**
- Benefícios: Eliminação total de conflitos semânticos. Simplicidade conceitual e de implementação. Determinismo — nunca há ambiguidade sobre o estado da Canon.
- Custos/Riscos: Pode criar gargalos em artefatos frequentemente tocados (e.g., um evento de domínio central). A declaração de escopo depende da qualidade da análise de impacto (conexão com lacuna 1.4). O overhead de espera pode exacerbar a percepção de burocracia já identificada na análise (seção 4 do documento de análise).
- Impacto no modelo: Requer adição de um mecanismo de "escopo declarado" a cada Canonical Change Plan. Compatível com o princípio de Governança por Cerimônia (seção 8) — adiciona mais governança. Pode tensionar a percepção de velocidade.

#### Opção B — Concorrência Otimista com Merge Semântico
- [x] Selecionada

Change Plans são aprovados independentemente. No momento de integração à Canon (Etapa 3 ou integração antecipada via estrangulamento), a IA executa um *merge semântico*: compara cada Change Plan contra o estado base da Canon e detecta colisões no nível de unidades semânticas (termo, evento, regra, bounded context). Colisões são reportadas como um *Conflict Report* que requer resolução humana antes da integração.

**Tradeoffs:**
- Benefícios: Maximiza throughput — equipes não se bloqueiam mutuamente. O conflito é detectado no ponto mais informado (pós-aprovação, com ambos os Change Plans completos). Alinhado com o modelo mental de desenvolvedores que já usam Git com feature branches.
- Custos/Riscos: Conflitos são detectados tarde, quando o custo de resolução é maior (trabalho já foi aprovado). O merge semântico depende da capacidade da IA de entender conflitos conceituais, não apenas textuais — o que adiciona uma dependência na qualidade dos guardrails (seção 9.1). Requer definição de "unidade semântica de conflito".
- Impacto no modelo: Requer definição de um novo artefato (Conflict Report) e um novo gate (resolução de conflito). Compatível com o Versionamento por Estrangulamento (pode operar como extensão). Alinhado com o princípio de "IA sem autonomia decisória" — a IA detecta, humanos resolvem.

#### Opção C — Detecção Antecipada por Escopo + Concorrência Permitida
- [ ] Selecionada

Cada Change Plan declara seu escopo de impacto (artefatos afetados). A IA verifica se há sobreposição de escopo com Change Plans em voo. Se houver, *sinaliza* a sobreposição mas *não bloqueia* — os aprovadores de ambos os Change Plans são notificados da concorrência e podem decidir coordenar ou prosseguir independentemente. Se prosseguirem, o merge semântico da Opção B é aplicado na integração.

**Tradeoffs:**
- Benefícios: Combina alerta antecipado (como ITIL) com flexibilidade (como Git). Aprovadores humanos decidem se o risco de conflito justifica coordenação — alinhado com "humanos decidem". Reduz o custo de resolução tardia da Opção B via alerta precoce.
- Custos/Riscos: Complexidade: combina mecanismos das Opções A e B. O alerta pode ser ignorado (fadiga de notificação), degradando para a Opção B de facto. A declaração de escopo pode ser imprecisa, gerando falsos negativos (conflito não alertado) ou falsos positivos (alerta sem conflito real).
- Impacto no modelo: Requer escopo declarado no Change Plan + mecanismo de notificação + merge semântico como fallback. Maior complexidade conceitual, mas oferece o caminho mais robusto para multiequipe.

### Recomendação

**Opção recomendada: B — Concorrência Otimista com Merge Semântico**

Na fase de prototipação, a concorrência real entre equipes é improvável (o protótipo será exercitado com escopo reduzido, conforme seção 10, item 5). A Opção B estabelece a semântica mínima necessária — *o que constitui um conflito* e *quando é detectado* — sem introduzir mecanismos de lock ou notificação que adicionariam complexidade prematura. Está alinhada com o modelo mental de versionamento que desenvolvedores já possuem e com o princípio de "IA sem autonomia decisória". A Opção C é o caminho natural de evolução quando o modelo for exercitado com múltiplas equipes, mas adicioná-la agora seria projetar para cenários hipotéticos. A definição de "unidade semântica de conflito" (termo, evento, regra, bounded context, ADR) é a única decisão que precisa ser tomada agora e deve ser validada na prototipação.

---

## Lacuna 1.2 — Fronteira entre Operacional e Decisório na Seleção de Contexto pela IA

### Contexto e Análise

A seção 4 do modelo divide os atos da IA em operacionais (permitidos) e decisórios (requerem humano). A seção 2.3.1 descreve a injeção seletiva de contexto como necessidade arquitetural — a Canon completa pode exceder os limites de contexto dos modelos. O problema: a *seleção* de quais fragmentos carregar é ela mesma uma decisão de alto impacto. Se a IA omite um bounded context afetado, o Change Plan incremental será incompleto, e nenhum humano terá visibilidade sobre essa omissão.

Esta lacuna é particularmente crítica porque afeta em cascata a lacuna 1.4 (critérios de "vazio"): um Change Plan "vazio" pode ser simplesmente um Change Plan cujos impactos não foram detectados *porque o contexto relevante não foi carregado*.

**Padrões relevantes da indústria:**

- **RAG com citação de fontes**: sistemas como Perplexity e Bing Chat anotam cada claim com referência ao chunk recuperado. Mostrar *o que foi consultado* é resolvido; mostrar *o que foi omitido* é um problema aberto de UX.
- **Basis Declaration (IA médica)**: em sistemas de suporte à decisão clínica, o FDA espera que o sistema declare sua base de evidência *antes* da recomendação — quais guidelines, dados e estudos informaram a sugestão.
- **Context Provenance**: conceito emergente que trata contexto como linhagem de dados — cada fragmento carrega metadados sobre origem, score de relevância, e cadeia de transformação.
- **Progressive Disclosure**: padrão de UX que opera em modo opaco por default, mas permite inspeção detalhada sob demanda. Cursor usa uma versão disso (painel de contexto visível mas não proeminente).

A tensão central é **carga cognitiva vs. accountability**: tornar a seleção transparente adiciona informação que o aprovador precisa processar; mantê-la opaca cria um ponto cego no gate de aprovação.

### Avaliação de Maturidade

**É o momento certo para definir isso?** Sim, esta é uma decisão que precisa ser tomada antes de prototipar. O protótipo da Etapa 2 *depende* da injeção seletiva de contexto. Se o protótipo opera com seleção opaca, a avaliação dos guardrails (desafio 2 da análise) não consegue distinguir entre "guardrail funcionou e não há impacto" e "guardrail não teve acesso ao contexto onde o impacto existe". A decisão mínima é: a seleção de contexto deve ser *declarada* (quais bounded contexts foram consultados) ou *opaca* (apenas o resultado é visível).

### Opções de Clarificação

#### Opção A — Seleção Opaca com Auditoria Opcional
- [ ] Selecionada

A IA seleciona contexto como ato operacional. O resultado (Change Plan, sinalizações) é apresentado sem declarar quais bounded contexts foram consultados. Um log de auditoria é mantido em background e pode ser consultado retroativamente se houver suspeita de falha.

**Tradeoffs:**
- Benefícios: Mínima carga cognitiva para aprovadores. Fluxo mais rápido. Simplicidade de implementação.
- Custos/Riscos: Ponto cego no gate de aprovação — o aprovador não sabe se um bounded context relevante foi omitido. Impossível validar a completude do Change Plan sem a IA como intermediário confiável. Degrada a confiança nos guardrails (seção 9.1). Na prática, transforma a seleção de contexto em uma "decisão de facto" da IA, violando o espírito do princípio de "IA sem autonomia decisória".
- Impacto no modelo: Contradiz potencialmente a seção 4 (separação operacional/decisório). O log de auditoria é reativo — descobre problemas depois de integrados.

#### Opção B — Basis Declaration Obrigatória
- [x] Selecionada

Cada Change Plan inclui uma seção de *Context Basis* que declara: (1) quais bounded contexts foram consultados, (2) quais artefatos específicos foram carregados, e (3) quais bounded contexts *não foram consultados* e a justificativa (e.g., "contexto X não foi carregado — sem relação semântica detectada"). O aprovador valida não apenas o conteúdo do Change Plan mas também a adequação da base de contexto.

**Tradeoffs:**
- Benefícios: Transparência completa. Permite ao aprovador identificar omissões ("por que Compliance não foi consultado?"). Converte a seleção de contexto de ato opaco para ato verificável — alinhado com "IA sem autonomia decisória". Permite validação empírica da qualidade de seleção durante a prototipação.
- Custos/Riscos: Adiciona carga cognitiva ao aprovador, que agora precisa avaliar também a base de contexto. A lista de "não consultados" pode ser extensa em Products com muitos bounded contexts. O aprovador pode não ter competência para julgar a adequação da seleção de contexto.
- Impacto no modelo: Adiciona uma seção estrutural ao Canonical Change Plan (compatível com a estrutura existente da seção 2.3.3). Enriquece o gate de aprovação sem criar gates novos. Reforça o princípio de Separação de Autoridade.

#### Opção C — Basis Declaration com Progressive Disclosure
- [ ] Selecionada

O Change Plan exibe por default apenas um resumo da base de contexto: "Bounded contexts consultados: Pagamentos, Compliance, Notificações." O detalhamento completo (artefatos específicos, scores de relevância, bounded contexts omitidos) é acessível sob demanda. A IA sinaliza ativamente quando detecta ambiguidade na seleção ("Bounded context X possui termos relacionados — incluir no escopo? [sim/não]").

**Tradeoffs:**
- Benefícios: Balanceia transparência e carga cognitiva. O resumo é rápido de validar; o detalhe está disponível quando necessário. A sinalização ativa de ambiguidade engaja o aprovador nos casos onde a seleção realmente importa.
- Custos/Riscos: Complexidade de implementação (dois níveis de visualização + sinalização ativa). O aprovador pode se acostumar a nunca expandir o detalhe, degradando para a Opção A de facto. O critério de "ambiguidade na seleção" precisa ser definido.
- Impacto no modelo: Exige definição de dois níveis de detalhe no Change Plan. Compatível com o princípio de Injeção Seletiva, mas adiciona UX sobre a seleção.

### Recomendação

**Opção recomendada: B — Basis Declaration Obrigatória**

Na fase de prototipação, a carga cognitiva sobre o aprovador é um custo aceitável — o protótipo opera em escopo reduzido (poucos bounded contexts), tornando a lista de contextos consultados curta e manejável. A Opção B é a mais alinhada com o princípio de "IA sem autonomia decisória" e permite coletar dados empíricos sobre a qualidade da seleção de contexto, que é um dos desafios críticos de validação (desafio 2 da análise). Se a prototipação revelar que a carga cognitiva é excessiva em escala real, a Opção C é uma evolução natural. A Opção A é inaceitável para prototipação porque impede a avaliação independente dos guardrails — não há como distinguir "guardrail correto" de "guardrail com ponto cego".

**Referência cruzada com lacuna 1.4:** A Basis Declaration fornece o alicerce para avaliar se um Change Plan "vazio" é genuinamente vazio ou se é resultado de contexto insuficiente.

---

## Lacuna 1.3 — Mecanismo de Entrada de Conhecimento do Domain Expert

### Contexto e Análise

O Domain Expert é definido na seção 4 como "guardião da integridade semântica da Product Canon", com autoridade de aprovação primária nos gates de Domain Discovery e Requirements Specification. No entanto, seu papel é exclusivamente de *validação* — aprova ou rejeita, mas não tem caminho formal para *contribuir* conhecimento.

O problema é que o Domain Expert é frequentemente quem possui o conhecimento tácito mais crítico, e esse conhecimento muitas vezes só emerge quando o expert vê algo concreto. Na terminologia de DDD, o Change Plan funciona como um "artefato de provocação" — ao ler a formalização proposta, o Domain Expert percebe lacunas que não teria articulado espontaneamente.

**Padrões relevantes da indústria:**

- **Knowledge Crunching (Evans/DDD)**: domain experts são co-criadores do modelo, não validadores passivos. O modelo emerge de diálogo iterativo, não de tradução unidirecional.
- **Hot Spots (Event Storming)**: marcadores explícitos para "algo está faltando aqui" — mecanismo de captura de baixa fricção que não exige resolução imediata, apenas registro.
- **SECI/Externalization (Nonaka & Takeuchi)**: a conversão de conhecimento tácito para explícito ocorre mais naturalmente em *diálogo*, não em formulários binários de aprovação.
- **Constructive Review (Bacchelli & Bird)**: em code review, a segunda função mais comum é transferência de conhecimento do reviewer para o autor — o reviewer contribui, não apenas valida.
- **Developmental Editing**: em publicação editorial, o editor de desenvolvimento vai além de aprovar/rejeitar — reestrutura, sugere adições, identifica lacunas.

A tensão central é **eficiência do gate vs. riqueza de captura**: gates rápidos (aprovar/rejeitar) são eficientes mas perdem conhecimento tácito; gates ricos (diálogo, contribuição) capturam mais mas são mais lentos.

### Avaliação de Maturidade

**É o momento certo para definir isso?** Parcialmente. O mecanismo exato pode emergir da experimentação (talvez o Domain Expert naturalmente contribua durante a aprovação e o protótipo precise apenas acomodar isso). O que *precisa* ser definido agora é: o gate de aprovação do Domain Expert é *binário* (aprovar/rejeitar/pedir revisão) ou *generativo* (pode incluir contribuições de conhecimento)? Sem essa definição, o protótipo implementará gates binários por default, e o conhecimento tácito do Domain Expert continuará se perdendo.

### Opções de Clarificação

#### Opção A — Gate Binário com Kickback para Nova Cerimônia
- [ ] Selecionada

O gate permanece estritamente binário: aprovar, rejeitar, ou pedir revisão. Se o Domain Expert identifica conhecimento não capturado durante a aprovação, ele rejeita o Change Plan com uma anotação descritiva e solicita uma nova iteração da cerimônia correspondente (ou uma Domain Discovery Session adicional) para incorporar o conhecimento descoberto. O ciclo de Canon Building absorve a contribuição via o mecanismo já existente de Decisão de Continuidade (seção 2.2.4).

**Tradeoffs:**
- Benefícios: Mantém a separação clara de papéis — quem produz vs. quem valida. Reutiliza mecanismos existentes (cerimônias, Decisão de Continuidade). Não adiciona complexidade conceitual ao gate.
- Custos/Riscos: Custo alto de ciclo para contribuições pequenas (rejeitar + refazer cerimônia para adicionar uma regra). Pode desincentivar o Domain Expert a reportar lacunas menores ("não vale a pena rejeitar por causa disso"). Conhecimento tácito é volátil — o insight pode se perder entre a rejeição e a nova cerimônia.
- Impacto no modelo: Nenhuma alteração estrutural necessária. Compatível com todos os princípios de design. Subótimo para captura de conhecimento incremental.

#### Opção B — Gate Enriquecido com Anotações Formais
- [x] Selecionada

O gate de aprovação é estendido para incluir uma terceira opção além de aprovar/rejeitar: **aprovar com anotações**. O Domain Expert pode anexar ao Change Plan anotações tipadas: `[LACUNA]` — conceito que está faltando; `[REFINAMENTO]` — conceito que precisa ser ajustado; `[REGRA NÃO CAPTURADA]` — regra de negócio que deveria existir. Anotações são integradas automaticamente como *hot spots* na Product Canon — itens pendentes de resolução que são visíveis em cerimônias futuras e na injeção de contexto da Etapa 2. O Change Plan é aprovado (o trabalho não é bloqueado) mas as anotações geram dívida de conhecimento rastreável.

**Tradeoffs:**
- Benefícios: Captura de baixa fricção — o Domain Expert não precisa rejeitar para contribuir. Não bloqueia o fluxo (o Change Plan é aprovado). O conceito de "hot spot" é familiar do Event Storming. Cria um backlog de conhecimento tácito que alimenta futuras cerimônias.
- Custos/Riscos: Risco de acúmulo de hot spots não resolvidos (dívida de conhecimento). A aprovação com anotações pode degradar para aprovação sem leitura das anotações por outros participantes. Requer definição do ciclo de vida dos hot spots (quem resolve, quando, como).
- Impacto no modelo: Adiciona um novo tipo de artefato (hot spot/anotação) à Product Canon. Estende o gate de aprovação sem alterar sua estrutura fundamental. Compatível com o princípio de "Canon Viva" — os hot spots são conhecimento parcialmente capturado que evolui.

#### Opção C — Domain Expert como Participante Opcional das Cerimônias
- [ ] Selecionada

O Domain Expert pode, a seu critério, participar das cerimônias de Domain Discovery e Requirements Specification como co-participante (além de aprovador no gate). Quando participa, contribui conhecimento durante a cerimônia em tempo real, junto com o Domain Builder. O papel na cerimônia é diferente — o Domain Builder descreve o negócio, o Domain Expert *corrige e complementa* com base em expertise de domínio mais profunda. A participação é opcional para não criar gargalo de disponibilidade.

**Tradeoffs:**
- Benefícios: Captura de conhecimento tácito no momento mais natural (durante o diálogo, conforme o modelo SECI). Elimina o problema de contribuição tardia no gate. Alinha com o princípio de Knowledge Crunching do DDD.
- Custos/Riscos: Dependência de disponibilidade do Domain Expert (tensiona seção 9.5 — já há preocupação com disponibilidade de aprovadores). Borra a fronteira entre papéis — se o Domain Expert participa da cerimônia, como ele avalia imparcialmente no gate? Pode inviabilizar times distribuídos assíncronos.
- Impacto no modelo: Requer revisão da definição de papéis na seção 4 ("não participa diretamente das cerimônias" → "pode participar opcionalmente"). Conflito potencial com a clareza de autoridade definida na tabela de atuação por etapa.

### Recomendação

**Opção recomendada: B — Gate Enriquecido com Anotações Formais**

A Opção B resolve o problema central (captura de conhecimento tácito no ponto de contato) com custo conceitual mínimo. O conceito de hot spot é nativo do Event Storming — uma das bases conceituais do modelo — e se integra naturalmente à Product Canon como artefato de conhecimento parcial. Diferente da Opção A, não penaliza o fluxo por contribuições pequenas; diferente da Opção C, não borra fronteiras de papéis nem cria dependência de disponibilidade. O risco de acúmulo de hot spots não resolvidos é gerenciável — a Etapa 3 (retroalimentação) e a Decisão de Continuidade (seção 2.2.4) são pontos naturais para priorizá-los.

**Referência cruzada com lacuna 1.5:** Os hot spots gerados pelo Domain Expert podem ser um dos *gatilhos* para a retroalimentação na Etapa 3, endereçando parcialmente a subdefinição dessa etapa.

---

## Lacuna 1.4 — Critérios de "Vazio" para o Change Plan Incremental na Etapa 2

### Contexto e Análise

A seção 2.3.4 estabelece que se o Change Plan incremental for "vazio" — a especificação consome a Canon sem alterá-la — a aprovação é dispensada e a spec flui diretamente para implementação. A questão é *quem determina* que é vazio e *com base em quais critérios*, dado que a detecção de impacto depende da injeção seletiva de contexto (lacuna 1.2).

O risco é preciso: um Change Plan "vazio" pode ser um Change Plan cujos impactos *não foram detectados* — seja porque o bounded context relevante não foi carregado, seja porque a IA não conseguiu inferir a conexão semântica.

**Padrões relevantes da indústria:**

- **Checksum vs. State Diff**: ferramentas de migração (Flyway, Alembic) distinguem entre "o arquivo mudou" (checksum) e "o estado resultante é diferente" (state diff). Checksum é barato mas impreciso; state diff é preciso mas caro.
- **ITIL Standard Changes**: mudanças pré-aprovadas são classificadas por *reconhecimento de padrão histórico*, não por análise da mudança em si — procedimento bem compreendido, taxa de falha historicamente baixa, rollback existente.
- **Build Graph Reachability (Nx, Bazel)**: marca como "afetados" todos os nós transitivamente alcançáveis a partir da mudança. Conservador por design — prefere falsos positivos a falsos negativos.
- **Semantic Impact Analysis**: determinar se uma mudança interna é externamente observável é formalmente equivalente a verificação de equivalência semântica — geralmente indecidível. Na prática, todas as soluções são aproximações conservadoras.

A lição transversal é: **"impacto zero" é uma claim positiva que requer evidência, não uma ausência padrão**. Todos os sistemas maduros tratam "sem impacto detectado" como diferente de "comprovadamente sem impacto".

### Avaliação de Maturidade

**É o momento certo para definir isso?** Sim. Esta é uma decisão que afeta diretamente o fluxo da Etapa 2 — se o protótipo não define quando a aprovação é dispensada, ou sempre exige aprovação (tornando o fluxo burocrático) ou nunca exige (tornando-o inseguro). A definição mínima necessária não é o algoritmo de detecção de impacto, mas os *critérios semânticos* que distinguem "sem impacto" de "impacto não detectado".

**Referência cruzada com lacuna 1.2:** A qualidade desta decisão depende diretamente da resolução da lacuna 1.2. Se a Basis Declaration for adotada (opção recomendada para 1.2), o aprovador tem visibilidade sobre quais contextos foram consultados, o que permite avaliar a credibilidade de um Change Plan "vazio".

### Opções de Clarificação

#### Opção A — Critério Estrutural: Nenhum Artefato Tocado
- [ ] Selecionada

O Change Plan é considerado vazio se, e somente se, a especificação não propõe nenhuma alteração em nenhum artefato da Product Canon: nenhum termo novo ou alterado no glossário, nenhum evento novo ou modificado, nenhuma regra de negócio nova, nenhum ADR necessário, nenhuma alteração de schema. A verificação é puramente estrutural — se o diff semântico entre o estado pré e pós-especificação é nulo para todos os tipos de artefato, o Change Plan é vazio.

**Tradeoffs:**
- Benefícios: Critério claro, binário, verificável mecanicamente. Não depende de julgamento humano nem de interpretação semântica da IA. Fácil de implementar no protótipo.
- Custos/Riscos: Conservador apenas na superfície — se a IA não detectou um impacto (e.g., não carregou o bounded context afetado), o diff será nulo e o Change Plan será falso-vazio. Não distingue entre "sem impacto" e "impacto não detectado". Precisão depende inteiramente da qualidade da injeção de contexto.
- Impacto no modelo: Nenhuma alteração estrutural. Formaliza o que já está implícito na seção 2.3.4. Insuficiente isoladamente — precisa ser combinado com Basis Declaration (lacuna 1.2).

#### Opção B — Critério Estrutural + Declaração de Confiança
- [x] Selecionada

O Change Plan é considerado vazio se o critério estrutural da Opção A for atendido **e** a Basis Declaration (lacuna 1.2) indicar que todos os bounded contexts com relação semântica à especificação foram consultados. A IA emite uma **declaração de confiança** junto com o Change Plan vazio: "Contextos consultados: [lista]. Nenhum impacto detectado em nenhum artefato. Confiança: [alta/média] — [justificativa]." Change Plans vazios com confiança média são sinalizados para revisão humana opcional.

**Tradeoffs:**
- Benefícios: Distingue explicitamente entre "sem impacto com cobertura completa" e "sem impacto com cobertura parcial". Dá ao aprovador informação para decidir se aceita a dispensa de aprovação. Produz dados empíricos sobre a qualidade da detecção durante a prototipação.
- Custos/Riscos: A IA precisa auto-avaliar a qualidade de sua seleção de contexto — meta-cognição que LLMs fazem com confiabilidade variável. A escala "alta/média" é subjetiva e pode dar falsa sensação de rigor. Pode gerar fadiga de revisão se muitos Change Plans forem sinalizados como "confiança média".
- Impacto no modelo: Depende da adoção da Basis Declaration (lacuna 1.2). Adiciona uma propriedade ao Change Plan (nível de confiança). Compatível com o princípio de "IA sem autonomia decisória" — a IA sinaliza incerteza, humanos decidem.

#### Opção C — Eliminação do Conceito de "Vazio" — Aprovação Sempre Necessária, com Fast-Track
- [ ] Selecionada

O conceito de "Change Plan vazio" é eliminado. Todo Change Plan incremental é submetido para aprovação, mas com um mecanismo de *fast-track*: se a IA não detecta impacto e a Basis Declaration cobre todos os contextos relevantes, o Change Plan recebe status de "fast-track" — aprovação automática após 24h se nenhum aprovador objetar (aprovação por silêncio). Aprovadores podem objetar e solicitar revisão dentro da janela.

**Tradeoffs:**
- Benefícios: Elimina a distinção problemática entre "vazio" e "não-detectado". Mantém um safety net humano mesmo em casos aparentemente sem impacto. Alinhado com o princípio de aprovação secundária assíncrona já presente no modelo (seção 9.5).
- Custos/Riscos: Adiciona latência mínima (24h) a toda especificação, mesmo as triviais. Pode ser percebido como burocracia excessiva — exatamente o risco de seção 9.5. Aprovação por silêncio pode degradar para rubber stamp se aprovadores não revisarem Change Plans fast-tracked.
- Impacto no modelo: Altera a seção 2.3.4 — remove "aprovação dispensada" e substitui por "fast-track com janela de veto". Adiciona complexidade temporal mas elimina ambiguidade semântica sobre "vazio".

### Recomendação

**Opção recomendada: B — Critério Estrutural + Declaração de Confiança**

A Opção B é o ponto de equilíbrio entre precisão e pragmatismo. Ela torna explícita a distinção entre "sem impacto verificado" e "impacto não detectado" sem impor latência adicional a toda especificação (como a Opção C) nem operar com ponto cego (como a Opção A isolada). A dependência da Basis Declaration é uma *feature*, não um bug — vincula as resoluções das lacunas 1.2 e 1.4, criando um sistema de reforço mútuo. O risco de meta-cognição imprecisa da IA é aceitável na prototipação porque produz dados empíricos sobre quando a IA acerta e quando erra — exatamente o tipo de hipótese testável que a seção 10 solicita.

**Referência cruzada:** Esta opção depende da adoção da Basis Declaration (lacuna 1.2, Opção B). As duas decisões são conceitualmente acopladas e devem ser avaliadas em conjunto.

---

## Lacuna 1.5 — Definição da Etapa 3 (Retroalimentação da Product Canon)

### Contexto e Análise

A seção 2.4 descreve *o que* é atualizado na Etapa 3 — glossário, eventos, regras, ADRs, princípios técnicos — mas não define *quem inicia* o processo, *quem valida* as atualizações, *qual o gatilho* que dispara a retroalimentação, nem *qual o critério de completude*. O documento de análise identifica corretamente que esta é a lacuna com maior impacto na integridade conceitual: o ciclo bidirecional é o diferencial central do ZionKit, e a Etapa 3 é o elo que fecha esse ciclo.

A seção 2.4 distingue dois tipos de atualização: (1) integração de Change Plans aprovados, que é "mecanicamente segura" porque o que atualizar já foi declarado; e (2) descobertas emergentes da implementação, que são o caso problemático — não declaradas previamente, emergem durante o código, e não têm cerimônia, gate, nem critério de completude.

**Padrões relevantes da indústria:**

- **Postmortems (SRE)**: gatilho por severidade (evento), responsável explícito (incident owner), definição de done (action items registrados como tickets com owners e deadlines). Sobrevivem à pressão temporal porque são mandatórios e bloqueiam o fechamento do incidente.
- **Retrospectives (Agile)**: gatilho por cadência (temporal), responsabilidade coletiva (time), definição de done (ao menos uma mudança concreta comprometida). Vulneráveis a serem puladas sob pressão.
- **Architecture Decision Records**: gatilho por decisão (evento), responsável = implementador, definição de done = contexto + decisão + consequências registrados. Sobrevivem porque são leves e capturados no momento da decisão.
- **Fitness Functions**: gatilho por build/deploy (automação), sem responsável humano (CI executa). Sobrevivem *exatamente* porque são automatizados — não dependem de disciplina humana.
- **Double-Loop Learning (Argyris)**: requer alguém com autoridade para questionar premissas, não apenas ajustar parâmetros operacionais. Aplicável quando uma descoberta revela que a premissa original do domínio estava errada.

A lição mais robusta: **processos que sobrevivem à pressão são os embutidos em fluxos existentes (ADRs, CI) ou mandatórios com bloqueio (postmortems), não os que dependem de disciplina voluntária (retrospectives).**

### Avaliação de Maturidade

**É o momento certo para definir isso?** Sim, com definição mínima. A análise já identifica esta como a lacuna mais crítica. Sem ao menos gatilho e responsável definidos, o protótipo não pode exercitar o ciclo bidirecional, e a validação fica limitada ao fluxo unidirecional (Canon → spec → código), que é essencialmente SDD com documentação mais estruturada. A cerimônia completa pode emergir da prototipação, mas a estrutura mínima (quem, quando, o que constitui "feito") precisa existir agora.

**Referência cruzada com lacuna 1.3:** Se hot spots forem adotados (Opção B da lacuna 1.3), eles se tornam um dos insumos da Etapa 3 — itens de conhecimento parcialmente capturado que precisam ser resolvidos.

### Opções de Clarificação

#### Opção A — Retroalimentação Automática pela IA com Validação Humana
- [ ] Selecionada

**Gatilho:** Conclusão da implementação de código a partir de uma especificação contextualizada (automático — embutido no fluxo da Etapa 2).

**Responsável pela detecção:** A IA. Após gerar/implementar o código, a IA compara o código resultante contra a especificação e a Product Canon, identificando descobertas emergentes: conceitos refinados, regras implícitas tornadas explícitas, decisões técnicas não previstas. A IA gera um **Discovery Report** com as descobertas e propostas de atualização da Canon.

**Validação:** O Discovery Report é submetido a um gate leve — o mesmo roteamento por camada da Etapa 2 (Domain Expert para negócio, Architect para arquitetura). Aprovação por silêncio (72h) para descobertas incrementais; revisão explícita para descobertas que alteram conceitos existentes.

**Critério de completude:** A Etapa 3 é considerada completa quando todas as descobertas do Discovery Report foram integradas à Canon ou explicitamente descartadas com justificativa.

**Tradeoffs:**
- Benefícios: Gatilho automático — não depende de disciplina humana. Captura sistematicamente o que mudou entre a spec e o código real. Alinhado com o princípio de "IA sem autonomia decisória" — propõe, humanos validam.
- Custos/Riscos: Depende da capacidade da IA de identificar corretamente diferenças semânticas entre spec e código — habilidade não validada. Pode gerar ruído (muitas "descobertas" triviais). O desenvolvedor que escreveu/revisou o código tem contexto que a IA não tem — a IA vê código, o desenvolvedor viu *o processo* de construção.
- Impacto no modelo: Adiciona um novo artefato (Discovery Report). Adiciona um gate leve à Etapa 3. Modifica a seção 2.4 para incluir gatilho, responsável e critério de completude.

#### Opção B — Captura pelo Desenvolvedor como Parte do Fluxo de Implementação
- [x] Selecionada

**Gatilho:** Duplo — (1) automático, embutido no fluxo de submissão de código (o desenvolvedor não pode submeter sem preencher o campo de descobertas); e (2) os hot spots pendentes do Domain Expert (lacuna 1.3, se adotada).

**Responsável pela detecção:** O desenvolvedor que implementou o código (ou revisou a implementação da IA). Durante a implementação, o desenvolvedor mantém um **Implementation Journal** leve — anotações estruturadas sobre descobertas emergentes, no formato: `[CONCEITO REFINADO]`, `[REGRA DESCOBERTA]`, `[DECISÃO TÉCNICA]`, `[PREMISSA INCORRETA]`. A IA auxilia compilando as anotações em um Discovery Report ao final da implementação.

**Validação:** O Discovery Report é validado com o mesmo roteamento por camada da Etapa 2. Para descobertas que apenas refinam conceitos existentes, aprovação por silêncio (48h). Para descobertas que contradizem premissas do Canon Building (`[PREMISSA INCORRETA]`), revisão explícita obrigatória — este é o cenário de *double-loop learning* onde o modelo precisa revisar suas próprias bases.

**Critério de completude:** A Etapa 3 é completa quando: (1) o Implementation Journal foi compilado, (2) o Discovery Report foi gerado, (3) todas as descobertas foram integradas ou descartadas, e (4) hot spots pendentes foram endereçados ou reproiorizados.

**Tradeoffs:**
- Benefícios: O desenvolvedor é quem possui o contexto mais rico sobre o que emergiu durante a implementação. O gatilho embutido no fluxo de submissão minimiza o risco de skip. Categorização por tipo de descoberta permite triagem eficiente. Integração com hot spots (lacuna 1.3) cria um ciclo coerente de captura de conhecimento.
- Custos/Riscos: Depende de disciplina do desenvolvedor para anotar durante a implementação (mitigado pelo campo obrigatório na submissão, mas pode degradar para preenchimento mecânico). Adiciona overhead ao fluxo do desenvolvedor. Se a IA gera o código sem supervisão humana ativa, o "desenvolvedor" pode não ter contexto suficiente.
- Impacto no modelo: Adiciona o conceito de Implementation Journal e Discovery Report. Cria responsabilidade formal para o desenvolvedor na Etapa 3 (atualmente ausente na tabela de papéis da seção 4). Conecta com hot spots da lacuna 1.3.

#### Opção C — Retroalimentação Periódica por Cerimônia Dedicada (Canon Review Session)
- [ ] Selecionada

**Gatilho:** Cadência temporal (e.g., ao final de cada sprint ou a cada N especificações implementadas). Não vinculada a uma implementação específica.

**Responsável:** Cerimônia coletiva com Domain Builder, Architect e IA. Semelhante a uma retrospectiva, mas focada exclusivamente em: o que aprendemos sobre o domínio desde a última Canon Review? O que precisa ser atualizado na Product Canon?

**Validação:** As atualizações propostas na Canon Review são formalizadas como um Canonical Change Plan tipado `review-plan`, com o mesmo fluxo de aprovação da Etapa 1.

**Critério de completude:** A Canon Review é completa quando o `review-plan` é aprovado e integrado.

**Tradeoffs:**
- Benefícios: Captura reflexiva — dá espaço para identificar padrões cross-cutting que implementações individuais não revelam. Cerimônia formal alinha com o princípio de "Governança por Cerimônia". Não adiciona overhead a cada implementação individual.
- Custos/Riscos: Gatilho temporal é o padrão mais vulnerável a ser pulado (conforme pesquisa — retrospectivas são as cerimônias mais frequentemente cortadas). Distância temporal entre a implementação e a revisão causa perda de contexto. Descobertas urgentes (premissas incorretas) ficam em espera até a próxima sessão. Adiciona uma quarta cerimônia ao modelo.
- Impacto no modelo: Adiciona nova cerimônia (Canon Review Session) e novo tipo de Change Plan (`review-plan`). Aumenta overhead cerimonial — tensiona diretamente o risco identificado na seção 9.5 e na análise (seção 4).

### Recomendação

**Opção recomendada: B — Captura pelo Desenvolvedor como Parte do Fluxo de Implementação**

A Opção B é a mais resiliente ao principal risco da Etapa 3: ser pulada sob pressão. O gatilho embutido no fluxo de submissão garante que a etapa é exercida sem depender de disciplina voluntária (diferente da Opção C) nem exclusivamente da capacidade de introspecção da IA (diferente da Opção A). O desenvolvedor — humano que supervisionou ou executou a implementação — é quem possui o contexto mais rico sobre o que emergiu. A categorização tipada (`[CONCEITO REFINADO]`, `[REGRA DESCOBERTA]`, etc.) permite triagem eficiente sem exigir narrativa elaborada. A integração com hot spots da lacuna 1.3 cria um ciclo coerente: o Domain Expert sinaliza lacunas → o desenvolvedor descobre durante implementação → a Canon é atualizada. A Opção A pode ser incorporada como complemento (a IA auxilia na compilação do journal), e elementos da Opção C podem ser adotados futuramente se o protótipo revelar a necessidade de reflexão cross-cutting periódica.

**Referência cruzada:** Esta opção se conecta com a lacuna 1.3 (hot spots como insumo), lacuna 1.2 (Basis Declaration para validar cobertura das descobertas), e lacuna 1.1 (Discovery Reports concorrentes de diferentes implementações podem conflitar, resolvido pela semântica de merge da lacuna 1.1).

---

## Síntese de Interdependências

As 5 lacunas não são independentes. As resoluções recomendadas formam um sistema coerente:

```
Lacuna 1.2 (Basis Declaration)
    │
    ├──► fundamenta Lacuna 1.4 (critérios de "vazio" dependem da 
    │    cobertura declarada de contexto)
    │
    └──► informa Lacuna 1.1 (escopo de impacto declarado no Change Plan
         viabiliza detecção de conflitos semânticos)

Lacuna 1.3 (Hot Spots do Domain Expert)
    │
    └──► alimenta Lacuna 1.5 (hot spots são insumo para o
         Implementation Journal da Etapa 3)

Lacuna 1.5 (Etapa 3 definida)
    │
    └──► produz Discovery Reports que podem conflitar entre si,
         resolvidos pela semântica de Lacuna 1.1
```

**Ordem sugerida de implementação no protótipo:**
1. Lacuna 1.2 (Basis Declaration) — pré-requisito para 1.4
2. Lacuna 1.4 (Critérios de "vazio") — depende de 1.2
3. Lacuna 1.3 (Hot Spots) — independente, mas alimenta 1.5
4. Lacuna 1.5 (Etapa 3) — beneficia-se de 1.3
5. Lacuna 1.1 (Conflitos) — relevante apenas quando há concorrência real
