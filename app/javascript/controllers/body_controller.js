import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="body"
export default class extends Controller {
  static targets = ["chat"]
  connect() {
  }
  
  delete_chat(event){
    const chatId = event.params.id;
    const present = document.getElementById(`chatag${chatId}`)
    if (present) {
      window.location.href="/home";
    }
  }
}
