import { parse } from "./markdown"
import $ from "jquery"

let isSaved = false

const setSaved = (saved: boolean) => {
  isSaved = saved
  console.log("setSaved", saved)
  if (saved) {
    $("#preview").removeClass("changed")
    $("#save-button").addClass("disabled")
    window.onbeforeunload = null
  } else {
    window.onbeforeunload = () => {
      return "You have unsaved changes. Are you sure you want to leave?"
    }
    $("#preview").addClass("changed")
    $("#save-button").removeClass("disabled")
  }
}

setSaved(true)

const save = () => {
  setSaved(true)
}

const preview = document.getElementById("preview")
if (preview) {
  const markdown = document.getElementById("markdown") as HTMLTextAreaElement
  preview.innerHTML = parse(markdown.value)
}

const markdown = document.getElementById("markdown")
if (markdown) {
  markdown.addEventListener("keyup", (event) => {
    const target = event.target as HTMLTextAreaElement

    if (isSaved) {
      setSaved(false)
    }
    if (preview) {
      preview.innerHTML = parse(target.value)
    }
  })
}

const saveButton = document.getElementById("save-button")
if (saveButton) {
  saveButton.addEventListener("click", save)
}
