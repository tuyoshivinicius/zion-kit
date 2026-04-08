# Tarefas de Implementação — Atualização do Site ZionKit v0.6

**Gerado a partir de:** `docs/plan-change-site.md`
**Total de tarefas:** 38

## Legenda
- [ ] Pendente
- [x] Concluída
- 🔗 Dependência (não iniciar antes da tarefa indicada)
- ⚡ Paralelo (pode ser executada simultaneamente com as tarefas indicadas)

---

## Fase 1 — Correções de tom e conteúdo

### F1-01: Reescrever título e adicionar nota de protótipo na HeroSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/HeroSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-02, F1-03, F1-04, F1-05, F1-06, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.1, §2 item 1
- **Contexto:**
  Editar o título principal da HeroSection. Substituir o texto atual do título:
  ```
  O conhecimento do seu produto <span class="gradient-text">morre a cada sprint</span>
  ```
  Pelo novo texto:
  ```
  O conhecimento do seu produto <span class="gradient-text">está espalhado em lugares que a IA não alcança</span>
  ```
  Adicionar um parágrafo introdutório logo após o subtítulo existente, dentro de um `ScrollReveal`, mencionando o status de protótipo conceitual:
  > "O ZionKit é um modelo conceitual em fase de prototipação. Ainda não foi testado em ambiente de produção."
  
  Manter: narrativa sobre conhecimento fragmentado, exemplo do e-commerce/reembolso, diagrama ContextVoidDiagram. Depth: 1. `sectionNumber` permanece 1.
  
  **Regras da constituição relevantes:**
  - Princípio VII: seção deve ter `SectionHeader` com `sectionNumber`, `title`, `depth`
  - Princípio V: verificar `aria-labelledby` no container da seção
- **Verificação:**
  - [ ] Título não contém mais "morre a cada sprint"
  - [ ] Novo título contém "está espalhado em lugares que a IA não alcança" com `gradient-text`
  - [ ] Parágrafo de protótipo conceitual está presente e visível

---

### F1-02: Reescrever título e tratar dados estatísticos na ConsequenciasSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/ConsequenciasSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-03, F1-04, F1-05, F1-06, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.2, §2 item 2 e item 11
- **Contexto:**
  1. Substituir o título atual:
     ```
     Três problemas que <span class="gradient-text">ninguém resolveu</span>
     ```
     Pelo novo texto:
     ```
     Três problemas que <span class="gradient-text">persistem no desenvolvimento com IA</span>
     ```
  2. Tratar os 5 dados estatísticos:
     - **Manter (verificar fonte):** "35% dos defeitos de produção" (Accenture), "40% do esforço é retrabalho" (ScopeMaster), "56% das falhas por comunicação" (PMI) — estes citam fonte mas precisam de verificação
     - **Remover ou substituir:** "75% mais problemas de lógica em áreas críticas de negócio" (sem fonte) e "65% dos desenvolvedores reportam que a IA 'perde contexto relevante'" (sem fonte) — substituir por formulação qualitativa como "é comum que..." ou "frequentemente..."
  
  Manter: três problemas (IA no escuro, exclusão não-técnico, conhecimento perdido), exemplos ilustrativos, diagrama ThreeGapsDiagram. Depth: 1. `sectionNumber` permanece 2.
- **Verificação:**
  - [ ] Título não contém mais "ninguém resolveu"
  - [ ] Os 2 dados sem fonte foram removidos ou substituídos por formulação qualitativa
  - [ ] Os 3 dados com fonte permanecem (com fontes citadas)

---

### F1-03: Reescrever título, adicionar tríade e nota de IA na SolutionBridgeSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/SolutionBridgeSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-04, F1-05, F1-06, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.3, §2 item 3, §3.3
- **Contexto:**
  1. Substituir o título atual:
     ```
     E se todo o conhecimento do seu produto <span class="gradient-text">tivesse uma casa?</span>
     ```
     Pelo novo texto:
     ```
     Um repositório central para <span class="gradient-text">todo o conhecimento do produto</span>
     ```
  2. Adicionar parágrafo sobre a tríade de padrões oficiais, em linguagem acessível (dentro de `ScrollReveal` com delay incremental):
     > "O ZionKit se apoia em três padrões: um para estruturar requisitos (IEEE 29148), um para verificá-los com exemplos concretos (SBE), e um que a IA usa internamente para encontrar ambiguidades (SBVR)."
  3. Adicionar nota sobre papel da IA (dentro de `ScrollReveal`):
     > "A IA propõe e sinaliza — quem decide é sempre o humano."
  4. Integrar o princípio de design "A Product Canon é viva, não estática" na descrição da Product Canon — como nota contextual: "Este é um dos princípios de design do modelo: a Product Canon é viva, não estática — diferente de documentos tradicionais, ela é continuamente alimentada pelo uso."
  5. Manter analogia da constituição (boa).
  
  Depth: 1. `sectionNumber` permanece 3.
  
  **Regras da constituição relevantes:**
  - Princípio VII: conteúdo narrativo deve ser wrapped por `ScrollReveal` com delays incrementais (0, 0.15, 0.3, 0.45...)
- **Verificação:**
  - [ ] Título não contém mais "tivesse uma casa?"
  - [ ] Parágrafo da tríade SBVR/IEEE/SBE presente
  - [ ] Nota "A IA propõe e sinaliza" presente
  - [ ] Princípio "Product Canon é viva" integrado no texto

---

### F1-04: Reescrever título e atualizar step cards na CycleOverviewSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/CycleOverviewSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-05, F1-06, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.4, §2 item 4, §3.3
- **Contexto:**
  1. Substituir o título atual:
     ```
     O ciclo que faz o <span class="gradient-text">conhecimento crescer</span>
     ```
     Pelo novo texto:
     ```
     Como o ciclo de <span class="gradient-text">três etapas funciona</span>
     ```
  2. Atualizar os step cards com terminologia v0.6:
     - **Etapa 1 — Canon Building:** Mencionar que opera através de 3 cerimônias formais (Domain Discovery Session, Technical Constitution Session, Requirements Specification Session) com gates de aprovação entre elas
     - **Etapa 2 — Spec Crafting:** Mencionar que gera um Canonical Change Plan incremental (`incremental-plan`) com aprovação condicional
     - **Etapa 3 — Canon Enrichment:** Mencionar sinalização explícita (`CANON-DISCOVERY`) e detecção assistida pela IA
  3. Adicionar menção à Decisão de Continuidade do Ciclo (ponto de decisão ao final do Canon Building com 3 caminhos: mais fluxos, mais requisitos, encerrar)
  4. Adicionar menção ao canal de Edição Direta do Domain Expert como canal complementar
  5. Integrar princípio "O ciclo é bidirecional" na narrativa: "Este é um dos princípios de design do modelo: o ciclo é bidirecional — informação flui da Product Canon para as especificações e das especificações de volta para a Product Canon."
  
  Depth: 1. `sectionNumber` permanece 4.
- **Verificação:**
  - [ ] Título atualizado para "Como o ciclo de três etapas funciona"
  - [ ] Step cards mencionam terminologia v0.6 (cerimônias, Change Plan incremental, sinalização explícita)
  - [ ] Decisão de Continuidade mencionada
  - [ ] Edição Direta mencionada como canal complementar

---

