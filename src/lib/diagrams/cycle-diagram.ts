import type { Node, Edge } from '@xyflow/react';

export const nodes: Node[] = [
  {
    id: 'canon',
    type: 'nodeCard',
    position: { x: 250, y: 0 },
    data: {
      title: 'Product Canon',
      content: 'Repositório vivo de conhecimento',
      variant: 'canon',
      icon: '📚',
      tooltip: 'Repositório central versionado com regras, vocabulário, processos e decisões técnicas do produto.',
    },
  },
  {
    id: 'build',
    type: 'nodeCard',
    position: { x: 0, y: 200 },
    data: {
      title: 'Etapa 1 — Construir',
      content: '3 sessões formais com aprovação',
      variant: 'default',
      icon: '🔨',
      tooltip: '3 sessões guiadas por IA: Descoberta de Processos, Constituição Técnica e Especificação de Requisitos.',
    },
  },
  {
    id: 'use',
    type: 'nodeCard',
    position: { x: 250, y: 350 },
    data: {
      title: 'Etapa 2 — Usar para Especificar',
      content: 'Contexto injetado automaticamente',
      variant: 'default',
      icon: '📝',
      tooltip: 'A IA carrega contexto relevante da Product Canon e confronta a spec com o conhecimento existente.',
    },
  },
  {
    id: 'feedback',
    type: 'nodeCard',
    position: { x: 500, y: 200 },
    data: {
      title: 'Etapa 3 — Devolver o Aprendizado',
      content: 'Retroalimentação formal',
      variant: 'default',
      icon: '🔄',
      tooltip: 'Termos novos, regras descobertas, eventos e decisões técnicas voltam para a Product Canon.',
    },
  },
];

export const edges: Edge[] = [
  {
    id: 'canon-build',
    source: 'canon',
    target: 'build',
    label: 'contexto injetado',
    animated: true,
    type: 'smoothstep',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'build-use',
    source: 'build',
    target: 'use',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'use-feedback',
    source: 'use',
    target: 'feedback',
    type: 'smoothstep',
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
  {
    id: 'feedback-canon',
    source: 'feedback',
    target: 'canon',
    label: 'descobertas',
    animated: true,
    type: 'smoothstep',
    labelStyle: { fill: '#94a3b8', fontSize: 11 },
    style: { stroke: 'rgba(34, 211, 238, 0.5)', strokeWidth: 2 },
  },
];
