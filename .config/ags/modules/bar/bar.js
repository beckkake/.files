import { Widget } from "../../imports.js";
const { Box, Window, CenterBox } = Widget;

import { Tray } from "./systray.js";
import { Notification } from "./notifications.js";
import { Clock } from "./clock.js";
import { Search, Home } from "./icons.js";

const Left = () =>
  Box({
    children: [Search],
  });

const Center = () =>
  Box({
    children: [Notification()],
  });

const Right = () =>
  Box({
    hpack: "end",
    children: [Tray(), Clock(), Home],
  });

export const Bar = ({ monitor } = {}) =>
  Window({
    className: "window",
    name: `bar-${monitor}`,
    monitor,
    anchor: ["top", "left", "right"],
    exclusive: true,
    child: CenterBox({
      className: "bar",
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });
