import { Widget, App } from "../../imports.js"
import { applauncherWindow } from "../applauncher/applauncher.js"
const { Label, Button } = Widget;

export const Search = Button({ child: Label({className: "barIconSearch",
label: "◉"}),
on_primary_click: () => App.openWindow(applauncherWindow)})

const openLauncher = () => App.openWindow(applauncherWindow)

export const Home = Label({
  className: "barIconHome",
  label: " ",
});