import { App } from "./imports.js";
import { Bar } from "./modules/bar/bar.js";
import { applauncher } from "./modules/applauncher/applauncher.js";


export default {
  style: `${App.configDir}/style.css`,
  windows: [Bar(), applauncher],
  
};
