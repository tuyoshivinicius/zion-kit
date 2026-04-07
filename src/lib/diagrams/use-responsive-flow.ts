import { useState, useEffect, useCallback, useRef } from 'react';
import { flowConfig, mobileFlowConfig, desktopFlowConfig } from './shared-config';
import type { ReactFlowInstance } from '@xyflow/react';

const MOBILE_BREAKPOINT = 768;

export function useResponsiveFlow() {
  const [isMobile, setIsMobile] = useState(
    typeof window !== 'undefined' ? window.innerWidth < MOBILE_BREAKPOINT : false
  );
  const instanceRef = useRef<ReactFlowInstance | null>(null);

  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
      if (instanceRef.current) {
        const padding = window.innerWidth < MOBILE_BREAKPOINT ? 0.05 : 0.15;
        setTimeout(() => instanceRef.current?.fitView({ padding }), 50);
      }
    };
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const onInit = useCallback((instance: ReactFlowInstance) => {
    instanceRef.current = instance;
    const padding = window.innerWidth < MOBILE_BREAKPOINT ? 0.05 : 0.15;
    // Multiple attempts to ensure fitView works after rendering
    instance.fitView({ padding });
    setTimeout(() => instance.fitView({ padding }), 50);
    setTimeout(() => instance.fitView({ padding }), 200);
  }, []);

  const config = isMobile ? mobileFlowConfig : desktopFlowConfig;

  return { ...config, onInit };
}
