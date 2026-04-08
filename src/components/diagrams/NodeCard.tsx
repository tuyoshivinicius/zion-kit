import { useState, useCallback, useRef } from 'react';
import { Handle, Position, useReactFlow, type NodeProps } from '@xyflow/react';
import { variantColors, type NodeVariant } from '../../lib/diagrams/shared-config';

export interface NodeCardData {
  title: string;
  content: string | string[];
  variant?: NodeVariant;
  icon?: string;
  tooltip?: string;
  [key: string]: unknown;
}

export function NodeCard({ data }: NodeProps) {
  const { title, content, variant = 'default', icon, tooltip } = data as NodeCardData;
  const colors = variantColors[variant];
  const [showTooltip, setShowTooltip] = useState(false);
  const { getViewport, setViewport } = useReactFlow();
  const dragRef = useRef<{ startX: number; startY: number; vpX: number; vpY: number } | null>(null);

  const contentArray = Array.isArray(content) ? content : [content];

  const handlePointerDown = useCallback((e: React.PointerEvent) => {
    if (e.button !== 0) return;
    const vp = getViewport();
    dragRef.current = { startX: e.clientX, startY: e.clientY, vpX: vp.x, vpY: vp.y };
    (e.target as HTMLElement).setPointerCapture(e.pointerId);
  }, [getViewport]);

  const handlePointerMove = useCallback((e: React.PointerEvent) => {
    if (!dragRef.current) return;
    const dx = e.clientX - dragRef.current.startX;
    const dy = e.clientY - dragRef.current.startY;
    const vp = getViewport();
    setViewport({ x: dragRef.current.vpX + dx, y: dragRef.current.vpY + dy, zoom: vp.zoom });
  }, [getViewport, setViewport]);

  const handlePointerUp = useCallback(() => {
    dragRef.current = null;
  }, []);

  return (
    <div
      style={{
        background: colors.bg,
        border: `1px solid ${colors.border}`,
        borderRadius: '0.75rem',
        padding: '1rem 1.25rem',
        minWidth: '180px',
        maxWidth: '260px',
        boxShadow: variant === 'canon' ? '0 0 20px rgba(34, 211, 238, 0.15)' : undefined,
        position: 'relative',
        cursor: 'grab',
      }}
      tabIndex={0}
      role="group"
      aria-label={title}
      onPointerDown={handlePointerDown}
      onPointerMove={handlePointerMove}
      onPointerUp={handlePointerUp}
      onPointerCancel={handlePointerUp}
      onMouseEnter={() => tooltip && setShowTooltip(true)}
      onMouseLeave={() => setShowTooltip(false)}
      onFocus={() => tooltip && setShowTooltip(true)}
      onBlur={() => setShowTooltip(false)}
      onClick={() => tooltip && setShowTooltip(prev => !prev)}
      onKeyDown={(e) => {
        if (tooltip && (e.key === 'Enter' || e.key === ' ')) {
          e.preventDefault();
          setShowTooltip(prev => !prev);
        }
      }}
      aria-describedby={tooltip ? `tooltip-${title.replace(/\s/g, '-')}` : undefined}
    >
      <Handle type="target" position={Position.Top} style={{ opacity: 0 }} />
      <Handle type="target" position={Position.Left} id="left" style={{ opacity: 0 }} />
      <Handle type="target" position={Position.Right} id="right" style={{ opacity: 0 }} />

      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.375rem' }}>
        {icon && (
          <span style={{ fontSize: '1.125rem' }} aria-hidden="true">{icon}</span>
        )}
        <strong style={{
          fontSize: '0.875rem',
          fontWeight: 600,
          color: variant === 'canon' ? '#67e8f9' : '#f1f5f9',
          lineHeight: 1.3,
        }}>
          {title}
        </strong>
      </div>

      {contentArray.map((line, i) => (
        <p key={i} style={{
          fontSize: '0.75rem',
          color: '#94a3b8',
          lineHeight: 1.5,
          margin: 0,
        }}>
          {line}
        </p>
      ))}

      {tooltip && showTooltip && (
        <div
          id={`tooltip-${title.replace(/\s/g, '-')}`}
          role="tooltip"
          style={{
            position: 'absolute',
            bottom: '100%',
            left: '50%',
            transform: 'translateX(-50%)',
            marginBottom: '8px',
            background: '#1e293b',
            border: '1px solid rgba(148, 163, 184, 0.2)',
            borderRadius: '0.5rem',
            padding: '0.75rem 1rem',
            fontSize: '0.75rem',
            color: '#f1f5f9',
            lineHeight: 1.5,
            maxWidth: '240px',
            zIndex: 100,
            boxShadow: '0 4px 12px rgba(0,0,0,0.4)',
            pointerEvents: 'none',
            whiteSpace: 'normal',
          }}
        >
          {tooltip}
        </div>
      )}

      <Handle type="source" position={Position.Bottom} style={{ opacity: 0 }} />
      <Handle type="source" position={Position.Left} id="left-source" style={{ opacity: 0 }} />
      <Handle type="source" position={Position.Right} id="right-source" style={{ opacity: 0 }} />
    </div>
  );
}

export const nodeTypes = {
  nodeCard: NodeCard,
};
