import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  {
    id: 'knowledge',
    type: 'nodeCard',
    position: { x: 0, y: 0 },
    data: {
      title: 'Conhecimento do produto',
      content: 'Disperso, informal, tácito',
      variant: 'default',
      icon: '🧠',
    },
  },
  {
    id: 'spec',
    type: 'nodeCard',
    position: { x: 300, y: 0 },
    data: {
      title: 'Especificação',
      content: 'Sem contexto do produto',
      variant: 'default',
      icon: '📄',
    },
  },
  {
    id: 'code',
    type: 'nodeCard',
    position: { x: 600, y: 0 },
    data: {
      title: 'Código gerado',
      content: 'Decisões silenciosas',
      variant: 'default',
      icon: '💻',
    },
  },
  {
    id: 'bugs',
    type: 'nodeCard',
    position: { x: 600, y: 150 },
    data: {
      title: 'Bugs de lógica de negócio',
      content: 'Descobertos em produção',
      variant: 'problem',
      icon: '🐛',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'knowledge-spec',
    source: 'knowledge',
    target: 'spec',
    type: 'smoothstep',
    animated: false,
    style: { stroke: '#f87171', strokeWidth: 2, strokeDasharray: '8 4' },
    label: '❌ vazio',
    labelStyle: { fill: '#f87171', fontSize: 11 },
  },
  {
    id: 'spec-code',
    source: 'spec',
    target: 'code',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'code-bugs',
    source: 'code',
    target: 'bugs',
    type: 'smoothstep',
    style: { stroke: '#f87171', strokeWidth: 2 },
    label: 'resultado',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
  },
];