### F1-05: Reescrever título, atualizar papéis e adicionar Protocolo de Perspectiva Assistida na RolesSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/RolesSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-04, F1-06, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.5, §2 itens 9 e 10, §3.3
- **Contexto:**
  1. Substituir o título atual:
     ```
     Cada decisão é tomada por quem tem <span class="gradient-text">competência sobre ela</span>
     ```
     Pelo novo texto:
     ```
     Quatro papéis com <span class="gradient-text">autoridades complementares</span>
     ```
  2. Atualizar descrição do **Domain Expert** — adicionar:
     - Capacidade de anotações contextuais (observações que adiciona durante revisão de Change Plans, com ciclo de vida: formalizar, descartar ou adiar)
     - Hotspots de domínio (áreas marcadas como frágeis ou frequentemente mal interpretadas; a IA dá atenção especial na validação)
     - Edição direta de artefatos na camada de negócio (fora de cerimônias formais)
  3. Atualizar descrição da **IA** — adicionar distinção explícita entre atos operacionais e decisórios:
     - **Operacional** (permitido): formatar, sugerir, reorganizar, sinalizar inconsistência, usar validação semântica interna, conduzir guardrails
     - **Decisório** (requer humano): incluir/excluir da Product Canon, aprovar Change Plan, resolver ambiguidade
  4. Corrigir analogia da IA. Substituir:
     > "A secretária mais competente do mundo — organiza, lembra, sinaliza, mas nunca assina pelo chefe."
     
     Por:
     > "Uma assistente que organiza, lembra e sinaliza — mas nunca decide pelo responsável."
  5. Adicionar bloco sobre **Protocolo de Perspectiva Assistida** (acúmulo de papéis). Conteúdo:
     > Em equipes pequenas, uma mesma pessoa pode exercer múltiplos papéis. O valor da separação está na completude das perspectivas exercidas. O Protocolo de Perspectiva Assistida governa o acúmulo:
     > 1. **Declaração explícita** — o acúmulo é declarado na configuração do projeto, ativando comportamento diferenciado da IA
     > 2. **Checklist de perspectiva mediado pela IA** — quando a mesma pessoa aprova em papéis distintos, a IA apresenta perguntas específicas da perspectiva do papel sendo exercido. As perguntas variam com base no conteúdo específico do Change Plan
     > 3. **Registro distinto por papel-perspectiva** — cada aprovação registra o papel exercido, mesmo que a pessoa seja a mesma
  6. Adicionar **tabela resumo de atuação por etapa** (do v0.6 §4):
  
     | Papel | Etapa 1 — Canon Building | Etapa 2 — Spec Crafting | Etapa 3 — Canon Enrichment | Edição Direta |
     |-------|--------------------------|-------------------------|----------------------------|---------------|
     | Domain Builder | Participa de Discovery e Specification; decide continuidade | Escreve spec de feature | — | — |
     | Architect | Conduz Technical Constitution; aprova gates | Decisões técnicas; aprova camada de arquitetura | Revisão assíncrona (janela de veto) | Aprova `expert-edit-plan` (obrigatório) |
     | Domain Expert | Aprova Discovery e Specification (com anotações e hotspots) | Aprova camada de negócio | Revisão assíncrona (janela de veto) | Edita e aprova `expert-edit-plan` (fidelidade) |
     | IA | Conduz sessões, gera Change Plans, opera guardrails | Gera Change Plan incremental; implementa código | Atualiza Product Canon | Conduz guardrails; gera `expert-edit-plan` |
  
  7. Explicitar princípio "Separação de autoridade" como nota contextual: "Este é um dos princípios de design do modelo: separação de autoridade — cada decisão é validada por quem tem competência sobre ela. Nenhum dos quatro papéis substitui os outros."
  
  Depth: 2. `sectionNumber` será 9 na estrutura final (ver F4-04).
- **Verificação:**
  - [ ] Título atualizado para "Quatro papéis com autoridades complementares"
  - [ ] Analogia da IA não contém mais "mais competente do mundo"
  - [ ] Protocolo de Perspectiva Assistida presente com 3 mecanismos
  - [ ] Tabela de atuação por etapa presente

---

### F1-06: Adicionar 2 comparações novas na ComparisonSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/ComparisonSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-04, F1-05, F1-07, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.6
- **Contexto:**
  Adicionar 2 novos itens de comparação antes/depois, usando o componente `ComparisonRow` existente (`src/components/ui/ComparisonRow.astro`):
  
  1. **Antes:** "Conhecimento de domínio tácito, preso na cabeça de indivíduos"
     **Depois:** "Product Canon formaliza e versiona o conhecimento em documentos acessíveis a todos"
     (Referência v0.6 §7 item 1)
  
  2. **Antes:** "Revisão de código é o único momento de validação de qualidade"
     **Depois:** "Gates de aprovação operam antes da implementação, verificando coerência de negócio e viabilidade técnica"
     (Referência v0.6 §7 item 9)
  
  Manter todos os 7 itens de comparação existentes. `sectionNumber` será 13 na estrutura final (ver F4-04). Depth: 1.
  
  **Regras da constituição relevantes:**
  - Princípio VII: novos itens devem ser wrapped por `ScrollReveal` com delays incrementais continuando dos existentes
- **Verificação:**
  - [ ] 9 itens de comparação no total (7 existentes + 2 novos)
  - [ ] Textos dos novos itens estão exatamente como especificado

---

### F1-07: Enriquecer cenários com terminologia v0.6 na ScenariosSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/ScenariosSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-04, F1-05, F1-06, F1-08, F1-09
- **Referência no plano:** §4.1 item 1.7
- **Contexto:**
  Enriquecer os 3 cenários existentes com terminologia e detalhes do v0.6:
  
  **Cenário 1 — Greenfield (Produto Novo):**
  - Mencionar que o CTO conduz a Technical Constitution Session
  - Mencionar nível Mínimo de aderência IEEE 29148 (adequado ao estágio de prototipação)
  - Mencionar que cada cerimônia produz Canonical Change Plans tipados (`discovery-plan`, `constitution-plan`, `specification-plan`)
  - Mencionar gaps identificados pela IA ("O que acontece se nenhuma transportadora fizer oferta dentro de 24 horas?")
  
  **Cenário 2 — Brownfield (Feature em Produto Existente):**
  - Mencionar roteamento de aprovação por bounded context — o Canonical Change Plan incremental lista bounded contexts afetados e é roteado para os Domain Experts e Architects correspondentes
  - Mencionar Domain Expert de Faturamento identificando conflito com contrato de operadora de saúde existente
  
  **Cenário 3 — Mudança Conceitual com Migração Gradual:**
  - Mencionar faces `current` (estado vigente) e `next` (estado em transição) do Versionamento por Estrangulamento
  - Mencionar conclusão formal pelo Architect: "quando todas as dependências forem migradas, o Architect declara formalmente a conclusão da transição"
  
  `sectionNumber` será 14 na estrutura final (ver F4-04). Depth: 1.
- **Verificação:**
  - [ ] Cenário 1 menciona Technical Constitution, nível Mínimo, Change Plans tipados
  - [ ] Cenário 2 menciona roteamento por bounded context e Domain Expert de Faturamento
  - [ ] Cenário 3 menciona faces current/next e conclusão formal pelo Architect

---

### F1-08: Substituir CTA Banner por nota informativa
- [ ] **Status**
- **Arquivo(s):** `src/pages/index.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-04, F1-05, F1-06, F1-07, F1-09
- **Referência no plano:** §4.1 item 1.8, §2 itens 5 e 6
- **Contexto:**
  No arquivo `src/pages/index.astro`, substituir o bloco do CTA Banner (linhas 58-65):
  ```astro
  <div class="max-width-content">
    <CTABanner
      title="Experimente com seu produto"
      description="Aplique o modelo ZionKit ao seu produto e veja a diferença no primeiro ciclo."
      linkText="Reler desde o início"
      linkHref="#problema"
    />
  </div>
  ```
  Por uma nota informativa discreta usando o componente `CTABanner` com props atualizadas:
  ```astro
  <div class="max-width-content">
    <CTABanner
      title="Quer reler desde o início?"
      description="O ZionKit é um modelo conceitual em fase de prototipação. A leitura completa leva cerca de 15 minutos."
      linkText="Reler desde o início"
      linkHref="#problema"
    />
  </div>
  ```
  Remover o import de `CTABanner` se decidir usar HTML inline em vez do componente. Caso reutilize o componente, manter o import.
- **Verificação:**
  - [ ] Texto "Experimente com seu produto" removido
  - [ ] Texto "Aplique o modelo ZionKit ao seu produto e veja a diferença no primeiro ciclo" removido
  - [ ] Nota informativa presente com tom neutro/informativo

---

### F1-09: Reestruturar Footer — remover newsletter fake e atualizar tagline
- [ ] **Status**
- **Arquivo(s):** `src/components/layout/Footer.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F1-01, F1-02, F1-03, F1-04, F1-05, F1-06, F1-07, F1-08
- **Referência no plano:** §4.1 item 1.9, §2 itens 7 e 8
- **Contexto:**
  1. Alterar tagline (linha 9 do Footer.astro):
     - De: `"O conhecimento do seu produto, formalizado e versionado."`
     - Para: `"Modelo conceitual para desenvolvimento de software orientado por especificações."`
  2. Remover completamente o bloco `footer-newsletter` (div com classe `footer-newsletter`, incluindo o formulário, input de email, botão "Inscrever" e feedback). Remover também os estilos CSS associados (`.footer-newsletter`, `.newsletter-form`, `.newsletter-input`, `.newsletter-btn`, `.newsletter-feedback`).
  3. Adicionar nota de status: `"Protótipo conceitual — v0.6"`
  4. Opcionalmente, adicionar link para documento do modelo (quando publicado)
  5. Ajustar grid do footer (atualmente `grid-template-columns: 1fr 1fr`) — com a remoção da newsletter, pode usar `1fr` ou reorganizar o layout.
- **Verificação:**
  - [ ] Newsletter fake completamente removida (formulário, input, botão)
  - [ ] Tagline atualizada para "Modelo conceitual para desenvolvimento de software orientado por especificações"
  - [ ] Nota "Protótipo conceitual — v0.6" presente

---

## Fase 2 — Desmembramento da PillarsSection

### F2-01: Criar CanonBuildingSection com CeremonyFlowDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/sections/CanonBuildingSection.astro` (criar)
  - `src/components/diagrams/CeremonyFlowDiagram.tsx` (criar)
  - `src/lib/diagrams/ceremony-flow-diagram.ts` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F2-02, F2-03
