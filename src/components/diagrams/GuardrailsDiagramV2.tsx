import { useRef } from 'react';
import SvgConnector from '../ui/SvgConnector';
import { variantColors } from '../../lib/diagrams/shared-config';

// ─── Layout 3×3 ──────────────────────────────────────────────────────────────
//  [compliance]  [enrichment]  [consistency]
//  [building]    [canon]       [crafting]
//  [semantic]    [strangler]   [formatting]
// ─────────────────────────────────────────────────────────────────────────────

const GRID_AREAS: Record<string, { col: number; row: number }> = {
  compliance: { col: 1, row: 1 },
  enrichment: { col: 2, row: 1 },
  consistency: { col: 3, row: 1 },
  building:   { col: 1, row: 2 },
  canon:      { col: 2, row: 2 },
  crafting:   { col: 3, row: 2 },
  semantic:   { col: 1, row: 3 },
  strangler:  { col: 2, row: 3 },
  formatting: { col: 3, row: 3 },
};

type NodeVariant = keyof typeof variantColors;

interface CardDef {
  id: string;
  title: string;
  subtitle: string;
  icon: string;
  variant: NodeVariant;
}

const ALL_CARDS: CardDef[] = [
  // Guardrails
  { id: 'compliance',  title: '1. Clarificação de Conformidade', subtitle: 'Alinhamento terminológico',    icon: '🔤', variant: 'gate'     },
  { id: 'consistency', title: '2. Validação de Consistência',    subtitle: 'Contradições com regras',      icon: '⚖️', variant: 'gate'     },
  { id: 'semantic',    title: '3. Validação Semântica',          subtitle: 'Detecção de ambiguidades',     icon: '🔍', variant: 'gate'     },
  { id: 'formatting',  title: '4. Padronização Canônica',        subtitle: 'Formato IEEE 29148 + SBE',     icon: '📐', variant: 'gate'     },
  { id: 'strangler',   title: '5. Versionamento',               subtitle: 'Faces current / next',         icon: '🌿', variant: 'solution' },
  // Canon
  { id: 'canon',       title: 'Product Canon',                  subtitle: 'Repositório central protegido', icon: '📚', variant: 'canon'    },
  // Stages
  { id: 'building',    title: 'Canon Building',                 subtitle: 'Etapa 1',                       icon: '🔨', variant: 'default'  },
  { id: 'crafting',    title: 'Spec Crafting',                  subtitle: 'Etapa 2',                       icon: '📝', variant: 'default'  },
  { id: 'enrichment',  title: 'Canon Enrichment',               subtitle: 'Etapa 3',                       icon: '🔄', variant: 'default'  },
];

// Mobile order: canon first, then guardrails 1-5, then stages
const MOBILE_ORDER = ['canon', 'compliance', 'consistency', 'semantic', 'formatting', 'strangler', 'building', 'crafting', 'enrichment'];

// Connections grouped by color
const GATE_CONNECTIONS = [
  { from: '#gv2-compliance',  to: '#gv2-canon', label: 'protege',       animated: true },
  { from: '#gv2-consistency', to: '#gv2-canon', label: 'protege',       animated: true },
  { from: '#gv2-semantic',    to: '#gv2-canon', label: 'protege',       animated: true },
  { from: '#gv2-formatting',  to: '#gv2-canon', label: 'protege',       animated: true },
];

const STRANGLER_CONNECTIONS = [
  { from: '#gv2-strangler',   to: '#gv2-canon', label: 'versiona',      animated: true },
];

const STAGE_CONNECTIONS = [
  { from: '#gv2-building',    to: '#gv2-compliance',  dashed: true },
  { from: '#gv2-building',    to: '#gv2-semantic',    dashed: true },
  { from: '#gv2-crafting',    to: '#gv2-consistency', dashed: true },
  { from: '#gv2-crafting',    to: '#gv2-formatting',  dashed: true },
  { from: '#gv2-enrichment',  to: '#gv2-canon',       label: 'retroalimenta', dashed: true },
];

// ─── Sub-components ───────────────────────────────────────────────────────────

interface DiagramCardProps {
  card: CardDef;
  isCenter?: boolean;
}

function DiagramCard({ card, isCenter }: DiagramCardProps) {
  const colors = variantColors[card.variant];
  return (
    <div
      id={`gv2-${card.id}`}
      style={{
        background: colors.bg,
        border: `1px solid ${colors.border}`,
        borderRadius: 10,
        padding: isCenter ? '14px 16px' : '10px 12px',
        display: 'flex',
        flexDirection: 'column',
        gap: 4,
        minWidth: 0,
        boxShadow: isCenter ? `0 0 20px ${colors.border}40` : undefined,
        transition: 'box-shadow 0.2s ease',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
        <span style={{ fontSize: isCenter ? 20 : 16, lineHeight: 1 }} aria-hidden="true">
          {card.icon}
        </span>
        <span
          style={{
            fontSize: isCenter ? 13 : 11,
            fontWeight: 600,
            color: colors.icon,
            lineHeight: 1.3,
          }}
        >
          {card.title}
        </span>
      </div>
      <span
        style={{
          fontSize: 10,
          color: 'rgba(148, 163, 184, 0.7)',
          lineHeight: 1.3,
          paddingLeft: 2,
        }}
      >
        {card.subtitle}
      </span>
    </div>
  );
}

// ─── Main component ───────────────────────────────────────────────────────────

export default function GuardrailsDiagramV2() {
  const containerRef = useRef<HTMLDivElement>(null);

  const byId = Object.fromEntries(ALL_CARDS.map((c) => [c.id, c]));

  return (
    <div
      style={{ width: '100%' }}
      role="img"
      aria-label="Guardrails da Product Canon — cinco camadas de proteção mostrando onde cada guardrail atua no ciclo"
    >
      {/* ── Desktop grid ── */}
      <div
        ref={containerRef}
        className="gv2-desktop"
        style={{ position: 'relative' }}
      >
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(3, 1fr)',
            gridTemplateRows: 'repeat(3, auto)',
            gap: 16,
          }}
        >
          {Object.entries(GRID_AREAS).map(([id, { col, row }]) => (
            <div
              key={id}
              style={{ gridColumn: col, gridRow: row }}
            >
              <DiagramCard card={byId[id]} isCenter={id === 'canon'} />
            </div>
          ))}
        </div>

        {/* SVG connectors — three layers with distinct colors */}
        <SvgConnector
          connections={GATE_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(251, 191, 36, 0.55)"
          strokeWidth={2}
        />
        <SvgConnector
          connections={STRANGLER_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(52, 211, 153, 0.55)"
          strokeWidth={2}
        />
        <SvgConnector
          connections={STAGE_CONNECTIONS}
          containerRef={containerRef as React.RefObject<HTMLElement>}
          strokeColor="rgba(148, 163, 184, 0.3)"
          strokeWidth={1}
        />
      </div>

      {/* ── Mobile list ── */}
      <div className="gv2-mobile" style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {MOBILE_ORDER.map((id) => (
          <DiagramCard key={id} card={byId[id]} isCenter={id === 'canon'} />
        ))}
      </div>

      <style>{`
        .gv2-desktop { display: block; }
        .gv2-mobile  { display: none;  }

        @media (max-width: 600px) {
          .gv2-desktop { display: none;  }
          .gv2-mobile  { display: flex;  }
        }
      `}</style>
    </div>
  );
}
