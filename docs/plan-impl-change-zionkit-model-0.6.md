# Plano de Implementação — ZionKit v0.5 → v0.6

**Data:** 2026-04-07  
**Versão alvo:** 0.6  
**Documentos de referência:**
- `docs/zionkit-model.md` (v0.5 — documento base a ser evoluído)
- `docs/plan-refin-change-zionkit-model-0.6.md` (refinamento das 17 mudanças)

---

## 1. Análise do Formato Atual (v0.5)

### 1.1 Estrutura de 10 seções do documento v0.5

| # | Seção | Conteúdo |
|---|-------|----------|
| — | Resumo Executivo | Visão geral do modelo em parágrafos |
| 1 | Problema | 3 subseções de problemas (1.1, 1.2, 1.3) |
| 2 | O Modelo ZionKit | Product Canon (2.1), Etapa 1 com 3 cerimônias + Decisão + Guardrails (2.2), Etapa 2 (2.3), Etapa 3 (2.4) |
| 3 | O Ciclo Completo | Diagrama textual ASCII do fluxo |
| 4 | Papéis no Modelo | Descrição dos 4 papéis + tabela de atuação |
| 5 | Estrutura de Artefatos | Lista de artefatos da Product Canon |
| 6 | Cenários de Aplicação | Greenfield (6.1), Brownfield (6.2), Migração Gradual (6.3) |
| 7 | Dores Endereçadas | Tabela dor → solução |
| 8 | Princípios de Design | 7 princípios narrativos |
| 9 | Riscos e Limitações Conhecidas | 7 riscos (9.1–9.7) |
| 10 | Direções para Prototipação | 7 prioridades numeradas |

### 1.2 Diagnóstico de capacidade da estrutura para o novo escopo

A estrutura de 10 seções **comporta** o novo escopo com os seguintes ajustes:

1. **Tríade de padrões (Mudança 17):** A v0.5 não possui nenhuma subseção dedicada aos padrões utilizados pelo modelo. IEEE 29148, SBVR e SBE são mencionados dispersamente nas seções 2.1, 2.2.3, 5 e 10. A formalização da tríade justifica uma **nova subseção 2.0.1** (ou equivalente) antes da descrição da Product Canon, posicionando os padrões como conceito de primeira classe que fundamenta tudo que se segue.

2. **Edição direta do Domain Expert (Mudanças 7, 8, 9):** A v0.5 organiza toda a governança da Product Canon dentro da seção 2.2 (Etapa 1 — Canon Building). A edição direta não é uma cerimônia da Etapa 1, nem se encaixa na Etapa 2 (especificação de feature). Justifica uma **nova subseção 2.2.6** (ou equivalente) dentro da Etapa 1, posicionada como canal complementar de manutenção da Product Canon.

3. **Governança por cerimônia (seção 8):** O princípio afirma que a Product Canon é modificada "exclusivamente" através de cerimônias formais. A edição direta exige **qualificação** desse princípio — "primariamente" em vez de "exclusivamente", com menção ao canal de exceção.

4. **Riscos (seção 9):** A v0.5 tem 7 riscos (9.1–9.7). Vários riscos da v0.5 são absorvidos ou reformulados pelas mudanças. A seção deve ser **reestruturada**: risco 9.6 (curva SBVR) é eliminado e substituído por novos riscos; riscos novos são adicionados.

5. **Prototipação (seção 10):** A v0.5 tem 7 prioridades. A v0.6 adiciona 3 novas (prioridades 8, 9, 10) e reformula a prioridade 6. A seção expande de 7 para 10 prioridades.

### 1.3 Oportunidades de simplificação

1. **Seção 5 (Estrutura de Artefatos):** Contém redundância parcial com a seção 2.1 (Product Canon), que já lista os mesmos artefatos. A v0.6 pode consolidar a seção 5 como referência de formato (IEEE 29148 + SBE, níveis de aderência) em vez de repetir o conteúdo da 2.1. Decisão: manter a seção 5 mas reescrevê-la como referência de formato e tipagem, eliminando a descrição redundante dos artefatos.

2. **Exemplo SBVR na seção 2.2.3:** O exemplo de mediação SBVR ("É obrigatório que cada Pedido cujo Status é 'Pendente'...") deve ser substituído por um exemplo equivalente no novo fluxo (clarificação em linguagem natural + formalização IEEE 29148 + SBE).

---

## 2. Análise de Resíduos da v0.5

Todos os pontos do documento v0.5 onde conceitos que serão substituídos estão presentes:

### 2.1 Resíduos de SBVR como formato visível

| Local | Trecho | Tipo de resíduo |
|-------|--------|-----------------|
| Resumo Executivo | "Canon Building — construção e manutenção assistida da Product Canon por Domain Builders e Architects, através de três cerimônias formais" | Não menciona SBVR, mas omite a tríade de padrões — resíduo por ausência |
| Seção 2.1 (Product Canon) | "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example)" | SBVR como formato de armazenamento visível |
| Seção 2.2.3 (Requirements Specification Session) | "cerimônia conversacional de formalização semântica de requisitos, utilizando SBVR para vocabulário e regras de negócio declarativas" | SBVR como metodologia visível da cerimônia |
| Seção 2.2.3 | "O Domain Builder descreve requisitos em linguagem natural. A IA traduz para SBVR controlado e apresenta a formalização para validação do Domain Builder." | Fluxo SBVR visível |
| Seção 2.2.3 | Exemplo de mediação SBVR: "É obrigatório que cada Pedido cujo Status é 'Pendente'..." | Notação SBVR visível ao usuário |
| Seção 2.2.3 | "contendo regras de negócio em SBVR e critérios de aceitação em SBE" | SBVR no Change Plan |
| Seção 3 (Diagrama) | "Domain Builder + IA (SBVR + SBE)" na caixa da Requirements Specification Session | SBVR visível no diagrama |
| Seção 4 (Papéis) | Ato operacional da IA: "traduzir linguagem natural para SBVR" | SBVR como ato visível |
| Seção 5 (Estrutura de Artefatos) | "Regras de negócio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session" | SBVR como formato de armazenamento |
| Seção 5 | "Requisitos com critérios de aceitação: especificados em SBE (Specification by Example) para verificabilidade" | Não menciona IEEE 29148 — resíduo por ausência |
| Seção 6.1 (Greenfield) | "utilizando SBVR + SBE mediado pela IA, os requisitos de cada contexto são formalizados e validados" | SBVR visível no cenário |
| Seção 6.1 | "a IA traduz para SBVR controlado, apresentando a formalização para validação" | Fluxo SBVR visível no cenário |
| Seção 7 (Dores) | "Na Requirements Specification, a IA traduz para SBVR controlado" | SBVR visível na tabela de dores |
| Seção 9.6 | "Curva de aprendizado SBVR" — risco inteiro baseado em SBVR como formato visível | Risco obsoleto |
| Seção 10, prioridade 6 | "Formalização SBVR + SBE mediada pela IA" — testa compreensão humana do SBVR | Prioridade de prototipação obsoleta |

### 2.2 Resíduos de Domain Expert como papel passivo

| Local | Trecho | Tipo de resíduo |
|-------|--------|-----------------|
| Seção 4 (Domain Expert) | "Não participa diretamente das cerimônias nem escreve especificações" | Descrição limitada — sem anotações, hotspots ou edição direta |
| Seção 4 (tabela) | Domain Expert atua apenas como aprovador nas Etapas 1 e 2, sem edição direta | Tabela incompleta |

### 2.3 Resíduos de governança exclusivamente cerimonial

