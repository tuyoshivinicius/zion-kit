import type { Edge } from '@xyflow/react';

export const defaultEdgeOptions: Partial<Edge> = {
  type: 'smoothstep',
  style: {
    stroke: 'rgba(34, 211, 238, 0.5)',
    strokeWidth: 2,
  },
};

export const flowConfig = {
  fitView: true,
  panOnDrag: false,
  zoomOnScroll: false,
  zoomOnPinch: false,
  zoomOnDoubleClick: false,
  preventScrolling: false,
  proOptions: { hideAttribution: true },
} as const;

export const mobileFlowConfig = {
  ...flowConfig,
} as const;

export const desktopFlowConfig = {
  ...flowConfig,
  zoomOnScroll: true,
  zoomOnPinch: true,
} as const;

export const variantColors = {
  default: {
    border: 'rgba(148, 163, 184, 0.1)',
    bg: '#111827',
    icon: '#94a3b8',
  },
  problem: {
    border: '#f87171',
    bg: 'rgba(248, 113, 113, 0.05)',
    icon: '#f87171',
  },
  solution: {
    border: '#34d399',
    bg: 'rgba(52, 211, 153, 0.05)',
    icon: '#34d399',
  },
  gate: {
    border: '#fbbf24',
    bg: 'rgba(251, 191, 36, 0.05)',
    icon: '#fbbf24',
  },
  canon: {
    border: '#22d3ee',
    bg: 'rgba(34, 211, 238, 0.08)',
    icon: '#22d3ee',
  },
} as const;

export type NodeVariant = keyof typeof variantColors;
