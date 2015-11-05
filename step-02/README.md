# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 02

In this step we are going to use our first Polymer element, a very simple custom `beer-list-item`.
By using it you will see how easily you can add Polymer widgets to your normal web applications.


## The custom element

Our `beer-list-item` is stored in the `elements` folder.

As you can see, a Polymer element definition is composed of two parts:

* A `dom-model` declaration defining the local DOM for the element. Inside it you will usually find a `template` where we declare the local DOM of the element and the CSS rules that apply to this local DOM.

* A `Polymer` element registration linking the `dom-model` and it's behavior and making it available to the application.

You will get (lots of) more details on custom element definition on further steps, by now this should be enough.


## Using Polymer elements

Using Polymer elements is quick and painless, you only need to follow three steps:

1. Load the polyfill Web Components to have support for older browsers

```html
<!-- Polyfill Web Components support for older browsers -->
<script src="/bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
```

1. Import the elements you want to use, i.e. `beer-list-item`

```html
<!-- Import `beer-list-item` element -->
<link rel="import" href="elements/beer-list-item.html">
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

In order to do it, you need to follow the steps previously described in *Using Polymer elements*, loading the polyfill and inporting the `beer-list-item` element in the header section of `index.html` and then using the newly registered `<beer-list-item>` in the HTML body for both beers.

![Screenshot](/img/step-02_01.jpg)


## Additional experiments

Try modifying the element to show the beer name in red.

You will see that you need to do it inside the `style` block of the `dom-model` definition for the element. Following the encapsulation principe, global CSS rules don't pass the element frontier.

## Summary

You have added a Polymer custom web component to an otherwise static app. Now go to [step-03](../step-03/) to see how to create another element to automatically generate the beer list.
