import type { Node, Edge } from '@xyflow/react';

// Layout manual — fluxo iterativo com feedback loop.
// ELK cyclicFlow cria coluna única com back-edges confusos.
export const layoutOptions = null;

export const nodes: Node[] = [
  {
    id: 'propose',
    type: 'nodeCard',
    position: { x: 0, y: 140 },
    data: {
      title: '1. Proposta',
      content: 'Domain Expert propõe alteração em linguagem natural',
      variant: 'default',
      icon: '✏️',
      tooltip: 'O Domain Expert descreve a mudança em formato livre — correção factual, ajuste de definição ou mudança regulatória.',
    },
  },
  {
    id: 'guardrails',
    type: 'nodeCard',
    position: { x: 280, y: 0 },
    data: {
      title: '2. Guardrails Simultâneos',
      content: [
        'Clarificação de Conformidade',
        'Validação Semântica (SBVR)',
        'Validação de Consistência',
        'Padronização Canônica (IEEE 29148 + SBE)',
      ],
      variant: 'solution',
      icon: '🛡️',
      tooltip: 'A IA executa 4 guardrails simultaneamente sobre a proposta do Domain Expert.',
    },
  },
  {
    id: 'report',
    type: 'nodeCard',
    position: { x: 570, y: 0 },
    data: {
      title: '3. Relatório de Conformidade',
      content: [
        'Divergências terminológicas',
        'Contradições com regras existentes',
        'Impactos em bounded contexts',
        'Divergências intencionais aceitas',
      ],
      variant: 'canon',
      icon: '📋',
      tooltip: 'Documento gerado pela IA com 4 seções fixas — o Domain Expert apenas revisa.',
    },
  },
  {
    id: 'review',
    type: 'nodeCard',
    position: { x: 400, y: 250 },
    data: {
      title: '4. Decisão do Domain Expert',
      content: 'Aceitar, ajustar, responder clarificações ou reescrever',
      variant: 'gate',
      icon: '🔄',
      tooltip: 'O Domain Expert revisa a versão formalizada e o relatório. O ciclo repete até resolução.',
    },
  },
  {
    id: 'plan',
    type: 'nodeCard',
    position: { x: 740, y: 180 },
    data: {
      title: '5. expert-edit-plan',
      content: 'Change Plan com versão formalizada + relatório + impactos',
      variant: 'canon',
      icon: '📄',
      tooltip: 'Change Plan tipado como expert-edit-plan, contendo a versão formalizada e o Relatório de Conformidade.',
    },
  },
  {
    id: 'approve-de',
    type: 'nodeCard',
    position: { x: 700, y: 370 },
    data: {
      title: 'Aprovação: Domain Expert',
      content: 'Valida fidelidade semântica',
      variant: 'gate',
      icon: '✅',
      tooltip: 'Primeiro aprovador — confirma que a formalização preserva a intenção original.',
    },
  },
  {
    id: 'approve-arch',
    type: 'nodeCard',
    position: { x: 980, y: 370 },
    data: {
      title: 'Aprovação: Architect',
      content: 'Valida impacto técnico (obrigatória)',
      variant: 'gate',
      icon: '🔒',
      tooltip: 'Segundo aprovador — avalia impacto técnico. Obrigatória e não delegável. Expiração = bloqueio.',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'propose-guardrails',
    source: 'propose',
    target: 'guardrails',
    type: 'smoothstep',
    label: 'submete',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'guardrails-report',
    source: 'guardrails',
    target: 'report',
    type: 'smoothstep',
    animated: true,
    label: 'gera',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'report-review',
    source: 'report',
    target: 'review',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'review-guardrails',
    source: 'review',
    target: 'guardrails',
    type: 'smoothstep',
    label: 'ajustes',
    animated: true,
    labelStyle: { fill: '#fbbf24', fontSize: 11 },
    style: { stroke: 'rgba(251, 191, 36, 0.4)', strokeWidth: 2, strokeDasharray: '6 3' },
  },
  {
    id: 'review-plan',
    source: 'review',
    target: 'plan',
    type: 'smoothstep',
    label: 'aceita',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'plan-approve-de',
    source: 'plan',
    target: 'approve-de',
    type: 'smoothstep',
    label: '1º',
    labelStyle: { fill: '#fbbf24', fontSize: 12, fontWeight: 700 },
    style: { stroke: 'rgba(251, 191, 36, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'approve-de-arch',
    source: 'approve-de',
    target: 'approve-arch',
    type: 'smoothstep',
    label: '2º (sequencial)',
    labelStyle: { fill: '#fbbf24', fontSize: 11, fontWeight: 700 },
    style: { stroke: 'rgba(251, 191, 36, 0.5)', strokeWidth: 2 },
  },
];
