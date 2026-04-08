### ISSUE-02: Domain Builder vs Domain Expert — fronteira de papeis indefinida

**Criticidade**: Critica
**Secoes afetadas**: Resumo Executivo (linha 12), secao 1.2, secao 2.2.1, secao 2.2.3, secao 2.2.4, secao 2.2.6, secao 4 (tabela de papeis), secao 6.1 (cenario greenfield)
**Descricao do problema**: O modelo define 4 papeis (secao 4) com "autoridades complementares e nao sobrepostas", mas a relacao entre Domain Builder e Domain Expert apresenta tensoes nao resolvidas:

1. **Sobreposicao no cenario greenfield (6.1):** O fundador age simultaneamente como Domain Builder (participa das cerimonias, descreve fluxos) e Domain Expert ("O Domain Expert (o proprio fundador) aprova" — linha 495). Se uma mesma pessoa pode exercer ambos os papeis, a "autoridade complementar e nao sobreposta" e violada na pratica.
2. **Assimetria no Resumo Executivo:** O Resumo Executivo (linha 12) menciona "Domain Builders" e "Architects" mas omite "Domain Expert", sugerindo que Domain Builder e o papel central de negocio — quando na verdade Domain Expert detem autoridade semantica superior.
3. **Ausencia no problema (secao 1.2):** A secao 1.2 ("A exclusao do Domain Builder") nao menciona Domain Expert. O problema que o modelo resolve e a exclusao de quem? Do Domain Builder (que participa) ou do Domain Expert (que aprova)?
4. **Dependencia de aprovacao:** Domain Builder produz artefatos; Domain Expert aprova. Se sao a mesma pessoa, a aprovacao perde valor como gate de qualidade — o autor aprova a si mesmo.

#### Contexto e Research

O modelo atribui ao Domain Builder: participacao ativa em Domain Discovery Session e Requirements Specification Session, escrita de especificacoes de feature (Etapa 2), decisao de continuidade do ciclo. Atribui ao Domain Expert: aprovacao primaria de Discovery e Specification, aprovacao secundaria de Constitution, anotacoes contextuais, hotspots de dominio, edicao direta na camada de negocios.

A distincao conceitual e clara: Domain Builder = autor (produz conhecimento em linguagem natural), Domain Expert = guardiao (valida fidelidade semantica). O problema nao esta na definicao dos papeis, mas na ausencia de regras explicitas sobre acumulacao de papeis e na inconsistencia de visibilidade entre as secoes do documento.

O principio de design "Separacao de autoridade" (secao 8) afirma: "Nenhum dos quatro substitui os outros." Isso implica que os papeis sao conceituais, nao necessariamente pessoas distintas — mas o documento nunca explicita essa distincao.

#### Solucao eleita: Distincao de perspectiva, nao de pessoa

Adicionar ao inicio da secao 4 um paragrafo que explicite: (a) os 4 papeis representam perspectivas distintas sobre o conhecimento do produto, nao necessariamente pessoas distintas; (b) em equipes pequenas, uma pessoa pode exercer multiplas perspectivas; (c) o valor da separacao esta na completude das perspectivas exercidas — mesmo quando acumulados, cada papel forca perguntas diferentes sobre o artefato. Nao alterar mecanicas de aprovacao — quando uma pessoa acumula papeis, ela exerce os dois momentos de aprovacao como exercicio deliberado de perspectiva. Atualizar Resumo Executivo e secao 1.2.

- **Pros:** Solucao mais simples e elegante. Nao introduz mecanicas novas. Reforta o modelo como framework de pensamento, nao como burocracia organizacional. Funciona para equipes de 1 pessoa (startup) ate equipes grandes.
- **Contras:** Quando uma pessoa "exerce duas perspectivas", ha risco de auto-confirmacao — vieses humanos naturais. O gate de aprovacao perde forca como mecanismo de prevencao quando exercido pela mesma pessoa.
- **Aderencia aos principios:** Preserva "Separacao de autoridade" (redefinida como separacao de perspectivas). Alinhada com "A Product Canon e viva" (adaptabilidade). Tensao leve com "Prevencao sobre deteccao" (auto-aprovacao reduz prevencao).

#### Justificativa

