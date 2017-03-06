// assets/js/socket.js

import {Socket} from "phoenix"

let socket = new Socket("/socket", {
  params: {
    guardianToken: window.jwtToken,
  }
})

socket.connect()

export default socket
