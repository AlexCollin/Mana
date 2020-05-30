import css from "../css/app.scss"

import "phoenix_html"

import "alpinejs"

import {Socket} from "phoenix"

import LiveSocket from "phoenix_live_view"


let Hooks = {}

Hooks.InitModal = {
    mounted() {
      const modal = $(this.el)
      modal.on('shown.bs.modal', function (e) {

      })
    }
  }
  
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

liveSocket.connect()

liveSocket.enableDebug()
// liveSocket.enableLatencySim(1000)



