# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 03

In this step we are going to create a more complex Polymer element, a custom `beer-list`.
This element will use a JavaScript array as model and automatically generate a `beer-list-item` for each beer in the array.


## Creating the element file

We begin by creating a new file for the element, `elements/beer-list.html`. Inside it we put a basic Polymer element definition:

```html
<!-- Our beer-list will generate `beer-list-item` elements, so we import it -->
<link rel="import" href="./beer-list-item.html">

<dom-module id="beer-list">
  <template>
    <!-- local DOM for your element -->
    <style>
      /* CSS rules for your element */
    </style>
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

We are going to model our (ever growing) beer collection as a JavaScript array in our `beer-list` element.
We will use the element's `ready` function, a function that is called when the element has been loaded and instantiated, and that is often used to initialize variables.

```html
<script>
  // element registration
  Polymer({
    is: "beer-list",
    // add properties and methods on the element's prototype
    properties: {
      beers: {
        type: Array,
        // When initializing a property to an object or array value, use a function to ensure that each element
        // gets its own copy of the value, rather than having an object or array shared across all instances of the element
        value: function() { return []; }
      }
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

So now we have a `beers` property in our element, that can be access in the JS side using `this.beers` and in the `dom-model` side using  `{{beers}}`.

As you can see, for each beer we have the `name` and `description` properties that `beer-list-item` needs, and also added an `alcohol` property that our element isn't capable to use yet.


## Data-binding

A reasonable thing to do for our `beer-list` would be to spawn a `beer-list-element` for each beer in the `beers` array. How can we do that? By using Polymer's [data binding helper element](https://www.polymer-project.org/1.0/docs/devguide/templates.html), concretely a template repeater (`dom-repeat`):

```html
<dom-module id="beer-list">
  <template>  
    <style>
      /* CSS rules for your element */
    </style>
    <div class="beers">
      <template is="dom-repeat" items="{{beers}}">
        <beer-list-item name="{{item.name}}" description="{{item.description}}">
        </beer-list-item>
      </template>
    </div>
  </template>
</dom-module>
```

The template repeater is a specialized template that binds to an array. It creates one instance of the template’s contents for each item in the array. It adds two properties to the binding scope for each instance:

- `item`: The array item used to create this instance
- `index`: The index of item in the array

For more information about the template repeater, see the [Polymer documentation](https://www.polymer-project.org/1.0/docs/devguide/templates.html#dom-repeat).

## Using the new element

In the `index.html` file we aren't going to use directly `beer-list-item` elements anymore, but a simple `beer-list`.
Let's replace the import of `beer-list-item` by an import of `beer-list`:

```html
<!-- Import `beer-list` element -->
<link rel="import" href="./elements/beer-list.html">
```

And use it in the body:

```html
  <div class="container">
    <beer-list></beer-list>
  </div>
```

## Aditionnal experiments

### Make the `beer-list` element show the number of beers in the list.

In the element's `dom-model` you have access to the beers variable, you can then get it's size and show it after the beers:

```html
<div>Number of beers in list: {{beers.length}}</div>
```

*Note: unlike precedent Polymer versions, Polymer 1.0 required the double curly-brake syntax (`{{}}`) to be used as the only element inside a DOM node. So the precedent line needed to be rewritten as `<div>Number of beers in list: <span>{{beers.length}}</span></div>`. This restriction was lifted on Polymer 1.2.*

### Play with `dom-repeat`

Create a repeater in `beer-list` that constructs a simple table:

```html
<table>
  <tr><th>Row number</th></tr>
  <template is="dom-repeat" items="[0, 1, 2, 3, 4, 5, 6, 7]">
    <tr><td>{{item}}</td></tr>
  </template>
</table>
```

Extra points: try and make an 8x8 table using an additional `dom-repeat`.

*Note: To access properties from nested `dom-repeat` templates, use the `as` attribute to assign a different name for the item property. Use the `index-as` attribute to assign a different name for the `index` property.*

## Summary ##

You now have a web application using Polymer web components.
Now, let's go to [step-04](../step-04/) to learn how to add full text search to the app.
