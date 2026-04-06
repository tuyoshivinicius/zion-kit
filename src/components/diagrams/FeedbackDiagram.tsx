import { ReactFlow, Background, BackgroundVariant } from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import { nodeTypes } from './NodeCard';
import { nodes, edges } from '../../lib/diagrams/feedback-diagram';
import { flowConfig, defaultEdgeOptions } from '../../lib/diagrams/shared-config';

export default function FeedbackDiagram() {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
      {/* Parte A — Retroalimentação normal */}
      <div style={{ width: '100%', height: '500px' }}>
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

      {/* Parte B — Versionamento gradual (HTML) */}
      <div style={{
        background: '#111827',
        border: '1px solid rgba(148, 163, 184, 0.1)',
        borderRadius: '0.75rem',
        padding: '1.5rem',
        fontFamily: "'JetBrains Mono', monospace",
        fontSize: '0.8rem',
        color: '#94a3b8',
        lineHeight: 1.8,
      }}>
        <div style={{ color: '#67e8f9', fontWeight: 600, marginBottom: '0.5rem' }}>
          Product Canon — Versionamento Gradual
        </div>
        <div>
          <span style={{ color: '#34d399' }}>├──</span> Versão <strong style={{ color: '#f1f5f9' }}>VIGENTE</strong>: "Faturamento"
          <span style={{ color: '#64748b' }}> ← specs de manutenção usam esta</span>
        </div>
        <div>
          <span style={{ color: '#a78bfa' }}>└──</span> Versão <strong style={{ color: '#f1f5f9' }}>EM TRANSIÇÃO</strong>: "Cobrança" + "Receita"
          <span style={{ color: '#64748b' }}> ← specs novas usam esta</span>
        </div>
        <div style={{ marginTop: '0.75rem', fontSize: '0.75rem', color: '#64748b', fontStyle: 'italic' }}>
          Migração gradual: cada spec implementada no novo modelo contribui para a transição.
        </div>
      </div>
    </div>
  );
}