Resolve o problema com alteracao minima e coerente. O principio "Separacao de autoridade" (secao 8) ja opera como separacao de perspectivas — esta solucao apenas explicita o que ja esta implicito. Para a fase de prototipacao, a simplicidade e superior: nao introduz mecanicas novas nem burocracia combinatoria. O risco de auto-confirmacao quando papeis sao acumulados e real, mas e mitigado pelos guardrails da IA que operam independentemente de quem exerce os papeis — a IA continuara sinalizando inconsistencias mesmo que o aprovador seja o proprio autor. A prototipacao revelara se compensacoes adicionais sao necessarias. As correcoes no Resumo Executivo e na secao 1.2 resolvem a assimetria de visibilidade.

---

### ISSUE-03: Etapa 3 (Retroalimentacao) sem governanca de aprovacao

**Criticidade**: Critica
**Secoes afetadas**: secao 2.4 (Etapa 3), secao 3 (diagrama do ciclo), secao 8 (principio "Governanca por cerimonia"), secao 9.4 (risco de disciplina)
**Descricao do problema**: A Etapa 3 (Retroalimentacao da Product Canon) e a unica etapa do modelo que modifica a Product Canon sem gate de aprovacao explicito. A secao 2.4 descreve que "alteracoes declaradas no plano sao refletidas na Product Canon, junto com as descobertas emergentes do ciclo de implementacao" — mas nao define:

1. Quem aprova a incorporacao das descobertas emergentes?
2. Qual e o mecanismo formal — ha um Change Plan? Ha um gate?
3. As "descobertas emergentes" passam pelos guardrails (Clarificacao de Conformidade, Validacao de Consistencia, Padronizacao Canonica)?

O documento distingue dois componentes da Etapa 3: (a) integracao de Change Plans ja aprovados (mecanicamente segura — ja passaram por gates) e (b) descobertas emergentes da implementacao (sem governanca definida). O componente (b) contradiz diretamente o principio "Governanca por cerimonia" (secao 8), que afirma: "toda mudanca no corpo de conhecimento do produto passa por um processo formal."

A secao 9.4 reconhece o risco de que equipes pulem a retroalimentacao, mas nao aborda o risco inverso: descobertas emergentes sendo incorporadas sem validacao adequada, degradando a qualidade da Product Canon.

#### Contexto e Research

A Etapa 3 opera em dois modos:
- **Integracao antecipada**: Change Plans do Canon Building ja aprovados sao integrados via Versionamento por Estrangulamento. Estes ja passaram por gates de aprovacao e nao representam risco de governanca.
- **Descobertas emergentes**: Conceitos refinados, regras nao documentadas, decisoes tecnicas imprevistas que surgem durante a implementacao. Estes NAO passaram por nenhum gate.

O modelo ja possui toda a infraestrutura necessaria para governar essas descobertas: Change Plans tipados, aprovacao por camada, guardrails. A lacuna e de definicao, nao de arquitetura.

O principio "O ciclo e bidirecional" (secao 8) fundamenta a Etapa 3 — mas bidirecionalidade nao implica ausencia de governanca no caminho de retorno.

#### Solucao eleita: Aprovacao leve com escalacao condicional

Descobertas emergentes sao formalizadas pela IA e passam pelos guardrails (Padronizacao Canonica, Validacao de Consistencia, Clarificacao de Conformidade). Se os guardrails nao detectam problemas, a integracao e aprovada com revisao assincrona (janela de veto pelo Domain Expert ou Architect conforme camada afetada). Se os guardrails detectam inconsistencias, contradices ou impacto cross-context, a descoberta e escalada para um Change Plan formal do tipo apropriado que requer aprovacao ativa. Nao cria tipo novo.

- **Pros:** Proporcionalidade — descobertas simples (refinamento de termo, correcao factual) nao exigem cerimonia pesada. Descobertas complexas recebem governanca completa. Reduz friccao para o caso comum. Usa guardrails como mecanismo de triagem — funcao que ja exercem.
- **Contras:** A decisao de "simples vs. complexo" e delegada aos guardrails da IA — se a IA errar na triagem, uma descoberta significativa pode entrar sem aprovacao ativa. Mecanica ligeiramente diferente das demais (janela de veto vs. aprovacao ativa) — adiciona variacao.
- **Aderencia aos principios:** "Governanca por cerimonia" preservada com gradacao. "Prevencao sobre deteccao" parcialmente preservada (guardrails operam, mas aprovacao pode ser passiva). Forte aderencia a "A Product Canon e viva" — baixa friccao para evolucao.

