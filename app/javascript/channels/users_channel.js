import dom from "./users/dom"
import User from './users/setup'

$(document).on('ready turbolinks:load', () => {
  let user_switchers = document.querySelectorAll('.role-switcher')
  if(user_switchers.length > 0){
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