| Local | Trecho | Tipo de resíduo |
|-------|--------|-----------------|
| Seção 8 | "Governança por cerimônia. O conhecimento da Product Canon é construído e modificado exclusivamente através de cerimônias formais" | "exclusivamente" impede edição direta |

### 2.4 Resíduos por ausência (conceitos v0.6 sem representação na v0.5)

| Conceito v0.6 | Ausência na v0.5 |
|----------------|------------------|
| Tríade de padrões (SBVR/IEEE 29148/SBE com papéis distintos) | Nenhuma subseção dedicada |
| IEEE 29148 como padrão de estruturação | Ausente em todo o documento |
| Níveis de aderência (Mínimo/Moderado/Completo) | Ausente em todo o documento |
| Guardrail de Padronização Canônica | Ausente na seção 2.2.5 |
| Anotações contextuais do Domain Expert | Ausente na seção 4 e nos gates |
| Hotspots de domínio | Ausente em todo o documento |
| Edição direta do Domain Expert | Ausente em todo o documento |
| `expert-edit-plan` | Ausente na seção 5 e na seção 2.3.3 |
| Prioridades de prototipação 8, 9, 10 | Ausentes na seção 10 |

---

## 3. Plano de Mudanças

### Mudança 1 — Reposicionamento do SBVR: de formato visível para ferramenta interna

**Seções afetadas:** 2.1, 2.2.3, 2.2.5, 3, 4, 5, 6.1, 7, 9.6, 10 (prioridade 6), Resumo Executivo.

**Descrição cirúrgica:**

1. **Seção 2.1 (Product Canon, camada de negócio).** Substituir o bullet:
   > "Requisitos formalizados via SBVR (Semantics of Business Vocabulary and Business Rules) + SBE (Specification by Example): requisitos de software produzidos e mantidos através de processos assistidos de formalização semântica, com completude e consistência validadas."
   
   Por:
   > "Requisitos formalizados em formato IEEE 29148 com critérios de aceitação SBE (Specification by Example): requisitos de software produzidos e mantidos através de processos assistidos de formalização, com completude e consistência validadas internamente pela IA utilizando metodologias como SBVR (Semantics of Business Vocabulary and Business Rules)."

2. **Seção 2.2.3 (Requirements Specification Session).** Tratada integralmente na Mudança 10.

3. **Seção 2.2.5 (Guardrails).** Adicionar, após o parágrafo de Validação de Consistência, menção à validação SBVR como mecanismo interno complementar:
   > "**Validação semântica interna.** A IA utiliza internamente metodologias de validação semântica — incluindo SBVR para detecção de ambiguidade estrutural, incompletude de predicados e indefinição de participantes — para analisar a expressão individual de cada requisito. Os problemas detectados são apresentados ao participante como perguntas de clarificação em linguagem natural, nunca como notação formal. SBVR é a metodologia principal de validação interna, mas não exclusiva — a IA pode utilizar outras metodologias (análise de dependências entre bounded contexts, verificação de completude de fluxos, análise de cobertura de cenários de erro) desde que os resultados sejam apresentados em linguagem natural."

4. **Seção 4 (Papéis — atos da IA).** Substituir o ato operacional:
   > "traduzir linguagem natural para SBVR"
   
   Por:
   > "usar metodologias de validação semântica (incluindo SBVR) internamente para detectar ambiguidades, incompletudes e contradições, e traduzir os problemas detectados em perguntas de clarificação em linguagem natural"

5. **Seção 9.6 (Curva de aprendizado SBVR).** Eliminar inteiramente este risco. Substituir por um novo risco:
   > "**9.6 Qualidade da tradução de validação interna para linguagem natural.** A IA utiliza metodologias de validação semântica (incluindo SBVR) internamente para detectar problemas em requisitos. A eficácia desse processo depende da capacidade da IA de traduzir os problemas detectados em perguntas de clarificação claras e acionáveis em linguagem natural. Se a tradução for imprecisa, o benefício da validação se perde. Mitigação: o ciclo iterativo de clarificação permite que o Domain Builder questione e refine as perguntas da IA; a formalização final em IEEE 29148 + SBE serve como ponto de validação auditável."

6. Demais seções (3, 5, 6.1, 7, Resumo Executivo): tratadas nas Mudanças 4, 11 e 12.

**Tratamento de mitigações de risco:**
- Mitigação "a IA deve explicitar a natureza da validação sem expor a metodologia": **absorvida** como parte da descrição do guardrail de validação semântica interna (item 3 acima). A orientação é coerente com o modelo e não aumenta complexidade.
- Mitigação "prioridade de prototipação 6 reformulada": **absorvida** como Mudança 13.
- Mitigação "formalização final em IEEE 29148 + SBE serve como ponto de validação auditável": **absorvida** — decorre naturalmente da Mudança 4.

**Dependências:** Habilita Mudanças 2, 4, 10, 13. Deve ser implementada antes dessas.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 1

---

### Mudança 2 — Adoção do IEEE 29148 como padrão oficial de estruturação de requisitos

**Seções afetadas:** 2.1, 2.2.2, 2.2.3, 5, nova subseção de tríade de padrões.

**Descrição cirúrgica:**

1. **Nova subseção (tríade de padrões).** Tratada integralmente na Mudança 17.

2. **Seção 2.1 (Product Canon, camada de negócio).** Já atualizada na Mudança 1 (item 1). Adicionalmente, após o bullet de requisitos, adicionar explicação:
   > "IEEE 29148 (ISO/IEC/IEEE 29148:2018) fornece a taxonomia para classificar requisitos (funcionais, não-funcionais, de interface, de design, restrições), atributos obrigatórios por requisito (identificador único, rastreabilidade, prioridade, verificabilidade) e critérios de qualidade. A adoção é motivada pela maturidade do padrão e pela familiaridade dos LLMs com sua taxonomia."

3. **Seção 2.2.2 (Technical Constitution Session).** Adicionar ao parágrafo que descreve as responsabilidades do Architect:
   > "O Architect define também o nível de aderência IEEE 29148 (ver Mudança 3 — níveis de aderência) como parte dos princípios técnicos constitucionais."

4. **Seção 2.1 (Product Canon, camada de arquitetura).** Adicionar ao bullet de princípios técnicos constitucionais:
   > "Incluem o nível de aderência IEEE 29148 configurado para cada bounded context."

5. **Seção 5 (Estrutura de Artefatos).** Tratada na Mudança 4.

**Tratamento de mitigações de risco:**
- Mitigação "Mudança 3 garante aderência adaptativa": **absorvida** — referenciada diretamente no item 3.
- Mitigação "mediação da IA abstrai complexidade": **absorvida** — já é princípio do modelo.
- Mitigação "prioridade de prototipação dedicada": **absorvida** como Mudança 16.

**Dependências:** Requer Mudança 1 (SBVR internalizado). Habilita Mudanças 3, 4, 5.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 2

---

### Mudança 3 — Natureza adaptativa do IEEE 29148 com três níveis de aderência

**Seções afetadas:** 2.2.2, 2.1 (indireta), 6, nova subseção de tríade de padrões.

**Descrição cirúrgica:**

