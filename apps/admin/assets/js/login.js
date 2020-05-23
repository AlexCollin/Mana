import css from "../css/app.scss"
import Popper from "popper.js";

import "../vendor/bootstrap-material-design.min.js"
import "../vendor/material-dashboard.js"

$(document).ready(function() {
  md.checkFullPageBackgroundImage();
  setTimeout(function() {
    // after 1000 ms we add the class animated to the login/register card
    $('.card').removeClass('card-hidden');
  }, 700);
});