import css from "../css/app.scss"

import "phoenix_html"

import {Socket} from "phoenix"

import LiveSocket from "phoenix_live_view"

import NProgress from "nprogress"

const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  onOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})

let Hooks = {}

Hooks.InitModal = {
    beforeDestroy() {
      $(".modal-backdrop").remove()
      $("body").removeClass("modal-open")
    },
    // beforeUpdate() {
    //   console.log("beforeUpdate")
    // },
    // updated() {
    //   console.log("updated")
    // },
    // destroyed() {
    //   console.log("destroyed")
    // },
    mounted() {
      $(this.el).modal({keyboard: false})
    }
  }

  Hooks.AlertInfo = {
    mounted() {
      let text = $(this.el).text()
      Toast.fire({
        type: 'success',
        title: text
      })
      $(this.el).remove()
    }
  }

  Hooks.AlertError = {
    mounted() {
      let text = $(this.el).text()
      Toast.fire({
        type: 'danger',
        title: text
      })
      $(this.el).remove()
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

