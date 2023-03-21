import "./ninja"
import $ from "jquery"

document.addEventListener(
  "keydown",
  (event) => {
    var name = event.key
    switch (name) {
      case "?":
        $("#help").toggleClass("hidden")
        break
      // case "a":
      // goToAddNewNotePate()
      // break
    }
  },
  false
)

function goToAddNewNotePate() {
  window.location.href = "/notes/new"
}
