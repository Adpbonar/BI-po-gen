import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ['title', 'titleCounter', 'description', 'counter'];

  countCharacters(event) {
    let characters = this.descriptionTarget.value.length;
    const counterDisplay = this.counterTarget
    counterDisplay.innerText = characters;
    if (characters >= Number(this.data.get('limit')) + 1) {
      counterDisplay.style.color = 'black'
      counterDisplay.style.backgroundColor = 'white';
      counterDisplay.style.pading = '.25em';
      counterDisplay.style.textDecoration = 'line-through'
    } else {
      counterDisplay.style.color = 'blue'
      counterDisplay.style.backgroundColor = 'white';
      counterDisplay.style.textDecoration = 'none'
      counterDisplay.style.pading = '.25em';
      counterDisplay.style.borderRadius = '25%';
    }
  }

  countTitle(event) {
    let characters = this.titleTarget.value.length;
    const counterDisplay = this.titleCounterTarget
    counterDisplay.innerText = characters;
    if (characters >= Number(this.data.get('limit'))) {
      counterDisplay.style.color = 'black'
      counterDisplay.style.backgroundColor = 'white';
      counterDisplay.style.pading = '.25em';
      counterDisplay.innerText = 'LIMIT REACHED';
    } else {
      counterDisplay.style.color = 'blue'
      counterDisplay.style.backgroundColor = 'white';
      counterDisplay.style.pading = '.25em';
      counterDisplay.style.borderRadius = '25%';
    }
  }
}