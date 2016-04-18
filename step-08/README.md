# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 08

Now we are going to have two different "pages" (or *views*) in our Polymer Beers application, one for the beer list and another for a single beer detail.

## Beer detail component

We are going to create a `beer-detail` component that calls to a *beer details* service (or in these case, a set of *beer details* JSON files) to recover and show more information on the chosen beer.

![Screenshot](/img/step-08_02.jpg)

The template includes more beer properties, found in the detailed JSON file for each beer.
The *iron-ajax* calls the file according to the beer id.

```javascript
<dom-module id="beer-details">
  <template>
    <style>
      [...]
    </style>

    <div id="{{beer.id}}" class="beer clearfix">
      <a href="#/beers"><img class="pull-right back" src="../img/back.png"></a>
      <h1 class="name">{{beer.name}}</h1>
      <img class="pull-right img" src="../../data/{{mainImg}}">
      <p class="description">{{beer.description}}</p>

      <ul class="beer-thumbs">
        <li>
          <img src="../../data/{{beer.img}}" on-click="setImage">
        </li>
        <li>
          <img src="../../data/{{beer.label}}" on-click="setImage">
        </li>
      </ul>
      <ul class="specs">
        <li>
          <dl>
            <dt>Alcohol content</dt>
            <dd>{{beer.alcohol}}%</dd>
          </dl>
        </li>
        [...]
      </ul>
    </div>
    <iron-ajax
      auto
      url="{{url}}"
      method='get'
      params='{}'
      handle-as="json"
      on-response="gotBeers"
      debounce-duration="300"></iron-ajax>
  </template>

  <script>
    Polymer({
      is: 'beer-details',

      properties: {
        id: String,
        name: String,
        description: String,
        img: String,
        alcohol: String,
        url: {
          type: String,
          computed: "getUrl(id)"
        }
      },
      getUrl: function(id) {
        return "../../data/beers/details/"+id+".json";
      },

      gotBeers: function(event, ironRequest) {
        this.beer = ironRequest.response;
        this.mainImg = this.beer.img;
      },
      setImage: function(evt) {
        this.mainImg = evt.srcElement.src;
      }
    });
  </script>
</dom-module>
```


## Don't change a winning team...

We keep the same *carbon-route* routing, with our two routes, one for the beer list (URL fragment `#/beers`) and another for the individual beers (URL fragments following the '/beer/:id' schema).

But instead of using the auto-binding template, that frankly is a bit hacky, we are going to create a global `polymer-beers` element in `index.html`:

```html
<polymer-beers></polymer-beers>

<dom-module id="polymer-beers">
  <style>
    :host {
      display: block;
    }
  </style>
  <template>
    <carbon-location route="{{route}}" use-hash-as-path></carbon-location>

    <carbon-route route="{{route}}" pattern="/beers" active="{{beerListActive}}"></carbon-route>
    <carbon-route route="{{route}}" pattern="/beer/:id" data="{{beerId}}" active="{{beerIdActive}}"></carbon-route>


    <div class="container">
      <div class="alert alert-warning" role="alert">Variable `beerListActive` = {{beerListActive}}</div>
      <template is="dom-if" if="{{beerListActive}}">
        <div class="alert alert-success" role="alert">You have selected the main beer list (URL fragment = #/beers)</div>
      </template>
    </div>

    <div class="container">
      <div class="alert alert-warning" role="alert">Variable `beerIdActive` = {{beerIdActive}}</div>
      <template is="dom-if" if="{{beerIdActive}}">
        <div class="alert alert-success" role="alert">You have selected a beer: {{beerId.id}}</div>
      </template>
    </div>

    <div class="container">
      <beer-list></beer-list>
    </div>
  </template>
  <script>
    HTMLImports.whenReady(function () {
      Polymer({
        is: 'polymer-beers',        
        attached: function() {
          if (!this.route.path) {
            this.set('route.path', '/beers');
          }
        }
      });
    });
  </script>
</dom-module>
```

To define an element in your main HTML document, define the element from `HTMLImports.whenReady(callback)` as explained in the [defining an element in the main HTML document guidelines](https://www.polymer-project.org/1.0/docs/devguide/registering-elements.html#main-document-definitions). `callback` is invoked when all imports in the document have finished loading.

The initialization of the route is done in the `attached` [lifecycle callback](https://www.polymer-project.org/1.0/docs/devguide/registering-elements.html#lifecycle-callbacks), called after the element is attached to the document.


## Or better yet, upgrade it!


We also keep the conditional templates, but instead of using it to show (or not) a label, we are going to use it to show the right component according to the route:

```html
<polymer-beers></polymer-beers>

<dom-module id="polymer-beers">
  <style>
    :host {
      display: block;
    }
  </style>
  <template>
    <carbon-location route="{{route}}" use-hash-as-path></carbon-location>

    <carbon-route route="{{route}}" pattern="/beers" active="{{beerListActive}}"></carbon-route>
    <carbon-route route="{{route}}" pattern="/beer/:id" data="{{beerId}}" active="{{beerIdActive}}"></carbon-route>


    <template is="dom-if" if="{{beerListActive}}">
      <div class="container">
        <beer-list></beer-list>
      </div>
    </template>


    <template is="dom-if" if="{{beerIdActive}}">
      <div class="container">
        <beer-details id="{{beerId.id}}"></beer-details>
      </div>
    </template>


  </template>
  <script>
    HTMLImports.whenReady(function () {
      Polymer({
        is: 'polymer-beers',
        route:{
          type: Object
        },
        attached: function() {
          if (!this.route.path) {
            this.set('route.path', '/beers');
          }
        }
      });
    });
  </script>
</dom-module>
```
