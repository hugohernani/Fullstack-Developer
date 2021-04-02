import dom from "./users/dom"
import User from './users/setup'

$(document).on('ready turbolinks:load', () => {
  if(window.location.pathname == "/admin/users"){
    const usersChannel = User.setupChannel({
      onCardTemplateReceive: (cardData) => {
        dom.toggleField(cardData['user_id'], cardData['is_admin'])
        dom.renderCardHtml(cardData);
      }
    })

    dom.onCardClick((userId) => {
      User.toggleRole(usersChannel, userId)
    })
  }
})
