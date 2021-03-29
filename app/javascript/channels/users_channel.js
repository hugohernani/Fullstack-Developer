import dom from "./users/dom"
import User from './users/setup'

$(document).ready(() => {
  let bodyElement = document.querySelector('body[data-current-user-id]')
  if(window.location.pathname == "/admin/users"){
    const usersChannel = User.setupChannel({
      onCardTemplateReceive: (cardData) => {
        dom.toggleField(cardData['user_id'])
        dom.renderCardHtml(cardData);
      }
    })

    dom.onCardClick((userId) => {
      User.toggleRole(usersChannel, userId)
    })
  }
})
