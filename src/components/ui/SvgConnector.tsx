import { useLayoutEffect, useEffect, useCallback, useMemo, useRef, useState } from 'react';

interface Connection {
  from: string;
  to: string;
  label?: string;
  animated?: boolean;
  dashed?: boolean;
  fromSide?: 'top' | 'bottom' | 'left' | 'right';
  toSide?: 'top' | 'bottom' | 'left' | 'right';
}

interface SvgConnectorProps {
  connections: Connection[];
  containerRef: React.RefObject<HTMLElement>;
  strokeColor?: string;
  strokeWidth?: number;
  className?: string;
}

interface PathData {
  d: string;
  midX: number;
  midY: number;
  markerId: string;
  animated: boolean;
  dashed: boolean;
  label?: string;
}

function getAnchorPoint(
  rect: DOMRect,
  containerRect: DOMRect,
  side: 'top' | 'bottom' | 'left' | 'right'
): { x: number; y: number } {
  const left = rect.left - containerRect.left;
  const top = rect.top - containerRect.top;
  const cx = left + rect.width / 2;
  const cy = top + rect.height / 2;

  switch (side) {
    case 'top':    return { x: cx, y: top };
    case 'bottom': return { x: cx, y: top + rect.height };
    case 'left':   return { x: left, y: cy };
    case 'right':  return { x: left + rect.width, y: cy };
  }
}

function getAutoSides(
  fromRect: DOMRect,
  toRect: DOMRect,
  containerRect: DOMRect
): { fromSide: 'top' | 'bottom' | 'left' | 'right'; toSide: 'top' | 'bottom' | 'left' | 'right' } {
  const fCx = fromRect.left - containerRect.left + fromRect.width / 2;
  const fCy = fromRect.top - containerRect.top + fromRect.height / 2;
  const tCx = toRect.left - containerRect.left + toRect.width / 2;
  const tCy = toRect.top - containerRect.top + toRect.height / 2;

  const dx = tCx - fCx;
  const dy = tCy - fCy;

  if (Math.abs(dx) > Math.abs(dy)) {
    return dx > 0
      ? { fromSide: 'right', toSide: 'left' }
      : { fromSide: 'left', toSide: 'right' };
  } else {
    return dy > 0
      ? { fromSide: 'bottom', toSide: 'top' }
      : { fromSide: 'top', toSide: 'bottom' };
  }
}

function buildCubicPath(
  from: { x: number; y: number },
  to: { x: number; y: number },
  fromSide: 'top' | 'bottom' | 'left' | 'right',
  toSide: 'top' | 'bottom' | 'left' | 'right'
): { d: string; midX: number; midY: number } {
  const CTRL_OFFSET = 50;

  const sideOffset = (side: 'top' | 'bottom' | 'left' | 'right'): { dx: number; dy: number } => {
    switch (side) {
      case 'top':    return { dx: 0, dy: -CTRL_OFFSET };
      case 'bottom': return { dx: 0, dy: CTRL_OFFSET };
      case 'left':   return { dx: -CTRL_OFFSET, dy: 0 };
      case 'right':  return { dx: CTRL_OFFSET, dy: 0 };
    }
  };

  const fc = sideOffset(fromSide);
  const tc = sideOffset(toSide);

  const cp1x = from.x + fc.dx;
  const cp1y = from.y + fc.dy;
  const cp2x = to.x + tc.dx;
  const cp2y = to.y + tc.dy;

  // Midpoint on the bezier at t=0.5
  const midX =
    0.125 * from.x +
    0.375 * cp1x +
    0.375 * cp2x +
    0.125 * to.x;
  const midY =
    0.125 * from.y +
    0.375 * cp1y +
    0.375 * cp2y +
    0.125 * to.y;

  return {
    d: `M ${from.x} ${from.y} C ${cp1x} ${cp1y}, ${cp2x} ${cp2y}, ${to.x} ${to.y}`,
    midX,
    midY,
  };
}

