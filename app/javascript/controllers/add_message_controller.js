import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-message"
export default class extends Controller {
  static targets = ["chatinput", "form", "messages"]

  connect() {
    this.chatinputTarget.addEventListener("keydown", this.submitOnEnter.bind(this))
  }

  disconnect() {
    this.chatinputTarget.removeEventListener("keydown", this.submitOnEnter.bind(this))
  }

  submitOnEnter(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault()
      this.formTarget.requestSubmit()
      this.clearInput()
      this.scrollToBottom() 
    }
  }

  submitInput(event) {
    event.preventDefault()
    this.formTarget.requestSubmit()
    this.clearInput()
    this.scrollToBottom() 
  }

  clearInput() {
    this.chatinputTarget.value = ""
  }

  scrollToBottom() {
    console.log("Scrolling to bottom...")
    setTimeout(() => {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }, 100)
  }
}
