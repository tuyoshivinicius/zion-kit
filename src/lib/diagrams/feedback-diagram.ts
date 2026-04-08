import type { Node, Edge } from '@xyflow/react';

// Layout manual — padrão diamante com bifurcação.
// ELK layered empilha tudo verticalmente, perdendo a forma de diamante.
export const layoutOptions = null;

export const nodes: Node[] = [
  {
    id: 'impl',
    type: 'nodeCard',
    position: { x: 120, y: 0 },
    data: {
      title: 'Implementação concluída',
      content: 'Funcionalidade entregue',
      variant: 'default',
      icon: '✅',
    },
  },
  {
    id: 'explicit-signal',
    type: 'nodeCard',
    position: { x: 0, y: 140 },
    data: {
      title: 'Sinalização explícita',
      content: [
        '• Tag CANON-DISCOVERY',
        '• Anotação inline ou artefato',
        '• Mecanismo primário',
      ],
      variant: 'solution',
      icon: '📌',
    },
  },
  {
    id: 'ai-detection',
    type: 'nodeCard',
    position: { x: 280, y: 140 },
    data: {
      title: 'Detecção assistida (IA)',
      content: [
        '• Compara código vs Canon',
        '• Candidatos não sinalizados',
        '• Rede de segurança',
      ],
      variant: 'canon',
      icon: '🔍',
    },
  },
  {
    id: 'guardrails',
    type: 'nodeCard',
    position: { x: 120, y: 310 },
    data: {
      title: 'Guardrails',
      content: [
        '• Padronização Canônica',
        '• Validação de Consistência',
        '• Clarificação de Conformidade',
      ],
      variant: 'gate',
      icon: '🛡️',
    },
  },
  {
    id: 'async-review',
    type: 'nodeCard',
    position: { x: 0, y: 480 },
    data: {
      title: 'Revisão assíncrona',
      content: [
        '• Janela de veto',
        '• Aprovação tácita se expirar',
        '• Ajustes sem impacto cross-context',
      ],
      variant: 'solution',
      icon: '✅',
    },
  },
  {
    id: 'escalation',
    type: 'nodeCard',
    position: { x: 280, y: 480 },
    data: {
      title: 'Escalação — Change Plan formal',
      content: [
        '• specification-plan',
        '• constitution-plan',
        '• discovery-plan',
      ],
      variant: 'problem',
      icon: '⚠️',
    },
  },
  {
    id: 'canon-updated',
    type: 'nodeCard',
    position: { x: 120, y: 650 },
    data: {
      title: 'Product Canon atualizada',
      content: 'Mais rica que antes',
      variant: 'canon',
      icon: '📚',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'impl-explicit',
    source: 'impl',
    target: 'explicit-signal',
    type: 'smoothstep',
    label: 'descobertas',
    labelStyle: { fill: '#94a3b8', fontSize: 10 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'impl-ai',
    source: 'impl',
    target: 'ai-detection',
    type: 'smoothstep',
    label: 'análise automática',
    labelStyle: { fill: '#94a3b8', fontSize: 10 },
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'explicit-guardrails',
    source: 'explicit-signal',
    target: 'guardrails',
    type: 'smoothstep',
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'ai-guardrails',
    source: 'ai-detection',
    target: 'guardrails',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'guardrails-async',
    source: 'guardrails',
    target: 'async-review',
    type: 'smoothstep',
    label: 'sem problemas',
    labelStyle: { fill: '#34d399', fontSize: 10, fontWeight: 600 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'guardrails-escalation',
    source: 'guardrails',
    target: 'escalation',
    type: 'smoothstep',
    label: 'com problemas',
    labelStyle: { fill: '#fbbf24', fontSize: 10, fontWeight: 600 },
    style: { stroke: 'rgba(251, 191, 36, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'async-canon',
    source: 'async-review',
    target: 'canon-updated',
    type: 'smoothstep',
    animated: true,
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'escalation-canon',
    source: 'escalation',
    target: 'canon-updated',
    type: 'smoothstep',
    animated: true,
    label: 'após aprovação',
    labelStyle: { fill: '#94a3b8', fontSize: 10 },
    style: { stroke: 'rgba(251, 191, 36, 0.5)', strokeWidth: 2 },
  },
];
