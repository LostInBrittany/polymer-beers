# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 07

What if we wanted to show more details about a beer when we click on it? We can imagine opening another panel with the detailed information.

In AngularJS we would get this behaviour by using a router, and defining the routing conditions in the global application definition.

Until recently there wasn't an official routing solution for Polymer. When they needed to add a routing component to Polymer, most people either use a non-official component like [excess-router](https://github.com/atotic/excess-router) or packaged an external router library like [visionmedia's page.js](https://visionmedia.github.io/page.js/) inside a custom component.

Since Polymer 1.4 an official solution for routing on Polymer has been released: [carbon-route](https://elements.polymer-project.org/elements/carbon-route), an element that enables declarative, self-describing routing for a web app.

So we are going to use *carbon-route* to do the routing side of our app without having to change things in our elements.

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

Polymer data binding is only available in templates that are managed by Polymer. So data binding works inside an element’s local DOM template, but not for elements placed in the main document.

To use Polymer bindings without defining a new custom element, use the `dom-bind` element. This template immediately stamps its contents into the main document. Data bindings in an auto-binding template use the template itself as the binding scope.

Now inside the `app` template we can use Polymer bindings, and the template is automatically instantiated when the application is loaded. The `unresolved` attribute says to the body to hide its contents until Polymer is fully charged.

In order to set initial values to variables or two manipulate the attributes, you need to use a `<script>` block:

```html
<body unresolved>
  <template is="dom-bind" id="app">
    <div class="container">
      <beer-list></beer-list>
    </div>
  </template>
</body>
<script>
  var app = document.querySelector('#app');

  // here you could set variables inside the template scope:
  //  app.toto = "test"
  // In the template part you could get or set the value of the variable:
  // {{toto}}

  // The dom-change event signifies when the template has stamped its DOM.
  app.addEventListener('dom-change', function() {
    // auto-binding template is ready.
    // here you can do operations that need to happen when the template is ready
  });
</script>
```

## Defining the routes

In order to use *carbon-route* the first step would be to add it to our dependencies using bower, i.e. adding it to the `bower.json` file.

```json
{
  "name": "polymer-beers",
  "version": "0.0.0",
  "license": "http://polymer.github.io/LICENSE.txt",
  "dependencies": {    
    "bootstrap": "~3.3.6",
    "polymer": "~1.4.0",
    "iron-ajax": "~1.2.0",
    "carbon-route": "~0.8.4"
  }
}
```

As usual, and for the needs of the tutorial, *carbon-route* dependencies are already in `/bower_components`


## `<carbon-route>` and `<carbon-location>`

In order to use  *carbon-route* for your application route, you need to understand the two elements offered by this library:
`carbon-route` and `carbon-location`


### `<carbon-route>` and `<carbon-location>`

`<carbon-route>` simply matches an input path against a specified pattern. The input path doesn't come necessarily from the URL, it's a  normal Polymer variable boun d to the  `<carbon-route>`'s `route` attribute. Here you have an example:

```
<carbon-route route="{{route}}" pattern="/test" active="{{active}}"></carbon-route>
```

If `route` variable matches `/test` pattern, `<carbon-route>` will set `active` to `true`, else `active` will be `false`.

`<carbon-route>` deals with hierarchical, slash separated paths. You give it a pattern, and it tells you when the input matches.

If the pattern contains any variables, like `/:page` then the extracts that portion of the matched URL and exposes it via the `data` object.


### `<carbon-location>`

`<carbon-route>` doesn’t know about the URL, it just knows about paths. While you’ll have many `<carbon-route>` elements in your app, there’s only one URL bar. The URL is global. So we’ve got an element whose single responsibility is connecting the URL to your app. We call this element `<carbon-location>`, and it exposes a route property suitable for binding into a `<carbon-route>`, like so:

```html
<carbon-location route="{{route}}"></carbon-location>
<carbon-route
    route="{{route}}"
    pattern="/:page"
    data="{{data}}"
    tail="{{tail}}">
</carbon-route>
```

For client-side applications, changing the URL is a risky business, you need a server side application serving the right content.
Helpfully, `<carbon-location>` provides the `use-hash-as-path` option, which will place the route path on the URL fragment
(the URL content beginning with the hash separator `#`).

In our example, we declare two routes, one for the beer list (URL fragment `#/beers`) and another for the individual beers
(URL fragments following the '/beer/:id' schema):

```html
<!--
  `carbon-location binds with the URL and produces a route for  carbon-route
  elements to consume. Since this application needs to run without server
  `cooperation we'll use the hash portion of the URL for our route paths.
-->
<carbon-location route="{{route}}" use-hash-as-path></carbon-location>

<!--
  carbon-routes parse route paths based on the their `pattern`.
  Parameters are extracted into the `data` object. The rest of the path that
  comes after the `pattern` is put into the `tail` object, which can be
  passed to the `route` property of downstream carbon-routes.
-->
<carbon-route route="{{route}}" pattern="/beers" active="{{beerListActive}}"></carbon-route>
<carbon-route route="{{route}}" pattern="/beer/:id" data="{{beerId}}" active="{{beerIdActive}}"></carbon-route>
```

## Hyperlinking the beers

In order to get more details on a beer when we click on its name, we need to put the name inside a `<a>` tag that will send us to the route corresponding to that beer.


In Polymer 1.0 the binding annotation must currently span the entire text content of a node, or the entire value of an attribute. So string concatenation is not supported. Notations that were usual in older versions of Polymer, like `<a href="#/beer/{{id}}"><h2 class="el-name">{{name}}</h2></a>` are not legal in Polymer 1.x.  We need to use a [computed property](https://www.polymer-project.org/1.0/docs/devguide/properties.html#computed-properties), like `<a href="{{url}}"><h2 class="el-name">{{name}}</h2></a>`.

In Polymer 1.4 this restriction is lift, and you could simple use `<a href="#/beer/{{id}}"><h2 class="el-name">{{name}}</h2></a>`,
but I keep here the *computed property* way of doing thing to show how computed properties work.

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
    return "#/beer/"+id
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

To keep the learning curve gentle, in the current step we are only showing messages informing use of what beer (if any) is currently selected.
Later in next step we will see how to show a different page when the beer detail is selected.

To show a label when a beer have been selected, we are going to use Polymer's [conditional templates](https://www.polymer-project.org/1.0/docs/devguide/templates.html#dom-if). Conditional templates (or `dom-if`) allow to conditionally
stamp elements into the DOM according to boolean properties.  The `dom-if` template stamps its contents into the DOM only when its `if`
property becomes truthy.

We want to monitor the variables set by *carbon-route*, so we can define two blocks:

```html
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
```

Let's see what happens here:

* when the router detects a `/beers` URL fragment, it sets the `beerListActive` to `true`. The first `dom-if` template then shows its content.

* when the router detects a `/beer/:id` URL fragment, it sets the `beerIdActive` to `true` and `beerId` to `{id: the_id_portion}` where `the_id_portion` is the part of the fragment after `/beer/`. The second `dom-if` template, that uses `beerIdActive` as condition, shows its content

We haven't any default routing. What if we want to detect an initial unsupported route and redirect the page to the main `#/beers` route? To do it, we use the initialization block of the `dom-bind` template:


```html
<script>
  var app = document.querySelector('#app');

  // The dom-change event signifies when the template has stamped its DOM.
  app.addEventListener('dom-change', function() {
    // auto-binding template is ready.
    this.async(function() {
      // If the path is blank, redirect to /
      if (!this.route.path) {
        this.set('route.path', '/beers');
      }
    });
  });
</script>
```

`async` is one of the [Polymer's utility functions](https://www.polymer-project.org/1.0/docs/devguide/utility-functions.html#utility-functions), and it allows to call a function asynchronously.



![Screenshot](/img/step-07_01.jpg)
