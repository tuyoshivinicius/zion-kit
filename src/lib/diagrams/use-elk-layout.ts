import { useState, useEffect, useRef, useMemo } from 'react';
import type { Node, Edge } from '@xyflow/react';
import type { ElkPreset } from './elk-presets';

interface ElkPort {
  id: string;
  side: 'NORTH' | 'SOUTH' | 'EAST' | 'WEST';
}

export interface UseElkLayoutOptions {
  nodes: Node[];
  edges: Edge[];
  layoutOptions: ElkPreset;
  defaultNodeWidth?: number;
  defaultNodeHeight?: number;
}

export interface UseElkLayoutResult {
  nodes: Node[];
  edges: Edge[];
  isLayouted: boolean;
  boundingBox: { width: number; height: number } | null;
}

export function useElkLayout({
  nodes: rawNodes,
  edges: rawEdges,
  layoutOptions,
  defaultNodeWidth = 220,
  defaultNodeHeight = 100,
}: UseElkLayoutOptions): UseElkLayoutResult {
  const [result, setResult] = useState<UseElkLayoutResult>({
    nodes: [],
    edges: [],
    isLayouted: false,
    boundingBox: null,
  });

  const elkRef = useRef<import('elkjs/lib/elk.bundled.js').default | null>(null);

  const inputKey = useMemo(
    () => JSON.stringify({ nodes: rawNodes.map(n => n.id), edges: rawEdges.map(e => e.id), layoutOptions }),
    [rawNodes, rawEdges, layoutOptions],
  );

  useEffect(() => {
    if (typeof window === 'undefined') return;

    let cancelled = false;

    async function runLayout() {
      if (!elkRef.current) {
        const ELK = (await import('elkjs/lib/elk.bundled.js')).default;
        elkRef.current = new ELK();
      }
      const elk = elkRef.current;

      const elkNodes = rawNodes.map(node => {
        const w = (node.data as Record<string, unknown>).width as number | undefined ?? defaultNodeWidth;
        const h = (node.data as Record<string, unknown>).height as number | undefined ?? defaultNodeHeight;
        const elkPorts = (node.data as Record<string, unknown>).elkPorts as ElkPort[] | undefined;

        const elkNode: Record<string, unknown> = {
          id: node.id,
          width: w,
          height: h,
        };

        if (elkPorts?.length) {
          elkNode.ports = elkPorts.map(p => ({
            id: `${node.id}-${p.id}`,
            properties: { 'port.side': p.side },
          }));
          elkNode.properties = { 'portConstraints': 'FIXED_SIDE' };
        }

        return elkNode;
      });

      const elkEdges = rawEdges.map(edge => {
        const sourceHandle = edge.sourceHandle;
        const targetHandle = edge.targetHandle;

        return {
          id: edge.id,
          sources: [sourceHandle ? `${edge.source}-${sourceHandle}` : edge.source],
          targets: [targetHandle ? `${edge.target}-${targetHandle}` : edge.target],
        };
      });

      const graph = {
        id: 'root',
        layoutOptions,
        children: elkNodes,
        edges: elkEdges,
      };

      try {
        const layoutResult = await elk.layout(graph);

        if (cancelled) return;

        const positionedNodes = rawNodes.map(node => {
          const elkChild = layoutResult.children?.find(c => c.id === node.id);
          if (!elkChild) return node;
          return {
            ...node,
            position: { x: elkChild.x ?? 0, y: elkChild.y ?? 0 },
          };
        });

        let maxX = 0;
        let maxY = 0;
        for (const child of layoutResult.children ?? []) {
          const right = (child.x ?? 0) + (child.width ?? 0);
          const bottom = (child.y ?? 0) + (child.height ?? 0);
          if (right > maxX) maxX = right;
          if (bottom > maxY) maxY = bottom;
        }

        setResult({
          nodes: positionedNodes,
          edges: rawEdges,
          isLayouted: true,
          boundingBox: { width: maxX, height: maxY },
        });
      } catch {
        if (cancelled) return;
        setResult({
          nodes: rawNodes,
          edges: rawEdges,
          isLayouted: true,
          boundingBox: null,
        });
      }
    }

    runLayout();
    return () => { cancelled = true; };
  }, [inputKey, rawNodes, rawEdges, layoutOptions, defaultNodeWidth, defaultNodeHeight]);

  return result;
}
