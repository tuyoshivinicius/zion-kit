# Tarefas de Implementacao — ZionKit v0.5 → v0.6

**Data:** 2026-04-07  
**Documentos de referencia:**
- `docs/zionkit-model.md` — documento base (v0.5) a ser evoluido
- `docs/plan-impl-change-zionkit-model-0.6.md` — plano de implementacao (descricoes cirurgicas)
- `docs/plan-refin-change-zionkit-model-0.6.md` — refinamento (contexto, justificativa, riscos)

---

## Fase A — Fundacoes de padroes

### A1 — Triade de padroes oficiais (Mudanca 17)

- [ ] **A1.1 — Criar subseção da triade de padroes na secao 2**
  - **O que fazer:** Adicionar uma subsecao introdutoria na secao 2, posicionada entre o paragrafo introdutorio ("O ZionKit resolve os problemas descritos acima...") e a subsecao 2.1 (Product Canon). A subsecao deve descrever a triade formal de padroes oficiais do ZionKit v0.6 com papeis e visibilidades distintas: SBVR (motor interno de validacao semantica, invisivel ao participante), IEEE 29148 (formato canonico de estrutura, visivel), SBE (formato canonico de verificacao, visivel). Incluir a frase "Cada padrao tem responsabilidade unica e delimitada: SBVR detecta, IEEE 29148 estrutura, SBE verifica." Explicitar que SBVR e a metodologia principal de validacao interna, mas nao exclusiva.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2 (nova subsecao antes de 2.1)
  - **Impl:** plan-impl, Mudanca 17, item 1 (descricao cirurgica da nova subsecao)
  - **Refin:** plan-refin, Mudanca 17 (contexto, justificativa, riscos da triade)
  - **Dependencias:** Nenhuma — primeira tarefa do plano.

- [ ] **A1.2 — Atualizar Resumo Executivo para mencionar a triade de padroes**
  - **O que fazer:** Revisar o Resumo Executivo para incluir mencao a triade de padroes. No trecho que descreve "Canon Building", incluir referencia ao formato canonico IEEE 29148 + SBE e a validacao semantica interna. Substituir referencias a SBVR como formato visivel. Manter o resumo conciso — a triade e detalhada na secao 2.
  - **Secoes afetadas em `zionkit-model.md`:** Resumo Executivo
  - **Impl:** plan-impl, Mudanca 17, item 2 (atualizacao do Resumo Executivo)
  - **Refin:** plan-refin, Mudanca 17 (contexto sobre ausencia de formulacao unificada na v0.5)
  - **Dependencias:** A1.1 (a triade deve estar definida antes de ser referenciada no resumo).

---

### A2 — Reposicionamento do SBVR como ferramenta interna (Mudanca 1)

- [ ] **A2.1 — Atualizar secao 2.1 (Product Canon, camada de negocio) — SBVR para interno**
  - **O que fazer:** Na secao 2.1, substituir o bullet "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example)..." por "Requisitos formalizados em formato IEEE 29148 com criterios de aceitacao SBE (Specification by Example): requisitos de software produzidos e mantidos atraves de processos assistidos de formalizacao, com completude e consistencia validadas internamente pela IA utilizando metodologias como SBVR (Semantics of Business Vocabulary and Business Rules)."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.1 (Product Canon, camada de negocio)
  - **Impl:** plan-impl, Mudanca 1, item 1
  - **Refin:** plan-refin, Mudanca 1 (reposicionamento do SBVR de formato visivel para ferramenta interna)
  - **Dependencias:** A1.1 (triade conceitual deve estar estabelecida).

- [ ] **A2.2 — Adicionar guardrail de validacao semantica interna na secao 2.2.5**
  - **O que fazer:** Na secao 2.2.5 (Guardrails), apos o paragrafo de Validacao de Consistencia, adicionar novo paragrafo sobre "Validacao semantica interna" descrevendo que a IA utiliza internamente metodologias de validacao semantica (incluindo SBVR) para analisar a expressao individual de cada requisito. Problemas detectados sao apresentados como perguntas de clarificacao em linguagem natural, nunca como notacao formal. SBVR e metodologia principal mas nao exclusiva.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.5 (Guardrails da Product Canon)
  - **Impl:** plan-impl, Mudanca 1, item 3
  - **Refin:** plan-refin, Mudanca 1 (eliminacao do risco de rubber stamp, SBVR como uma entre varias metodologias)
  - **Dependencias:** A1.1.

- [ ] **A2.3 — Atualizar ato operacional da IA na secao 4**
  - **O que fazer:** Na secao 4 (Papeis), nos atos operacionais da IA, substituir "traduzir linguagem natural para SBVR" por "usar metodologias de validacao semantica (incluindo SBVR) internamente para detectar ambiguidades, incompletudes e contradicoes, e traduzir os problemas detectados em perguntas de clarificacao em linguagem natural".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (Papeis — atos operacionais da IA)
  - **Impl:** plan-impl, Mudanca 1, item 4
  - **Refin:** plan-refin, Mudanca 1 (impacto no papel da IA)
  - **Dependencias:** A1.1.

