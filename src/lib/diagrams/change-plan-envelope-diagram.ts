import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  // Envelope header
  {
    id: 'envelope',
    type: 'nodeCard',
    position: { x: 220, y: 0 },
    data: {
      title: 'Canonical Change Plan',
      content: 'Envelope + Payload',
      variant: 'canon',
      icon: '📋',
      tooltip: 'Documento que descreve exatamente o que vai mudar na Product Canon. Composto por envelope (metadados) e payload (conteúdo tipado).',
    },
  },

  // Universal fields
  {
    id: 'universal',
    type: 'nodeCard',
    position: { x: 0, y: 130 },
    data: {
      title: '7 Campos Universais',
      content: [
        'id — identificador único',
        'type — um dos 5 tipos',
        'status — draft → approved',
        'author — pessoa ou papel',
        'created-at — data de criação',
        'scope — bounded contexts',
        'approvals — registro sequencial',
      ],
      variant: 'solution',
      icon: '🔒',
      tooltip: 'Campos presentes em todos os 5 tipos de Change Plan, sem exceção.',
    },
  },

  // Conditional fields
  {
    id: 'conditional',
    type: 'nodeCard',
    position: { x: 440, y: 130 },
    data: {
      title: '4 Campos Condicionais',
      content: [
        'affected-layer → incremental',
        'conditionality → incremental',
        'edited-artifacts → expert-edit',
        'compliance-report → expert-edit',
      ],
      variant: 'gate',
      icon: '⚙️',
      tooltip: 'Campos presentes apenas em tipos específicos: incremental-plan e expert-edit-plan.',
    },
  },

  // 5 types
  {
    id: 'discovery',
    type: 'nodeCard',
    position: { x: -80, y: 420 },
    data: {
      title: 'discovery-plan',
      content: 'Sessão de Descoberta (Etapa 1)',
      variant: 'default',
      icon: '🔍',
      tooltip: 'Captura fluxos, eventos, atores e agregados descobertos via Event Storming.',
    },
  },
  {
    id: 'constitution',
    type: 'nodeCard',
    position: { x: 120, y: 420 },
    data: {
      title: 'constitution-plan',
      content: 'Constituição Técnica (Etapa 1)',
      variant: 'default',
      icon: '⚖️',
      tooltip: 'Captura princípios técnicos, restrições e decisões de ADR.',
    },
  },
  {
    id: 'specification',
    type: 'nodeCard',
    position: { x: 320, y: 420 },
    data: {
      title: 'specification-plan',
      content: 'Especificação de Requisitos (Etapa 1)',
      variant: 'default',
      icon: '📐',
      tooltip: 'Captura requisitos formalizados em IEEE 29148 + SBE.',
    },
  },
  {
    id: 'expert-edit',
    type: 'nodeCard',
    position: { x: 520, y: 420 },
    data: {
      title: 'expert-edit-plan',
      content: 'Edição Direta do Domain Expert',
      variant: 'problem',
      icon: '✏️',
      tooltip: 'Refinamentos e correções fora de cerimônias. Aprovação sequencial obrigatória: Domain Expert → Architect (sem aprovação tácita).',
    },
  },
  {
    id: 'incremental',
    type: 'nodeCard',
    position: { x: 720, y: 420 },
    data: {
      title: 'incremental-plan',
      content: 'Spec Crafting (Etapa 2)',
      variant: 'default',
      icon: '📈',
      tooltip: 'Mudanças emergentes ao escrever specs. Pode ser vazio (sem aprovação) ou com impacto (roteado por camada afetada).',
    },
  },

  // Approval flow
  {
    id: 'approval',
    type: 'nodeCard',
    position: { x: 100, y: 620 },
    data: {
      title: 'Aprovação por Afinidade',
      content: [
        'Primário: papel com expertise direta',
        'Secundário: assíncrono com janela de veto',
        'Expiração = aprovação tácita',
      ],
      variant: 'solution',
      icon: '✅',
      tooltip: 'O aprovador é determinado pela competência sobre o conteúdo, não por hierarquia burocrática. Janela de veto padrão: 48h úteis.',
    },
  },

  // Exception
  {
    id: 'exception',
    type: 'nodeCard',
    position: { x: 470, y: 620 },
    data: {
      title: 'Exceção: expert-edit-plan',
      content: [
        '1. Domain Expert aprova primeiro',
        '2. Architect aprova segundo',
        'Expiração = bloqueio (não tácita)',
      ],
      variant: 'problem',
      icon: '⚠️',
      tooltip: 'Aprovação sequencial obrigatória e não-delegável. A expiração da janela do Architect bloqueia o Change Plan até manifestação ativa.',
    },
  },
];

export const edges: Edge[] = [
  // Envelope to fields
  {
    id: 'envelope-universal',
    source: 'envelope',
    target: 'universal',
    label: 'obrigatórios',
    type: 'smoothstep',
    animated: true,
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'envelope-conditional',
    source: 'envelope',
    target: 'conditional',
    label: 'por tipo',
    type: 'smoothstep',
    animated: true,
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(251, 191, 36, 0.5)', strokeWidth: 2 },
  },

  // Universal to types
  {
    id: 'universal-discovery',
    source: 'universal',
    target: 'discovery',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'universal-constitution',
    source: 'universal',
    target: 'constitution',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'universal-specification',
    source: 'universal',
    target: 'specification',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'universal-expert',
    source: 'universal',
    target: 'expert-edit',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'universal-incremental',
    source: 'universal',
    target: 'incremental',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.3)', strokeWidth: 1.5 },
  },

  // Conditional to specific types
  {
    id: 'conditional-expert',
    source: 'conditional',
    target: 'expert-edit',
    label: 'edited-artifacts + compliance-report',
    type: 'smoothstep',
    labelStyle: { fill: '#fbbf24', fontSize: 10 },
    style: { stroke: 'rgba(251, 191, 36, 0.4)', strokeWidth: 1.5 },
  },
  {
    id: 'conditional-incremental',
    source: 'conditional',
    target: 'incremental',
    label: 'affected-layer + conditionality',
    type: 'smoothstep',
    labelStyle: { fill: '#fbbf24', fontSize: 10 },
    style: { stroke: 'rgba(251, 191, 36, 0.4)', strokeWidth: 1.5 },
  },

  // Types to approval
  {
    id: 'discovery-approval',
    source: 'discovery',
    target: 'approval',
    type: 'smoothstep',
    style: { stroke: 'rgba(52, 211, 153, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'constitution-approval',
    source: 'constitution',
    target: 'approval',
    type: 'smoothstep',
    style: { stroke: 'rgba(52, 211, 153, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'specification-approval',
    source: 'specification',
    target: 'approval',
    type: 'smoothstep',
    style: { stroke: 'rgba(52, 211, 153, 0.3)', strokeWidth: 1.5 },
  },
  {
    id: 'incremental-approval',
    source: 'incremental',
    target: 'approval',
    type: 'smoothstep',
    style: { stroke: 'rgba(52, 211, 153, 0.3)', strokeWidth: 1.5 },
  },

  // Expert-edit to exception
  {
    id: 'expert-exception',
    source: 'expert-edit',
    target: 'exception',
    type: 'smoothstep',
    animated: true,
    style: { stroke: 'rgba(248, 113, 113, 0.5)', strokeWidth: 2 },
  },
];
