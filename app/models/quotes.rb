class Quotes
  include Mongoid::Document

  # All quotes are saved in a hash-like format
  # { quotes: [
  #   {
  #     quote: 'frase',
  #     author: 'nome do autor',
  #     author_about: 'link para perfil do autor',
  #     tags: ['tag1', 'tag2']
  #    }
  # ]}
  field :content, type: Hash
  field :tag, type: String

  index({ tag: 1 }, { unique: true, name: 'ssn_index' })

  before_save :scrape_quotes

  validates :tag, uniqueness: true, presence: true

  def scrape_quotes
    # TODO: implement quotes crawler
  end
end