#### Justificativa

Resolve a contradicao de governanca sem agravar o risco de disciplina (secao 9.4). A Etapa 3 e o ponto do modelo mais vulneravel a abandono por pressao de prazo — adicionar Change Plans formais obrigatorios ou reclassificacao semantica aumentaria essa vulnerabilidade. Esta solucao usa os guardrails — que ja existem e ja operam em todas as outras etapas — como mecanismo de triagem natural: se a descoberta e trivial, integra com revisao passiva; se e significativa, escala para o fluxo formal. Isso preserva o principio "Governanca por cerimonia" (toda mudanca passa por guardrails + revisao) enquanto mantém proporcionalidade. A tensao com "Prevencao sobre deteccao" e aceitavel na fase de prototipacao — a prioridade 5 da secao 10 (ciclo completo em escopo reduzido) permitira validar se o mecanismo de escalacao funciona na pratica.

---

### ISSUE-04: Canonical Change Plan incremental — tipagem indefinida

**Criticidade**: Critica
**Secoes afetadas**: secao 2.3.3 (Canonical Change Plan Incremental), secao 2.3.4 (Aprovacao Condicional), secao 5 (Estrutura de Artefatos — lista de tipos), diagrama da secao 3
**Descricao do problema**: A secao 2.3.3 define o Canonical Change Plan incremental da Etapa 2 como artefato que captura "impactos emergentes que so se tornam visiveis quando uma especificacao concreta e escrita contra a Product Canon." No mesmo paragrafo, o documento lista os 4 tipos de Change Plan: `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan`. Porem, o Change Plan incremental nao e atribuido a nenhum desses tipos.

Problemas derivados:
1. Se e `specification-plan`, conflita semanticamente com o `specification-plan` da Requirements Specification Session (Etapa 1) — contextos diferentes, momentos do ciclo diferentes, aprovadores potencialmente diferentes.
2. Se e um quinto tipo nao nomeado, a lista de 4 tipos esta incompleta.
3. O envelope tipado e fundamental para auditoria e roteamento — um Change Plan sem tipo quebra a rastreabilidade.

#### Contexto e Research

O Canonical Change Plan incremental tem caracteristicas unicas que o distinguem dos demais:
- **Origem**: Etapa 2 (especificacao de feature), nao uma cerimonia de Canon Building
- **Natureza**: Captura impactos emergentes, nao conhecimento primario
- **Condicionalidade**: Pode ser vazio (aprovacao dispensada) — unico Change Plan com essa propriedade
- **Aprovacao**: Por camada afetada (Domain Expert para negocios, Architect para arquitetura), nao por cerimonia
- **Conteudo**: Misto — pode conter alteracoes em ambas as camadas simultaneamente

Reutilizar `specification-plan` seria tecnicamente possivel, mas geraria ambiguidade: um `specification-plan` da Etapa 1 foi produzido em cerimonia formal com fluxo completo de guardrails; um `specification-plan` da Etapa 2 foi gerado automaticamente pela IA durante a escrita de uma spec. Contextos radicalmente diferentes.

#### Solucao eleita: Novo tipo `incremental-plan`

Adicionar um quinto tipo de Change Plan: `incremental-plan`. Atualizar a lista da secao 2.3.3, a secao 5 (Estrutura de Artefatos) e o diagrama da secao 3. Definir que `incremental-plan` designa Change Plans gerados na Etapa 2, com condicionalidade (pode ser vazio), aprovacao por camada e conteudo misto.

- **Pros:** Tipagem precisa e univoca. Cada tipo tem associacao clara com seu contexto de origem. Auditoria limpa — proporcao de `incremental-plan` vs. outros tipos e metrica util.
- **Contras:** Quinto tipo adiciona complexidade. Se a ISSUE-03 tambem criar um tipo novo (`feedback-plan`), o sistema de tipagem cresce para 6 tipos.
- **Aderencia aos principios:** Forte aderencia a "Governanca por cerimonia" (rastreabilidade completa). Alinhado com a sistematica do modelo (cada cerimonia/canal produz tipo distinto).

#### Justificativa