- **Referência no plano:** §4.1 item 2.1
- **Contexto:**
  Criar seção depth 2 para detalhar a Etapa 1 — Canon Building. A seção substitui o conteúdo da primeira tab ("Canon Building") da PillarsSection atual. ID da seção: `canon-building`. `sectionNumber`: 5.
  
  **Estrutura da seção Astro:**
  ```
  <section id="canon-building" class="section-odd" aria-labelledby="heading-canon-building">
    <SectionHeader sectionNumber={5} title='Canon Building — <span class="gradient-text">Construir o Conhecimento</span>' depth={2} sectionId="canon-building" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo (cada bloco em `ScrollReveal` com delays 0, 0.15, 0.3, 0.45...):**
  
  1. **Princípio orientador** (nota contextual): "Este é um dos princípios de design do modelo: governança por cerimônia com canal de exceção — toda mudança na Product Canon passa por processo formal, seja cerimônia ou edição direta com guardrails."
  
  2. **Introdução:** O Domain Builder e o Architect constroem e mantêm a Product Canon de forma complementar, através de três cerimônias formais organizadas em um fluxo sequencial com gates de aprovação. Cada cerimônia produz um Canonical Change Plan que precisa ser aprovado antes de habilitar a próxima.
  
  3. **Sessão 1 — Domain Discovery Session:**
     - Baseada em Event Storming: "É uma técnica onde você conta a história do negócio e alguém organiza em um mapa — no ZionKit, esse alguém é a IA."
     - 4 fases: (1) Descoberta de eventos de domínio — o que acontece no negócio, expressos no passado ("Pedido Criado", "Pagamento Confirmado"); (2) Identificação de comandos e atores — o que causou cada evento e quem disparou; (3) Mapeamento de agregados e bounded contexts — agrupamentos coesos com fronteiras naturais; (4) Decomposição de casos de uso — pré-condições, pós-condições, fluxos alternativos.
     - **Exemplo fintech:** Um gestor de operações descreve: "Quando um cliente pede pra sacar dinheiro, a gente verifica se tem saldo, se tem limite diário disponível, e se não tem nenhum bloqueio judicial." → IA identifica eventos (SaqueSolicitado, SaldoVerificado, LimiteValidado, BloqueioVerificado, SaqueProcessado, NotificaçãoEnviada), comandos, atores (Cliente, Sistema de Compliance), bounded contexts (Conta, Compliance, Notificações).
     - **Perspectiva do Architect:** Avalia que verificação de bloqueio judicial (Compliance) precisa ser síncrona com processamento de saque (Conta). Comunicação com Notificações será assíncrona via evento. Registra como ADR.
     - Saída: `discovery-plan` → aprovação primária Domain Expert + secundária Architect
  
  4. **Sessão 2 — Technical Constitution Session:**
     - Architect define princípios técnicos constitucionais (stack, comunicação entre contextos, persistência, segurança, observabilidade)
     - **Exemplo de princípios** (formato simplificado): Stack (Python/FastAPI, PostgreSQL, Redis, RabbitMQ), comunicação assíncrona entre bounded contexts via eventos, schema de banco por contexto, autenticação OAuth2/JWT, traces OpenTelemetry
     - **Níveis de aderência IEEE 29148** — explicar com analogia: "O nível de detalhe de uma planta de casa — pode ser um croqui básico (Mínimo), uma planta técnica (Moderado), ou um projeto executivo (Completo)."
       - **Mínimo:** tipo + descrição + SBE (produtos novos, prototipação)
       - **Moderado:** adiciona subtipo, rastreabilidade, dependências (produto em crescimento)
       - **Completo:** aplicação integral com rastreabilidade bidirecional e atributos de qualidade (produto maduro, domínios regulados)
       - O nível pode variar por bounded context. SBE obrigatório em todos os níveis.
     - Saída: `constitution-plan` → aprovação primária Architect + secundária Domain Expert
  
  5. **Sessão 3 — Requirements Specification Session:**
     - Formalização de requisitos via clarificação iterativa: (1) Domain Builder descreve requisito em linguagem natural; (2) IA ativa validação semântica interna (SBVR) + demais guardrails; (3) IA consolida problemas e apresenta perguntas de clarificação; (4) Domain Builder refina em ciclo iterativo; (5) IA formaliza em IEEE 29148 + SBE; (6) Domain Builder valida.
     - **Exemplo REQ-CANCEL-001:** Domain Builder descreve "O cliente deve poder cancelar um pedido antes do faturamento." → IA detecta ambiguidade ("Quais status permitem cancelamento? Apenas Pendente, ou também Confirmado?") → Domain Builder esclarece → IA consulta Product Canon e encontra regra existente → Requisito formalizado:
       > **REQ-CANCEL-001** | Tipo: Funcional | Contexto: Pedidos | Prioridade: Alta
       > *O sistema deve permitir que o Cliente titular cancele um Pedido cujo status é Pendente ou Confirmado.*
       > **Cenário SBE:** Dado um Pedido com status 'Confirmado' pertencente ao Cliente titular / Quando o Cliente solicita cancelamento / Então o status muda para 'Cancelado' e o evento PedidoCancelado é emitido.
     - Saída: `specification-plan` → aprovação primária Domain Expert + secundária Architect
  
  6. **Decisão de Continuidade do Ciclo:**
     - 3 caminhos: (a) Mapear mais fluxos → volta para Domain Discovery; (b) Formalizar mais requisitos → volta para Requirements Specification; (c) Encerrar ciclo → prosseguir para Spec Crafting
     - **Pré-condição do caminho (b):** Só pode voltar direto para Requirements Specification se os bounded contexts já foram mapeados e têm constituição técnica definida. Se os novos requisitos tocam bounded contexts não mapeados, deve voltar para Domain Discovery (caminho a).
     - **Checkpoint IEEE 29148:** A IA apresenta sinais indicativos de que o nível de aderência pode ser insuficiente (requisitos com dependências inter-contexto não rastreadas, requisitos não-funcionais aparecendo, rejeições por ambiguidade de escopo). A decisão de progredir é do Architect.
     - Autoridade: Domain Builder decide, IA sinaliza cobertura.
  
  7. **Princípio "Prevenção sobre detecção"** (nota contextual): "Gates de aprovação capturam inconsistências no momento mais barato de corrigi-las — antes de qualquer linha de código existir."
  
  **Diagrama CanonBuildingDiagram existente:** Reutilizar `src/components/diagrams/CanonBuildingDiagram.tsx` dentro de `DiagramContainer` com `client:visible`.
  
  **Novo diagrama CeremonyFlowDiagram:**
  - Criar `src/components/diagrams/CeremonyFlowDiagram.tsx` — diagrama React com @xyflow/react
  - Criar `src/lib/diagrams/ceremony-flow-diagram.ts` — config de nós e edges
  - Conceito: fluxo sequencial vertical com 3 nós de cerimônia (Domain Discovery → Technical Constitution → Requirements Specification), gates de aprovação entre elas (com tipos de Change Plan), e nó de Decisão de Continuidade com 3 caminhos. Usar estilo visual consistente com diagramas existentes (ver `shared-config.ts`).
  - Wrapping: `<DiagramContainer label="Fluxo das cerimônias do Canon Building" title="CeremonyFlowDiagram">` com `client:visible`
  
  **Regras da constituição relevantes:**
  - Princípio II: seção em `sections/`, diagrama em `diagrams/`, config em `lib/diagrams/`
  - Princípio III: React (.tsx) apenas para diagrama interativo, com `client:visible`
  - Princípio IV: usar classes `section-odd`/`section-even` conforme posição na página
  - Princípio V: `aria-labelledby="heading-canon-building"`, `prefers-reduced-motion` no diagrama
  - Princípio VI: `depth={2}` no SectionHeader
  - Princípio VII: `SectionHeader` com props, `ScrollReveal` com delays, `DiagramContainer` com label
- **Verificação:**
  - [ ] Seção renderiza com `SectionHeader` depth 2 e `sectionNumber` 5
  - [ ] 3 cerimônias descritas com exemplos
  - [ ] Decisão de Continuidade com 3 caminhos documentada
  - [ ] CeremonyFlowDiagram renderiza com `client:visible`

---

### F2-02: Criar SpecCraftingSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/SpecCraftingSection.astro` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F2-01, F2-03
- **Referência no plano:** §4.1 item 2.2
- **Contexto:**
  Criar seção depth 2 para detalhar a Etapa 2 — Spec Crafting. Substitui o conteúdo da segunda tab da PillarsSection. ID: `spec-crafting`. `sectionNumber`: 6.
  
  **Estrutura:**
  ```
  <section id="spec-crafting" class="section-even" aria-labelledby="heading-spec-crafting">
    <SectionHeader sectionNumber={6} title='Spec Crafting — <span class="gradient-text">Especificação Contextualizada</span>' depth={2} sectionId="spec-crafting" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo (em `ScrollReveal` com delays incrementais):**
  
  1. **Injeção seletiva de contexto** (princípio de design §8): "A IA não recebe toda a Product Canon — só os pedaços relevantes para a tarefa. Ela identifica quais bounded contexts são tocados pela especificação e carrega apenas os artefatos pertinentes: glossário do contexto afetado, eventos de domínio, regras de negócio aplicáveis, ADRs relevantes e requisitos existentes relacionados."
  
  2. **Clarificação e validação contextualizada:** Termos inconsistentes são sinalizados. Requisitos que contradizem regras existentes são flagrados. Dependências entre bounded contexts são identificadas. Mesmo processo que na Etapa 1, mas contra a Product Canon como referência.
  
  3. **Canonical Change Plan incremental (`incremental-plan`):** Quando a IA identifica que uma feature vai causar mudanças na Product Canon não antecipadas no Canon Building, ela gera automaticamente um Change Plan incremental — um "diff semântico" entre o estado atual da Product Canon e o estado após a implementação. Organizado em duas seções: alterações na camada de negócio e alterações na camada de arquitetura.
     - **Exemplo PIX no Checkout:** (do v0.6 §2.3.3)
       - Camada de Negócio: novo termo "Chave PIX" no glossário, nova regra "transações PIX acima de R$ 1.000 em horário noturno requerem confirmação adicional"
       - Camada de Arquitetura: alteração no evento "PagamentoConfirmado" (novo campo "metodo_pagamento"), novo evento "ChavePixValidada"
  
  4. **Aprovação condicional:** Se o Change Plan incremental for vazio (a spec consome a Product Canon sem alterá-la), a aprovação é dispensada e a spec flui direto para implementação. Se houver impacto, a aprovação é roteada por camada: Domain Expert aprova camada de negócio, Architect aprova camada de arquitetura. Specs que afetam ambas exigem as duas aprovações.
  
  **Diagrama existente:** Reutilizar `ContextualSpecDiagram` dentro de `DiagramContainer` com `client:visible`.
  
  **Regras da constituição relevantes:** Princípios II, III, IV, V, VI, VII (mesmas regras de F2-01).
- **Verificação:**
  - [ ] Seção renderiza com depth 2 e sectionNumber 6
  - [ ] Injeção seletiva explicada
  - [ ] Exemplo PIX presente
  - [ ] Aprovação condicional explicada (Change Plan vazio = sem gate)

---

### F2-03: Criar EnrichmentSection e atualizar FeedbackDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/sections/EnrichmentSection.astro` (criar)
  - `src/components/diagrams/FeedbackDiagram.tsx` (editar)
  - `src/lib/diagrams/feedback-diagram.ts` (editar)