export default function SvgConnector({
  connections,
  containerRef,
  strokeColor = 'rgba(34, 211, 238, 0.5)',
  strokeWidth = 2,
  className,
}: SvgConnectorProps) {
  const [paths, setPaths] = useState<PathData[]>([]);
  const prefersReducedMotion = useRef(
    typeof window !== 'undefined' &&
      window.matchMedia('(prefers-reduced-motion: reduce)').matches
  );

  const markerId = useMemo(() => `arrow-${Math.random().toString(36).slice(2, 7)}`, []);

  const calculatePaths = useCallback(() => {
    const container = containerRef.current;
    if (!container) return;

    const containerRect = container.getBoundingClientRect();
    const result: PathData[] = [];

    for (let i = 0; i < connections.length; i++) {
      const conn = connections[i];
      const fromEl = container.querySelector(conn.from);
      const toEl = container.querySelector(conn.to);
      if (!fromEl || !toEl) continue;

      const fromRect = fromEl.getBoundingClientRect();
      const toRect = toEl.getBoundingClientRect();

      const { fromSide, toSide } = conn.fromSide && conn.toSide
        ? { fromSide: conn.fromSide, toSide: conn.toSide }
        : getAutoSides(fromRect, toRect, containerRect);

      const fromAnchor = getAnchorPoint(fromRect, containerRect, fromSide);
      const toAnchor = getAnchorPoint(toRect, containerRect, toSide);

      const { d, midX, midY } = buildCubicPath(fromAnchor, toAnchor, fromSide, toSide);

      result.push({
        d,
        midX,
        midY,
        markerId: `${markerId}-${i}`,
        animated: !prefersReducedMotion.current && (conn.animated ?? false),
        dashed: conn.dashed ?? false,
        label: conn.label,
      });
    }

    setPaths(result);
  }, [connections, containerRef, markerId]);

  useLayoutEffect(() => {
    calculatePaths();
  }, [calculatePaths]);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const observer = new ResizeObserver(calculatePaths);
    observer.observe(container);

    return () => observer.disconnect();
  }, [containerRef, calculatePaths]);

  if (paths.length === 0) return null;

  return (
    <>
      <svg
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          pointerEvents: 'none',
          overflow: 'visible',
        }}
        className={className}
        aria-hidden="true"
      >
        <defs>
          {paths.map((path) => (
            <marker
              key={path.markerId}
              id={path.markerId}
              markerWidth="8"
              markerHeight="6"
              refX="7"
              refY="3"
              orient="auto"
              markerUnits="userSpaceOnUse"
            >
              <polygon
                points="0 0, 8 3, 0 6"
                fill={strokeColor}
              />
            </marker>
          ))}

          {paths.some((p) => p.animated) && (
            <style>{`
              @keyframes svgConnectorDash {
                from { stroke-dashoffset: 24; }
                to   { stroke-dashoffset: 0; }
              }
            `}</style>
          )}
        </defs>

        {paths.map((path, i) => {
          const dashArray = path.dashed || path.animated ? '8 4' : undefined;
          const animation = path.animated
            ? 'svgConnectorDash 1.5s linear infinite'
            : undefined;

          return (
            <path
              key={i}
              d={path.d}
              fill="none"
              stroke={strokeColor}
              strokeWidth={strokeWidth}
              strokeDasharray={dashArray}
              style={{
                filter: 'drop-shadow(0 0 4px rgba(34, 211, 238, 0.3))',
                animation,
              }}
              markerEnd={`url(#${path.markerId})`}
            />
          );
        })}
      </svg>

      {paths.map((path, i) =>
        path.label ? (
          <div
            key={i}
            style={{
              position: 'absolute',
              left: path.midX,
              top: path.midY,
              transform: 'translate(-50%, -50%)',
              fontSize: '0.75rem',
              background: 'rgba(15, 23, 42, 0.8)',
              color: 'rgba(34, 211, 238, 0.9)',
              borderRadius: '4px',
              padding: '2px 6px',
              pointerEvents: 'none',
              whiteSpace: 'nowrap',
              lineHeight: 1.4,
            }}
          >
            {path.label}
          </div>
        ) : null
      )}
    </>
  );
}
