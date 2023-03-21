// parser.js
import { marked } from "marked"
import emoji from "node-emoji"

export const parse = (markdown: string) => {
  const replacer = (match: string) => emoji.emojify(match)
  markdown = markdown.replace(/(:.*:)/g, replacer)

  return marked(markdown)
}
