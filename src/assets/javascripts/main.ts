import "bootstrap"
import "./keys/index"
import "./editor"
import "./tags"
import $ from "jquery"

$("input[content]").each(function() {
  const content = $(this).attr("content")
  if (content) {
    $(this).attr("value", content)
  }
})

$("input[type='hidden'][name='icon']").each(function() {
  const icon = $(this).attr("value")
  $("input[type='radio'][id='icon-" + icon + "']").attr("checked", "checked")
  console.log(icon)
  console.log("boo")
})

$("input[type='radio'][name='icon'].icon-input").on("click", () => {
  const icon = $("input[type='radio'][name='icon']:checked").attr("value")
  if (icon) {
    $("input[type='hidden'][name='icon']").attr("value", icon)
  }
})
