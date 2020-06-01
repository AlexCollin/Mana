import css from "../css/app.scss"

import "phoenix_html"

import {Socket} from "phoenix"

import LiveSocket from "phoenix_live_view"

import NProgress from "nprogress"

let Hooks = {}

Hooks.InitModal = {
    mounted() {
      $(this.el).modal({keyboard: false})
      $(document).on('hide.bs.modal', function () {
          $(".modal-backdrop").remove()
          $("body").removeClass("modal-open")
      })
    }
  }

  
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})


// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

liveSocket.connect()

liveSocket.enableDebug()
// liveSocket.enableLatencySim(1000)

window.liveSocket = liveSocket

