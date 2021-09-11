// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "../stylesheets/application"
// import flatpickr from "flatpickr"
import "@hotwired/turbo-rails"
import "controllers"


require("flatpickr/dist/flatpickr.css")

Rails.start()
ActiveStorage.start()

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))

// import Flatpickr
import Flatpickr from 'stimulus-flatpickr'

// Import style for flatpickr
require("flatpickr/dist/flatpickr.css")

// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr)

document.addEventListener("turbo:load", function () {
//     flatpickr("[data-behavior='flatpickr']", {
//       altInput: true,
//       enableTime: true,
//       altFormat: "F j, Y H:i",
//       dateFormat: "Y-m-d H:i",
//       disableMobile: "true",
//     });

    var installmentSubmit  = document.getElementById("installment-submit");
    var showInstallments = document.getElementById("adjust-installments");
    var showMoreButton = document.getElementById("show-button")
    var showLessButton = document.getElementById("hide-button")
    if(showMoreButton) {
      showMoreButton.addEventListener("click", () => {
          showInstallments.classList.remove("no-show");
          showMoreButton.classList.add("no-show");
          showLessButton.classList.remove("no-show");
      });
      showLessButton.addEventListener("click", () => {
          showInstallments.classList.add("no-show");
          showMoreButton.classList.remove("no-show")
          showLessButton.classList.add("no-show");
      });
      installmentInput.addEventListener("keyup", () => {
          var value = installmentSubmit.setAttribute("data-installments", installmentInput.value);
      });
    }
  });