O Canonical Change Plan incremental tem caracteristicas unicas que justificam tipagem propria: condicionalidade (pode ser vazio), aprovacao por camada (nao por cerimonia), geracao automatica pela IA (nao em cerimonia conversacional), e conteudo misto (negocios + arquitetura). Essas diferencas nao sao cosmeticas — afetam mecanica de aprovacao, roteamento e auditoria. Cada canal distinto de producao de Change Plans (Discovery, Constitution, Specification, Edicao Direta) produz tipo distinto. A Etapa 2 e um canal distinto — merece tipo distinto. A complexidade de um quinto tipo e menor que a ambiguidade de reutilizar `specification-plan` ou introduzir subtipagem. Com a ISSUE-03 adotando aprovacao leve com escalacao, nao havera sexto tipo — o sistema fica em 5 tipos, cada um com associacao univoca.

---

### ISSUE-05: Decisao de Continuidade pode violar o fluxo sequencial

**Criticidade**: Critica
**Secoes afetadas**: secao 2.2.4 (Decisao de Continuidade), secao 2.2 (fluxo sequencial da Etapa 1), diagrama da secao 3 (linhas 370-372), regra de habilitacao sequencial (linha 97)
**Descricao do problema**: A secao 2.2.4 define tres caminhos na Decisao de Continuidade:

- (a) Mapear mais fluxos e contextos → volta para Domain Discovery Session
- (b) Formalizar mais requisitos → volta para Requirements Specification Session
- (c) Encerrar ciclo → prosseguir para Etapa 2

O caminho (b) viola potencialmente o fluxo sequencial definido na secao 2.2: "Somente apos a aprovacao do Change Plan de uma cerimonia a proxima cerimonia e habilitada" (linha 97). Se o Domain Builder escolhe "formalizar mais requisitos" e volta diretamente para Requirements Specification Session, ele pula Domain Discovery Session e Technical Constitution Session. Isso levanta questoes:

1. Os novos requisitos podem ter dependencias de dominio nao mapeadas (que seriam capturadas na Discovery).
2. Os novos requisitos podem ter implicacoes tecnicas nao previstas (que seriam capturadas na Constitution).
3. O modelo nao define se o caminho (b) e um "atalho" legitimo ou uma violacao do principio sequencial.

O caminho (a) tambem levanta questao: volta para Discovery implica que Constitution e Specification serao refeitas, ou apenas a Discovery gera um novo Change Plan e o fluxo continua?

#### Contexto e Research

A regra sequencial e estruturante no modelo: Discovery produz contexto que Constitution consome, Constitution produz principios que Specification consome. Pular cerimonias significa operar sem o contexto que elas produziriam.

Porem, ha um cenario legitimo para o caminho (b): o Domain Builder ja mapeou todos os bounded contexts (Discovery completa) e ja definiu todos os principios tecnicos (Constitution completa), mas quer formalizar mais requisitos dentro dos bounded contexts ja mapeados. Nesse caso, nova Discovery e nova Constitution seriam redundantes — o contexto ja existe na Product Canon.

O diagrama da secao 3 (linhas 370-372) confirma os tres caminhos sem restricoes, replicando a ambiguidade textual.

#### Solucao eleita: Pre-condicao explicita para caminho (b)

Adicionar a secao 2.2.4 uma pre-condicao para o caminho (b): o Domain Builder so pode voltar diretamente para Requirements Specification Session se os novos requisitos pertencem a bounded contexts ja mapeados na Product Canon e cujos principios tecnicos constitucionais ja foram definidos. Se os novos requisitos tocam bounded contexts nao mapeados ou sem constituicao tecnica, o caminho correto e (a). A IA sinaliza quando a pre-condicao nao e atendida. A decisao final e do Domain Builder.

- **Pros:** Resolve a contradicao com regra simples e derivada da logica do modelo. Mantem a flexibilidade do caminho (b) para o caso legitimo. A IA como sinalizador e consistente com seu papel no modelo (sinaliza, nao decide).
- **Contras:** A verificacao da pre-condicao depende da IA avaliar corretamente se novos requisitos tocam bounded contexts nao mapeados — avaliacao que pode ser falha.
- **Aderencia aos principios:** Forte aderencia a "Prevencao sobre deteccao" (IA sinaliza potencial problema). Preserva "Separacao de autoridade" (Domain Builder decide, IA sinaliza). Consistente com o fluxo sequencial — o atalho so e permitido quando o contexto ja existe.

