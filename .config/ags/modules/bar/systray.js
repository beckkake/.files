import { SystemTray } from "../../imports.js";
import { Widget } from "../../imports.js";
const { Label, Box, Button, Icon, Revealer, EventBox } = Widget;

export const RevIcon = Label({
  className: "trayBtn",
  label: "<",
});

export const TrayItems = () =>
  Box({
    className: "trayIcons",
    connections: [
      [
        SystemTray,
        (self) => {
          self.children = SystemTray.items.map((item) =>
            Button({
              className: "trayIcon",
              child: Icon({ binds: [["icon", item, "icon"]] }),
              binds: [["tooltip-markup", item, "tooltip-markup"]],
              on_primary_click: (_, event) => item.activate(event),
            })
          );
        },
      ],
    ],
  });

export const trayRevealer = Revealer({
  transition: "slide_right",
  child: TrayItems(),
});

export const Tray = () =>
  EventBox({
    on_primary_click: (self) => {
      trayRevealer.revealChild = !trayRevealer.revealChild;
      revIcon.label = trayRevealer.revealChild ? ">" : "<";
    },
    child: Box({
      className: "tray",
      children: [trayRevealer, RevIcon],
    }),
  });
