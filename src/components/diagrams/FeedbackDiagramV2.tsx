import { useRef } from 'react';
import SvgConnector from '../ui/SvgConnector';
import { variantColors } from '../../lib/diagrams/shared-config';

// ─── Layout 3×5 (diamond / bifurcation) ──────────────────────────────────────
//  col:      1                2                3
//  row 1:    .                impl             .
//  row 2:    explicit-signal  .                ai-detection
//  row 3:    .                guardrails       .
//  row 4:    async-review     .                escalation
//  row 5:    .                canon-updated    .
// ─────────────────────────────────────────────────────────────────────────────

type NodeVariant = keyof typeof variantColors;

interface CardDef {
  id: string;
  title: string;
  lines: string[];
  icon: string;
  variant: NodeVariant;
  col: number;
  row: number;
}

const CARDS: CardDef[] = [
  {
    id: 'impl',
    title: 'Implementação concluída',
    lines: ['Funcionalidade entregue'],
    icon: '✅',
    variant: 'default',
    col: 2,
    row: 1,
  },
  {
    id: 'explicit-signal',
    title: 'Sinalização explícita',
    lines: ['Tag CANON-DISCOVERY', 'Anotação inline ou artefato', 'Mecanismo primário'],
    icon: '📌',
    variant: 'solution',
    col: 1,
    row: 2,
  },
  {
    id: 'ai-detection',
    title: 'Detecção assistida (IA)',
    lines: ['Compara código vs Canon', 'Candidatos não sinalizados', 'Rede de segurança'],
    icon: '🔍',
    variant: 'canon',
    col: 3,
    row: 2,
  },
  {
    id: 'guardrails',
    title: 'Guardrails',
    lines: ['Padronização Canônica', 'Validação de Consistência', 'Clarificação de Conformidade'],
    icon: '🛡️',
    variant: 'gate',
    col: 2,
    row: 3,
  },
  {
    id: 'async-review',
    title: 'Revisão assíncrona',
    lines: ['Janela de veto', 'Aprovação tácita se expirar', 'Ajustes sem impacto cross-context'],
    icon: '✅',
    variant: 'solution',
    col: 1,
    row: 4,
  },
  {
    id: 'escalation',
    title: 'Escalação — Change Plan',
    lines: ['specification-plan', 'constitution-plan', 'discovery-plan'],
    icon: '⚠️',
    variant: 'problem',
    col: 3,
    row: 4,
  },
  {
    id: 'canon-updated',
    title: 'Product Canon atualizada',
    lines: ['Mais rica que antes'],
    icon: '📚',
    variant: 'canon',
    col: 2,
    row: 5,
  },
];

// Mobile order: top-to-bottom reading order
const MOBILE_ORDER = ['impl', 'explicit-signal', 'ai-detection', 'guardrails', 'async-review', 'escalation', 'canon-updated'];

// ─── Connections ──────────────────────────────────────────────────────────────

const GREEN_CONNECTIONS = [
  { from: '#fv2-impl',           to: '#fv2-explicit-signal', label: 'descobertas' },
  { from: '#fv2-explicit-signal', to: '#fv2-guardrails' },
  { from: '#fv2-guardrails',     to: '#fv2-async-review', label: 'sem problemas' },
  { from: '#fv2-async-review',   to: '#fv2-canon-updated', animated: true },
];

const CYAN_CONNECTIONS = [
  { from: '#fv2-impl',        to: '#fv2-ai-detection', label: 'análise automática' },
  { from: '#fv2-ai-detection', to: '#fv2-guardrails' },
];

const YELLOW_CONNECTIONS = [
  { from: '#fv2-guardrails',  to: '#fv2-escalation', label: 'com problemas' },
  { from: '#fv2-escalation',  to: '#fv2-canon-updated', animated: true, label: 'após aprovação' },
];

// ─── Sub-components ───────────────────────────────────────────────────────────

