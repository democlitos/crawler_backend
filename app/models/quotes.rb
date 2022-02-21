class Quotes
  include Mongoid::Document

  QUOTES_BASE_URI = 'http://quotes.toscrape.com'

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

  before_create :scrape_quotes

  validates :tag, uniqueness: true, presence: true

  def scrape_quotes
    return unless tag && content.nil?

    require 'open-uri'

    doc = Nokogiri::HTML(URI.open("#{QUOTES_BASE_URI}/tag/#{tag}/"))
    self.content = html_to_hash(doc)
  end

  private

  # Parse html document and return a hash with an array of quotes with
  # the attributes 'quote', 'author', 'author_about' and 'tags'.
  def html_to_hash(doc)
    {
      quotes: doc.xpath(
        "//div[@class=\"quote\" and .//meta[contains(@content, \"#{tag}\")]]"
      ).map do |quote|
        {
          quote: quote.at(".//span[@itemprop = 'text']").children.text,
          author: quote.at(".//small[@itemprop = 'author']").children.text,
          author_about: "#{QUOTES_BASE_URI}#{quote.at('a:contains("(about)")')['href']}",
          tags: quote.xpath('.//a[@class="tag"]').map { |tag| tag.children.text }
        }
      end
    }
  end
end
