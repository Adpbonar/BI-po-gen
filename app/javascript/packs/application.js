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
import flatpickr from "flatpickr"
import "@hotwired/turbo-rails"
import "controllers"

require("flatpickr/dist/flatpickr.css")

Rails.start()
ActiveStorage.start()

document.addEventListener("turbo:load", function () {
    flatpickr("[data-behavior='flatpickr']", {
      altInput: true,
      enableTime: true,
      altFormat: "F j, Y H:i",
      dateFormat: "Y-m-d H:i",
      disableMobile: "true",
    });
  });