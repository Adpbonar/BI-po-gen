// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "packs/counter"
import "../stylesheets/application"
import "@hotwired/turbo-rails"
import "chartkick/chart.js"
import "controllers"

require("flatpickr/dist/flatpickr.css")
require("easy-autocomplete")

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
    var submitForFindings = document.getElementById("participant-submit");
    var installmentSubmit = document.getElementById("installment-submit");
    var installmentDefualtSubmit = document.getElementById("default-installment-submit");
    var defualtOptionsSubmit = document.getElementById("default-option-submit");
    var showInstallments = document.getElementById("adjust-installments");
    var showMoreButton = document.getElementById("show-button")
    var showLessButton = document.getElementById("hide-button")
    if (showMoreButton) {
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
    installment1Input.addEventListener("keyup", () => {
        var value = installmentDefualtSubmit.setAttribute("data-installment1", installment1Input.value);
    });
    installment2Input.addEventListener("keyup", () => {
        var value = installmentDefualtSubmit.setAttribute("data-installment2", installment2Input.value);
    });
    installment3Input.addEventListener("keyup", () => {
        var value = installmentDefualtSubmit.setAttribute("data-installment3", installment3Input.value);
    });
    taxInput.addEventListener("keyup", () => {
        var value = defualtOptionsSubmit.setAttribute("data-tax", taxInput.value);
    });
    finderInput.addEventListener("keyup", () => {
        var value = defualtOptionsSubmit.setAttribute("data-finder", finderInput.value);
    });
    shareInput.addEventListener("keyup", () => {
        var value = defualtOptionsSubmit.setAttribute("data-share", shareInput.value);
    });
    associateInput.addEventListener("keyup", () => {
        var value = defualtOptionsSubmit.setAttribute("data-share", associateInput.value);
    });
});