- **Tipo:** criar + editar
- **Dependências:** nenhuma
- **Paralelo com:** F2-01, F2-02
- **Referência no plano:** §4.1 item 2.3, §4.3 (FeedbackDiagram update)
- **Contexto:**
  Criar seção depth 2 para detalhar a Etapa 3 — Canon Enrichment. Substitui o conteúdo da terceira tab da PillarsSection. ID: `enrichment`. `sectionNumber`: 7.
  
  **Estrutura:**
  ```
  <section id="enrichment" class="section-odd" aria-labelledby="heading-enrichment">
    <SectionHeader sectionNumber={7} title='Canon Enrichment — <span class="gradient-text">Retroalimentação</span>' depth={2} sectionId="enrichment" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo (em `ScrollReveal` com delays incrementais):**
  
  1. **Integração de Change Plans aprovados:** Canonical Change Plans aprovados no Canon Building e na Etapa 2 já declararam quais artefatos da Product Canon serão afetados. Essa integração é parcialmente antecipada via Versionamento por Estrangulamento.
  
  2. **Descobertas emergentes — dois mecanismos complementares:**
     - **Sinalização explícita (`CANON-DISCOVERY`):** O desenvolvedor (ou a IA de codificação) marca descobertas durante a implementação em formato leve — anotação inline (`// CANON-DISCOVERY: [descrição]`) ou registro em artefato dedicado. Mecanismo primário: não depende de capacidades incertas da IA.
     - **Detecção assistida pela IA:** Ao iniciar a Etapa 3, a IA compara artefatos da implementação contra a Product Canon e apresenta candidatos a descobertas não sinalizados. Exemplo: "O código introduziu o conceito 'OfertaExpirada' que não existe no glossário — formalizar?" Mecanismo complementar, rede de segurança.
  
  3. **Mecanismo de aprovação leve com escalação condicional:**
     - A IA formaliza cada descoberta e submete aos guardrails (Padronização Canônica, Validação de Consistência, Clarificação de Conformidade)
     - **Sem problemas:** integração aprovada com revisão assíncrona — janela de veto (se expira sem manifestação = aprovação tácita). Para refinamentos de termos, correções factuais, ajustes sem impacto cross-context.
     - **Com problemas:** descoberta escalada para Canonical Change Plan formal do tipo apropriado (`specification-plan`, `constitution-plan` ou `discovery-plan`), que segue aprovação ativa.
  
  4. **Anotações contextuais e ciclo de vida:**
     - Anotações não formalizadas em ciclos anteriores são reapresentadas pela IA como candidatos a incorporação durante cerimônias de Canon Building
     - Resolução obrigatória: **formalizar** (incorporar via Change Plan), **descartar** (arquivar com motivo), ou **adiar** (re-apresentar no próximo ciclo)
     - Adiamentos consecutivos (>2 ciclos) ativam sinalização da IA: "esta anotação foi adiada N vezes — considerar formalizar ou descartar"
  
  **Atualização do FeedbackDiagram:**
  No `FeedbackDiagram.tsx` e `feedback-diagram.ts`, adicionar:
  - Bifurcação: sinalização explícita + detecção assistida → guardrails → revisão assíncrona OU escalação para Change Plan formal
  - Manter estilo visual consistente com diagramas existentes
  
  **Regras da constituição relevantes:** Princípios II, III, IV, V, VI, VII.
- **Verificação:**
  - [ ] Seção renderiza com depth 2 e sectionNumber 7
  - [ ] Sinalização explícita e detecção assistida descritas
  - [ ] Mecanismo de aprovação leve com escalação presente
  - [ ] FeedbackDiagram atualizado com bifurcação

---

### F2-04: Remover PillarsSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/PillarsSection.astro`
- **Tipo:** remover
- **Dependências:** 🔗 F2-01, F2-02, F2-03 (só executar após as 3 novas seções estarem implementadas e funcionais)
- **Paralelo com:** nenhuma
- **Referência no plano:** §4.1 item 2.4
- **Contexto:**
  Remover o arquivo `src/components/sections/PillarsSection.astro`. Este arquivo é substituído pelas 3 novas seções (CanonBuildingSection, SpecCraftingSection, EnrichmentSection).
  
  **Não remover ainda** o import e uso em `index.astro` — isso será feito na Fase 4 (F4-02). A remoção do arquivo pode ser feita assim que as 3 seções substitutivas estejam funcionais, mesmo que `index.astro` ainda não tenha sido atualizado (resultará em erro de build temporário que será resolvido na F4-02).
  
  **Alternativa:** Se preferir manter o build funcional, postergar esta tarefa para ser executada junto com F4-02.
- **Verificação:**
  - [ ] Arquivo `PillarsSection.astro` removido
  - [ ] Conteúdo das 3 tabs está coberto pelas novas seções F2-01, F2-02, F2-03

---

## Fase 3 — Novas seções

### F3-01: Criar GuardrailsSection com GuardrailsDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/sections/GuardrailsSection.astro` (criar)
  - `src/components/diagrams/GuardrailsDiagram.tsx` (criar)
  - `src/lib/diagrams/guardrails-diagram.ts` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F3-02, F3-03, F3-04, F3-05
