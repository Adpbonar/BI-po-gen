import { Controller } from "stimulus"

const LEAVING_PAGE_MESSAGE = "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?"

export default class extends Controller {

  formIsChanged(event) {
    this.setChanged("true")
  }

  leavingPage(event) {
    if (this.isFormChanged()) {
      if (event.type == "turbo:before-visit") {
        if (!window.confirm(LEAVING_PAGE_MESSAGE)) { 
          event.preventDefault()
        }
      } else {
        event.returnValue = LEAVING_PAGE_MESSAGE;
        return event.returnValue;
      }
    } 
  }

  allowFormSubmission(event) {
    this.setChanged("false")
  }

  setChanged(changed) {
    this.data.set("changed", changed)
  }

  isFormChanged() {
    return this.data.get("changed") == "true";
  }
}