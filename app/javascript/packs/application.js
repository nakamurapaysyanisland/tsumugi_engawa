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



$(document).on('turbo:load turbolinks:load', function() {
  $('#file-input').on('change', function(e) {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        // 中のアイコンと文字をまとめて隠す
        $("#inner-content").hide();
        // プレビューを表示
        $("#preview").attr('src', e.target.result).show();
      }
      reader.readAsDataURL(file);
    }
  });
});