- [ ] **A2.4 — Substituir risco 9.6 (Curva de aprendizado SBVR)**
  - **O que fazer:** Na secao 9, eliminar inteiramente o risco 9.6 ("Curva de aprendizado SBVR") e substitui-lo por novo risco: "9.6 Qualidade da traducao de validacao interna para linguagem natural." Descrever que a eficacia depende da capacidade da IA de traduzir problemas detectados em perguntas de clarificacao claras e acionaveis. Mitigacao: ciclo iterativo de clarificacao + formalizacao final em IEEE 29148 + SBE como ponto de validacao auditavel.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 9.6
  - **Impl:** plan-impl, Mudanca 1, item 5
  - **Refin:** plan-refin, Mudanca 1 (riscos: qualidade da traducao, opacidade do processo)
  - **Dependencias:** A1.1.

---

### A3 — Adocao do IEEE 29148 (Mudanca 2)

- [ ] **A3.1 — Adicionar explicacao do IEEE 29148 na secao 2.1**
  - **O que fazer:** Na secao 2.1, apos o bullet de requisitos (ja atualizado na A2.1), adicionar explicacao: "IEEE 29148 (ISO/IEC/IEEE 29148:2018) fornece a taxonomia para classificar requisitos (funcionais, nao-funcionais, de interface, de design, restricoes), atributos obrigatorios por requisito (identificador unico, rastreabilidade, prioridade, verificabilidade) e criterios de qualidade. A adocao e motivada pela maturidade do padrao e pela familiaridade dos LLMs com sua taxonomia."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.1 (Product Canon, camada de negocio)
  - **Impl:** plan-impl, Mudanca 2, item 2
  - **Refin:** plan-refin, Mudanca 2 (justificativa: lacuna de framework organizacional na v0.5)
  - **Dependencias:** A2.1 (bullet de requisitos ja atualizado).

- [ ] **A3.2 — Adicionar responsabilidade do Architect na secao 2.2.2**
  - **O que fazer:** Na secao 2.2.2 (Technical Constitution Session), adicionar ao paragrafo de responsabilidades do Architect: "O Architect define tambem o nivel de aderencia IEEE 29148 (ver niveis de aderencia) como parte dos principios tecnicos constitucionais."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.2 (Technical Constitution Session)
  - **Impl:** plan-impl, Mudanca 2, item 3
  - **Refin:** plan-refin, Mudanca 2 (impacto na Technical Constitution Session)
  - **Dependencias:** A2.1.

- [ ] **A3.3 — Adicionar nivel de aderencia na camada de arquitetura da secao 2.1**
  - **O que fazer:** Na secao 2.1 (Product Canon, camada de arquitetura), adicionar ao bullet de principios tecnicos constitucionais: "Incluem o nivel de aderencia IEEE 29148 configurado para cada bounded context."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.1 (Product Canon, camada de arquitetura)
  - **Impl:** plan-impl, Mudanca 2, item 4
  - **Refin:** plan-refin, Mudanca 2 (principios tecnicos constitucionais conectados a IEEE 29148)
  - **Dependencias:** A2.1.

---

### A4 — Aderencia adaptativa com tres niveis (Mudanca 3)

- [ ] **A4.1 — Adicionar tres niveis de aderencia na secao 2.2.2**
  - **O que fazer:** Na secao 2.2.2 (Technical Constitution Session), apos o paragrafo "O Architect utiliza as estruturas de dominio descobertas...", adicionar novo paragrafo descrevendo os tres niveis de aderencia IEEE 29148: Minimo (produto novo, prototipacao — tipo + descricao + SBE), Moderado (produto em crescimento — adiciona subtipo, rastreabilidade, dependencias), Completo (produto maduro, dominios regulados — taxonomia integral). Mencionar que o nivel pode variar por bounded context e que SBE e obrigatorio em todos os niveis.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.2 (Technical Constitution Session)
  - **Impl:** plan-impl, Mudanca 3, item 1
  - **Refin:** plan-refin, Mudanca 3 (natureza adaptativa, justificativa contra burocracia)
  - **Dependencias:** A3.2 (responsabilidade do Architect ja adicionada).

- [ ] **A4.2 — Adicionar exemplo de nivel de aderencia no bloco de codigo da secao 2.2.2**
  - **O que fazer:** No bloco de codigo de exemplo de principios tecnicos constitucionais da secao 2.2.2, adicionar secao "REQUISITOS" com "Nivel de aderencia IEEE 29148: Minimo (produto em fase de prototipacao)" e "SBE obrigatorio em todos os requisitos funcionais".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.2 (bloco de codigo de exemplo)
  - **Impl:** plan-impl, Mudanca 3, item 2
  - **Refin:** plan-refin, Mudanca 3 (registro do nivel nos principios tecnicos constitucionais)
  - **Dependencias:** A4.1.

---

### A5 — Formato canonico IEEE 29148 + SBE (Mudanca 4)

- [ ] **A5.1 — Verificar secao 2.1 sem residuos SBVR como formato de armazenamento**
  - **O que fazer:** Verificar que a secao 2.1 (Product Canon, camada de negocio), ja atualizada nas tarefas A2.1 e A3.1, nao contem nenhuma referencia a "SBVR" como formato de armazenamento. Apenas referencias a SBVR como metodologia interna de validacao devem permanecer.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.1
  - **Impl:** plan-impl, Mudanca 4, item 1
  - **Refin:** plan-refin, Mudanca 4 (formato canonico serve consumidores humanos)
  - **Dependencias:** A2.1, A3.1.

