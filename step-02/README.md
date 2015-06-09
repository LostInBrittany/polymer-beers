# Polymer Beers - Polymer tutorial - Step 02

In this step we are going to use our first Polymer elements, a very simple custom `beer-list-item`. 
By using it you will see how easily you can add Polymer widgets to your normal web applications.


## The custom element

Our `beer-list-item` is stored in the `elements` folder. 

As you can see, a Polymer element definition is composed of two parts:

* A `dom-model` declaration defining the local DOM for the element. Inside it you will usually find a `template` where we declare the local DOM of the element and a `style` block with the CSS rules that apply to this local DOM.

* A `Polymer` element registration linking the `dom-model` and it's behaviour and making it available to the application.

You will get (lots of) more details on custom element definition on further steps, by now this should be enough.


## Using Polymer elements 

Using Polymer elements is quick and painless, you only need to follow three steps:

1. Load the polyfill Web Components to have support for older browsers 

    <!-- Polyfill Web Components support for older browsers -->
    <script src="/bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>

1. Import the elements you want to use, i.e. `beer-list-item`

    <!-- Import `beer-list-item` element -->
    <link rel="import" href="elements/beer-list-item.html">

1. Use the element as a new HTML tag

    <beer-list-item 
      name="Affligem Blond" 
      description="Affligem Blonde, the classic clear blonde abbey ale, with a gentle roundness and 6.8% alcohol. Low on bitterness, it is eminently drinkable."
    ></beer-list-item>

    <beer-list-item 
      name="Affligem Tripel" 
      description="The king of the abbey beers. It is amber-gold and pours with a deep head and original aroma, delivering a complex, full bodied flavour. Pure enjoyment! Secondary fermentation in the bottle."
    ></beer-list-item>


## What must I do?

You're going to remplace the `<ul>` and the `<li>` items that you created in [step-01](../step-01/) with two `beer-list-item` elements, one for each beer.

In order to do it, you need to follow the steps previously described in *Using Polymer elements*, loading the polyfill and inporting the `beer-list-item` element in the header section of `index.html` and then using the newly registered `<beer-list-item>` in the HTML body for both beers.

[![Screenshot of step 02](/img/step-01_01-550.jpg)]((/img/step-01_01.jpg))



