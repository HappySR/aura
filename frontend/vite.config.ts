import dotenv from "dotenv";
import { resolve } from "path";
import { defineConfig } from "vite";
import { sveltekit } from "@sveltejs/kit/vite";

dotenv.config({ path: resolve(__dirname, "../.env") });

export default defineConfig({
  define: {
    "process.env": process.env,
  },
  plugins: [sveltekit()],
});