- [ ] **A5.2 — Atualizar secao 5 (Estrutura de Artefatos) — regras de negocio**
  - **O que fazer:** Na secao 5, substituir "Regras de negocio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session" por "Regras de negocio: formalizadas em formato IEEE 29148, validadas internamente pela IA utilizando metodologias como SBVR". Substituir "Requisitos com criterios de aceitacao: especificados em SBE (Specification by Example) para verificabilidade" por "Requisitos com criterios de aceitacao: estruturados em IEEE 29148 com cenarios SBE (Specification by Example) para verificabilidade".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 5 (Estrutura de Artefatos)
  - **Impl:** plan-impl, Mudanca 4, item 2
  - **Refin:** plan-refin, Mudanca 4 (camada de negocio armazena IEEE 29148 + SBE)
  - **Dependencias:** A2.1.

- [ ] **A5.3 — Atualizar secao 2.3.3 (Canonical Change Plan Incremental)**
  - **O que fazer:** Na secao 2.3.3, verificar que a descricao textual ao redor do exemplo de Canonical Change Plan incremental nao menciona SBVR. Adicionar ao texto descritivo, se necessario: "O Canonical Change Plan incremental contem requisitos no formato IEEE 29148 + SBE."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.3.3
  - **Impl:** plan-impl, Mudanca 4, item 4
  - **Refin:** plan-refin, Mudanca 4 (todos os Change Plans contem IEEE 29148 + SBE)
  - **Dependencias:** A2.1.

---

## Fase B — Guardrails e cerimonias

### B1 — Guardrail de Padronizacao Canonica (Mudanca 5)

- [ ] **B1.1 — Adicionar guardrail de Padronizacao Canonica na secao 2.2.5**
  - **O que fazer:** Na secao 2.2.5, apos o paragrafo de Validacao de Consistencia e antes do paragrafo de Versionamento Gradual por Estrangulamento, adicionar novo guardrail "Padronizacao Canonica (Canonical Formatting)". Descrever: garante que toda escrita na Product Canon esteja no formato canonico IEEE 29148 + SBE. Valida duas dimensoes: IEEE 29148 (atributos obrigatorios conforme nivel de aderencia) e SBE (cenarios Dado/Quando/Entao). Opera em dois modos: implicito nas cerimonias, explicito na edicao direta. Respeita o nivel de aderencia configurado pelo Architect (Minimo/Moderado/Completo).
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.5 (Guardrails da Product Canon)
  - **Impl:** plan-impl, Mudanca 5, item 1
  - **Refin:** plan-refin, Mudanca 5 (justificativa: novo canal de entrada exige uniformidade de formato)
  - **Dependencias:** A3.1, A4.1, A5.2 (IEEE 29148 como formato canonico deve estar estabelecido).

---

### B2 — Revisao da Requirements Specification Session (Mudanca 10)

- [ ] **B2.1 — Reescrever primeiro paragrafo da secao 2.2.3**
  - **O que fazer:** Substituir "A Requirements Specification Session e uma cerimonia conversacional de formalizacao semantica de requisitos, utilizando SBVR..." por "A Requirements Specification Session e uma cerimonia conversacional de formalizacao de requisitos, produzindo requisitos no formato IEEE 29148 com criterios de aceitacao SBE (Specification by Example). A cerimonia opera em dois niveis — regra individual e documento — sem fases rigidas, seguindo diretrizes de conducao."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.3 (primeiro paragrafo)
  - **Impl:** plan-impl, Mudanca 10, item 1
  - **Refin:** plan-refin, Mudanca 10 (fluxo em dois niveis substitui fluxo linear SBVR)
  - **Dependencias:** B1.1 (Padronizacao Canonica referenciada no novo fluxo).

- [ ] **B2.2 — Reescrever segundo paragrafo da secao 2.2.3 (fluxo)**
  - **O que fazer:** Substituir o paragrafo do fluxo linear SBVR ("O Domain Builder descreve requisitos em linguagem natural. A IA traduz para SBVR controlado...") pelo novo fluxo em dois niveis: nivel de regras individuais (6 passos: descricao → validacao simultanea → clarificacao → refinamento iterativo → formalizacao IEEE 29148 + SBE → validacao) e nivel de documento (verificacao de completude estrutural via taxonomia IEEE 29148, sinalizacao de categorias nao cobertas como sinalizacao, nao bloqueio).
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.3 (segundo paragrafo — fluxo)
  - **Impl:** plan-impl, Mudanca 10, item 2
  - **Refin:** plan-refin, Mudanca 10 (ativacao simultanea de mecanismos, dois niveis)
  - **Dependencias:** B2.1.

- [ ] **B2.3 — Reescrever terceiro paragrafo da secao 2.2.3 (saida)**
  - **O que fazer:** Substituir "A saida e um Canonical Change Plan tipado como `specification-plan`, contendo regras de negocio em SBVR e criterios de aceitacao em SBE." por "A saida e um Canonical Change Plan tipado como `specification-plan`, contendo requisitos em formato IEEE 29148 + SBE." Manter intacta a mecanica de aprovacao.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.3 (terceiro paragrafo — saida)
  - **Impl:** plan-impl, Mudanca 10, item 3
  - **Refin:** plan-refin, Mudanca 10 (specification-plan sem SBVR)
  - **Dependencias:** B2.2.

