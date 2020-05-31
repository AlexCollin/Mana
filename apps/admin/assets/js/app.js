import css from "../css/app.scss"

import "phoenix_html"

import "./modal"

import {Socket} from "phoenix"

import NProgress from "nprogress"

import LiveSocket from "phoenix_live_view"

import 'alpinejs'

let Hooks = {}

Hooks.InitModal = {
    mounted() {
      $(document).on('hide.bs.modal', function () {
          console.log('hide');
          $(this.el).modal('handleUpdate')
          $(".modal-backdrop.fade.show").remove()
          $("body").removeClass("modal-open")
      })
      $(document).on('hidden.bs.modal', function () {
        console.log('hidden');
        $(this.el).modal('handleUpdate')
        $(".modal-backdrop.fade.show").remove()
          $("body").removeClass("modal-open")
      })
       $(this.el).modal({ keyboard: false })
      // $(this.el).on('hide.bs.modal', function (e) {
      //   $(this.el).modal('dispose')
      //   $(".modal-backdrop").remove()
      //   $("body").removeClass("modal-open")
      // })
      // $(this.el).on('hidden.bs.modal', function (e) {
      //   $(this.el).modal('dispose')
      //   $(".modal-backdrop").remove()
      //   $("body").removeClass("modal-open")
      // })
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

