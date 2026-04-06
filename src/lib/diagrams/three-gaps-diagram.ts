import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  {
    id: 'gap1',
    type: 'nodeCard',
    position: { x: 0, y: 0 },
    data: {
      title: 'IA SEM CONTEXTO',
      content: [
        'A IA gera código sem saber',
        'as regras do produto',
      ],
      variant: 'problem',
      icon: '🤖',
    },
  },
  {
    id: 'gap2',
    type: 'nodeCard',
    position: { x: 280, y: 0 },
    data: {
      title: 'NEGÓCIO EXCLUÍDO',
      content: [
        'Quem conhece o produto',
        'não participa da especificação',
      ],
      variant: 'problem',
      icon: '🚫',
    },
  },
  {
    id: 'gap3',
    type: 'nodeCard',
    position: { x: 560, y: 0 },
    data: {
      title: 'CONHECIMENTO DESCARTÁVEL',
      content: [
        'Descobertas da implementação',
        'morrem no código e na memória',
      ],
      variant: 'problem',
      icon: '🗑️',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'gap1-gap2',
    source: 'gap1',
    target: 'gap2',
    type: 'smoothstep',
    style: { stroke: 'rgba(248, 113, 113, 0.3)', strokeWidth: 1, strokeDasharray: '4 4' },
    sourceHandle: null,
    targetHandle: null,
  },
  {
    id: 'gap2-gap3',
    source: 'gap2',
    target: 'gap3',
    type: 'smoothstep',
    style: { stroke: 'rgba(248, 113, 113, 0.3)', strokeWidth: 1, strokeDasharray: '4 4' },
  },
];