- [ ] **B2.4 — Substituir exemplo de mediacao SBVR na secao 2.2.3**
  - **O que fazer:** Substituir integralmente o exemplo "Exemplo — mediacao SBVR" (com notacao "E obrigatorio que cada Pedido cujo Status e 'Pendente'...") pelo novo exemplo "Exemplo — clarificacao e formalizacao" que demonstra: deteccao de ambiguidade via validacao semantica interna, pergunta de clarificacao em linguagem natural, consulta a Product Canon, e formalizacao final em IEEE 29148 + SBE (com identificador REQ-CANCEL-001, tipo, contexto, prioridade, cenario SBE).
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.3 (exemplo de mediacao)
  - **Impl:** plan-impl, Mudanca 10, item 4
  - **Refin:** plan-refin, Mudanca 10 (eliminacao de notacao SBVR visivel)
  - **Dependencias:** B2.3.

---

## Fase C — Expansao do Domain Expert

### C1 — Anotacoes contextuais e hotspots de dominio (Mudanca 6)

- [ ] **C1.1 — Expandir descricao do Domain Expert na secao 4**
  - **O que fazer:** Na secao 4, substituir a descricao completa do Domain Expert ("Detem autoridade sobre o significado dos conceitos do dominio. Nao participa diretamente das cerimonias nem escreve especificacoes...") pela nova descricao expandida que inclui: guardiao ativo (nao passivo), anotacoes contextuais durante avaliacao de Change Plans (observacoes, ressalvas, esclarecimentos registrados no historico de aprovacao como insumos para cerimonias futuras), e hotspots de dominio (zonas que requerem atencao especial, metadados no artefato: autor/data/descricao, nao impedem aprovacao, utilizados pela IA na Clarificacao de Conformidade).
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (descricao do Domain Expert)
  - **Impl:** plan-impl, Mudanca 6, item 1
  - **Refin:** plan-refin, Mudanca 6 (transformacao de aprovacao binaria para processo ativo)
  - **Dependencias:** Nenhuma dentro desta fase — Mudanca 6 e independente.

- [ ] **C1.2 — Adicionar uso de hotspots na Clarificacao de Conformidade (secao 2.2.5)**
  - **O que fazer:** Na secao 2.2.5, adicionar ao final do paragrafo do guardrail de Clarificacao de Conformidade: "Quando uma especificacao ou edicao toca um trecho marcado como hotspot de dominio, a IA exibe proativamente a definicao precisa e alerta sobre a incerteza registrada, priorizando esses pontos na clarificacao."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.5 (Guardrail de Clarificacao de Conformidade)
  - **Impl:** plan-impl, Mudanca 6, item 3
  - **Refin:** plan-refin, Mudanca 6 (IA utiliza hotspots na Clarificacao de Conformidade)
  - **Dependencias:** C1.1.

- [ ] **C1.3 — Adicionar metadados de hotspot e anotacoes na secao 2.1**
  - **O que fazer:** Na secao 2.1 (Product Canon), adicionar mencao: "Artefatos da Product Canon podem conter metadados de hotspot de dominio (autor, data, descricao) e historico de anotacoes de aprovacao, enriquecendo o contexto disponivel para especificacoes futuras."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.1 (Product Canon)
  - **Impl:** plan-impl, Mudanca 6, item 4
  - **Refin:** plan-refin, Mudanca 6 (artefatos ganham metadados e historico)
  - **Dependencias:** C1.1.

- [ ] **C1.4 — Adicionar anotacoes na retroalimentacao (secao 2.4)**
  - **O que fazer:** Na secao 2.4 (Retroalimentacao), adicionar: "Anotacoes contextuais nao formalizadas nos ciclos anteriores sao apresentadas pela IA como candidatos a incorporacao durante cerimonias de Canon Building."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.4 (Etapa 3 — Retroalimentacao)
  - **Impl:** plan-impl, Mudanca 6, item 5
  - **Refin:** plan-refin, Mudanca 6 (anotacoes como insumos para formalizacao futura)
  - **Dependencias:** C1.1.

---

### C2 — Edicao direta do Domain Expert (Mudanca 7)

- [ ] **C2.1 — Criar subsecao 2.2.6 (Edicao Direta do Domain Expert)**
  - **O que fazer:** Adicionar nova subsecao 2.2.6 apos a secao 2.2.5 (Guardrails) e antes da secao 2.3 (Etapa 2). Descrever: o Domain Expert pode editar diretamente artefatos da camada de negocio da Product Canon fora do contexto de cerimonia formal. Canal complementar de manutencao, nao de rotina. Listar as 6 salvaguardas: (a) escopo limitado a camada de negocio, (b) natureza restrita a refinamentos/correcoes, (c) Domain Expert propoe em linguagem natural — IA formaliza, (d) tipagem distinta `expert-edit-plan`, (e) aprovacao do Architect obrigatoria e nao delegavel, (f) guardrails operam antes do Change Plan. Mencionar deteccao de contorno por proporcao de `expert-edit-plan`.
  - **Secoes afetadas em `zionkit-model.md`:** Nova subsecao 2.2.6
  - **Impl:** plan-impl, Mudanca 7, item 1
  - **Refin:** plan-refin, Mudanca 7 (canal de excecao com salvaguardas)
  - **Dependencias:** B1.1 (Padronizacao Canonica como pre-requisito).