- **Referência no plano:** §4.1 item 3.1
- **Contexto:**
  Criar seção depth 2 dedicada aos 5 guardrails da Product Canon. ID: `guardrails`. `sectionNumber`: 8.
  
  **Estrutura:**
  ```
  <section id="guardrails" class="section-even" aria-labelledby="heading-guardrails">
    <SectionHeader sectionNumber={8} title='Guardrails — <span class="gradient-text">Como a Integridade é Mantida</span>' depth={2} sectionId="guardrails" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo (em `ScrollReveal` com delays incrementais):**
  
  Introdução: "Guardrails são mecanismos automáticos que a IA usa para manter a integridade da Product Canon. Eles operam em todas as etapas do ciclo."
  
  **5 guardrails explicados didaticamente:**
  
  1. **Clarificação de Conformidade (Compliance Clarification):**
     "Se você diz 'cliente' onde o glossário define 'titular da conta', a IA pergunta: 'Você quis dizer titular da conta?'"
     Atua nas sessões de Domain Discovery e Technical Constitution. Hotspots de domínio recebem atenção especial — a IA exibe proativamente a definição precisa e alerta sobre a incerteza registrada.
  
  2. **Validação de Consistência:**
     "Se você propõe algo que contradiz uma regra existente, a IA mostra a contradição antes de aceitar."
     Confronta alterações com o estado atual da Product Canon, incluindo regras de negócio E princípios técnicos constitucionais.
  
  3. **Validação Semântica Interna:**
     "A IA usa internamente métodos formais (como SBVR) para encontrar ambiguidades — mas apresenta os problemas como perguntas simples."
     SBVR é a metodologia principal mas não exclusiva. Detecta: ambiguidade estrutural, incompletude de predicados, indefinição de participantes. Resultados sempre em linguagem natural.
  
  4. **Padronização Canônica (Canonical Formatting):**
     "Tudo que entra na Product Canon precisa estar no formato padrão (IEEE 29148 + SBE). A IA faz a formatação automaticamente."
     Dois modos: **implícito** nas cerimônias (parte da mediação da IA) e **explícito** na edição direta (Domain Expert propõe em formato livre, IA reescreve). Respeita o nível de aderência IEEE 29148 configurado.
  
  5. **Versionamento por Estrangulamento (Strangler Fig):**
     "Mudanças grandes são aplicadas aos poucos. A Product Canon mantém duas versões: a vigente (current) e a em transição (next)."
     - Escopo declarado: lista explícita de artefatos e bounded contexts afetados
     - Conclusão pelo Architect: quando todas as dependências forem migradas, o Architect declara a transição como concluída
     - Cancelamento possível: via Change Plan que restaura `current` como estado único
     - Heurística de impacto cross-context: a IA sinaliza automaticamente quando mudança afeta múltiplos bounded contexts → recomendação de versionamento gradual (decisão do Architect)
     - Nota contextual do princípio "Alterações radicais são graduais" (§8): "Este é um dos princípios de design do modelo: alterações radicais são graduais — mudanças estruturais são versionadas e aplicadas por criticidade, sem quebrar o que já funciona."
  
  **Conceito transversal — Hotspots de domínio:**
  Incluir na explicação da Clarificação de Conformidade: áreas da Product Canon marcadas pelo Domain Expert como frágeis ou frequentemente mal interpretadas. Metadados no artefato (autor, data, descrição). A IA os prioriza durante validação.
  
  **Novo diagrama GuardrailsDiagram:**
  - Criar `GuardrailsDiagram.tsx` + `guardrails-diagram.ts`
  - Conceito: diagrama visual dos 5 guardrails como camadas de proteção, mostrando onde cada um atua no ciclo (Canon Building, Spec Crafting, Enrichment, Edição Direta)
  - Usar @xyflow/react, `client:visible`, `DiagramContainer` com label descritivo
  
  **Regras da constituição relevantes:** Princípios II, III, IV, V, VI, VII.
- **Verificação:**
  - [ ] 5 guardrails explicados com linguagem acessível
  - [ ] Hotspots de domínio mencionados na Clarificação de Conformidade
  - [ ] Versionamento por Estrangulamento com faces current/next e princípio §8
  - [ ] GuardrailsDiagram renderiza com `client:visible`

---

### F3-02: Criar ChangePlanSection com ChangePlanEnvelopeDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/sections/ChangePlanSection.astro` (criar)
  - `src/components/diagrams/ChangePlanEnvelopeDiagram.tsx` (criar)
  - `src/lib/diagrams/change-plan-envelope-diagram.ts` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F3-01, F3-03, F3-04, F3-05
- **Referência no plano:** §4.1 item 3.2
- **Contexto:**
  Criar seção depth 3 dedicada ao Canonical Change Plan como artefato central. ID: `change-plan`. `sectionNumber`: 10.
  
  **Estrutura:**
  ```
  <section id="change-plan" class="section-even" aria-labelledby="heading-change-plan">
    <SectionHeader sectionNumber={10} title='O <span class="gradient-text">Canonical Change Plan</span>' depth={3} sectionId="change-plan" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo:**
  
  1. **O que é:** "Documento que descreve exatamente o que vai mudar na Product Canon. É o artefato que torna visíveis as mudanças antes de serem aplicadas."
  
  2. **Envelope de metadados — campos universais (obrigatórios em todos os 5 tipos):**
     - `id` — identificador único (ex.: `CP-discovery-2026-04-08-001`)
     - `type` — um dos 5 tipos
     - `status` — `draft`, `pending-approval`, `approved`, `rejected`, `abandoned`
     - `author` — pessoa ou papel que originou
     - `created-at` — data de criação
     - `scope` — lista de bounded contexts afetados
     - `approvals` — registro sequencial de cada aprovação/rejeição (papel, pessoa, decisão, data, motivo)
  
  3. **Campos condicionais:**
     - `affected-layer` (apenas `incremental-plan`) — `negocio`, `arquitetura` ou ambas
     - `edited-artifacts` (apenas `expert-edit-plan`) — artefatos alterados
     - `compliance-report` (apenas `expert-edit-plan`) — referência ao Relatório de Conformidade
     - `conditionality` (apenas `incremental-plan`) — indica se há impactos (vazio = sem aprovação)
  
  4. **5 tipos explicados com contexto de uso:**
     - `discovery-plan` — saída da Domain Discovery Session (Etapa 1)
     - `constitution-plan` — saída da Technical Constitution Session (Etapa 1)
     - `specification-plan` — saída da Requirements Specification Session (Etapa 1)
     - `expert-edit-plan` — saída da Edição Direta do Domain Expert
     - `incremental-plan` — saída da Spec Crafting (Etapa 2), condicional
  
  5. **Fluxo de aprovação por afinidade:**
     - Aprovador primário: papel com expertise principal sobre o conteúdo
     - Aprovador secundário: assíncrono com janela de veto (duração-default configurada pelo Architect, default 48h úteis). Se expira sem manifestação = aprovação tácita.
     - **Exceção `expert-edit-plan`:** aprovação sequencial obrigatória (Domain Expert → Architect). Expiração da janela do Architect = bloqueio (não aprovação tácita).
  
  6. **Rejeição:** Devolução do Change Plan ao contexto de origem com motivo em texto livre registrado. O autor decide: revisar e resubmeter ou abandonar. Sem rejeição parcial (devolvido como unidade). Abandono registrado com motivo.
  
  7. **Exemplo visual:** Change Plan incremental do PIX no Checkout (formato do v0.6 §2.3.3 — envelope + payload com camada de negócio e camada de arquitetura)
  
  **Novo diagrama ChangePlanEnvelopeDiagram:**
  - Criar `.tsx` + `.ts`
  - Conceito: estrutura visual do envelope (campos universais + condicionais), com os 5 tipos e o fluxo de aprovação
  - @xyflow/react, `client:visible`, `DiagramContainer`
  
  **Regras da constituição relevantes:** Princípios II, III, IV, V, VI, VII.
- **Verificação:**
  - [ ] Seção renderiza com depth 3 e sectionNumber 10
  - [ ] Envelope com 7 campos universais e 4 condicionais documentados
  - [ ] 5 tipos de Change Plan explicados
  - [ ] Aprovação por afinidade e exceção do `expert-edit-plan` explicadas

---

### F3-03: Criar DirectEditSection com DirectEditFlowDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/sections/DirectEditSection.astro` (criar)
  - `src/components/diagrams/DirectEditFlowDiagram.tsx` (criar)
  - `src/lib/diagrams/direct-edit-flow-diagram.ts` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F3-01, F3-02, F3-04, F3-05