#### Justificativa

A pre-condicao e logicamente derivada do proprio modelo: o fluxo sequencial existe porque cada cerimonia produz contexto que a seguinte consome; se o contexto ja existe na Product Canon, a pre-condicao do fluxo sequencial ja esta satisfeita. Coloca a regra no lugar certo (na Decisao de Continuidade) e usa a IA no papel certo (sinalizador, nao decisor), preservando os principios de "Prevencao sobre deteccao" e "Separacao de autoridade". A pre-condicao e simples o suficiente para ser implementada na prototipacao (a IA verifica se os bounded contexts mencionados pelo Domain Builder ja existem na Product Canon) e sera testada pela prioridade 7 da secao 10 (fluxo sequencial com gates).

---

### ISSUE-06: Aprovacao da Edicao Direta — inconsistencia entre secoes

**Criticidade**: Alta
**Secoes afetadas**: secao 2.2.6 (texto da Edicao Direta), secao 3 (diagrama, linhas 383-386), secao 4 (tabela de papeis, linhas 451-456)
**Descricao do problema**: O fluxo de aprovacao do `expert-edit-plan` e descrito de tres formas diferentes em tres locais do documento:

1. **Secao 2.2.6 (texto normativo):** Aprovacao sequencial com ordem fixa — Domain Expert aprova primeiro (valida fidelidade semantica), Architect aprova depois (avalia impacto tecnico). Descricao detalhada com justificativa para a ordem.
2. **Diagrama secao 3 (linha 385):** "Gate: Architect aprova expert-edit-plan" — menciona apenas o Architect, omitindo o Domain Expert.
3. **Tabela secao 4:** Domain Expert "aprova Change Plan consolidado" (coluna Edicao Direta) + Architect "Aprova `expert-edit-plan` (obrigatorio, nao delegavel)" (coluna Edicao Direta). Ambos mencionados, mas sem indicacao de ordem.

A secao 2.2.6 e a mais detalhada e recente (adicionada na versao 0.6 como prioridade 9). O diagrama e a tabela nao foram atualizados para refletir a mecanica sequencial completa.

#### Contexto e Research

A secao 2.2.6 e inequivoca sobre a mecanica: aprovacao sequencial Domain Expert → Architect, com justificativa formal ("fidelidade semantica e pre-requisito para avaliacao tecnica"). O sub-titulo "expert-edit-plan e Aprovacao Sequencial" reforta a intencionalidade.

O diagrama da secao 3 foi originalmente escrito quando o modelo tinha apenas aprovacao do Architect para a edicao direta. A adicao da aprovacao do Domain Expert (prioridade 9 da v0.6) atualizou o texto normativo mas nao o diagrama.

A tabela da secao 4 menciona ambos os aprovadores mas em colunas separadas sem indicacao de sequencia — a mesma informacao que o texto descreve como "sequencial com ordem fixa" aparece como dois itens independentes na tabela.

#### Solucao eleita: Atualizar diagrama e tabela para refletir o texto normativo

Alterar o diagrama da secao 3 (linhas 383-386) para:
```
Gate: Domain Expert aprova (1o) + Architect aprova (2o) expert-edit-plan
```
Alterar a tabela da secao 4 para incluir na coluna "Edicao Direta" do Domain Expert: "Aprova expert-edit-plan (1o — fidelidade semantica)". Na coluna do Architect: "Aprova expert-edit-plan (2o — impacto tecnico, obrigatorio, nao delegavel)".

- **Pros:** Resolve a inconsistencia completamente. Uma unica fonte de verdade (secao 2.2.6) refletida consistentemente em todas as representacoes. Alteracao minima e cirurgica.
- **Contras:** Nenhum contra significativo. E uma correcao de consistencia, nao uma decisao de design.
- **Aderencia aos principios:** Alinhada com todos os principios — nao altera mecanica, apenas corrige representacao.

#### Justificativa

Correcao de consistencia, nao decisao de design. A secao 2.2.6 e inequivoca sobre a mecanica de aprovacao sequencial. O diagrama e a tabela devem refletir essa mecanica. A alteracao e cirurgica, sem risco e sem complexidade adicional. O principio "Governanca por cerimonia" (secao 8) exige que gates sejam claros — um diagrama que omite metade do gate de aprovacao nao atende esse requisito.

---


