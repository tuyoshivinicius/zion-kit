import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  {
    id: 'impl',
    type: 'nodeCard',
    position: { x: 0, y: 0 },
    data: {
      title: 'Implementação concluída',
      content: 'Funcionalidade entregue',
      variant: 'default',
      icon: '✅',
    },
  },
  {
    id: 'discoveries',
    type: 'nodeCard',
    position: { x: 0, y: 170 },
    data: {
      title: 'Descobertas emergentes',
      content: [
        '• Termos novos',
        '• Regras não documentadas',
        '• Decisões técnicas',
      ],
      variant: 'solution',
      icon: '💡',
    },
  },
  {
    id: 'canon-updated',
    type: 'nodeCard',
    position: { x: 0, y: 380 },
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
    id: 'impl-disc',
    source: 'impl',
    target: 'discoveries',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'disc-canon',
    source: 'discoveries',
    target: 'canon-updated',
    type: 'smoothstep',
    animated: true,
    label: 'retroalimentação',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
];
