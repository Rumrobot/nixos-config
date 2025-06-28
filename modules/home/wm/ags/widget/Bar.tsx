import {For, Accessor} from "ags"
import {App, Astal, Gtk, Gdk} from "ags/gtk4"
import {createPoll} from "ags/time"
import {Hyprland} from "ags/hyprland"

const {TOP, LEFT, RIGHT} = Astal.WindowAnchor
const time = createPoll("", 1000, "date")
const hyprland = Hyprland.get_default()
let workspaces: Accessor<Array<Hyprland.Workspace>> = hyprland.workspaces

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return (
        <window
            visible
            class="Bar"
            {gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={App}>
            <centerbox cssName="centerbox">
                <box>
                    <For each={workspaces}>
                        {(workspace, index: Binding<number>) => (
                            <label label={index.as((i) => `${i}`)}/>
                        )}
                    </For>
                </box>
                <box/>
                <menubutton
                    hexpand
                    halign={Gtk.Align.CENTER}
                >
                    <label label={time()}/>
                    <popover>
                        <Gtk.Calendar/>
                    </popover>
                </menubutton>
            </centerbox>
        </window>
    )
}