- **Referência no plano:** §4.1 item 3.3
- **Contexto:**
  Criar seção depth 3 dedicada à Edição Direta do Domain Expert. ID: `edicao-direta`. `sectionNumber`: 12.
  
  **Estrutura:**
  ```
  <section id="edicao-direta" class="section-even" aria-labelledby="heading-edicao-direta">
    <SectionHeader sectionNumber={12} title='Edição Direta do <span class="gradient-text">Domain Expert</span>' depth={3} sectionId="edicao-direta" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo:**
  
  1. **Quando usar:** "Para capturar conhecimento de domínio que emerge fora do ritmo das cerimônias — uma mudança regulatória, uma correção factual, uma definição que precisa de ajuste. Novas funcionalidades e alterações conceituais significativas devem continuar passando pelas cerimônias formais."
  
  2. **Escopo limitado:**
     - Apenas camada de negócio (glossário, regras, requisitos, fluxos) — artefatos de arquitetura exclusivos do Architect
     - Apenas refinamentos e correções de artefatos existentes — conceitos inteiramente novos requerem cerimônia completa
  
  3. **Fluxo de guardrails iterativos:**
     - (1) Domain Expert propõe alteração em linguagem natural/formato livre
     - (2) IA executa simultaneamente: Clarificação de Conformidade + validação semântica interna (SBVR) + Validação de Consistência + Padronização Canônica (reescrita em IEEE 29148 + SBE)
     - (3) IA apresenta: perguntas de clarificação, versão formalizada como proposta, e **Relatório de Conformidade**
     - (4) Domain Expert decide: aceitar, solicitar ajustes, responder clarificações, ou reescrever e resubmeter
     - (5) Ciclo repete até resolução
  
  4. **Relatório de Conformidade** — documento markdown com 4 seções fixas:
     - Divergências terminológicas (com referência ao glossário)
     - Contradições com regras de negócio existentes (com referência ao artefato conflitante)
     - Impactos em bounded contexts adjacentes
     - Divergências intencionais aceitas (com justificativa do Domain Expert)
     Gerado automaticamente pela IA — Domain Expert apenas revisa.
  
  5. **`expert-edit-plan` e aprovação sequencial obrigatória:**
     - Saída: Change Plan tipado como `expert-edit-plan` contendo versão formalizada + Relatório de Conformidade + divergências flagradas + impactos
     - **Ordem fixa:** (1) Domain Expert aprova primeiro (fidelidade semântica) → (2) Architect aprova depois (impacto técnico)
     - Aprovação do Architect obrigatória e não delegável. Expiração = bloqueio.
     - Justificativa da ordem: fidelidade semântica é pré-requisito para avaliação técnica
  
  6. **Salvaguardas que preservam a primazia das cerimônias:**
     - Tipagem distinta (`expert-edit-plan`) permite auditoria de frequência
     - Fricção deliberada (aprovação obrigatória do Architect)
     - Se proporção de `expert-edit-plan` crescer excessivamente → sinal de contorno do processo formal
  
  **Novo diagrama DirectEditFlowDiagram:**
  - Conceito: fluxo horizontal/vertical: edição proposta → guardrails iterativos (ciclo) → Relatório de Conformidade → `expert-edit-plan` → aprovação sequencial (Domain Expert → Architect)
  - @xyflow/react, `client:visible`, `DiagramContainer`
  
  **Regras da constituição relevantes:** Princípios II, III, IV, V, VI, VII.
- **Verificação:**
  - [ ] Seção renderiza com depth 3 e sectionNumber 12
  - [ ] Fluxo de guardrails iterativos com 5 passos descrito
  - [ ] Relatório de Conformidade com 4 seções documentado
  - [ ] Aprovação sequencial obrigatória (Domain Expert → Architect) explicada

---

### F3-04: Criar RiscosSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/RiscosSection.astro` (criar)
- **Tipo:** criar
- **Dependências:** nenhuma
- **Paralelo com:** F3-01, F3-02, F3-03, F3-05
- **Referência no plano:** §4.1 item 3.4
- **Contexto:**
  Criar seção depth 2 dedicada aos riscos e limitações do modelo. Sem diagrama. ID: `riscos`. `sectionNumber`: 15.
  
  **Estrutura:**
  ```
  <section id="riscos" class="section-odd" aria-labelledby="heading-riscos">
    <SectionHeader sectionNumber={15} title='Riscos e <span class="gradient-text">Limitações</span>' depth={2} sectionId="riscos" />
    ...
  </section>
  ```
  
  **Conteúdo narrativo:**
  
  Introdução: "Todo modelo tem limitações. O ZionKit documenta as suas abertamente."
  
  Nota de status: "O modelo é um protótipo conceitual que ainda não foi testado em produção."
  
  **10 riscos, cada um com "o que pode dar errado" + "o que o modelo faz para mitigar":**
  
  1. **Qualidade dos guardrails depende da capacidade da IA** — Se a IA não detecta que um termo está sendo usado incorretamente, o guardrail falha silenciosamente. *Mitigação:* eficácia precisa ser validada empiricamente.
  
  2. **Injeção seletiva de contexto é problema não trivial** — Uma spec que aparenta tocar um bounded context pode ter implicações em outros. *Mitigação:* qualidade da seleção afeta diretamente a qualidade do Change Plan.
  
  3. **Custo de bootstrap** — Construir a Product Canon inicial exige investimento. Canon Building é mais estruturado (3 cerimônias com gates). *Mitigação:* retorno se materializa ao longo de múltiplos ciclos, não imediatamente.
  
  4. **Disciplina de retroalimentação** — Equipes sob pressão podem pular a Etapa 3, degradando o modelo para SDD convencional. *Mitigação:* Canon Building antecipa parte da integração; sinalização explícita captura descobertas no momento em que surgem; detecção assistida funciona como rede de segurança.
  
  5. **Disponibilidade de aprovadores** — Múltiplos gates exigem múltiplos aprovadores. *Mitigação:* aprovação por afinidade; secundária assíncrona com janela de veto; Etapa 2 condicional; roteamento por camada.
  
  6. **Qualidade da tradução de validação interna para linguagem natural** — Se a IA traduz mal os problemas detectados pelo SBVR, o benefício se perde. *Mitigação:* ciclo iterativo de clarificação; formalização IEEE 29148 + SBE como ponto de validação auditável.
  
  7. **Acúmulo de papéis pode degradar governança** — Uma pessoa exercendo múltiplos papéis pode aprovar mecanicamente. *Mitigação:* Protocolo de Perspectiva Assistida (perguntas específicas por papel, variação baseada no conteúdo).
  
  8. **Concorrência de transições no Versionamento por Estrangulamento** — Duas transições simultâneas afetando artefatos interdependentes podem gerar inconsistências. *Mitigação:* Architect avalia caso a caso; semântica de concorrência será refinada com dados empíricos.
  
  9. **Estagnação no nível Mínimo de aderência IEEE 29148** — Se progressão depende só do julgamento do Architect, risco de permanecer no Mínimo por inércia. *Mitigação:* checkpoint de revisão de nível na Decisão de Continuidade.
  
  10. **Perda de detalhamento estrutural** — Canon Building não detalha fases internas de todas as cerimônias nem organização física da Product Canon. *Mitigação:* escolha deliberada — estrutura deve emergir da prototipação prática.
  
  **Regras da constituição relevantes:** Princípios IV (section-odd/even), V (aria-labelledby), VI (depth 2), VII (SectionHeader, ScrollReveal).
- **Verificação:**
  - [ ] 10 riscos listados com "o que pode dar errado" + mitigação
  - [ ] Nota de protótipo conceitual presente
  - [ ] Seção renderiza com depth 2 e sectionNumber 15

---

### F3-05: Atualizar CanonDeepDiveSection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/CanonDeepDiveSection.astro`
- **Tipo:** editar
- **Dependências:** nenhuma
- **Paralelo com:** F3-01, F3-02, F3-03, F3-04
- **Referência no plano:** §4.1 item 3.5
- **Contexto:**
  Atualizar a seção existente de detalhamento da Product Canon com conteúdo v0.6. `sectionNumber` será 11 (atualizar no `SectionHeader`). Depth: 3.
  
  **Edições:**
  
  1. **Camada de Negócio:** Adicionar nos requisitos a menção a "formato IEEE 29148 + SBE" — os requisitos são formalizados em formato IEEE 29148 com critérios de aceitação SBE (Specification by Example), com completude e consistência validadas internamente pela IA.
  
  2. **Adicionar menção a hotspots de domínio e anotações contextuais como metadados:**
     > "Artefatos da Product Canon podem conter metadados de hotspot de domínio (autor, data, descrição) — áreas frágeis que a IA prioriza durante validação — e histórico de anotações de aprovação, enriquecendo o contexto disponível para especificações futuras."
  
  3. **Camada de Arquitetura:** Adicionar menção a níveis de aderência IEEE 29148 nos princípios técnicos constitucionais:
     > "Os princípios técnicos constitucionais incluem o nível de aderência IEEE 29148 configurado para cada bounded context (Mínimo, Moderado ou Completo)."
  
  4. **Adicionar Canonical Change Plans como artefato da Canon:**
     > "Canonical Change Plans (com envelope tipado): registros dos planos de mudança aprovados em cada cerimônia ou canal — `discovery-plan`, `constitution-plan`, `specification-plan`, `expert-edit-plan`, `incremental-plan` — todos contendo requisitos em formato IEEE 29148 + SBE."
  
  5. Atualizar `sectionNumber` de 8 para 11 no `SectionHeader`.
- **Verificação:**
  - [ ] Camada de Negócio menciona "formato IEEE 29148 + SBE"
  - [ ] Hotspots de domínio e anotações contextuais mencionados
  - [ ] Níveis de aderência IEEE 29148 mencionados na Camada de Arquitetura
  - [ ] Canonical Change Plans listados como artefato da Canon

---

