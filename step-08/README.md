# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 08

Now we are going to have two different "pages" (or *views*) in our Polymer Beers application.

## Beer detail component

We are going to create a `beer-detail` component that calls to a *beer details* service (or in these case, a set of *beer details* JSON files) to recover and show more information on the chosen beer.

![Screenshot](/img/step-08_02.jpg)

The template includes more beer properties, found in the detailed JSON file for each beer.
The *iron-ajax* calls the file according to the beer id.

```
<dom-module id="beer-details">
  <template>
    <style>
      [...]
    </style>

    <div id="{{beer.id}}" class="beer clearfix">
      <a href="#/beers"><img class="pull-right back" src="../img/back.png"></a>
      <h1 class="name"><span>{{beer.name}}</span></h1>
      <img class="pull-right img" src="{{mainImg}}">
      <p class="description">{{beer.description}}</p>

      <ul class="beer-thumbs">
        <li>
          <img src="{{beer.img}}" on-click="setImage">
        </li>
        <li>
          <img src="{{beer.label}}" on-click="setImage">
        </li>
      </ul>
      <ul class="specs">
        <li>
          <dl>
            <dt>Alcohol content</dt>
            <dd><span>{{beer.alcohol}}</span>%</dd>
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
  </template>
</dom-module>
```

The JavaScript code:

```javascript
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
    return "./beers/details/"+id+".json";
  },

  gotBeers: function(event, ironRequest) {
    this.beer = ironRequest.response;
    this.mainImg = this.beer.img;
  },
  setImage: function(evt) {
    this.mainImg = evt.srcElement.src;
  }
})
</script>
```



## Don't change a winning team...

We keep the same *page.js* routing, with our two routes, one for the beer list (URL fragment `#/beers`) and another for the individual beers (URL fragments following the '/beer/:name' schema) and a default one (defined with `page.redirect('*', '/beers');`) redirects traffic for other URL fragments to the beer list.

```javascript
  page('/beers', function (data) {
    app.route = 'beers';
  });
  page('/beer/:name', function (data) {
    app.route = 'beer';
    app.params = data.params;
    console.log(data.params)
  });
  page.redirect('*', '/beers');
  // add #! before urls
  page({
    hashbang: true
  });
```

## Or better yet, upgrade it!

We also keep [iron-pages](https://elements.polymer-project.org/elements/iron-pages) to choose an element according to a `selected` property.
But instead of using it to show (or not) a label, we are going to use it to show the right component according to the route:

```html
<body unresolved>
  <template is="dom-bind" id="app">
    <div>
      <iron-pages attr-for-selected="data-route" selected="{{route}}">

        <!-- If route is "beers" we show the list of beers -->
        <div data-route="beers"  class="container">
          <beer-list></beer-list>
        </div>

        <!-- If route is "beer" we show the detail of that beer -->
        <beer-details data-route="beer" id="{{params.name}}"></beer-details>

      </iron-pages>
    </div>
  </template>
</body>
```





## Showing current choice

To keep the learning curve gentle, in the current step we are only showing a label when a beer have been selected.
Later in next step we will see how to show a different page when the beer detail is selected.

To show a label when a beer have been selected, we are going to use Polymer's [iron-pages](https://elements.polymer-project.org/elements/iron-pages) element. *iron-pages* is an element that shows only one of its children, according to a `selected` property.

In order to use it, we do the import in `index.html`:

```javascript
<!-- Import iron-pages -->
<link rel="import" href="/bower_components/iron-pages/iron-pages.html">
```

Then we use it:

```javascript
<template is="dom-bind" id="app">
  <div>
    <iron-pages attr-for-selected="data-route" selected="{{route}}">
      <h1 data-route="beer">You have clicked on <span>{{params.name}}</span></h1>
    </iron-pages>

    <div class="container">
      <beer-list></beer-list>
    </div>
  </div>
</template>
```

Its attribute `attr-for-selected` tells us what attribute from its children is used for selecting, the selecting key. Here we are looking to the `data-route` attribute on its children.

The `selected` attribute tells us the value of the selecting attribute. We are binding it to the `route` property, which (as you may remember) is set by the router.

Let's see what happens here:

* when the router detects a `/beers` URL fragment, it sets the `route` to `beers`. The `iron-pages` components takes then the `route` value, `beers`, and compared them with the value of the `data-route` attribute of its only child. As it doesn't coincide, the child isn't shown.

* when the router detects a `/beer/:name` URL fragment, it sets the `route` to `beer` and puts the beer name inside `params`. The `iron-pages` components takes then the `route` value, `beer`, and compared them with the value of the `data-route` attribute of its only child. As it coincides, that children is shown, and the label uses `param.name` to get the name of the selected beer.

![Screenshot](/img/step-07_01.jpg)
