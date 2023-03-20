import "./ninja"

document.addEventListener(
  "keydown",
  (event) => {
    var name = event.key
    switch (name) {
      case "?":
        console.log("show help")
        break
    }
  },
  false
)
