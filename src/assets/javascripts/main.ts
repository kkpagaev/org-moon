import $ from "jquery"
import "bootstrap"
import "./keys/index"
import { parse } from "./markdown"

const preview = document.getElementById("preview")
if (preview) {
  preview.innerHTML = parse(
    "# Marked in the browser \n\nRendered by :rose: \n- [X] **marked**."
  )
}

const markdown = document.getElementById("markdown")
if (markdown) {
  markdown.addEventListener("keyup", (event) => {
    const target = event.target as HTMLTextAreaElement
    if (preview) {
      preview.innerHTML = parse(target.value)
    }
  })
}
