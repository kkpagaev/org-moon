import $ from "jquery"

var stringToColour = function(str: string) {
  var hash = 0
  for (var i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash)
  }
  var colour = "#"
  for (var i = 0; i < 3; i++) {
    var value = (hash >> (i * 8)) & 0xff
    colour += ("00" + value.toString(16)).substring(-2)
  }
  return colour
}

$(".tag").each(function() {
  var tag = $(this).text()
  // $(this).css("background-color", "black")
  // console.log(stringToColour(tag))
})