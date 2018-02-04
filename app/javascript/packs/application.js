/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker');

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