### F3-06: Adicionar novos termos ao GlossarySection
- [ ] **Status**
- **Arquivo(s):** `src/components/sections/GlossarySection.astro`
- **Tipo:** editar
- **Dependências:** 🔗 Todas as tarefas das Fases 1, 2 e 3 (deve ser implementado por último, depende de todas as seções para terminologia final)
- **Paralelo com:** nenhuma
- **Referência no plano:** §4.1 item 3.6, §4.2
- **Contexto:**
  Adicionar os seguintes 17 novos termos ao glossário, utilizando o componente `GlossaryItem` existente (`src/components/ui/GlossaryItem.astro`). Cada termo tem definição e analogia. `sectionNumber` será 16 (atualizar no `SectionHeader`).
  
  **Termos a adicionar:**
  
  1. **Canonical Change Plan** — Documento que descreve exatamente o que será adicionado ou alterado na Product Canon. Possui envelope com metadados (tipo, status, autor, escopo) e payload com conteúdo da mudança. Precisa de aprovação. *Analogia:* A proposta de emenda à constituição do produto — descreve o que muda, quem precisa aprovar, e só entra em vigor depois da votação.
  
  2. **Envelope do Change Plan** — Conjunto de metadados que acompanha todo Canonical Change Plan: identificador, tipo, status, autor, escopo e registro de aprovações. *Analogia:* A capa de um processo administrativo — identifica o processo, seu status e quem já assinou.
  
  3. **`expert-edit-plan`** — Tipo de Canonical Change Plan originado por edição direta do Domain Expert. Aprovação sequencial obrigatória: Domain Expert valida fidelidade, Architect avalia impacto técnico. *Analogia:* Uma correção no manual do produto — o especialista propõe, mas o engenheiro precisa verificar se a mudança não quebra nada.
  
  4. **`incremental-plan`** — Tipo de Canonical Change Plan gerado na Etapa 2 (Spec Crafting). Captura impactos emergentes que só aparecem quando uma spec concreta é escrita contra a Product Canon. Pode ser vazio (sem impacto = sem aprovação). *Analogia:* A lista de ajustes que aparece quando você aplica uma regra geral a um caso concreto.
  
  5. **Protocolo de Perspectiva Assistida** — Mecanismo que permite que uma mesma pessoa exerça múltiplos papéis sem perder a qualidade das validações. A IA apresenta perguntas específicas da perspectiva de cada papel. *Analogia:* Quando o fundador de uma startup precisa ser ao mesmo tempo o cliente e o vendedor — ele usa um checklist diferente para cada "chapéu".
  
  6. **Hotspot de domínio** — Área da Product Canon marcada pelo Domain Expert como frágil, frequentemente mal interpretada, ou com histórico de problemas. A IA usa essas marcações para atenção especial durante validações. *Analogia:* Um trecho de uma receita com a anotação "cuidado aqui — já errei várias vezes nesse passo".
  
  7. **Anotação contextual** — Observação que o Domain Expert adiciona durante a revisão de um Change Plan — nuances de domínio, ressalvas, esclarecimentos. Ciclo de vida: formalizar, descartar ou adiar. *Analogia:* Um post-it na margem de um documento — "isso aqui merece uma discussão mais profunda depois".
  
  8. **Relatório de Conformidade** — Documento gerado pela IA durante edição direta. 4 seções: divergências terminológicas, contradições com regras, impactos em bounded contexts, divergências intencionais aceitas. *Analogia:* O parecer do revisor antes de publicar — lista tudo que encontrou de inconsistente para o autor decidir.
  
  9. **Aprovação por afinidade** — Modelo de aprovação onde o aprovador primário é o papel com expertise principal. O secundário opera com janela de veto assíncrona — sem manifestação no prazo = aprovação tácita. *Analogia:* Quem entende de encanamento aprova a obra de encanamento; o síndico pode vetar, mas se não disser nada no prazo, a obra segue.
  
  10. **Sinalização explícita** — Marcação durante implementação para registrar descobertas emergentes (ex.: `// CANON-DISCOVERY: conceito novo`). Captura aprendizados no momento em que surgem. *Analogia:* Anotar no cantinho do caderno "lembrar de incluir isso no relatório" enquanto trabalha.
  
  11. **Detecção assistida** — IA compara código implementado contra Product Canon e identifica conceitos novos não sinalizados. Rede de segurança. *Analogia:* O revisor que lê o texto final e percebe uma referência nova que o autor esqueceu de adicionar ao índice.
  
  12. **Clarificação de Conformidade** — Guardrail que sinaliza quando alguém usa termos diferentes do vocabulário oficial. Não bloqueia — pergunta e propõe alinhamento. *Analogia:* O corretor ortográfico do produto — sublinha e pergunta.
  
  13. **Validação de Consistência** — Guardrail que confronta alterações com estado atual da Product Canon, detectando contradições em ambas as camadas. *Analogia:* O verificador de compatibilidade — antes de instalar uma peça nova, confere se não conflita.
  
  14. **Validação Semântica Interna** — Guardrail interno da IA (incluindo SBVR) para detectar ambiguidade, incompletude e contradição. Resultados em linguagem natural. *Analogia:* O consultor que lê nas entrelinhas e transforma em perguntas claras.
  
  15. **Padronização Canônica** — Guardrail que garante formato IEEE 29148 + SBE em toda escrita na Product Canon. Reescreve automaticamente. *Analogia:* O formatador de documentos — você escreve o conteúdo, ele coloca nos campos certos.
  
  16. **Nível de aderência IEEE 29148** — Configuração de formalidade dos requisitos: Mínimo (tipo + descrição + SBE), Moderado (+ rastreabilidade e dependências), Completo (aplicação integral). Definido pelo Architect. *Analogia:* O nível de detalhe de uma planta de casa — croqui básico, planta técnica ou projeto executivo.
  
  17. **Decisão de Continuidade** — Ponto de decisão no final de cada ciclo de Canon Building. 3 caminhos: mapear mais fluxos, formalizar mais requisitos, ou encerrar e seguir para Spec Crafting. *Analogia:* O final de cada capítulo de um livro — o autor decide se continua a história, aprofunda um ponto, ou passa para o próximo ato.
  
  Atualizar `sectionNumber` de 10 para 16 no `SectionHeader`.
  
  **Regras da constituição relevantes:**
  - Princípio VII: cada GlossaryItem deve ser wrapped por `ScrollReveal`
- **Verificação:**
  - [ ] 17 novos termos adicionados (total = 15 existentes + 17 novos = 32)
  - [ ] Cada termo tem definição e analogia
  - [ ] `sectionNumber` atualizado para 16

---

## Fase 4 — Integração final

### F4-01: Atualizar StickyNav com estrutura final de 16 seções
- [ ] **Status**
- **Arquivo(s):** `src/components/layout/StickyNav.astro`
- **Tipo:** editar
- **Dependências:** 🔗 F1-01 a F3-06 (todas as fases anteriores)
- **Paralelo com:** F4-02, F4-03, F4-04
- **Referência no plano:** §4.4 item 4.1
- **Contexto:**
  No arquivo `StickyNav.astro`, substituir o array `sections` (linhas 5-16) pelo novo array com 16 seções na ordem definida em §3.1:
  
  ```javascript
  const sections = [
    { id: 'problema', label: 'O Problema' },
    { id: 'consequencias', label: 'Consequências' },
    { id: 'solucao', label: 'O Modelo' },
    { id: 'ciclo', label: 'O Ciclo' },
    { id: 'canon-building', label: 'Canon Building' },
    { id: 'spec-crafting', label: 'Spec Crafting' },
    { id: 'enrichment', label: 'Retroalimentação' },
    { id: 'guardrails', label: 'Guardrails' },
    { id: 'papeis', label: 'Papéis' },
    { id: 'change-plan', label: 'Change Plan' },
    { id: 'canon', label: 'Product Canon' },
    { id: 'edicao-direta', label: 'Edição Direta' },
    { id: 'comparacao', label: 'Antes/Depois' },
    { id: 'cenarios', label: 'Cenários' },
    { id: 'riscos', label: 'Riscos' },
    { id: 'glossario', label: 'Glossário' },
  ];
  ```
- **Verificação:**
  - [ ] 16 seções no array
  - [ ] IDs correspondem aos IDs das seções implementadas
  - [ ] Ordem corresponde à estrutura definida em §3.1

---

### F4-02: Atualizar index.astro com imports, ordem e remoção do CTA
- [ ] **Status**
- **Arquivo(s):** `src/pages/index.astro`
- **Tipo:** editar
- **Dependências:** 🔗 F1-01 a F3-06, F2-04
- **Paralelo com:** F4-01, F4-03, F4-04
- **Referência no plano:** §4.4 item 4.2
- **Contexto:**
  Atualizar `index.astro` com a nova estrutura de 16 seções:
  
  1. **Adicionar imports** para as novas seções:
     ```javascript
     import CanonBuildingSection from '../components/sections/CanonBuildingSection.astro';
     import SpecCraftingSection from '../components/sections/SpecCraftingSection.astro';
     import EnrichmentSection from '../components/sections/EnrichmentSection.astro';
     import GuardrailsSection from '../components/sections/GuardrailsSection.astro';
     import ChangePlanSection from '../components/sections/ChangePlanSection.astro';
     import DirectEditSection from '../components/sections/DirectEditSection.astro';
     import RiscosSection from '../components/sections/RiscosSection.astro';
     ```
  
  2. **Remover import** de `PillarsSection` (já removido em F2-04)
  
  3. **Atualizar** a ordem dos componentes no `<main>`:
     ```
     <!-- 1 --> <HeroSection />
     <!-- 2 --> <ConsequenciasSection />
     <!-- 3 --> <SolutionBridgeSection />
     <!-- 4 --> <CycleOverviewSection />
     <!-- 5 --> <CanonBuildingSection />      (NOVA)
     <!-- 6 --> <SpecCraftingSection />       (NOVA)
     <!-- 7 --> <EnrichmentSection />         (NOVA)
     <!-- 8 --> <GuardrailsSection />         (NOVA)
     <!-- 9 --> <RolesSection />              (movida)
     <!-- 10 --> <ChangePlanSection />        (NOVA)
     <!-- 11 --> <CanonDeepDiveSection />     (movida)
     <!-- 12 --> <DirectEditSection />        (NOVA)
     <!-- 13 --> <ComparisonSection />        (movida)
     <!-- 14 --> <ScenariosSection />         (movida)
     <!-- CTA nota informativa -->
     <!-- 15 --> <RiscosSection />            (NOVA)
     <!-- 16 --> <GlossarySection />          (movida)
     ```
  
  4. **Remover** a referência à `PillarsSection`
  5. **Verificar** que o CTA Banner já foi atualizado em F1-08 (nota informativa, não CTA marketeiro)
  6. Atualizar os comentários HTML para refletir a nova numeração
  
  **Regras da constituição relevantes:**
  - Princípio IV: seções devem alternar entre `section-odd` e `section-even` para ritmo visual. Verificar que a alternância está correta na nova ordem.
  - Princípio VII: toda nova seção deve estar registrada neste arquivo na posição narrativa correta.
