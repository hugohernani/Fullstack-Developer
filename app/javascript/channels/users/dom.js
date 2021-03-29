const dom = {}

dom.onCardClick = (fn) => {
  document.querySelectorAll('div.user-role-switcher').forEach((toggler_elem, i) => {
    toggler_elem.addEventListener('click', (event) => {
      event.preventDefault()

      let target = event.currentTarget;
      target.dataset.trigger = true;

      fn(target.dataset.userId)
    })
  });
}

dom.toggleField = (user_id) => {
  let cardSwitcher = document.querySelector(`input.custom-control-input#switcher_user_${user_id}`)
  cardSwitcher.checked = !cardSwitcher.checked
}

dom.renderCardHtml = ({user_id, card_template}) => {
  let userCard = document.querySelector(`div.user-role-switcher[data-user-id='${user_id}']`);
  if(userCard.dataset.trigger === "true"){ return }
  userCard.innerHTML = card_template;
}

export default dom;
