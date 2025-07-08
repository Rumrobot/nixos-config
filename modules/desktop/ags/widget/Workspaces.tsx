import { For, createBinding, type Accessor, type Binding } from "ags"
import { Gtk } from "ags/gtk4"
import AstalHyprland from "gi://AstalHyprland"

const hyprland = AstalHyprland.get_default()

export default function Workspaces(props: {
  /** pass `true` for vertical, `false` for horizontal */
  vertical: boolean | Accessor<boolean>
}) {
  // Hook into GObject properties as reactive Accessors
  const workspaces: Accessor<AstalHyprland.Workspace[]> =
    createBinding(hyprland, "workspaces")
  const focused: Accessor<AstalHyprland.Workspace> =
    createBinding(hyprland, "focusedWorkspace")

  return (
    <widget
      // GTK4 layout-manager replaces Astal.Box
      layoutManager={new Gtk.BoxLayout({
        orientation: props.vertical
          ? Gtk.Orientation.VERTICAL
          : Gtk.Orientation.HORIZONTAL,
        spacing: 6,
      })}
      hexpand
      halign={Gtk.Align.CENTER}
    >
      {/* Dynamically render buttons for each workspace */}
      <For each={workspaces}>
        {(ws, idx: Binding<number>) => (
          <button
            // ws.as(fn) is the v3 way to map an Accessor → prop
            label={`${ws.id}`}
            className={ws.id === hyprland.get_focused_workspace().id
                ? "ws-button focused"
                : "ws-button"
            }
            onClicked={() => ws.focus()}
          />
        )}
      </For>
    </widget>
  )
}