1. **Seção 2.2.2 (Technical Constitution Session).** Após o parágrafo "O Architect utiliza as estruturas de domínio descobertas...", adicionar novo parágrafo:
   > "A aplicação do IEEE 29148 é proporcional à maturidade do produto e ao contexto do ciclo, através de três níveis de aderência definidos pelo Architect nos princípios técnicos constitucionais:
   > - **Mínimo** — produto novo, prototipação, discovery inicial: tipo de requisito, descrição em linguagem natural estruturada, critérios SBE.
   > - **Moderado** — produto em crescimento, após 2–3 ciclos de Canon Building: adiciona subtipo, rastreabilidade para Change Plans, dependências entre requisitos.
   > - **Completo** — produto maduro, domínios regulados, integrações complexas: aplicação integral da taxonomia IEEE 29148 com rastreabilidade bidirecional, atributos de qualidade, seções de interface e restrição de design.
   >
   > O nível pode variar por bounded context — um contexto maduro pode operar em nível Completo enquanto um contexto novo opera em nível Mínimo. O SBE (Dado/Quando/Então) é obrigatório em todos os níveis."

2. **Exemplo de princípios técnicos constitucionais (seção 2.2.2).** Adicionar ao bloco de código de exemplo:
   ```
   REQUISITOS
     - Nível de aderência IEEE 29148: Mínimo (produto em fase de 
       prototipação)
     - SBE obrigatório em todos os requisitos funcionais
   ```

3. **Seção 6.1 (Greenfield).** Mencionar que o projeto opera naturalmente em nível Mínimo (tratado na Mudança 12).

**Tratamento de mitigações de risco:**
- Mitigação "registro do nível nos princípios técnicos constitucionais cria ponto de auditoria": **absorvida** — é parte natural do item 1.
- Mitigação "obrigatoriedade do SBE em todos os níveis garante piso mínimo": **absorvida** — mencionado explicitamente no item 1.
- Mitigação do risco 9.11 (excesso de formalismo): **absorvida** — a própria aderência adaptativa é a mitigação.

**Dependências:** Requer Mudança 2 (IEEE 29148). Habilita Mudança 5 (Padronização Canônica).

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 3

---

### Mudança 4 — Formato canônico: de SBVR + SBE para IEEE 29148 + SBE

**Seções afetadas:** 2.1, 2.3.3, 5.

**Descrição cirúrgica:**

1. **Seção 2.1 (Product Canon, camada de negócio).** Já tratada na Mudança 1 (item 1) e Mudança 2 (item 2). Verificar que nenhuma referência a "SBVR" como formato de armazenamento permanece.

2. **Seção 5 (Estrutura de Artefatos).** Substituir:
   > "Regras de negócio: formalizadas em SBVR quando mediadas pela IA na Requirements Specification Session"
   
   Por:
   > "Regras de negócio: formalizadas em formato IEEE 29148, validadas internamente pela IA utilizando metodologias como SBVR"

   Substituir:
   > "Requisitos com critérios de aceitação: especificados em SBE (Specification by Example) para verificabilidade"
   
   Por:
   > "Requisitos com critérios de aceitação: estruturados em IEEE 29148 com cenários SBE (Specification by Example) para verificabilidade"

3. **Seção 5 (Canonical Change Plans).** Atualizar a lista de tipos com envelope para incluir `expert-edit-plan` (tratado na Mudança 9). Indicar que todos os tipos contêm requisitos em formato IEEE 29148 + SBE.

4. **Seção 2.3.3 (Canonical Change Plan Incremental).** No exemplo de Canonical Change Plan incremental (bloco de código "PIX no Checkout"), não há notação SBVR visível — o exemplo já opera em linguagem natural estruturada. Verificar que a descrição textual ao redor do exemplo não menciona SBVR. Adicionar ao texto descritivo, se necessário:
   > "O Canonical Change Plan incremental contém requisitos no formato IEEE 29148 + SBE."

**Tratamento de mitigações de risco:**
- Mitigação "migração gradual via Versionamento por Estrangulamento": **mantida como escopo considerável** — a migração de artefatos existentes é um problema operacional real, mas especulativo neste nível de prototipação conceitual. O plano de implementação não trata de migração de dados, apenas de migração documental.
- Mitigação "ciclo iterativo garante validação antes do armazenamento": **absorvida** — já é parte do modelo.

**Dependências:** Requer Mudanças 1 e 2. Deve ser implementada junto com a Mudança 1.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 4

---

### Mudança 5 — Novo guardrail: Padronização Canônica (Canonical Formatting)

**Seções afetadas:** 2.2.5.

**Descrição cirúrgica:**

1. **Seção 2.2.5 (Guardrails da Product Canon).** Após o parágrafo de Validação de Consistência e antes do parágrafo de Versionamento Gradual por Estrangulamento, adicionar novo guardrail:
   > "**Padronização Canônica (Canonical Formatting).** Garante que toda escrita na Product Canon esteja no formato canônico IEEE 29148 + SBE aderido pelo modelo. Valida duas dimensões: IEEE 29148 (o requisito está estruturado com os atributos obrigatórios conforme o nível de aderência configurado, classificado na taxonomia correta) e SBE (cada requisito funcional possui cenários de aceitação concretos Dado/Quando/Então). O guardrail opera em dois modos: nas cerimônias de Canon Building, a padronização é parte integrante da mediação da IA (modo implícito); na edição direta pelo Domain Expert, o guardrail é explícito — o Domain Expert propõe edições em formato livre, e a IA reescreve no formato canônico antes de qualquer validação semântica ou geração de Change Plan. O guardrail respeita o nível de aderência IEEE 29148 configurado pelo Architect: em nível Mínimo valida apenas tipo + descrição + SBE; em nível Moderado adiciona subtipo, rastreabilidade e dependências; em nível Completo valida conformidade integral."

2. **Seção 3 (Diagrama).** Atualizar a caixa de guardrails para incluir Padronização Canônica (tratado na Mudança 12).

**Tratamento de mitigações de risco:**
- Mitigação "Domain Expert revisa e aprova a formalização": **absorvida** — é parte do fluxo de edição direta (Mudança 8).
- Mitigação "parametrização por nível de aderência": **absorvida** — descrita no item 1.
- Mitigação "prioridade de prototipação valida taxa de aceitação": **absorvida** como Mudança 14.

**Dependências:** Requer Mudanças 2, 3 e 4 (IEEE 29148 como formato canônico). Habilita Mudanças 7 e 8 (edição direta).

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 5

---

### Mudança 6 — Expansão do Domain Expert: anotações e hotspots

**Seções afetadas:** 4, 2.2.5, 2.1, 2.4.

**Descrição cirúrgica:**

1. **Seção 4 (Papéis — Domain Expert).** Substituir:
   > "Detém autoridade sobre o significado dos conceitos do domínio. Não participa diretamente das cerimônias nem escreve especificações. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution. Funciona como guardião da integridade semântica da Product Canon."
   
   Por:
   > "Detém autoridade sobre o significado dos conceitos do domínio. Funciona como guardião ativo da integridade semântica da Product Canon. É aprovador primário nos gates de Domain Discovery e Requirements Specification, validando fidelidade semântica ao domínio. É aprovador secundário no gate de Technical Constitution. Durante a avaliação de qualquer Canonical Change Plan, pode adicionar **anotações contextuais** ao artefato sob revisão — observações sobre nuances de domínio, ressalvas sobre interpretações, ou esclarecimentos que enriquecem o registro. As anotações são registradas como parte do histórico de aprovação e são insumos formais para cerimônias futuras: a IA as apresenta como candidatos a formalização no próximo ciclo de Canon Building. Adicionalmente, o Domain Expert pode marcar áreas da Product Canon como **hotspots de domínio** — zonas que requerem atenção especial por serem frágeis, frequentemente mal interpretadas, ou com histórico de problemas. Hotspots são metadados no artefato afetado (autor, data, descrição), não impedem a aprovação, e são utilizados proativamente pela IA na Clarificação de Conformidade."