- **Verificação:**
  - [ ] 16 seções no `<main>` (sem PillarsSection)
  - [ ] Imports corretos para todas as novas seções
  - [ ] Ordem das seções segue §3.1

---

### F4-03: Atualizar CycleDiagram e CanonBuildingDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/diagrams/CycleDiagram.tsx` (editar)
  - `src/lib/diagrams/cycle-diagram.ts` (editar)
  - `src/components/diagrams/CanonBuildingDiagram.tsx` (editar)
  - `src/lib/diagrams/canon-building-diagram.ts` (editar)
- **Tipo:** editar
- **Dependências:** 🔗 F1-01 a F3-06
- **Paralelo com:** F4-01, F4-02, F4-04
- **Referência no plano:** §4.3 e §4.4 item 4.3
- **Contexto:**
  **CycleDiagram — atualizações:**
  - Adicionar nó de "Decisão de Continuidade" ao fluxo da Etapa 1 (com 3 caminhos: mais fluxos, mais requisitos, encerrar)
  - Adicionar canal de "Edição Direta" como ramo complementar (não faz parte do ciclo principal, mas é canal paralelo de manutenção)
  - Manter estilo visual existente (consultar `shared-config.ts` e `cycle-diagram.ts`)
  
  **CanonBuildingDiagram — atualizações:**
  - Adicionar labels de tipo de Change Plan aos gates de aprovação entre cerimônias:
    - Gate 1: `discovery-plan`
    - Gate 2: `constitution-plan`
    - Gate 3: `specification-plan`
  - Manter estilo visual existente
  
  **Regras da constituição relevantes:**
  - Princípio III: componentes React com `client:visible`
  - Princípio V: `prefers-reduced-motion` respeitado nas animações
- **Verificação:**
  - [ ] CycleDiagram mostra Decisão de Continuidade e Edição Direta
  - [ ] CanonBuildingDiagram mostra tipos de Change Plan nos gates
  - [ ] Diagramas renderizam corretamente sem erros

---

### F4-04: Revisar sectionNumber em todas as seções
- [ ] **Status**
- **Arquivo(s):** Todos os arquivos em `src/components/sections/`:
  - `HeroSection.astro` → sectionNumber 1
  - `ConsequenciasSection.astro` → sectionNumber 2
  - `SolutionBridgeSection.astro` → sectionNumber 3
  - `CycleOverviewSection.astro` → sectionNumber 4
  - `CanonBuildingSection.astro` → sectionNumber 5
  - `SpecCraftingSection.astro` → sectionNumber 6
  - `EnrichmentSection.astro` → sectionNumber 7
  - `GuardrailsSection.astro` → sectionNumber 8
  - `RolesSection.astro` → sectionNumber 9
  - `ChangePlanSection.astro` → sectionNumber 10
  - `CanonDeepDiveSection.astro` → sectionNumber 11
  - `DirectEditSection.astro` → sectionNumber 12
  - `ComparisonSection.astro` → sectionNumber 13
  - `ScenariosSection.astro` → sectionNumber 14
  - `RiscosSection.astro` → sectionNumber 15
  - `GlossarySection.astro` → sectionNumber 16
- **Tipo:** editar
- **Dependências:** 🔗 F4-01, F4-02 (precisa da estrutura final definida)
- **Paralelo com:** F4-03
- **Referência no plano:** §4.4 item 4.4
- **Contexto:**
  Verificar e corrigir o `sectionNumber` no `SectionHeader` de cada seção para que siga a sequência numérica correta conforme a nova ordem de 16 seções definida em §3.1.
  
  **Seções que precisam ter sectionNumber atualizado (mudaram de posição):**
  - `RolesSection.astro`: era 6 → agora 9
  - `ComparisonSection.astro`: era 7 → agora 13
  - `CanonDeepDiveSection.astro`: era 8 → agora 11
  - `ScenariosSection.astro`: era 9 → agora 14
  - `GlossarySection.astro`: era 10 → agora 16
  
  **Seções novas** (já devem ter o sectionNumber correto se implementadas conforme tarefas F2/F3):
  - Verificar CanonBuildingSection (5), SpecCraftingSection (6), EnrichmentSection (7), GuardrailsSection (8), ChangePlanSection (10), DirectEditSection (12), RiscosSection (15)
  
  **Seções que mantêm sectionNumber:**
  - HeroSection (1), ConsequenciasSection (2), SolutionBridgeSection (3), CycleOverviewSection (4)
  
  **Regra da constituição relevante:**
  - Princípio VII: `sectionNumber` deve seguir sequência existente (incrementando)
- **Verificação:**
  - [ ] Todas as 16 seções têm sectionNumber sequencial de 1 a 16
  - [ ] Nenhum sectionNumber duplicado
  - [ ] Números correspondem à ordem em index.astro

---

### F4-05: Atualizar RolesMatrixDiagram
- [ ] **Status**
- **Arquivo(s):**
  - `src/components/diagrams/RolesMatrixDiagram.tsx` (editar — se existir como componente separado, caso contrário está embutido no RolesSection)
  - Verificar se os dados da matriz estão em arquivo de config separado em `src/lib/diagrams/`
- **Tipo:** editar
- **Dependências:** 🔗 F1-05 (atualização da RolesSection)
- **Paralelo com:** F4-01, F4-02, F4-03, F4-04
- **Referência no plano:** §4.3 (RolesMatrixDiagram update)
- **Contexto:**
  Atualizar o diagrama/matriz de papéis:
  - Adicionar coluna "Edição Direta" à matriz
  - Adicionar linhas ou indicadores para o Protocolo de Perspectiva Assistida
  - Refletir as novas responsabilidades de cada papel conforme a tabela de atuação por etapa adicionada em F1-05
  
  **Nota:** Verificar primeiro se `RolesMatrixDiagram` é um componente React separado ou se está inline no `RolesSection.astro`. Se inline, esta tarefa pode ser absorvida pela F1-05.
- **Verificação:**
  - [ ] Coluna "Edição Direta" presente
  - [ ] Protocolo de Perspectiva Assistida representado
  - [ ] Dados consistentes com a tabela de atuação adicionada em F1-05

---

### F4-06: Verificar acessibilidade em componentes novos
- [ ] **Status**
- **Arquivo(s):** Todos os arquivos criados nas Fases 2 e 3:
  - `CanonBuildingSection.astro`
  - `SpecCraftingSection.astro`
  - `EnrichmentSection.astro`
  - `GuardrailsSection.astro`
  - `ChangePlanSection.astro`
  - `DirectEditSection.astro`
  - `RiscosSection.astro`
  - `CeremonyFlowDiagram.tsx`
  - `GuardrailsDiagram.tsx`
  - `ChangePlanEnvelopeDiagram.tsx`
  - `DirectEditFlowDiagram.tsx`
- **Tipo:** editar
- **Dependências:** 🔗 F2-01, F2-02, F2-03, F3-01, F3-02, F3-03, F3-04
- **Paralelo com:** F4-01, F4-02, F4-03, F4-04, F4-05
- **Referência no plano:** §4.4 (item frequentemente esquecido)
- **Contexto:**
  Verificar e corrigir acessibilidade em todos os componentes novos:
  
  **Para cada seção Astro (.astro):**
  - `aria-labelledby` no `<section>` apontando para o heading (ex.: `aria-labelledby="heading-canon-building"`)
  - `sectionId` passado ao `SectionHeader` para gerar o `id` no heading
  
  **Para cada diagrama React (.tsx):**
  - `prefers-reduced-motion: reduce` — desabilitar ou simplificar animações quando usuário prefere motion reduzido
  - Usar `@media (prefers-reduced-motion: reduce)` no CSS ou verificar via `window.matchMedia` no JS
  - `aria-hidden="true"` em elementos puramente decorativos (ícones, linhas decorativas)
  - `DiagramContainer` deve ter `label` e `title` descritivos
  
  **Regras da constituição relevantes:**
  - Princípio V: "Accessibility First" — WCAG 2.1 AA mínimo. Animações devem respeitar `prefers-reduced-motion`. Seções devem usar `aria-labelledby`. Elementos decorativos com `aria-hidden="true"`.
- **Verificação:**
  - [ ] Todas as 7 novas seções têm `aria-labelledby` correto
  - [ ] Todos os 4 novos diagramas respeitam `prefers-reduced-motion`
  - [ ] `DiagramContainer` com labels descritivos em todos os diagramas
