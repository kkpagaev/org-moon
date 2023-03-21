// parser.js
import { marked } from "marked"
import emoji from "node-emoji"
// import hljs from "highlight.js"

// marked.setOptions({
// highlight: function(code, lang) {
// return hljs.highlight(lang, code).value
// },
// })

export const parse = (markdown: string) => {
  const replacer = (match: string) => emoji.emojify(match)
  markdown = markdown.replace(/(:.*:)/g, replacer)

  return marked(markdown)
}
