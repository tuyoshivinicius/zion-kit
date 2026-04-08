import { useState, useEffect } from 'react';
import { flowConfig, mobileFlowConfig, desktopFlowConfig } from './shared-config';

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

  return config;
}
