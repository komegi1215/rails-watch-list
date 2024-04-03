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
