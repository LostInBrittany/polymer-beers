# Polymer Beers - Polymer tutorial - Step 02 

In this step we are going to use create our first Polymer elements, a simple custom `beer-list`.
This element will use a JavaScript array as model and automatically generate a `beer-list-element` for each beer in the array.


## Creating the element file

We begin by creating a new file for the element, `elements/beer-list.html`. Inside it we put a basic Polymer element definition:

```html
<!-- Our beer-list will generate `beer-list-item` elements, so we import it -->
<link rel="import" href="beer-list-item.html">

<dom-module id="beer-list">
  <style>
    /* CSS rules for your element */
  </style>
  <template>
    <!-- local DOM for your element -->
  </template>
</dom-module>

<script>
  // element registration
  Polymer({
    is: "beer-list",
    // add properties and methods on the element's prototype
    properties: {
    }
  });
</script>
```

## Defining the model

We are going to modelize our (ever growing) beer collection as a JavaScript array in our `beer-list` element.
We will use the element's `ready` function, a functon that is called when the element has been loaded and instanciated, and that is often used used to initialize variables.

```html
<script>
  // element registration
  Polymer({
    is: "beer-list",
    // add properties and methods on the element's prototype
    properties: {
    },
    ready: function() {
      this.beers = [
        {
          alcohol: 8.5,
          name: "Affligem Tripel",
          description: "The king of the abbey beers. It is amber-gold and pours with a deep head and original aroma, delivering a complex, full bodied flavour. Pure enjoyment! Secondary fermentation in the bottle."
        },
        {
          alcohol: 9.2,
          name: "Rochefort 8",
          description: "A dry but rich flavoured beer with complex fruity and spicy flavours."
        },
        {
          alcohol: 7,
          name: "Chimay Rouge",
          description: "This Trappist beer possesses a beautiful coppery colour that makes it particularly attractive. Topped with a creamy head, it gives off a slight fruity apricot smell from the fermentation. The aroma felt in the mouth is a balance confirming the fruit nuances revealed to the sense of smell. This traditional Belgian beer is best savoured at cellar temperature "
        }
      ];
    }
  });
</script>
```

So now we have a `beers` variable in our element, that can be access in the JS side using `this.beers` and in the `dom-model` side using  `{{beers}}`.

As you can see, for each beer we have the `name` and `description` properties that `beer-list-item` needs, and also added an `alcohol` property that our element isn't capable to use yet.


## Data-binding

A reasonable thing to do for our `beer-list` would be to spawn a `beer-list-element` for each beer in the `beers` array. How can we do that? By using Polymer's [data binding helper element](https://www.polymer-project.org/1.0/docs/devguide/templates.html), concretly a template repeater (dom-repeat):

```html
<dom-module id="beer-list">
  <style>
    /* CSS rules for your element */
  </style>
  <template>
    <div class="beers">
      <template is="dom-repeat" items="{{beers}}">
        <beer-list-item name="{{item.name}}" description="{{item.description}}">
        </beer-list-item>
      </template>
    </div>
  </template>
</dom-module>
```

## Using the new element

In the `index.html` file we aren't going to use directly `beer-list-item` elements anymore, but a simple `beer-list`.
Let's replace the import of `beer-list-item` by an import of `beer-list`:

```html
<!-- Import `beer-list` element -->
<link rel="import" href="elements/beer-list.html">
```

And use it in the body:

```html
  <div class="container">
    <beer-list></beer-list>
  </div>
```

## Aditionnal experiments

Make the `list-item` element show the number of beers in the list. 
In the element's `dom-model` you have access to the beers variable, you can then get it's size and show it after the beers:

```html
<div>Number of beers in list: <span>{{beers.length}}</span></div>
```

*Note: unlike precedent Polymer versions, the double curly-brake syntax (`{{}}`) can only be used as the only element inside a DOM node. So we need to surround it with a `span` tag.*