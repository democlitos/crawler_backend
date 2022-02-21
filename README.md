# Crawler Backend

Crawler Backend é utilizado para realizar consulta de frases no site https://quotes.toscrape.com.

### Dependências

* Ruby (3.1.1)
* Rails (6.0.4)
* bundler (2.3.7)
* mongodb (5.0.6)

### Como utilizar

Na pasta raiz do projeto, execute ```bundle install``` para instalar as dependências. Em seguida, adicione um arquivo <code>.env</code> com o seguinte código:
```env
export ACCESS_TOKEN=MEU_TOKEN_DE_ACESSO
```
Onde <code>MEU_TOKEN_DE_ACESSO</code> é um token seguro gerado por você. Por exemplo, usando [SecureRandom](https://ruby-doc.org/stdlib-2.5.1/libdoc/securerandom/rdoc/SecureRandom.html):
```ruby
SecureRandom.urlsafe_base64(32)
```

Em seguida, execute <code>rails s</code> para iniciar o servidor. Para fazer requisições para o servidor, é possível utilizar o arquivo http.requests.http junto com o [Rest client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client), ou utilizar um serviço como o [Postman](https://www.postman.com/).

**********

O **endpoint** para fazer requisições ao servidor é: <code>GET {{URL_BASE}}/quotes/:searh_tag</code>

**********

### Sobre a solução adotada

Foi utilizado um único documento (Quotes), com dois atributos: <code>tag</code> (string, indexada para propósito de consulta) e <code>content</code> (Hash).
O crawler utiliza nokogiri pra percorrer o documento. Basicamente, a action <code>show</code> do quotes_controller dará um find_by na <code>search_tag</code> informada. Caso ainda não exista, será criado um novo registro do documento Quotes passando a tag como argumento. Então um *callback* executado em um <code>before_create</code> irá pegar os dados no site de citações e converter para o formato:

```ruby
{ quotes: [
  {
    quote: 'frase',
    author: 'nome do autor',
    author_about: 'link para perfil do autor',
    tags: ['tag1', 'tag2']
   }
 ]}
  ```
  
  e salvando-o na coluna <code>content</code>.
