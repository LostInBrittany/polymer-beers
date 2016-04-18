# ![](/img/logo-25px.png) Polymer Beers - Polymer tutorial - Step 04

We did a lot of work in laying a foundation for the app in the last step, so now we'll do something simple;
we will add full text search (yes, it will be simple!).

We want to add a search box to the app, and we want the results on the beer list change according to what the user types into the search box.

## Modifying `beer-list` local DOM

We use [Twitter Bootstrap](http://getbootstrap.com) column model to divide the page in two (fully responsive) columns, the left one for the search box, the right one for the beer list.

We need to add a standard HTML `<input>` tag, give them some magical data-binding properties and adding a Polymer [filter](https://www.polymer-project.org/1.0/docs/devguide/templates.html#filtering-and-sorting-lists) function to process the input for the [dom-repeat](https://www.polymer-project.org/1.0/docs/devguide/templates.html#dom-repeat) template repeater.

This lets a user enter search criteria and immediately see the effects of their search on the beer list.  

Let's begin by modifying the template to add the search input.

```html
<template>
  <div class="container">
    <div class="row">
      <div class="col-md-2">
        <!--Sidebar content-->
        Search: <input>
      </div>
      <div class="col-md-10">
        <div class="beers">
          <template is="dom-repeat" items="{{beers}}">
            <beer-list-item name="{{item.name}}" description="{{item.description}}">
            </beer-list-item>
          </template>
        </div>
      </div>
    </div>
  </div>  
</template>
```

## Two-ways data-binding

Now we need to link the search input field value to a property of the object.

In the template we use value to link the `input` event of the `input` item to the `filterText` property,
and we add a label under it to show the current value of `filterText`:

```html
<div>Search: <input value="{{filterText::input}}"></div>
<div>Current search: {{filterText}}</div>

```

In the element registration we declare the `filterText` property as a string:

```javascript
    properties: {
      filterText: String
    }
```
And now we have a two-way data-binding between the input field and the label under it.

![Screenshot](/img/step-04_01.jpg)

## Adding a filter to the list

To filter or sort the displayed items in your list, we specify a `filter` or `sort` property on the `dom-repeat` (or both):

+ `filter`: it specifies a filter callback function following the standard [Array `filter` API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)

+ `sort`: it specifies a comparison function following the standard [Array `sort` API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)

In both cases, the value can be either a function object, or a string identifying a function defined on the host element.

The only problem in our case is that, by default, the filter and sort functions only run when the array itself is mutated (for example, by adding or removing items). And we want it to run when we modify an outside property, `filterText`. We will need to use the `render` function of the `dom-repeat` to force a re-run of the filter.


1. Modify the `filterText` property to give it an [observer*](https://www.polymer-project.org/1.0/docs/devguide/properties.html#change-callbacks), a function that runs when the property changes:

  ```javascript
    properties: {
      filterText: {
        type: String,
        observer: "filterTextChanged"
      }
    },
    filterTextChanged: function(newValue, oldValue) {
      console.log("Filter text changed, new value: "+newValue);
    }
  ```

1. Add a filter to the template repeater:

  ```html
    <template id="beerList" is="dom-repeat" items="{{beers}}" filter="beerFilter">
      <beer-list-item name="{{item.name}}" description="{{item.description}}">
      </beer-list-item>
    </template>
  ```

  ```javascript
    beerFilter:  function(item) {
        return item.name.match(new RegExp(this.filterText, 'i'));
    }
  ```   

1. Use the observer for `filterText` to force a run of the filter everytime we modify the input field content:

  ```javascript
    filterTextChanged: function(newValue, oldValue) {
      this.$.beerList.render();
    }
  ```

And now we have a working filter for our beers!

![Screenshot](/img/step-04_02.jpg)

## Additional experiments

You have maybe noticed it, the *total beers* that you added in the *additional experiments* section some steps ago shows only that, the total. It would be nice if it showed the *current beers* metric, i.e. the number of beers currently showed in page, after filtering.

How could you do it? Polymer has several kinds of properties, and one of them is going to help us here: the  [computed properties](https://www.polymer-project.org/1.0/docs/devguide/p watroperties.html#computed-properties). These are virtual properties whose values are calculated from other properties.

To define a computed property, add it to the properties object with a computed key mapping to a computing function.

We need a virtual properties, `currentBeers` that watches `beers` and `filterText` and that recalculates the number of beers on the page.

```javascript
    properties: {
      filterText: {
        type: String,
        observer: "filterTextChanged"
      },
      beers: {
        type: Array,
      },
      currentBeers: {
        type: String,
        computed: "getCurrentBeers(beers, filterText)"
      }
    },
    getCurrentBeers: function() {
      // Do something clever...
    },
```

Inside the function we can go through `beers` and incrementing a counter if the beer matches the `beerFilter` filter.


## Summary ##

We have now added full text search! Now let's go on to [step-05](../step-05) to learn how to add sorting capability to the beer app.
