import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    host: true, // This allows external access
    port: 5173,
    allowedHosts: ['ec2-3-108-219-11.ap-south-1.compute.amazonaws.com'],
  },
});
