import { ReactFlow, Background, BackgroundVariant } from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import { nodeTypes } from './NodeCard';
import { nodes, edges } from '../../lib/diagrams/canon-building-diagram';
import { flowConfig, defaultEdgeOptions } from '../../lib/diagrams/shared-config';

export default function CanonBuildingDiagram() {
  return (
    <div style={{ width: '100%', height: '380px' }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        nodeTypes={nodeTypes}
        defaultEdgeOptions={defaultEdgeOptions}
        {...flowConfig}
      >
        <Background variant={BackgroundVariant.Dots} color="rgba(148, 163, 184, 0.08)" gap={20} size={1} />
      </ReactFlow>
    </div>
  );
}
