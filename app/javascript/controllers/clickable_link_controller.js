import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-link"
export default class extends Controller {
  connect() {
  }

  handleClick(event) {
    // Prevent the default action for links inside the post
    if (!event.target.closest('a') && !event.target.closest('button')) {
      const url = this.element.dataset.url
      window.location.href = url
    }
  }
}
