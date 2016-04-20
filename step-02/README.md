# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 02

In this step we are going to use our first Polymer element, a very simple custom `beer-list-item`.
By using it you will see how easily you can add Polymer widgets to your normal web applications.

## Dependencies ##

In this step we are adding two dependencies, Polymer to get the WebComponents polyfill and the Polymer library core fun functionalities, and Bootstrap to make our app prettier.
As usual, you set these dependencies in the `bower.json` file of your working directory:

```
{
  "name": "polymer-beers",
  "version": "0.0.0",
  "license": "http://polymer.github.io/LICENSE.txt",
  "dependencies": {
    "bootstrap": "~3.3.6",
    "polymer": "~1.4.0"
  }
}
```

## The custom element

We are adding a custom `beer-list-item` Polymer element that will be stored in the `elements` folder.

A Polymer element definition is composed of two parts inside a `dom-model` declaration:

* A  `template` defining the local DOM for the element and the CSS rules that apply to this local DOM.

* A `Polymer` element registration linking the `dom-model` and it's behavior and making it available to the application.

You will get (lots of) more details on custom element definition on further steps, by now this should be enough.

Our custom element is very simple at this step:

```html
<!-- Import Polymer library -->
<link rel="import" href="../../bower_components/polymer/polymer.html">

<dom-module id="beer-list-item">
  <template>
    <style>
      .beer {
        margin: 10px;
        padding: 10px;
        border: solid 1px black;
        border-radius: 10px;
        min-height: 50px;
      }
    </style>
    <div class="beer">
      <h2>{{name}}</h2>
      <p>{{description}}</p>
    </div>
  </template>
  <script>
    Polymer({
      is: 'beer-list-item',

      properties: {
        name: String,
        description: {
          type: String,
          value: ""
        }
      }
    })
  </script>
</dom-module>

```

## Using Polymer elements

Using Polymer elements is quick and painless, you only need to follow three steps:

1. Load the polyfill Web Components to have support for older browsers

```html
<!-- Polyfill Web Components lite, adding support for older browsers -->
<script src="../bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
```

1. Import the elements you want to use, i.e. `beer-list-item`

```html
<!-- Import `beer-list-item` element -->
<link rel="import" href="./elements/beer-list-item.html">
```

1. Use the element as a new HTML tag

```html
<beer-list-item
  name="Affligem Blond"
  description="Affligem Blonde, the classic clear blonde abbey ale, with a gentle roundness and 6.8%..."
></beer-list-item>

<beer-list-item
  name="Affligem Tripel"
  description="The king of the abbey beers. It is amber-gold and pours with a deep head and original..."
></beer-list-item>
```

## What must I do?

You're going to replace the `<ul>` and the `<li>` items that you created in [step-01](../step-01/) with two `beer-list-item` elements, one for each beer.

In order to do it, you need to follow the steps previously described in *Using Polymer elements*, loading the polyfill and importing the `beer-list-item` element in the header section of `index.html` and then using the newly registered `<beer-list-item>` in the HTML body for both beers.

![Screenshot](/img/step-02_01.jpg)


## Local DOM and data binding  ##

Data binding binds a property or sub-property of a custom element (the host element) to a property or attribute of an element in its local DOM (the child or target element).

A binding is created with a binding annotation in the host element’s local DOM template:

```html
<dom-module id="beer-list-item">
  <template>
    <div class="beer">
      <h2>{{name}}</h2>
      <p>{{description}}</p>
    </div>
  </template>
</dom-module>
```

A binding annotation consists of a property name enclosed in curly brackets (`{{}}`) or square brackets (`[[]]`).

- Square brackets ([[]]) create one-way bindings. Data flow is downward, host-to-child, and the binding never modifies the host property.

- Curly brackets ({{}}) create automatic bindings. Data flow is one-way or two-way, depending whether the target property is configured for two-way binding.

To bind to a child property, specify the attribute name that corresponds to the property, with an annotation as the attribute value:

```html
<beer-list-item
  name="Affligem Tripel"
  description="The king of the abbey beers. It is amber-gold and pours with a deep head and original..."
></beer-list-item>
```

Here we are defining an instance of `beer-list-item`  component binding the component `name` property to `"Affligem Tripel"` and the `description` to `"The king of the abbey beers. It is amber-gold and pours with a deep head and original..."`.

For more information about data binding, see the [Polymer documentation](https://www.polymer-project.org/1.0/docs/devguide/data-binding.html)

## Declared properties ##

Any property that’s part of your element’s public API should be declared in the `properties` object of the Polymer element registration.
In this `properties` object you associated the property name to a string defining the property type  or to an object describing more details of the property, as:

- Property type.
- Default value.
- Property change observer. Calls a method whenever the property value changes.
- Read-only status. Prevents accidental changes to the property value.
- Two-way data binding support. Fires an event whenever the property value changes.
- Computed property. Dynamically calculates a value based on other properties.
- Property reflection to attribute. Updates the corresponding attribute value when the property value changes.  

```html
<script>
Polymer({
  is: 'beer-list-item',

  properties: {
    name: String,
    description: {
      type: String,
      value: ""
    }
  }
})
</script>
```


For more information about properties, see the [Polymer documentation](https://www.polymer-project.org/1.0/docs/devguide/properties.html)


## Additional experiments

Try modifying the element to show the beer name in red.

You will see that you need to do it inside the `style` block of the `dom-model` definition for the element. Following the encapsulation principle, global CSS rules don't pass the element frontier.

## Summary

You have added a Polymer custom web component to an otherwise static app. Now go to [step-03](../step-03/) to see how to create another element to automatically generate the beer list.