2. **Seção 4 (tabela de atuação).** Atualizar as células do Domain Expert para incluir "(com anotações e hotspots)" nas colunas de Etapa 1 e Etapa 2. Tratado integralmente na Mudança 11.

3. **Seção 2.2.5 (Guardrail de Clarificação de Conformidade).** Adicionar ao final do parágrafo existente:
   > "Quando uma especificação ou edição toca um trecho marcado como hotspot de domínio, a IA exibe proativamente a definição precisa e alerta sobre a incerteza registrada, priorizando esses pontos na clarificação."

4. **Seção 2.1 (Product Canon).** Adicionar menção a metadados de artefato:
   > "Artefatos da Product Canon podem conter metadados de hotspot de domínio (autor, data, descrição) e histórico de anotações de aprovação, enriquecendo o contexto disponível para especificações futuras."

5. **Seção 2.4 (Retroalimentação).** Adicionar:
   > "Anotações contextuais não formalizadas nos ciclos anteriores são apresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building."

**Tratamento de mitigações de risco:**
- Mitigação "anotações posicionadas como insumos para formalização futura": **absorvida** — descrita no item 1 e no item 5.
- Mitigação "hotspots com data de validade ou revisão periódica": **mantida como escopo considerável** — a revisão periódica adiciona complexidade de processo que não se justifica nesta fase de prototipação conceitual. Pode ser mencionada como possibilidade futura, mas não como mecanismo formal do modelo.
- Mitigação "IA utiliza hotspots especificamente na Clarificação de Conformidade": **absorvida** — descrita no item 3.

**Dependências:** Independente das outras mudanças. Habilita Mudança 11 (atualização de papéis).

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 6

---

### Mudança 7 — Edição direta do Domain Expert na camada de negócio

**Seções afetadas:** 2.2 (nova subseção), 4, 8.

**Descrição cirúrgica:**

