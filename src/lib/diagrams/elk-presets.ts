export type ElkPreset = Record<string, string>;

export const horizontalFlow: ElkPreset = {
  'elk.algorithm': 'layered',
  'elk.direction': 'RIGHT',
  'elk.layered.spacing.nodeNodeBetweenLayers': '80',
  'elk.spacing.nodeNode': '40',
  'elk.padding': '[top=40,left=40,bottom=40,right=40]',
};

export const verticalFlow: ElkPreset = {
  'elk.algorithm': 'layered',
  'elk.direction': 'DOWN',
  'elk.layered.spacing.nodeNodeBetweenLayers': '80',
  'elk.spacing.nodeNode': '40',
  'elk.padding': '[top=40,left=40,bottom=40,right=40]',
};

export const hierarchical: ElkPreset = {
  'elk.algorithm': 'layered',
  'elk.direction': 'DOWN',
  'elk.layered.spacing.nodeNodeBetweenLayers': '100',
  'elk.spacing.nodeNode': '50',
  'elk.layered.mergeEdges': 'true',
  'elk.padding': '[top=40,left=40,bottom=40,right=40]',
};

export const cyclicFlow: ElkPreset = {
  'elk.algorithm': 'layered',
  'elk.direction': 'DOWN',
  'elk.layered.cycleBreaking.strategy': 'GREEDY',
  'elk.layered.spacing.nodeNodeBetweenLayers': '80',
  'elk.spacing.nodeNode': '40',
  'elk.padding': '[top=40,left=40,bottom=40,right=40]',
};
