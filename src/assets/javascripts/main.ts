import "bootstrap"
import { marked } from "marked"
import "./keys/index"

const preview = document.getElementById("preview")
if (preview) {
  preview.innerHTML = marked(
    "# Marked in the browser \n\nRendered by \n- [X] **marked**."
  )
}

const markdown = document.getElementById("markdown")
if (markdown) {
  markdown.addEventListener("keyup", (event) => {
    const target = event.target as HTMLTextAreaElement
    if (preview) {
      preview.innerHTML = marked(target.value)
    }
  })
}
