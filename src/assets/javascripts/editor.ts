import { parse } from "./markdown"
import $ from "jquery"

let isSaved = false

const setSaved = (saved: boolean) => {
  isSaved = saved
  if (saved) {
    $("#preview").removeClass("changed")
    $("#save").addClass("disabled")
    window.onbeforeunload = null
  } else {
    window.onbeforeunload = () => {
      return "You have unsaved changes. Are you sure you want to leave?"
    }
    $("#preview").addClass("changed")
    $("#save").removeClass("disabled")
  }
}

const save = () => {
  const markdown = $("#markdown").val()
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

    if (!isSaved) {
      setSaved(false)
    }
    if (preview) {
      preview.innerHTML = parse(target.value)
    }
  })
}
