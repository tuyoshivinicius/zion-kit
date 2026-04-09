import { useRef } from 'react';
import SvgConnector from '../ui/SvgConnector';
import { variantColors } from '../../lib/diagrams/shared-config';

// ─── Layout CSS Grid (named areas) ────────────────────────────────────────────
//  col:      1            2            3
//  row 1:    .            canon        .
//  row 2:    build        .            feedback
//  row 3:    continuity   .            direct-edit
//  row 4:    .            use          .
// ─────────────────────────────────────────────────────────────────────────────

type NodeVariant = keyof typeof variantColors;

interface CardDef {
  id: string;
  title: string;
  lines: string[];
  icon: string;
  variant: NodeVariant;
  area: string;
  isHub?: boolean;
}

const CARDS: CardDef[] = [
  {
    id: 'canon',
    title: 'Product Canon',
    lines: ['Repositório vivo de conhecimento'],
    icon: '📚',
    variant: 'canon',
    area: 'canon',
    isHub: true,
  },
  {
    id: 'build',
    title: 'Etapa 1 — Construir',
    lines: ['3 sessões formais com aprovação'],
    icon: '🔨',
    variant: 'default',
    area: 'build',
  },
  {
    id: 'continuity',
    title: 'Decisão de Continuidade',
    lines: [
      'a) Mais fluxos → Discovery',
      'b) Mais requisitos → Specification',
      'c) Encerrar → Etapa 2',
    ],
    icon: '🔀',
    variant: 'decision',
    area: 'continuity',
  },
  {
    id: 'use',
    title: 'Etapa 2 — Usar para Especificar',
    lines: ['Contexto injetado automaticamente'],
    icon: '📝',
    variant: 'default',
    area: 'use',
  },
  {
    id: 'feedback',
    title: 'Etapa 3 — Devolver o Aprendizado',
    lines: ['Retroalimentação formal'],
    icon: '🔄',
    variant: 'default',
    area: 'feedback',
  },
  {
    id: 'direct-edit',
    title: 'Edição Direta',
    lines: ['Canal complementar', 'Domain Expert + IA', 'expert-edit-plan'],
    icon: '✏️',
    variant: 'complementary',
    area: 'direct-edit',
  },
];

const MOBILE_ORDER = ['canon', 'build', 'continuity', 'use', 'feedback', 'direct-edit'];

// ─── Connections ──────────────────────────────────────────────────────────────
// Cyan — main cycle flow
const CYAN_CONNECTIONS = [
  {
    from: '#cv2-canon',
    to: '#cv2-build',
    label: 'contexto injetado',
    animated: true,
    fromSide: 'left' as const,
    toSide: 'top' as const,
  },
  {
    from: '#cv2-build',
    to: '#cv2-continuity',
    fromSide: 'bottom' as const,
    toSide: 'top' as const,
  },
  {
    from: '#cv2-use',
    to: '#cv2-feedback',
    fromSide: 'right' as const,
    toSide: 'bottom' as const,
  },
  {
    from: '#cv2-feedback',
    to: '#cv2-canon',
    label: 'descobertas',
    animated: true,
    fromSide: 'top' as const,
    toSide: 'right' as const,
  },
];

// Purple — decision paths
const PURPLE_CONNECTIONS = [
  {
    from: '#cv2-continuity',
    to: '#cv2-build',
    label: 'mais fluxos / requisitos',
    animated: true,
    fromSide: 'left' as const,
    toSide: 'left' as const,
  },
  {
    from: '#cv2-continuity',
    to: '#cv2-use',
    label: 'encerrar ciclo',
    fromSide: 'bottom' as const,
    toSide: 'left' as const,
  },
];

// Pink — direct-edit complementary channel (dashed)
const PINK_CONNECTIONS = [
  {
    from: '#cv2-direct-edit',
    to: '#cv2-canon',
    label: 'expert-edit-plan',
    animated: true,
    dashed: true,
    fromSide: 'right' as const,
    toSide: 'right' as const,
  },
];

// ─── Sub-components ───────────────────────────────────────────────────────────

function DiagramCard({ card }: { card: CardDef }) {
  const colors = variantColors[card.variant];
  return (
    <div
      id={`cv2-${card.id}`}
      style={{
        background: colors.bg,
        border: `1px solid ${colors.border}`,
        borderRadius: 10,
        padding: card.isHub ? '14px 18px' : '10px 14px',
        display: 'flex',
        flexDirection: 'column',
        gap: 4,
        minWidth: 0,
        boxShadow: card.isHub ? `0 0 24px ${colors.border}40` : undefined,
        transition: 'box-shadow 0.2s ease',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
        <span style={{ fontSize: card.isHub ? 18 : 15, lineHeight: 1 }} aria-hidden="true">
          {card.icon}
        </span>
        <span
          style={{
            fontSize: card.isHub ? 12 : 11,
            fontWeight: 600,
            color: colors.icon,
            lineHeight: 1.3,
          }}
        >
          {card.title}
        </span>
      </div>
      {card.lines.map((line, i) => (
        <span
          key={i}
          style={{
            fontSize: 10,
            color: 'rgba(148, 163, 184, 0.7)',
            lineHeight: 1.4,
            paddingLeft: 2,
          }}
        >
          • {line}
        </span>
      ))}
    </div>
  );
}

// ─── Main component ───────────────────────────────────────────────────────────

export default function CycleDiagramV2() {
  const containerRef = useRef<HTMLDivElement>(null);
  const byId = Object.fromEntries(CARDS.map((c) => [c.id, c]));

  return (
    <div
      style={{ width: '100%' }}
      role="img"
      aria-label="Ciclo do ZionKit — Product Canon alimenta o Canon Building (Etapa 1), que leva à Decisão de Continuidade. A decisão pode retornar ao Canon Building ou encerrar o ciclo e avançar para o Spec Crafting (Etapa 2). O Spec Crafting alimenta o Canon Enrichment (Etapa 3), que devolve descobertas à Product Canon. A Edição Direta é um canal complementar que atualiza a Product Canon via expert-edit-plan."
    >
      {/* ── Desktop grid ── */}
      <div ref={containerRef} className="cv2-desktop" style={{ position: 'relative' }}>
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: '1fr 1fr 1fr',
            gridTemplateRows: 'auto auto auto auto',
            gridTemplateAreas: `
              ". canon ."
              "build . feedback"
              "continuity . direct-edit"
              ". use ."
            `,
            gap: 16,
          }}
        >
          {CARDS.map((card) => (
            <div key={card.id} style={{ gridArea: card.area }}>
              <DiagramCard card={card} />
            </div>
          ))}
        </div>

        <SvgConnector
          connections={CYAN_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(34, 211, 238, 0.55)"
          strokeWidth={2}
        />
        <SvgConnector
          connections={PURPLE_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(167, 139, 250, 0.55)"
          strokeWidth={2}
        />
        <SvgConnector
          connections={PINK_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(244, 114, 182, 0.55)"
          strokeWidth={2}
        />
      </div>

      {/* ── Mobile list ── */}
      <div className="cv2-mobile" style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {MOBILE_ORDER.map((id) => (
          <DiagramCard key={id} card={byId[id]} />
        ))}
      </div>

      <style>{`
        .cv2-desktop { display: block; }
        .cv2-mobile  { display: none;  }

        @media (max-width: 600px) {
          .cv2-desktop { display: none;  }
          .cv2-mobile  { display: flex;  }
        }
      `}</style>
    </div>
  );
}
