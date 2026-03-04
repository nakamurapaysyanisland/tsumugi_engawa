// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  const input = document.getElementById('file-input');
  const preview = document.getElementById('preview');

  if (input) {
    input.addEventListener('change', (e) => {
      const file = e.target.files[0];
      const reader = new FileReader();
      reader.onload = (event) => {
        preview.setAttribute('src', event.target.result);
        preview.style.display = 'block';
      };
      if (file) reader.readAsDataURL(file);
    });
  }
});
