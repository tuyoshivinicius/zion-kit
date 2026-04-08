import { useState, useEffect, useCallback } from 'react';
import type { ReactFlowInstance } from '@xyflow/react';
import { mobileFlowConfig, desktopFlowConfig } from './shared-config';

const MOBILE_BREAKPOINT = 768;

export function useResponsiveFlow() {
  const [isMobile, setIsMobile] = useState(
    typeof window !== 'undefined' ? window.innerWidth < MOBILE_BREAKPOINT : false
  );

  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
    };
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const config = isMobile ? mobileFlowConfig : desktopFlowConfig;

  const onInit = useCallback((instance: ReactFlowInstance) => {
    // Re-run fitView after a frame to handle content-visibility: auto
    // race condition where container may have 0 dimensions on first render
    requestAnimationFrame(() => {
      instance.fitView(config.fitViewOptions);
    });
  }, [config.fitViewOptions]);

  return { ...config, onInit };
}