- [ ] **C2.2 — Qualificar principio de Governanca por cerimonia na secao 8**
  - **O que fazer:** Na secao 8 (Principios de Design), substituir "Governanca por cerimonia. O conhecimento da Product Canon e construido e modificado exclusivamente atraves de cerimonias formais..." por "Governanca por cerimonia com canal de excecao. O conhecimento da Product Canon e construido e modificado primariamente atraves de cerimonias formais... Para capturar conhecimento de dominio que emerge fora do ritmo das cerimonias, o Domain Expert dispoe de um canal de excecao — edicao direta na camada de negocio (secao 2.2.6) — com salvaguardas que preservam a primazia das cerimonias: escopo restrito, tipagem distinta, aprovacao obrigatoria do Architect."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 8 (Principios de Design — Governanca por cerimonia)
  - **Impl:** plan-impl, Mudanca 7, item 2
  - **Refin:** plan-refin, Mudanca 7 (qualificacao de "exclusivamente" para "primariamente")
  - **Dependencias:** C2.1 (subsecao 2.2.6 deve existir para ser referenciada).

---

### C3 — Fluxo de guardrails pre-Change Plan (Mudanca 8)

- [ ] **C3.1 — Adicionar fluxo de guardrails dentro da secao 2.2.6**
  - **O que fazer:** Dentro da subsecao 2.2.6 (criada em C2.1), adicionar descricao do fluxo de guardrails na edicao direta: (1) Domain Expert propoe alteracao em linguagem natural; (2) IA executa simultaneamente todos os mecanismos de validacao (Clarificacao de Conformidade, validacao semantica interna incluindo SBVR, Validacao de Consistencia) e Padronizacao Canonica; (3) IA apresenta perguntas de clarificacao, versao formalizada como proposta, e Relatorio de Conformidade; (4) Domain Expert decide: aceitar, solicitar ajustes, responder perguntas, ou reescrever; (5) ciclo repete ate aceitacao. Mencionar que Relatorio de Conformidade pode ser estatico ou conversacional, a escolha do Domain Expert. Somente apos conclusao do ciclo o `expert-edit-plan` e gerado.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.6 (nova subsecao de fluxo de guardrails)
  - **Impl:** plan-impl, Mudanca 8, item 1
  - **Refin:** plan-refin, Mudanca 8 (fluxo iterativo pre-Change Plan, autoria do Domain Expert preservada)
  - **Dependencias:** C2.1 (subsecao 2.2.6 criada), B1.1 (Padronizacao Canonica).

---

### C4 — Tipo `expert-edit-plan` com aprovacao sequencial (Mudanca 9)

- [ ] **C4.1 — Adicionar descricao do `expert-edit-plan` e aprovacao sequencial na secao 2.2.6**
  - **O que fazer:** Dentro da subsecao 2.2.6, apos o fluxo de guardrails (C3.1), adicionar descricao do `expert-edit-plan`: conteudo (versao final IEEE 29148 + SBE, Relatorio de Conformidade, divergencias flagradas, impactos cross-context). Descrever aprovacao sequencial com ordem fixa: (1) Domain Expert aprova primeiro (valida fidelidade da formalizacao), (2) Architect aprova depois (avalia impacto tecnico — dependencias, eventos de dominio, principios constitucionais, ADRs, requisitos nao-funcionais). Aprovacao do Architect e obrigatoria e nao delegavel. Justificar a ordem: fidelidade semantica e pre-requisito para avaliacao tecnica. Mencionar tipagem distinta para auditoria de frequencia.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.2.6 (continuacao)
  - **Impl:** plan-impl, Mudanca 9, item 1
  - **Refin:** plan-refin, Mudanca 9 (aprovacao sequencial, mitigacao de rubber stamp no Change Plan)
  - **Dependencias:** C3.1 (fluxo de guardrails descrito).

- [ ] **C4.2 — Adicionar `expert-edit-plan` na secao 5 (Estrutura de Artefatos)**
  - **O que fazer:** Na secao 5, na lista de Canonical Change Plans com envelope tipado, adicionar: "`expert-edit-plan` — planos de mudanca originados por edicao direta do Domain Expert". Indicar que todos os tipos contem requisitos em formato IEEE 29148 + SBE.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 5 (Estrutura de Artefatos — Canonical Change Plans)
  - **Impl:** plan-impl, Mudanca 9, item 2 e Mudanca 4, item 3
  - **Refin:** plan-refin, Mudanca 9 (rastreabilidade por tipagem distinta)
  - **Dependencias:** A5.2 (secao 5 ja atualizada com IEEE 29148).

- [ ] **C4.3 — Mencionar `expert-edit-plan` na secao 2.3.3**
  - **O que fazer:** Na secao 2.3.3 (Canonical Change Plans), mencionar o `expert-edit-plan` como quarto tipo na descricao geral dos Change Plans, se houver texto descritivo dos tipos.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 2.3.3
  - **Impl:** plan-impl, Mudanca 9, item 3
  - **Refin:** plan-refin, Mudanca 9 (quarto tipo de Change Plan)
  - **Dependencias:** A5.3.

---

## Fase D — Consolidacao

### D1 — Atualizacao da tabela de papeis (Mudanca 11)

- [ ] **D1.1 — Adicionar edicao direta na descricao do Domain Expert (secao 4)**
  - **O que fazer:** Na secao 4, ao final da descricao do Domain Expert (ja expandida em C1.1), adicionar: "Ganha capacidade de edicao direta na camada de negocio da Product Canon (secao 2.2.6), propondo refinamentos e correcoes fora do contexto de cerimonias formais, com aprovacao sequencial obrigatoria (Domain Expert → Architect)."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (Domain Expert)
  - **Impl:** plan-impl, Mudanca 11, item 1
  - **Refin:** plan-refin, Mudanca 11 (consolidacao de todas as mudancas de papeis)
  - **Dependencias:** C1.1 (descricao expandida), C2.1 (edicao direta descrita), C4.1 (`expert-edit-plan` descrito).

