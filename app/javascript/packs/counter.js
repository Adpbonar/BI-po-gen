const characterCount = (element, len) => {
    var counter = document.getElementById("characterCount");
    var container = document.getElementById("counter-container");
    document.addEventListener('keyup', () => {
        container.classList.remove('no-show');
        var length = element.value.length;
        counter.textContent = length;
        if(length <= len) {
        container.style.color = 'green';
        counter.style.textDecoration = 'none';
        } else {
        container.style.color = 'red';
        counter.style.textDecoration = 'line-through';
        }
        if (length === 0) {
          container.classList.add('no-show');
        } else {
          container.classList.remove('no-show');
        }
    });
}

  export { characterCount };