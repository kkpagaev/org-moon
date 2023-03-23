// parser.js
import { marked } from "marked"
import emoji from "node-emoji"
// import hljs from "highlight.js"

// marked.setOptions({
// highlight: function(code, lang) {
// return hljs.highlight(lang, code).value
// },
// })
const renderer = new marked.Renderer()

// let checkboxCount = 0
// @ts-ignore
// window.foo = (index: number, checked: boolean) => {
// const markdown = document.getElementById("markdown") as HTMLTextAreaElement
// if (!checked) {
// let replace = `/- \[\s\]/`
// let regex = new RegExp(replace, "g")
// markdown.value = markdown.value.replace(regex, `- [x]`)
// } else {
// let replace = `/- \[\(x|X)\]/`
// let regex = new RegExp(replace, "g")
// markdown.value = markdown.value.replace(regex, `- [ ]`)
// }
// }
// renderer.checkbox = (checked) => {
// return `<input id="checkbox-${checkboxCount}" onClick="window.foo(${checkboxCount++}, ${checked})" type="checkbox" ${checked ? "checked" : ""
// } />`
// }

marked.setOptions({
  headerIds: false,
  gfm: true,
  renderer: renderer,
})

export const parse = (markdown: string): string => {
  // checkboxCount = 0
  const replacer = (match: string) => emoji.emojify(match)
  markdown = markdown.replace(/(:.*:)/g, replacer)

  const lexer = new marked.Lexer()
  const tokens = lexer.lex(markdown)
  return marked.parser(tokens)
}