- [ ] **D1.2 — Adicionar aprovacao de `expert-edit-plan` na descricao do Architect (secao 4)**
  - **O que fazer:** Na secao 4, ao final da descricao do Architect, adicionar: "Aprova obrigatoriamente e sem delegacao cada `expert-edit-plan` originado por edicao direta do Domain Expert, com foco no impacto tecnico."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (Architect)
  - **Impl:** plan-impl, Mudanca 11, item 2
  - **Refin:** plan-refin, Mudanca 11 (Architect como aprovador obrigatorio)
  - **Dependencias:** C4.1.

- [ ] **D1.3 — Adicionar ato operacional da IA para edicao direta (secao 4)**
  - **O que fazer:** Na secao 4, nos atos operacionais da IA (ja atualizado em A2.3), adicionar: "conduzir o ciclo iterativo de guardrails na edicao direta do Domain Expert".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (IA — atos operacionais)
  - **Impl:** plan-impl, Mudanca 11, item 3
  - **Refin:** plan-refin, Mudanca 11 (novo ato operacional da IA)
  - **Dependencias:** A2.3 (ato de validacao SBVR ja atualizado), C3.1 (fluxo de guardrails descrito).

- [ ] **D1.4 — Adicionar coluna "Edicao Direta" na tabela de atuacao por etapa (secao 4)**
  - **O que fazer:** Na tabela de atuacao por etapa da secao 4, adicionar nova coluna "Edicao Direta" com: Domain Builder = "—"; Architect = "Aprova `expert-edit-plan` (obrigatorio, nao delegavel)"; Domain Expert = "Edita camada de negocio; resolve divergencias com IA; aprova Change Plan consolidado"; IA = "Conduz ciclo de guardrails; formaliza em IEEE 29148 + SBE; gera `expert-edit-plan`". Nas colunas existentes de Etapa 1 e Etapa 2, atualizar celulas do Domain Expert para incluir "(com anotacoes e hotspots)".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 4 (tabela de atuacao por etapa)
  - **Impl:** plan-impl, Mudanca 11, item 4
  - **Refin:** plan-refin, Mudanca 11 (nova coluna torna explicita a expansao)
  - **Dependencias:** D1.1, D1.2, D1.3.

---

### D2 — Cenarios, diagrama e dores (Mudanca 12)

- [ ] **D2.1 — Atualizar diagrama do Ciclo Completo (secao 3)**
  - **O que fazer:** Na secao 3 (diagrama): (a) substituir "Domain Builder + IA (SBVR + SBE)" por "Domain Builder + IA (IEEE 29148 + SBE)" na caixa da Requirements Specification Session; (b) substituir a caixa de Guardrails por "Guardrails: Clarificacao de Conformidade, Validacao de Consistencia, Padronizacao Canonica, Validacao Semantica Interna, Versionamento por Estrangulamento"; (c) considerar adicionar caixa representando a Edicao Direta do Domain Expert como canal complementar conectado a Product Canon, fora do fluxo principal.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 3 (Diagrama do Ciclo Completo)
  - **Impl:** plan-impl, Mudanca 12, item 1
  - **Refin:** plan-refin, Mudanca 12 (secoes derivadas devem refletir mudancas substanciais)
  - **Dependencias:** B2.4 (fluxo da cerimonia finalizado), B1.1 (Padronizacao Canonica), C2.1 (edicao direta).

- [ ] **D2.2 — Atualizar cenario Greenfield (secao 6.1)**
  - **O que fazer:** Na secao 6.1 (Greenfield, passo 3), substituir "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA, os requisitos de cada contexto sao formalizados..." pelo novo texto que descreve clarificacao iterativa mediada pela IA, validacao semantica interna para detectar ambiguidades, formalizacao em IEEE 29148 + SBE com nivel de aderencia Minimo. Manter intacto o restante do passo 3.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 6.1 (Cenario Greenfield — passo 3)
  - **Impl:** plan-impl, Mudanca 12, item 2
  - **Refin:** plan-refin, Mudanca 12 (cenarios como secoes derivadas)
  - **Dependencias:** B2.4.

- [ ] **D2.3 — Atualizar tabela de dores endereçadas (secao 7)**
  - **O que fazer:** Na secao 7, na linha "Domain Builders excluidos do processo de especificacao", substituir a coluna "Como o ZionKit endereca" que menciona "a IA traduz para SBVR controlado" pela nova descricao: "A IA utiliza validacao semantica interna para garantir rigor, e formaliza os requisitos em IEEE 29148 + SBE — formato compreensivel por pessoas de negocio".
  - **Secoes afetadas em `zionkit-model.md`:** Secao 7 (Dores Endereçadas)
  - **Impl:** plan-impl, Mudanca 12, item 3
  - **Refin:** plan-refin, Mudanca 12 (tabela de dores como secao derivada)
  - **Dependencias:** B2.4.

---

### D3 — Revisao da prioridade de prototipacao 6 (Mudanca 13)

