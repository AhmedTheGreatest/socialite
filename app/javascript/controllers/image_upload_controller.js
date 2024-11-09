import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];
  static classes = ["preview"];

  openFilePicker() {
    this.inputTarget.click();
  }

  connect() {
    this.inputTarget.addEventListener("input", () => this.displayPreview());
  }

  displayPreview() {
    this.previewTarget.innerHTML = ""; // Clear previous previews
    Array.from(this.inputTarget.files).forEach(file => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add(this.previewClass);
        this.previewTarget.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  }
}
