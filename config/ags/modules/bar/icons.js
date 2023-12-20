import { Widget, App } from "../../imports.js"
import { applauncherWindow } from "../applauncher/applauncher.js"
const { Label, Button, Box } = Widget;
// import PixelatedIcon from '../pixelatedIcon.js';

export const Search = Button({ child: Label({className: "barIconSearch",
label: "◉"}),
on_primary_click: () => App.openWindow(applauncherWindow)})

export const Home = Label({
  className: "barIconHome",
  label: " ",
});
  
/** export const Test = Box({child: PixelatedIcon({
  icon: "dialog-information-symbolic"
})}); /**  */bf