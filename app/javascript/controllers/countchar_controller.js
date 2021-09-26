import { Controller } from "stimulus"
export default class extends Controller {
    static get targets() {
      return ['title', 'titleCounter', 'description', 'counter'];
    }
    countCharacters(event) {
      let characters = this.descriptionTarget.value.length;
      const counterDisplay = this.counterTarget
      counterDisplay.innerText = characters;
      if (characters >= Number(this.data.get('limit')) + 1) {
        counterDisplay.style.color = 'black'
        counterDisplay.style.textDecoration = 'line-through'
      } else {
        counterDisplay.style.color = 'blue'
        counterDisplay.style.textDecoration = 'none'
      }
    }

    countTitle(event) {
      let characters = this.titleTarget.value.length;
      const counterDisplay = this.titleCounterTarget
      counterDisplay.innerText = characters;
      if (characters >= Number(this.data.get('limit'))) {
        counterDisplay.style.color = 'black'
        counterDisplay.innerText = 'Limit Reached';
      } else {
        counterDisplay.style.color = 'blue'
      }
    }
  }