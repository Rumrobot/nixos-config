import { For, Accessor } from "ags";
import App from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { createPoll } from "ags/time";
import Workspaces from "./Workspaces";
import Battery from "./Battery";

const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
const time = createPoll("", 1000, "date");

export default function Bar(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      visible
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <box></box>
      <box>
        <Battery />
      </box>
    </window>
  );
}
