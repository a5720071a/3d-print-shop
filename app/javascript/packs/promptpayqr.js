const generatePayload = require("promptpay-qr");
const qrcode = require("qrcode");
const payload = generatePayload('000-000-0000', 10);
console.log(payload)

document.addEventListener("turbolinks:load", function() {
  var canvas = document.getElementById('canvas')
  qrcode.toCanvas(canvas, 'sample text', function (error) {
    if (error) console.error(error)
    console.log('success!');
  })
})
