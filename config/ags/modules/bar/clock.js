import { Utils, Widget } from "../../imports.js";
const { execAsync } = Utils;
const { Label } = Widget;

export const Clock = () =>
  Label({
    className: "barClock",
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
