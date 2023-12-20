import { Widget, App, Applications } from "../../imports.js"
const { Button, Box, Icon, Label, Entry, Scrollable, Window } = Widget;
// import PixelatedIcon from '../pixelatedIcon.js';


export const applauncherWindow = "applauncher";

/** @param {import("resource:///com/github/Aylur/ags/service/applications.js").Application} app */
const AppItem = app => Button({
    on_clicked: () => {
        App.closeWindow(applauncherWindow);
        app.launch();
    },
    setup: self => self.app = app,
    child: Box({
        className: "appItem",
        children: [
            Icon({
                className: "appItemIcon",
                icon: app.icon_name || "",
                size: 42,
            }), 
            Box({
                vertical: true,
                vpack: "center",
                children: [
                    Label({
                        className: "appItemTitle",
                        label: app.name,
                        xalign: 0,
                        vpack: "center",
                        truncate: "end",
                    }),
                    !!app.description && Label({
                        className: "appItemDescription",
                        label: app.description || "",
                        wrap: true,
                        xalign: 0,
                        justification: "left",
                        vpack: "center",
                    }),
                ],
            }),
        ],
    }),
});

export const Applauncher = ({ width = 500, height = 500, spacing = 12 } = {}) => {
    const list = Box({
        vertical: true,
        spacing,
    });

    const entry = Entry({
        className: "applauncherSearch",
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        text: "-",

        on_accept: ({ text }) => {
            const list = Applications.query(text || "");
            if (list[0]) {
                App.toggleWindow(applauncherWindow);
                list[0].launch();
            }
        },

        on_change: ({ text }) => list.children.map(item => {
            item.visible = item.app.match(text);
        }),
    });

    return Box({
        className: "applauncherBox",
        vertical: true,
        css: `margin: ${spacing * 2}px;`,
        children: [
            entry,

            Scrollable({
                hscroll: "never",
                css: `
                    min-width: ${width}px;
                    min-height: ${height}px;
                `,
                child: list,
            }),
        ],

        connections: [[App, (_, name, visible) => {
            if (name !== applauncherWindow)
                return;

            list.children = Applications.list.map(AppItem);

            entry.text = "";
            if (visible)
                entry.grab_focus();
        }]],
    });
};

 export const applauncher = Window({
    name: applauncherWindow,
    popup: true,
    visible: false,
    focusable: true,
    child: Applauncher({
        width: 500,
        height: 500,
        spacing: 12,
    }),
});
