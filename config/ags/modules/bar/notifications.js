import { Notifications } from "../../imports.js";

import { Widget } from "../../imports.js";
const { Box, Icon, Label } = Widget;

export const Notification = () =>
  Box({
    className: "notification",
    children: [
      Icon({
        icon: "preferences-system-notifications-symbolic",
        connections: [
          [
            Notifications,
            (self) => (self.visible = Notifications.popups.length > 0),
          ],
        ],
      }),
      Label({
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
