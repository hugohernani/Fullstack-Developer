class Array
  def to_exclusive_sentence
    to_sentence(
      two_words_connector: " #{I18n.t('helpers.exclusive_or')} ",
      last_word_connector: " #{I18n.t('helpers.exclusive_or')} ",
      words_connector: " #{I18n.t('helpers.exclusive_or')} "
    )
  end
end