- [ ] **D3.1 — Reformular prioridade 6 na secao 10**
  - **O que fazer:** Na secao 10, substituir integralmente a prioridade 6 ("Formalizacao SBVR + SBE mediada pela IA. Testar se: (a) a IA consegue traduzir linguagem natural... (b) o Domain Builder consegue compreender e validar o resultado SBVR... Risco a monitorar: efeito rubber stamp") pela nova prioridade: "Validacao SBVR como motor interno de clarificacao. Testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradicoes; (b) a IA traduz problemas detectados em perguntas de clarificacao claras e acionaveis; (c) o processo produz requisitos IEEE 29148 + SBE mais completos. Metrica principal: taxa de problemas detectados que resultam em mudancas efetivas no requisito final."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 10 (prioridade 6)
  - **Impl:** plan-impl, Mudanca 13, item 1
  - **Refin:** plan-refin, Mudanca 13 (foco muda de compreensao humana para eficacia da validacao interna)
  - **Dependencias:** A2.1 (SBVR reposicionado como interno).

---

### D4 — Nova prioridade de prototipacao 8 (Mudanca 14)

- [ ] **D4.1 — Adicionar prioridade 8 na secao 10**
  - **O que fazer:** Na secao 10, adicionar prioridade 8 apos a prioridade 7 existente: "Guardrail de Padronizacao Canonica. Testar se a IA consegue formalizar corretamente edicoes em linguagem natural para IEEE 29148 + SBE (com classificacao conforme nivel de aderencia), preservando o significado original. Metrica: taxa de aceitacao pelo Domain Expert na primeira tentativa versus necessidade de ciclos iterativos. Validar tambem modo implicito nas cerimonias."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 10 (nova prioridade 8)
  - **Impl:** plan-impl, Mudanca 14, item 1
  - **Refin:** plan-refin, Mudanca 14 (validacao empirica da capacidade de formalizacao)
  - **Dependencias:** B1.1 (guardrail descrito no modelo).

---

### D5 — Nova prioridade de prototipacao 9 (Mudanca 15)

- [ ] **D5.1 — Adicionar prioridade 9 na secao 10**
  - **O que fazer:** Na secao 10, adicionar prioridade 9 apos a prioridade 8: "Edicao direta do Domain Expert com aprovacao sequencial. Testar fluxo completo: Domain Expert edita → guardrails validam e formalizam → ciclo iterativo → `expert-edit-plan` → Domain Expert aprova → Architect avalia. Avaliar: (a) segunda aprovacao agrega valor real; (b) ordem sequencial elimina retrabalho; (c) Domain Expert identifica diferencas entre ciclo iterativo e artefato final; (d) processo percebido como facilitador ou burocracia; (e) ambas as formas do Relatorio de Conformidade."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 10 (nova prioridade 9)
  - **Impl:** plan-impl, Mudanca 15, item 1
  - **Refin:** plan-refin, Mudanca 15 (validacao ponta a ponta da edicao direta)
  - **Dependencias:** D4.1 (prioridade 8 deve preceder a 9).

---

### D6 — Nova prioridade de prototipacao 10 (Mudanca 16)

- [ ] **D6.1 — Adicionar prioridade 10 na secao 10**
  - **O que fazer:** Na secao 10, adicionar prioridade 10 apos a prioridade 9: "Taxonomia IEEE 29148 na Requirements Specification Session. Testar se: (a) IA guia Domain Builder e Architect pelas categorias sem parecer burocratico; (b) sinalizacao de categorias nao cobertas produz requisitos que teriam sido omitidos; (c) aderencia adaptativa funciona — projetos iniciais aceitam secoes 'pendente'; (d) tres niveis percebidos como proporcionais; (e) progressao de Minimo para Moderado acontece naturalmente."
  - **Secoes afetadas em `zionkit-model.md`:** Secao 10 (nova prioridade 10)
  - **Impl:** plan-impl, Mudanca 16, item 1
  - **Refin:** plan-refin, Mudanca 16 (validacao empirica focada em percepcao humana)
  - **Dependencias:** A4.1 (niveis de aderencia descritos), B2.4 (cerimonia revisada).

---

## Fase E — Limpeza e verificacao

- [ ] **E1 — Reestruturacao da secao 9 (Riscos)**
  - **O que fazer:** Revisar a secao 9 inteira: (a) confirmar que o risco 9.6 antigo ("Curva de aprendizado SBVR") foi substituido pelo novo 9.6 (ja executado em A2.4); (b) manter intactos os riscos 9.1 a 9.5 e 9.7, exceto ajustes pontuais de terminologia — revisar se algum desses riscos menciona SBVR como formato visivel e ajustar; (c) nao adicionar novos riscos alem do 9.6 reformulado.
  - **Secoes afetadas em `zionkit-model.md`:** Secao 9 (Riscos e Limitacoes Conhecidas)
  - **Impl:** plan-impl, secao 4.3 (reestruturacao da secao 9)
  - **Refin:** plan-refin, Mudanca 1 (riscos associados ao reposicionamento do SBVR)
  - **Dependencias:** A2.4 (risco 9.6 ja substituido).

- [ ] **E2 — Revisao do Resumo Executivo**
  - **O que fazer:** Revisar o Resumo Executivo para garantir alinhamento completo com a triade de padroes e todas as mudancas implementadas. Verificar: (a) mencao ao formato canonico IEEE 29148 + SBE; (b) nenhuma referencia a SBVR como formato visivel; (c) mencao a validacao semantica interna. Se A1.2 ja foi executada, verificar que o resumo esta completo e coerente com o restante do documento.
  - **Secoes afetadas em `zionkit-model.md`:** Resumo Executivo
  - **Impl:** plan-impl, Fase E, item E2 (revisao do Resumo Executivo)
  - **Refin:** plan-refin, Mudanca 17 (triade como referencia conceitual)
  - **Dependencias:** Todas as fases A–D concluidas.

