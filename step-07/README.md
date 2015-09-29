# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 07

What if we wanted to show more details about a beer when we click on it? We can imagine the opening another panel with the detailed information.

In AngularJS we would get this behaviour by using a router, and defining the routing conditions in the global application definition.

Polymer hasn't got a router element as powerful as Angular's one... because it doesn't need it!

A part of the beauty of the component approach is that it works very well with external libraries. And in JavaScript there area (metric) ton of routers that we can use. My personal favorite is [visionmedia's page.js](https://visionmedia.github.io/page.js/), a tiny Express-inspired client-side router

So we are going to use *page.js* to do the routing side of our app without having to change things in our elements.

## Auto-binding magic

The first thing we are going to do is giving our main page some magic Polymer powers, by using [auto-binding templates](http://goo.gl/Dx1u2g).

```html
<body unresolved>
  <template is="dom-bind" id="app">
    <div class="container">
      <beer-list></beer-list>
    </div>
  </template>
</body>
```

Now inside the `app` template we can use Polymer bindings, and the template is automatically instanciated when the application is loaded. The `unresolved` attribute says to the body to hide its contents until Polymer is fully charged.


## Defining the routes

In order to use *page.js* the first step would be to add it to our dependencies using bower, i.e. adding it to the `bower.json` file.

```json
{
  "name": "polymer-beers",
  "version": "0.0.0",
  "license": "http://polymer.github.io/LICENSE.txt",
  "dependencies": {    
    "bootstrap": "~3.3.4",
    "polymer": "~1.0.0",
    "iron-ajax": "PolymerElements/iron-ajax#^1.0.0",
    "page.js": "visionmedia/page.js#~1.6.0"
  }
}
```

As usual, and for the needs of the tutorial, *page.js* dependencies are already in `/bower_components`

Then we create a new Polymer element, `routing.html`, that will call *page.js* an define the routing.

```html
<!-- Import Polymer library -->
<link rel="import" href="/bower_components/polymer/polymer.html">

<!-- Load page.js -->
<script src="/bower_components/page/page.js"></script>

<script>
  window.addEventListener('WebComponentsReady', function() {
    // Grab a reference to our auto-binding template
    // and give it some initial binding values
    // Learn more about auto-binding templates at http://goo.gl/Dx1u2g
    var app = document.querySelector('#app');

    // We use Page.js for routing. This is a Micro
    // client-side router inspired by the Express router
    // More info: https://visionmedia.github.io/page.js/
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
  });
</script>
```

As many Express-like routers, Page.js allows to define routes by matching rules on the URL fragment (the URL content beginning with the hash separator `#`).
In our example, we declare two routes, one for the beer list (URL fragment `#/beers`) and another for the individual beers (URL fragments following the '/beer/:name' schema). For each of these routes, we set properties in the `app` object, properties that can be read from the main app.
A third route (defined with `page.redirect('*', '/beers');`) redirects trafic for other URL fragments to the beer list.


## Hyperlinking the beers

In order to get more details on a beer when we click on its name, we need to put the name inside a `<a>` tag that will send us to the route corresponding to that beer.


In Polymer 1.x the binding annotation must currently span the entire text content of a node, or the entire value of an attribute. So string concatenation is not supported. Notations that were usual in older versions of Polymer, like `<a href="/beer/{{id}}"><h2 class="el-name">{{name}}</h2></a>` are not legal in Polymer 1.x.  We need to use a [computed property](https://www.polymer-project.org/1.0/docs/devguide/properties.html#computed-properties), like `<a href="{{url}}"><h2 class="el-name">{{name}}</h2></a>`.

So we define a `url` computed property in our element:

```javascript
Polymer({
  is: 'beer-list-item',

  properties: {
    [...]
    url: {
      type: String,
      computed: "getUrl(id)"
    }
  },
  getUrl: function(id) {
    return "/beer/"+id
  }
})
```

And then we use this property in the hyperlink element:

```javascript
<dom-module id="beer-list-item">
  <template>
    <style>
      [...]
    </style>
    <div id="{{id}}" class="beer clearfix">
      <img class="pull-right el-img" src="{{img}}">
      <a href="{{url}}"><h2 class="el-name">{{name}}</h2></a>
      <p class="el-description">{{description}}</p>
      <p class="pull-right el-alcohol">Alcohol content: <span>{{alcohol}}</span>%</p>
    </div>
  </template>
</dom-module>
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