1. **Nova subseção 2.2.6 — Edição Direta do Domain Expert.** Adicionar após a seção 2.2.5 (Guardrails) e antes da seção 2.3 (Etapa 2):
   > "#### 2.2.6 Edição Direta do Domain Expert
   >
   > O Domain Expert pode editar diretamente artefatos da camada de negócio da Product Canon — glossário, regras de negócio declarativas, requisitos formalizados e fluxos de domínio — fora do contexto de uma cerimônia formal. A edição direta é um canal complementar de manutenção, não de rotina, para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Novas funcionalidades, novos bounded contexts, novos fluxos de negócio e alterações conceituais significativas devem continuar passando pelas cerimônias formais.
   >
   > As salvaguardas que preservam a primazia das cerimônias formais são: (a) escopo limitado à camada de negócio — artefatos de arquitetura permanecem exclusivos do Architect; (b) natureza restrita a refinamentos e correções de artefatos existentes — conceitos inteiramente novos requerem cerimônia completa; (c) o Domain Expert propõe edições em linguagem natural ou formato livre, e a IA formaliza no formato canônico IEEE 29148 + SBE (ver Guardrail de Padronização Canônica na seção 2.2.5); (d) tipagem distinta do Change Plan (`expert-edit-plan`) permite auditoria e análise de frequência; (e) aprovação do Architect obrigatória e não delegável — diferente dos gates das cerimônias, onde a aprovação secundária é assíncrona com janela de veto, aqui o Architect deve aprovar ativamente, introduzindo fricção deliberada; (f) guardrails operam antes do Change Plan, não depois — divergências são resolvidas antes de o artefato ser empacotado para aprovação. Se a proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` crescer excessivamente, é sinal detectável de que o processo formal está sendo contornado.
   >
   > O fluxo operacional da edição direta é descrito nas subseções seguintes."

   Obs: As subseções do fluxo operacional (guardrails pré-Change Plan e `expert-edit-plan`) são tratadas nas Mudanças 8 e 9.

2. **Seção 8 (Princípios de Design — Governança por cerimônia).** Substituir:
   > "**Governança por cerimônia.** O conhecimento da Product Canon é construído e modificado exclusivamente através de cerimônias formais (Domain Discovery, Technical Constitution, Requirements Specification), cada uma com saída padronizada (Canonical Change Plan), gate de aprovação e rastreabilidade. Na prática, isso significa que toda mudança no corpo de conhecimento do produto passa por um processo formal, garantindo que nada é alterado silenciosamente."
   
   Por:
   > "**Governança por cerimônia com canal de exceção.** O conhecimento da Product Canon é construído e modificado primariamente através de cerimônias formais (Domain Discovery, Technical Constitution, Requirements Specification), cada uma com saída padronizada (Canonical Change Plan), gate de aprovação e rastreabilidade. Para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias, o Domain Expert dispõe de um canal de exceção — edição direta na camada de negócio (seção 2.2.6) — com salvaguardas que preservam a primazia das cerimônias: escopo restrito a refinamentos, tipagem distinta para auditoria, e aprovação obrigatória do Architect. Na prática, isso significa que toda mudança no corpo de conhecimento do produto passa por um processo formal — seja cerimônia ou edição direta com guardrails — garantindo que nada é alterado silenciosamente."

3. **Seção 4 (Papéis).** Tratada na Mudança 11.

**Tratamento de mitigações de risco:**
- Mitigação "escopo restrito + aprovação sequencial + tipagem distinta": **absorvida** — são as salvaguardas listadas no item 1.
- Mitigação "Architects designados por bounded context distribuem carga": **mantida como escopo considerável** — é uma recomendação operacional que depende da organização, não uma mudança no modelo. Pode ser mencionada como nota, mas não como parte da mecânica.
- Mitigação "Relatório de Conformidade explicita impactos": **absorvida** como parte da Mudança 8.

**Dependências:** Requer Mudança 5 (Padronização Canônica). Habilita Mudanças 8 e 9.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 7

---

### Mudança 8 — Fluxo de guardrails pré-Change Plan na edição direta

**Seções afetadas:** nova subseção dentro de 2.2.6.

**Descrição cirúrgica:**

1. **Nova subseção dentro de 2.2.6 — Fluxo de Guardrails na Edição Direta.** Adicionar como parte da seção 2.2.6 criada na Mudança 7:
   > "Quando o Domain Expert propõe uma edição direta, um ciclo iterativo de guardrails opera antes da geração de qualquer Canonical Change Plan:
   >
   > 1. O Domain Expert propõe a alteração em linguagem natural ou formato livre.
   > 2. A IA executa simultaneamente todos os mecanismos de validação — Clarificação de Conformidade (alinhamento terminológico), validação semântica interna (incluindo SBVR, para ambiguidade e incompletude), Validação de Consistência (contradições com regras existentes) — e o Guardrail de Padronização Canônica (reescrita no formato IEEE 29148 + SBE).
   > 3. A IA apresenta ao Domain Expert: perguntas de clarificação em linguagem natural; a versão formalizada como proposta (não como alteração consumada); e um Relatório de Conformidade consolidando divergências, contradições e impactos em bounded contexts adjacentes.
   > 4. O Domain Expert decide: aceitar a formalização, solicitar ajustes, responder perguntas de clarificação, ou reescrever a edição original e submeter novamente.
   > 5. O ciclo se repete até que o Domain Expert aceite a versão formalizada e as divergências sejam resolvidas ou explicitamente justificadas.
   >
   > O Relatório de Conformidade pode assumir forma estática (documento estruturado) ou forma conversacional (sessão interativa), à escolha do Domain Expert. Somente após a conclusão do ciclo, o `expert-edit-plan` é gerado."

**Tratamento de mitigações de risco:**
- Mitigação "Domain Expert tem controle total sobre o ciclo": **absorvida** — descrita no passo 4.
- Mitigação "divergências não resolvidas flagradas no Change Plan": **absorvida** — tratada na Mudança 9 (conteúdo do `expert-edit-plan`).
- Mitigação do risco de qualidade de formalização (9.9): **absorvida** — o ciclo iterativo é a mitigação.

**Dependências:** Requer Mudança 7 (subseção 2.2.6 criada) e Mudança 5 (Padronização Canônica). Habilita Mudança 9.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 8

---

### Mudança 9 — Novo tipo `expert-edit-plan` com aprovação sequencial

**Seções afetadas:** nova subseção dentro de 2.2.6, seção 5.

**Descrição cirúrgica:**

1. **Nova subseção dentro de 2.2.6 — `expert-edit-plan` e Aprovação Sequencial.** Adicionar como continuação da seção 2.2.6, após o fluxo de guardrails:
   > "A saída do processo de edição direta é um Canonical Change Plan tipado como `expert-edit-plan`, contendo: a versão final formalizada em IEEE 29148 + SBE; o Relatório de Conformidade final; divergências intencionais flagradas; e impactos em bounded contexts adjacentes.
   >
   > O `expert-edit-plan` requer aprovação sequencial com ordem fixa:
   > 1. **Domain Expert** aprova primeiro — valida que a formalização IEEE 29148 + SBE contida no Change Plan preserva fielmente a intenção original. Embora o Domain Expert já tenha revisado a formalização no ciclo iterativo de guardrails, esta aprovação mitiga o risco de que a IA, ao consolidar o Change Plan, tenha alterado o significado.
   > 2. **Architect** aprova depois — avalia impacto técnico: dependências cross-context, impacto em eventos de domínio, violação de princípios técnicos constitucionais, necessidade de novos ADRs, e impacto em requisitos não-funcionais. A aprovação do Architect é obrigatória e não delegável.
   >
   > A ordem é derivada da lógica do modelo: fidelidade semântica é pré-requisito para avaliação técnica. A tipagem distinta (`expert-edit-plan`) permite auditoria de frequência — crescimento excessivo da proporção de `expert-edit-plan` em relação a `specification-plan` e `discovery-plan` sinaliza contorno do processo formal."

2. **Seção 5 (Estrutura de Artefatos).** Na lista de Canonical Change Plans com envelope tipado, adicionar:
   > "`expert-edit-plan` — planos de mudança originados por edição direta do Domain Expert"

3. **Seção 2.3.3 (Canonical Change Plans).** Mencionar o `expert-edit-plan` como quarto tipo na descrição geral dos Change Plans, se houver texto descritivo dos tipos.

**Tratamento de mitigações de risco:**
- Mitigação "segunda aprovação opera sobre artefato consolidado": **absorvida** — descrita no item 1 (justificativa da aprovação do Domain Expert).
- Mitigação "tooling pode destacar diferenças": **mantida como escopo considerável** — é uma recomendação de implementação, não uma mudança conceitual no modelo.
- Mitigação do risco de fadiga de aprovação dupla (9.10): **mantida como escopo considerável** — o risco é real e a mitigação (abreviação para edições triviais) é pragmática, mas especulativa nesta fase. Pode ser mencionada como nota no texto, sem formalizar como mecanismo.

**Dependências:** Requer Mudanças 7 e 8. Habilita Mudança 11.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 9

---

### Mudança 10 — Revisão do fluxo da Requirements Specification Session

**Seções afetadas:** 2.2.3.

**Descrição cirúrgica:**

1. **Seção 2.2.3 — primeiro parágrafo.** Substituir:
   > "A Requirements Specification Session é uma cerimônia conversacional de formalização semântica de requisitos, utilizando SBVR (Semantics of Business Vocabulary and Business Rules) para vocabulário e regras de negócio declarativas, e SBE (Specification by Example) para critérios de aceitação verificáveis. A cerimônia opera sem fases rígidas, seguindo diretrizes de condução."
   
   Por:
   > "A Requirements Specification Session é uma cerimônia conversacional de formalização de requisitos, produzindo requisitos no formato IEEE 29148 com critérios de aceitação SBE (Specification by Example). A cerimônia opera em dois níveis — regra individual e documento — sem fases rígidas, seguindo diretrizes de condução."

2. **Seção 2.2.3 — segundo parágrafo (fluxo).** Substituir:
   > "O Domain Builder descreve requisitos em linguagem natural. A IA traduz para SBVR controlado e apresenta a formalização para validação do Domain Builder. O objetivo é produzir requisitos que sejam simultaneamente compreensíveis por pessoas de negócio e formalmente precisos o suficiente para consumo por agentes de IA."
   
   Por:
   > "No nível de regras individuais: (1) o Domain Builder descreve o requisito em linguagem natural; (2) a IA ativa simultaneamente todos os mecanismos de validação — Clarificação de Conformidade, validação semântica interna (incluindo SBVR), Validação de Consistência, Padronização Canônica; (3) a IA consolida problemas detectados e apresenta perguntas de clarificação em linguagem natural; (4) o Domain Builder refina o requisito em ciclo iterativo; (5) a IA formaliza o requisito no formato canônico IEEE 29148 + SBE; (6) o Domain Builder valida o resultado em linguagem natural estruturada. No nível de documento: ao final da sessão, a IA utiliza a taxonomia IEEE 29148 para verificar completude estrutural do conjunto de requisitos, sinalizando categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) — como sinalização, não como bloqueio. O objetivo é produzir requisitos simultaneamente compreensíveis por pessoas de negócio e formalmente precisos para consumo por agentes de IA."

3. **Seção 2.2.3 — terceiro parágrafo (habilitação e saída).** Substituir:
   > "A saída é um Canonical Change Plan tipado como `specification-plan`, contendo regras de negócio em SBVR e critérios de aceitação em SBE."
   
   Por:
   > "A saída é um Canonical Change Plan tipado como `specification-plan`, contendo requisitos em formato IEEE 29148 + SBE."

   Manter intacta a mecânica de aprovação (primária Domain Expert, secundária Architect).

4. **Seção 2.2.3 — exemplo de mediação SBVR.** Substituir o exemplo inteiro:
   > "**Exemplo — mediação SBVR.** O Domain Builder descreve: 'O cliente deve poder cancelar um pedido antes do faturamento.' A IA traduz para SBVR controlado: 'É obrigatório que cada Pedido cujo Status é Pendente ou Confirmado possa ser cancelado pelo Cliente titular. É proibido que um Pedido cujo Status é Faturado seja cancelado.' O Domain Builder valida a formalização, e a IA identifica — consultando a Product Canon — que já existe uma regra de negócio declarada: 'Pedidos faturados não podem ser cancelados, apenas devolvidos.' A formalização é ajustada para incluir o caminho de devolução como alternativa."
   
   Por:
   > "**Exemplo — clarificação e formalização.** O Domain Builder descreve: 'O cliente deve poder cancelar um pedido antes do faturamento.' A IA, utilizando validação semântica interna, detecta que a expressão não define o que 'antes do faturamento' significa em termos de status do pedido, e apresenta uma pergunta de clarificação: 'Quais status de pedido permitem cancelamento? Apenas Pendente, ou também Confirmado?' O Domain Builder esclarece: 'Pendente e Confirmado.' A IA, consultando a Product Canon, identifica que já existe uma regra: 'Pedidos faturados não podem ser cancelados, apenas devolvidos.' A IA apresenta essa regra e sugere incluir o caminho de devolução. O requisito é formalizado em IEEE 29148 + SBE:
   >
   > **REQ-CANCEL-001** | Tipo: Funcional | Contexto: Pedidos | Prioridade: Alta  
   > *O sistema deve permitir que o Cliente titular cancele um Pedido cujo status é Pendente ou Confirmado. Pedidos com status Faturado não podem ser cancelados — o caminho alternativo é a devolução (ver REQ-RETURN-003).*  
   > **Cenário SBE:** Dado um Pedido com status 'Confirmado' pertencente ao Cliente titular / Quando o Cliente solicita cancelamento / Então o status do Pedido muda para 'Cancelado' e o evento PedidoCancelado é emitido."

**Tratamento de mitigações de risco:**
- Mitigação "IA consolida e prioriza observações": **absorvida** — descrita no passo 3 do fluxo (item 2).
- Mitigação "verificação de completude opera como sinalização, não bloqueio": **absorvida** — descrita explicitamente no item 2.
- Mitigação "nível de aderência limita categorias obrigatórias": **absorvida** — referência à Mudança 3.

**Dependências:** Requer Mudanças 1, 2, 4 e 5. Habilita Mudança 12.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 10

---

### Mudança 11 — Atualização da tabela de papéis (seção 4)

**Seções afetadas:** 4.

**Descrição cirúrgica:**

1. **Seção 4 (Domain Expert).** Já atualizado na Mudança 6 (item 1). Adicionalmente, adicionar ao final da descrição do Domain Expert:
   > "Ganha capacidade de edição direta na camada de negócio da Product Canon (seção 2.2.6), propondo refinamentos e correções fora do contexto de cerimônias formais, com aprovação sequencial obrigatória (Domain Expert → Architect)."

2. **Seção 4 (Architect).** Adicionar ao final da descrição:
   > "Aprova obrigatoriamente e sem delegação cada `expert-edit-plan` originado por edição direta do Domain Expert, com foco no impacto técnico."

3. **Seção 4 (IA — atos operacionais).** Já tratado na Mudança 1 (item 4). Adicionalmente, adicionar:
   > "conduzir o ciclo iterativo de guardrails na edição direta do Domain Expert"

4. **Seção 4 (tabela de atuação por etapa).** Adicionar uma nova coluna "Edição Direta" à tabela:

   | Papel | ... (colunas existentes) | Edição Direta |
   |-------|--------------------------|---------------|
   | Domain Builder | ... | — |
   | Architect | ... | Aprova `expert-edit-plan` (obrigatório, não delegável) |
   | Domain Expert | ... | Edita camada de negócio; resolve divergências com IA; aprova Change Plan consolidado |
   | IA (Agentes LLM) | ... | Conduz ciclo de guardrails; formaliza em IEEE 29148 + SBE; gera `expert-edit-plan` |

   Nas colunas existentes de Etapa 1 e Etapa 2, atualizar as células do Domain Expert para incluir "(com anotações e hotspots)" na descrição de aprovação.

**Tratamento de mitigações de risco:**
- Mitigação "revisão cruzada para garantir consistência": **absorvida** — é procedimento de implementação, não conteúdo do modelo.

**Dependências:** Reflete Mudanças 1, 6, 7 e 9. Deve ser implementada após essas.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 11

---

### Mudança 12 — Atualização dos cenários (seção 6), diagrama (seção 3) e dores (seção 7)

**Seções afetadas:** 3, 6.1, 7.

**Descrição cirúrgica:**

1. **Seção 3 (Diagrama do Ciclo Completo).** Na caixa da Requirements Specification Session, substituir:
   > "Domain Builder + IA (SBVR + SBE)"
   
   Por:
   > "Domain Builder + IA (IEEE 29148 + SBE)"

   Na caixa de Guardrails ao final da Etapa 1, substituir:
   > "Guardrails: Clarificação de Conformidade, Validação de Consistência, Versionamento por Estrangulamento"
   
   Por:
   > "Guardrails: Clarificação de Conformidade, Validação de Consistência, Padronização Canônica, Validação Semântica Interna, Versionamento por Estrangulamento"

   Considerar adicionar uma caixa representando a Edição Direta do Domain Expert como canal complementar conectado à Product Canon, fora do fluxo principal das 3 etapas.

2. **Seção 6.1 (Greenfield — passo 3).** Substituir:
   > "Na Requirements Specification Session, utilizando SBVR + SBE mediado pela IA, os requisitos de cada contexto são formalizados e validados. O Domain Builder descreve os requisitos em linguagem natural, e a IA traduz para SBVR controlado, apresentando a formalização para validação."
   
   Por:
   > "Na Requirements Specification Session, os requisitos de cada contexto são formalizados utilizando o processo de clarificação iterativa mediado pela IA. O Domain Builder descreve os requisitos em linguagem natural; a IA utiliza validação semântica interna para detectar ambiguidades e incompletudes, apresentando perguntas de clarificação em linguagem natural. Os requisitos são formalizados em IEEE 29148 + SBE, com nível de aderência Mínimo (adequado ao estágio de prototipação do produto)."

   Manter intacto o restante do passo 3 (gaps identificados, etc.).

3. **Seção 7 (Dores Endereçadas).** Na linha "Domain Builders excluídos do processo de especificação", substituir a coluna "Como o ZionKit endereça":
   > "As cerimônias de Domain Discovery e Requirements Specification permitem que Domain Builders participem, descrevendo o negócio em linguagem natural. Na Requirements Specification, a IA traduz para SBVR controlado"
   
   Por:
   > "As cerimônias de Domain Discovery e Requirements Specification permitem que Domain Builders participem, descrevendo o negócio em linguagem natural. A IA utiliza validação semântica interna para garantir rigor, e formaliza os requisitos em IEEE 29148 + SBE — formato compreensível por pessoas de negócio"

**Tratamento de mitigações de risco:**
- Mitigação "busca textual completa por SBVR": **absorvida** — é procedimento de verificação, tratado na seção 7 (Checklist de Verificação Final).

**Dependências:** Reflete Mudanças 1, 2, 4, 5 e 10. Deve ser implementada após essas.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 12

---

### Mudança 13 — Revisão da prioridade de prototipação 6

**Seções afetadas:** 10 (prioridade 6).

**Descrição cirúrgica:**

1. **Seção 10, prioridade 6.** Substituir integralmente:
   > "6. **Formalização SBVR + SBE mediada pela IA.** Testar se: (a) a IA consegue traduzir linguagem natural do Domain Builder para SBVR controlado com fidelidade; (b) o Domain Builder consegue compreender e validar o resultado SBVR; (c) SBE produz critérios de aceitação verificáveis. Risco a monitorar: efeito 'rubber stamp' na validação."
   
   Por:
   > "6. **Validação SBVR como motor interno de clarificação.** Testar se: (a) a IA consegue usar SBVR internamente para detectar ambiguidades, incompletudes e contradições em requisitos em linguagem natural; (b) a IA consegue traduzir os problemas detectados pela validação SBVR em perguntas de clarificação claras e acionáveis em linguagem natural; (c) o processo de clarificação produz requisitos IEEE 29148 + SBE mais completos e consistentes do que sem a validação SBVR. Métrica principal: taxa de problemas detectados pela validação SBVR que resultam em mudanças efetivas no requisito final."

**Tratamento de mitigações de risco:** Nenhuma mitigação a tratar — esta mudança é autossuficiente.

**Dependências:** Reflete Mudança 1.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 13

---

### Mudança 14 — Nova prioridade de prototipação 8: Padronização Canônica

**Seções afetadas:** 10.

**Descrição cirúrgica:**

1. **Seção 10.** Adicionar prioridade 8 após a prioridade 7 existente:
   > "8. **Guardrail de Padronização Canônica.** Testar se a IA consegue formalizar corretamente edições em linguagem natural para o formato canônico IEEE 29148 + SBE (com classificação conforme nível de aderência configurado), preservando o significado original. Métrica: taxa de aceitação pelo Domain Expert na primeira tentativa de formalização versus necessidade de ciclos iterativos. Validar também se o guardrail opera corretamente nos artefatos produzidos por cerimônias (modo implícito)."

**Tratamento de mitigações de risco:** Nenhuma mitigação a tratar — esta mudança é autossuficiente.

**Dependências:** Reflete Mudança 5.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 14

---

### Mudança 15 — Nova prioridade de prototipação 9: edição direta

**Seções afetadas:** 10.

**Descrição cirúrgica:**

1. **Seção 10.** Adicionar prioridade 9 após a prioridade 8:
   > "9. **Edição direta do Domain Expert com aprovação sequencial.** Testar o fluxo completo: Domain Expert edita em formato livre → guardrails validam e formalizam em IEEE 29148 + SBE → Domain Expert revisa no ciclo iterativo → `expert-edit-plan` gerado → Domain Expert aprova o Change Plan consolidado → Architect avalia impacto técnico. Avaliar: (a) se a segunda aprovação do Domain Expert no Change Plan agrega valor real ou é percebida como burocracia; (b) se a ordem sequencial (Domain Expert antes do Architect) elimina retrabalho; (c) se o Domain Expert consegue identificar diferenças entre o que revisou no ciclo iterativo e o artefato consolidado final; (d) se o processo é percebido como facilitador ou como burocracia; (e) testar ambas as formas do Relatório de Conformidade (estática e conversacional)."

**Tratamento de mitigações de risco:** Nenhuma mitigação a tratar — esta mudança é autossuficiente.

**Dependências:** Reflete Mudanças 7, 8 e 9. Deve ser executada após prioridade 8 (Mudança 14).

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 15

---

### Mudança 16 — Nova prioridade de prototipação 10: taxonomia IEEE 29148

**Seções afetadas:** 10.

**Descrição cirúrgica:**

1. **Seção 10.** Adicionar prioridade 10 após a prioridade 9:
   > "10. **Taxonomia IEEE 29148 na Requirements Specification Session.** Testar se: (a) a IA consegue guiar Domain Builder e Architect pelas categorias IEEE 29148 sem que o processo pareça burocrático; (b) a sinalização de categorias não cobertas (requisitos não-funcionais, interfaces, restrições de design) produz requisitos que teriam sido omitidos sem o guia; (c) a aderência adaptativa funciona na prática — projetos em fase inicial aceitam seções 'pendente' sem pressão artificial de preenchimento; (d) os três níveis de aderência são percebidos como proporcionais e não arbitrários; (e) a progressão de nível Mínimo para Moderado acontece naturalmente conforme a Product Canon cresce."

**Tratamento de mitigações de risco:** Nenhuma mitigação a tratar — esta mudança é autossuficiente.

**Dependências:** Reflete Mudanças 2, 3 e 10.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 16

---

### Mudança 17 — Tríade de padrões oficiais do ZionKit v0.6

**Seções afetadas:** nova subseção antes de 2.1, Resumo Executivo.

**Descrição cirúrgica:**

1. **Nova subseção antes de 2.1.** Adicionar uma subseção introdutória ao modelo, posicionada entre o parágrafo introdutório da seção 2 e a subseção 2.1 (Product Canon). Sugestão de numeração: incluir como parte da introdução da seção 2, sem numeração própria, ou como subseção 2.0:
   > "O ZionKit v0.6 opera com uma tríade formal de padrões oficiais com papéis e visibilidades distintas:
   >
   > - **SBVR (Semantics of Business Vocabulary and Business Rules)** — motor interno de validação semântica (invisível ao participante). Responsável por detectar ambiguidade, incompletude, contradição e redundância na expressão individual de requisitos. A IA utiliza SBVR internamente como metodologia principal de validação, mas não exclusiva — outras metodologias de validação podem ser utilizadas desde que os resultados sejam apresentados em linguagem natural.
   > - **IEEE 29148 (ISO/IEC/IEEE 29148:2018)** — formato canônico de estrutura (visível ao participante). Responsável por organizar requisitos com tipo, identificador, rastreabilidade e classificação, cobrindo categorias que o SBVR não alcança (requisitos não-funcionais, interfaces, restrições de design). A aderência ao IEEE 29148 é adaptativa, com três níveis (Mínimo, Moderado, Completo) definidos pelo Architect.
   > - **SBE (Specification by Example)** — formato canônico de verificação (visível ao participante). Responsável por transformar cada requisito em cenários concretos (Dado/Quando/Então) compreensíveis por pessoas de negócio e executáveis como testes. Obrigatório em todos os níveis de aderência.
   >
   > Cada padrão tem responsabilidade única e delimitada: SBVR detecta, IEEE 29148 estrutura, SBE verifica. O formato canônico visível nos artefatos da Product Canon e nos Canonical Change Plans é IEEE 29148 + SBE."

2. **Resumo Executivo.** Atualizar para mencionar a tríade de padrões. No trecho que descreve o ciclo do modelo, substituir referências a SBVR como formato visível. Especificamente, revisar o parágrafo que menciona "Canon Building" para incluir menção ao formato canônico IEEE 29148 + SBE e à validação semântica interna. Atualizar a frase:
   > "criação de especificações contextualizadas com um Canonical Change Plan incremental aprovado condicionalmente"
   
   Para incluir referência ao formato canônico, se natural. Manter o resumo conciso — a tríade é detalhada na seção 2.

**Tratamento de mitigações de risco:**
- Mitigação "formulação deve explicitar que SBVR não é exclusivo": **absorvida** — descrita no item 1 ("mas não exclusiva").
- Mitigação "referência à Mudança 1 sobre extensibilidade": **absorvida** — a extensibilidade está implícita em "outras metodologias podem ser utilizadas".

**Dependências:** Consolida conceitualmente as Mudanças 1, 2 e 3. Deve ser implementada como uma das primeiras mudanças para estabelecer a referência conceitual.

**Ref:** plan-refin-change-zionkit-model-0.6.md → Mudança 17

---

## 4. Mudanças de Formato/Estrutura do Documento

### 4.1 Nova subseção introdutória na seção 2 (tríade de padrões)

**Justificativa:** A v0.5 menciona SBVR e SBE dispersamente sem uma formulação unificada. A v0.6 introduz IEEE 29148 como terceiro padrão e reposiciona SBVR. Uma subseção dedicada antes da 2.1 consolida a arquitetura de padrões como conceito de primeira classe.

**Posicionamento:** Após o parágrafo introdutório da seção 2 ("O ZionKit resolve os problemas descritos acima...") e antes da subseção 2.1 (Product Canon).

### 4.2 Nova subseção 2.2.6 (Edição Direta do Domain Expert)

**Justificativa:** A edição direta é um canal complementar de governança que não se encaixa em nenhuma cerimônia existente nem na Etapa 2. Posicioná-la como 2.2.6 — dentro da Etapa 1 (Canon Building) mas após os Guardrails — reflete que é um mecanismo de manutenção da Product Canon, não de especificação de feature.

**Conteúdo:** Descrição do canal, salvaguardas, fluxo de guardrails pré-Change Plan, `expert-edit-plan` e aprovação sequencial (Mudanças 7, 8 e 9 consolidadas).

### 4.3 Reestruturação da seção 9 (Riscos)

**Justificativa:** A seção 9 da v0.5 contém riscos que são eliminados (9.6), reformulados ou expandidos. A v0.6 deve refletir o novo panorama de riscos.

**Alterações:**
- **9.6** — eliminado ("Curva de aprendizado SBVR") e substituído por "Qualidade da tradução de validação interna para linguagem natural" (Mudança 1).
- Manter intactos os riscos 9.1 a 9.5 e 9.7, exceto ajustes pontuais de terminologia (ex: referências a SBVR como formato visível em 9.1 devem ser revisadas).
- Não adicionar novos riscos além do 9.6 reformulado — os riscos das Mudanças 6–9 (edição direta, fadiga de aprovação) são tratados nas seções descritivas das próprias mudanças e nas prioridades de prototipação.

### 4.4 Expansão da seção 10 (Prototipação)

**Justificativa:** A v0.6 adiciona 3 prioridades (8, 9, 10) e reformula a prioridade 6. A seção expande de 7 para 10 prioridades.

### 4.5 Coluna adicional na tabela de papéis (seção 4)

**Justificativa:** A edição direta cria uma nova dimensão de atuação para Domain Expert, Architect e IA que não cabe nas colunas existentes (Etapa 1, Etapa 2, Etapa 3).

### 4.6 Atualização do diagrama do Ciclo Completo (seção 3)

**Justificativa:** O diagrama deve refletir a tríade de padrões, os novos guardrails e o canal de edição direta.

---

## 5. Ordem de Implementação Sugerida

A ordem respeita dependências entre mudanças e prioriza fundações conceituais antes de mecanismos operacionais.

### Fase A — Fundações de padrões (sem dependências externas)

| Ordem | Mudança | Justificativa |
|-------|---------|---------------|
| A1 | **17** — Tríade de padrões | Estabelece a referência conceitual para todas as mudanças subsequentes |
| A2 | **1** — SBVR interno | Fundação conceitual: remove SBVR como formato visível |
| A3 | **2** — IEEE 29148 | Preenche a lacuna deixada pelo SBVR com o novo padrão de estruturação |
| A4 | **3** — Aderência adaptativa | Qualifica a adoção do IEEE 29148 com proporcionalidade |
| A5 | **4** — Formato canônico | Materializa a troca de formato nos artefatos |

### Fase B — Guardrails e cerimônias (requer Fase A)

| Ordem | Mudança | Justificativa |
|-------|---------|---------------|
| B1 | **5** — Padronização Canônica | Novo guardrail necessário antes da edição direta |
| B2 | **10** — Revisão Requirements Specification Session | Materializa as Mudanças 1–5 na cerimônia central |

### Fase C — Expansão do Domain Expert (requer Fase B)

| Ordem | Mudança | Justificativa |
|-------|---------|---------------|
| C1 | **6** — Anotações e hotspots | Independente, mas logicamente precede a edição direta |
| C2 | **7** — Edição direta | Canal complementar de governança |
| C3 | **8** — Fluxo de guardrails pré-Change Plan | Operacionaliza a edição direta |
| C4 | **9** — `expert-edit-plan` | Materializa o artefato de saída da edição direta |

### Fase D — Consolidação (requer todas as anteriores)

| Ordem | Mudança | Justificativa |
|-------|---------|---------------|
| D1 | **11** — Tabela de papéis | Consolida todas as mudanças de papéis |
| D2 | **12** — Cenários, diagrama, dores | Atualiza seções derivadas |
| D3 | **13** — Revisão prioridade 6 | Atualiza prototipação |
| D4 | **14** — Nova prioridade 8 | Adiciona prototipação |
| D5 | **15** — Nova prioridade 9 | Adiciona prototipação |
| D6 | **16** — Nova prioridade 10 | Adiciona prototipação |

### Fase E — Limpeza e verificação

| Ordem | Ação | Justificativa |
|-------|------|---------------|
| E1 | Reestruturação da seção 9 (Riscos) | Elimina 9.6 antigo, adiciona 9.6 reformulado |
| E2 | Revisão do Resumo Executivo | Alinha com tríade de padrões |
| E3 | Busca textual por resíduos | Verificação final |
| E4 | Atualização de metadados | Versão 0.6, data |

---

## 6. Checklist de Verificação Final

Após implementação de todas as mudanças, executar as seguintes verificações:

### 6.1 Eliminação de resíduos SBVR visível

- [ ] Busca textual por "SBVR" em todo o documento. Toda ocorrência deve estar qualificada como "interno", "validação interna", "motor interno" ou equivalente. Nenhuma ocorrência deve apresentar SBVR como formato visível ao usuário, formato de armazenamento ou formato de saída de cerimônias.
- [ ] Busca textual por "traduz para SBVR", "traduzir para SBVR", "notação SBVR", "formato SBVR". Nenhuma dessas expressões deve existir no documento v0.6.
- [ ] Verificar que o exemplo da seção 2.2.3 não contém notação SBVR ("É obrigatório que...", "É proibido que...").
- [ ] Verificar que o diagrama da seção 3 não contém "SBVR + SBE" como formato visível.

### 6.2 Presença dos novos conceitos

- [ ] Tríade de padrões descrita em subseção dedicada na seção 2.
- [ ] IEEE 29148 mencionado como formato canônico de estrutura em: 2.1, 2.2.3, 5, 6.1, 7.
- [ ] Três níveis de aderência (Mínimo/Moderado/Completo) descritos em 2.2.2.
- [ ] Guardrail de Padronização Canônica descrito em 2.2.5.
- [ ] Anotações contextuais e hotspots de domínio descritos na seção 4 (Domain Expert).
- [ ] Edição direta descrita em subseção 2.2.6.
- [ ] `expert-edit-plan` listado na seção 5 e descrito em 2.2.6.
- [ ] Prioridades de prototipação 8, 9 e 10 presentes na seção 10.
- [ ] Prioridade 6 reformulada na seção 10.

### 6.3 Coesão documental

- [ ] Princípio "Governança por cerimônia" na seção 8 qualificado com canal de exceção.
- [ ] Risco 9.6 substituído (não contém "Curva de aprendizado SBVR").
- [ ] Tabela de papéis (seção 4) contém coluna "Edição Direta".
- [ ] Diagrama (seção 3) contém Padronização Canônica nos guardrails.
- [ ] Resumo Executivo alinhado com tríade de padrões.
- [ ] Todas as referências a "SBVR + SBE" como formato de saída substituídas por "IEEE 29148 + SBE".
- [ ] Nenhuma seção referencia o Domain Expert como papel exclusivamente passivo.
- [ ] Versão do documento atualizada para 0.6.

### 6.4 Consistência cruzada

- [ ] Seção 6 (cenários) consistente com seção 2 (modelo).
- [ ] Seção 7 (dores) consistente com seção 2 (modelo).
- [ ] Seção 3 (diagrama) consistente com seção 2 (modelo).
- [ ] Seção 4 (papéis) consistente com seções 2.2.6 (edição direta) e 2.2.5 (guardrails).
- [ ] Seção 9 (riscos) consistente com o panorama de riscos das mudanças implementadas.
- [ ] Seção 10 (prototipação) consistente com as capacidades introduzidas.

---

*Plano de implementação para evolução do ZionKit v0.5 → v0.6. Documento para consumo por LLM implementadora.*
