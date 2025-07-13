import AstalBattery from "gi://AstalBattery"
import { createBinding } from "ags"

const battery = AstalBattery.Device
const percentage = createBinding(battery.get_default(), "percentage")

export default function Battery() {
  return (
    <box>
      <label label={percentage((perc) => `${Math.round(perc * 100)}\%`)} />
    </box>
  )
}
