// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@popperjs/core"
import "./controllers/bootstrap_confirm"

//= require rails-ujs

import { Modal } from 'bootstrap'

const bootstrapConfirm = (message) => {
  const modalElement = document.getElementById('turbo-confirm-modal')
  const messageElement = document.getElementById('turbo-confirm-modal-message')
  const confirmButtonElement = document.getElementById('turbo-confirm-modal-confirm-button')
  const modal = new Modal(modalElement)

  messageElement.textContent = message
  modal.show()

  return new Promise((resolve) => {
    confirmButtonElement.addEventListener(
      'click',
      () => {
        resolve(true)
        modal.hide()
      },
      { once: true },
    )
  })
}

Turbo.setConfirmMethod(bootstrapConfirm)
