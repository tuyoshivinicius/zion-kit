import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  {
    id: 'canon',
    type: 'nodeCard',
    position: { x: 200, y: 0 },
    data: {
      title: 'Product Canon',
      content: 'Conhecimento formalizado',
      variant: 'canon',
      icon: '📚',
    },
  },
  {
    id: 'spec',
    type: 'nodeCard',
    position: { x: 200, y: 170 },
    data: {
      title: 'Especificação de Funcionalidade',
      content: [
        '✓ Vocabulário consistente?',
        '✓ Regras de negócio respeitadas?',
        '✓ Decisões técnicas compatíveis?',
        '⚠ Impactos identificados',
      ],
      variant: 'default',
      icon: '📝',
    },
  },
  {
    id: 'plan',
    type: 'nodeCard',
    position: { x: 200, y: 400 },
    data: {
      title: 'Plano de Mudanças Incremental',
      content: [
        'Negócio: termos, regras novas',
        'Arquitetura: eventos, schemas',
        '→ Aprovação por responsáveis',
      ],
      variant: 'solution',
      icon: '📑',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'canon-spec',
    source: 'canon',
    target: 'spec',
    type: 'smoothstep',
    label: 'contexto relevante injetado',
    animated: true,
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'spec-plan',
    source: 'spec',
    target: 'plan',
    type: 'smoothstep',
    label: 'impactos documentados',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(52, 211, 153, 0.5)', strokeWidth: 2 },
  },
];