function DiagramCard({ card, isCenter }: { card: CardDef; isCenter?: boolean }) {
  const colors = variantColors[card.variant];
  return (
    <div
      id={`fv2-${card.id}`}
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
        <span style={{ fontSize: isCenter ? 18 : 15, lineHeight: 1 }} aria-hidden="true">
          {card.icon}
        </span>
        <span
          style={{
            fontSize: isCenter ? 12 : 11,
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

export default function FeedbackDiagramV2() {
  const containerRef = useRef<HTMLDivElement>(null);
  const byId = Object.fromEntries(CARDS.map((c) => [c.id, c]));

  return (
    <div style={{ width: '100%', display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
      {/* ── Part A — Flow diagram ── */}
      <div
        role="img"
        aria-label="Fluxo de retroalimentação: Implementação bifurca em Sinalização explícita e Detecção assistida, ambas convergem em Guardrails, que bifurca em Revisão assíncrona ou Escalação, ambas convergindo em Product Canon atualizada"
      >
        {/* Desktop grid */}
        <div ref={containerRef} className="fv2-desktop" style={{ position: 'relative' }}>
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(3, 1fr)',
              gridTemplateRows: 'repeat(5, auto)',
              gap: 16,
            }}
          >
            {CARDS.map((card) => (
              <div
                key={card.id}
                style={{ gridColumn: card.col, gridRow: card.row }}
              >
                <DiagramCard
                  card={card}
                  isCenter={card.id === 'impl' || card.id === 'guardrails' || card.id === 'canon-updated'}
                />
              </div>
            ))}
          </div>

          <SvgConnector
            connections={GREEN_CONNECTIONS}
            containerRef={containerRef as React.RefObject<HTMLElement>}
            strokeColor="rgba(52, 211, 153, 0.55)"
            strokeWidth={2}
          />
          <SvgConnector
            connections={CYAN_CONNECTIONS}
            containerRef={containerRef as React.RefObject<HTMLElement>}
            strokeColor="rgba(34, 211, 238, 0.55)"
            strokeWidth={2}
          />
          <SvgConnector
            connections={YELLOW_CONNECTIONS}
            containerRef={containerRef as React.RefObject<HTMLElement>}
            strokeColor="rgba(251, 191, 36, 0.55)"
            strokeWidth={2}
          />
        </div>

        {/* Mobile list */}
        <div className="fv2-mobile" style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {MOBILE_ORDER.map((id) => (
            <DiagramCard
              key={id}
              card={byId[id]}
              isCenter={id === 'impl' || id === 'guardrails' || id === 'canon-updated'}
            />
          ))}
        </div>
      </div>

      {/* ── Part B — Gradual versioning ── */}
      <div
        style={{
          background: '#111827',
          border: '1px solid rgba(148, 163, 184, 0.1)',
          borderRadius: '0.75rem',
          padding: '1.5rem',
          fontFamily: "'JetBrains Mono', monospace",
          fontSize: '0.8rem',
          color: '#94a3b8',
          lineHeight: 1.8,
        }}
      >
        <div style={{ color: '#67e8f9', fontWeight: 600, marginBottom: '0.5rem' }}>
          Product Canon — Versionamento Gradual
        </div>
        <div>
          <span style={{ color: '#34d399' }}>├──</span> Versão{' '}
          <strong style={{ color: '#f1f5f9' }}>VIGENTE</strong>: "Faturamento"
          <span style={{ color: '#64748b' }}> ← specs de manutenção usam esta</span>
        </div>
        <div>
          <span style={{ color: '#a78bfa' }}>└──</span> Versão{' '}
          <strong style={{ color: '#f1f5f9' }}>EM TRANSIÇÃO</strong>: "Cobrança" + "Receita"
          <span style={{ color: '#64748b' }}> ← specs novas usam esta</span>
        </div>
        <div
          style={{
            marginTop: '0.75rem',
            fontSize: '0.75rem',
            color: '#64748b',
            fontStyle: 'italic',
          }}
        >
          Migração gradual: cada spec implementada no novo modelo contribui para a transição.
        </div>
      </div>

      <style>{`
        .fv2-desktop { display: block; }
        .fv2-mobile  { display: none;  }

        @media (max-width: 600px) {
          .fv2-desktop { display: none; }
          .fv2-mobile  { display: flex; }
        }
      `}</style>
    </div>
  );
}
