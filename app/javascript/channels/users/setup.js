import Consumer from '../consumer';

const User = {}
export default User

User.setupChannel = ({ onCardTemplateReceive }) => {
  const onCardTemplateReceiveFn = (cardData) => {
    onCardTemplateReceive(cardData)
  }

  let usersChannel = Consumer.subscriptions.create({channel: "UsersChannel"}, {
    connected: function(){
      console.debug("User connected")
    },
    disconnected: function(){
      console.debug("User disconnected")
    },

    received: onCardTemplateReceiveFn
  })

  return usersChannel;
}

User.toggleRole = ( usersChannel, userId) => {
  userToggleRequest(usersChannel, "toggle_user_role", { user_id: userId })
}

function userToggleRequest(usersChannel, event, payload){
  usersChannel.perform(event, payload)
}
