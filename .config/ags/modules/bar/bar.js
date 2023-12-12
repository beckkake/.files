import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const Clock = () =>
  Widget.Label({
    className: "clock",
    connections: [
      [
        1000,
        (self) =>
          execAsync(["date", "+%I:%M"])
            .then((date) => (self.label = date))
            .catch(console.error),
      ],
    ],
  });

const Notification = () =>
  Widget.Box({
    className: "notification",
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
        connections: [
          [
            Notifications,
            (self) => (self.visible = Notifications.popups.length > 0),
          ],
        ],
      }),
      Widget.Label({
        connections: [
          [
            Notifications,
            (self) => {
              self.label = Notifications.popups[0]?.summary || "";
            },
          ],
        ],
      }),
    ],
  });

const RevIcon = () =>
  Widget.Label({
    className: "systraybtn",
    label: "<",
  });

const TrayItems = () =>
  Widget.Box({
    className: "trayIcons",
    connections: [
      [
        SystemTray,
        (self) => {
          self.children = SystemTray.items.map((item) =>
            Widget.Button({
              className: "trayIcon",
              child: Widget.Icon({ binds: [["icon", item, "icon"]] }),
              binds: [["tooltip-markup", item, "tooltip-markup"]],
              on_primary_click: (_, event) => item.activate(event),
            })
          );
        },
      ],
    ],
  });

export const Tray = () =>
  Widget.EventBox({
    on_primary_click: (self) => {
      self.child.children[0].label = self.child.children[1].revealChild
        ? "<"
        : "<";
      self.child.children[1].revealChild = !self.child.children[1].revealChild;
    },
    child: Widget.Box({
      className: "tray",
      children: [
        RevIcon(),
        Widget.Revealer({
          transition: "slide_left",
          child: TrayItems(),
        }),
      ],
    }),
  });

const Tag = Widget.Label({
  className: "tag",
  label: "⌕",
});

const Home = Widget.Label({
  className: "home",
  label: "",
});

const Left = () =>
  Widget.Box({
    className: "leftBox",
    children: [Tag],
  });

const Center = () =>
  Widget.Box({
    children: [Notification()],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [Tray(), Clock(), Home],
  });

export const Bar = ({ monitor } = {}) =>
  Widget.Window({
    className: "window",
    name: `bar-${monitor}`,
    monitor,
    anchor: ["top", "left", "right"],
    exclusive: true,
    child: Widget.CenterBox({
      className: "bar",
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });
