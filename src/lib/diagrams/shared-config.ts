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
  decision: {
    border: '#a78bfa',
    bg: 'rgba(167, 139, 250, 0.05)',
    icon: '#a78bfa',
  },
  complementary: {
    border: '#f472b6',
    bg: 'rgba(244, 114, 182, 0.05)',
    icon: '#f472b6',
  },
} as const;

export type NodeVariant = keyof typeof variantColors;
