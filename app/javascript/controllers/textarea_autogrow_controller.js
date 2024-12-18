import { Controller } from "@hotwired/stimulus"
import { debounce } from "utils"

export default class extends Controller {

  static values = {
    resizeDebounceDelay: {
      type: Number,
      default: 100,
    },
  }

  initialize(){
    this.autogrow = this.autogrow.bind(this)
  }

  connect() {
    this.element.style.overflow = "hidden"
    const delay = this.resizeDebounceDelayValue

    this.onResize = delay > 0 ? debounce(this.autogrow, delay) : this.autogrow

    this.autogrow()

    this.element.addEventListener("input", this.autogrow)
    window.addEventListener("resize", this.onResize)
  }

  disconnect() {
    window.removeEventListener("resize", this.onResize)
  }

  autogrow() {
    this.element.style.height = "auto" // Force re-print before calculating the scrollHeight value.
    this.element.style.height = `${this.element.scrollHeight}px`
  }
}