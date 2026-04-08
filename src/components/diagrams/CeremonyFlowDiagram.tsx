import { useMemo } from 'react';
import { ReactFlow, Background, BackgroundVariant } from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import { nodeTypes } from './NodeCard';
import { nodes, edges } from '../../lib/diagrams/ceremony-flow-diagram';
import { defaultEdgeOptions } from '../../lib/diagrams/shared-config';
import { useResponsiveFlow } from '../../lib/diagrams/use-responsive-flow';
import { useReducedMotion } from '../../lib/diagrams/use-reduced-motion';

export default function CeremonyFlowDiagram() {
  const responsiveConfig = useResponsiveFlow();
  const prefersReducedMotion = useReducedMotion();
  const safeEdges = useMemo(
    () => prefersReducedMotion ? edges.map(e => ({ ...e, animated: false })) : edges,
    [prefersReducedMotion]
  );
  return (
    <div style={{ width: '100%', height: '620px' }}>
      <ReactFlow
        defaultNodes={nodes}
        defaultEdges={safeEdges}
        nodeTypes={nodeTypes}
        defaultEdgeOptions={defaultEdgeOptions}
        {...responsiveConfig}
        aria-label="Fluxo sequencial das três cerimônias do Canon Building com gates de aprovação e decisão de continuidade"
        tabIndex={0}
      >
        <Background variant={BackgroundVariant.Dots} color="rgba(148, 163, 184, 0.08)" gap={20} size={1} aria-hidden="true" />
      </ReactFlow>
    </div>
  );
}
