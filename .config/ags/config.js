import { App } from "./imports.js";
import { Bar } from "./modules/bar/bar.js";

export default {
  style: `${App.configDir}/style.css`,
  windows: [Bar()],
};