- [ ] **E3 — Busca textual por residuos**
  - **O que fazer:** Executar busca textual completa por "SBVR" em todo o documento `zionkit-model.md`. Toda ocorrencia deve estar qualificada como "interno", "validacao interna", "motor interno" ou equivalente. Nenhuma ocorrencia deve apresentar SBVR como formato visivel, formato de armazenamento ou formato de saida. Buscar tambem: "traduz para SBVR", "traduzir para SBVR", "notacao SBVR", "formato SBVR" — nenhuma dessas expressoes deve existir. Verificar que o exemplo da secao 2.2.3 nao contem notacao SBVR. Verificar que o diagrama da secao 3 nao contem "SBVR + SBE".
  - **Secoes afetadas em `zionkit-model.md`:** Documento inteiro
  - **Impl:** plan-impl, secao 6.1 (eliminacao de residuos SBVR)
  - **Refin:** plan-refin, Mudanca 12 (busca textual como mitigacao)
  - **Dependencias:** E1, E2 (todas as edicoes finalizadas).

- [ ] **E4 — Atualizacao de metadados**
  - **O que fazer:** Atualizar a versao do documento de 0.5 para 0.6 e a data para a data de conclusao da implementacao.
  - **Secoes afetadas em `zionkit-model.md`:** Cabecalho/metadados do documento
  - **Impl:** plan-impl, Fase E, item E4
  - **Refin:** N/A
  - **Dependencias:** E3 (verificacao concluida).

---

## Checklist de Verificacao Final

Apos implementacao de todas as tarefas, executar as seguintes verificacoes:

### 6.1 Eliminacao de residuos SBVR visivel

- [ ] Busca textual por "SBVR" em todo o documento — toda ocorrencia qualificada como "interno"/"validacao interna"/"motor interno".
- [ ] Busca textual por "traduz para SBVR", "traduzir para SBVR", "notacao SBVR", "formato SBVR" — nenhuma deve existir.
- [ ] Exemplo da secao 2.2.3 nao contem notacao SBVR ("E obrigatorio que...", "E proibido que...").
- [ ] Diagrama da secao 3 nao contem "SBVR + SBE" como formato visivel.

### 6.2 Presenca dos novos conceitos

- [ ] Triade de padroes descrita em subsecao dedicada na secao 2.
- [ ] IEEE 29148 mencionado como formato canonico em: 2.1, 2.2.3, 5, 6.1, 7.
- [ ] Tres niveis de aderencia (Minimo/Moderado/Completo) descritos em 2.2.2.
- [ ] Guardrail de Padronizacao Canonica descrito em 2.2.5.
- [ ] Anotacoes contextuais e hotspots de dominio descritos na secao 4 (Domain Expert).
- [ ] Edicao direta descrita em subsecao 2.2.6.
- [ ] `expert-edit-plan` listado na secao 5 e descrito em 2.2.6.
- [ ] Prioridades de prototipacao 8, 9 e 10 presentes na secao 10.
- [ ] Prioridade 6 reformulada na secao 10.

### 6.3 Coesao documental

- [ ] Principio "Governanca por cerimonia" na secao 8 qualificado com canal de excecao.
- [ ] Risco 9.6 substituido (nao contem "Curva de aprendizado SBVR").
- [ ] Tabela de papeis (secao 4) contem coluna "Edicao Direta".
- [ ] Diagrama (secao 3) contem Padronizacao Canonica nos guardrails.
- [ ] Resumo Executivo alinhado com triade de padroes.
- [ ] Todas as referencias a "SBVR + SBE" como formato de saida substituidas por "IEEE 29148 + SBE".
- [ ] Nenhuma secao referencia o Domain Expert como papel exclusivamente passivo.
- [ ] Versao do documento atualizada para 0.6.

### 6.4 Consistencia cruzada

- [ ] Secao 6 (cenarios) consistente com secao 2 (modelo).
- [ ] Secao 7 (dores) consistente com secao 2 (modelo).
- [ ] Secao 3 (diagrama) consistente com secao 2 (modelo).
- [ ] Secao 4 (papeis) consistente com secoes 2.2.6 (edicao direta) e 2.2.5 (guardrails).
- [ ] Secao 9 (riscos) consistente com o panorama de riscos das mudancas implementadas.
- [ ] Secao 10 (prototipacao) consistente com as capacidades introduzidas.

---

## Contagem Total de Tarefas

| Fase | Tarefas |
|------|---------|
| A — Fundacoes de padroes | 14 |
| B — Guardrails e cerimonias | 5 |
| C — Expansao do Domain Expert | 9 |
| D — Consolidacao | 10 |
| E — Limpeza e verificacao | 4 |
| **Total de tarefas de implementacao** | **42** |
| Checklist de verificacao final | 20 itens |

**Cobertura:** 17/17 mudancas (M1–M17), 5/5 fases (A–E), 4 mudancas de formato/estrutura (subsecoes 4.1–4.6 do plano), checklist de verificacao integral (secao 6 do plano, categorias 6.1–6.4), atualizacao de metadados.
