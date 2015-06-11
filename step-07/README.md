# Polymer Beers - Polymer tutorial - Step 06

What if we wanted to show more details about a beer when we click on it? We can imagine the opening another panel with the detailed information.

In AngularJS we would get this behaviour by using a router, and defining the routing conditions in the global applicaation definition.

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
    page('/beers', function () {
      app.route = 'beers';
    });
    page('/beers/:name', function (data) {
      app.route = 'beers';
      app.params = data.params;
    });

    page.redirect('*', '/beers');
    // add #! before urls
    page({
      hashbang: true
    });
  });
</script>
```

