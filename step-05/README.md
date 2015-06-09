# Polymer Beers - Polymer tutorial - Step 05

In this step, you will add a feature to let your users control the order of the items in the beer list. The dynamic ordering is implemented by creating a new model property, wiring it together with the repeater, and letting the data binding magic do the rest of the work.

In addition to the search box, the app displays a drop down menu that allows users to control the order in which the beers are listed.


## Modifying `beer-list` local DOM


We need to make the following changes to the `beer-list` template:

1. First, we add a `<select>` html element named `orderProp`, so that our users can pick from the two provided sorting options.

  ```html
    <template id="beerList" is="dom-repeat" items="{{beers}}" filter="beerFilter" sort="alcoholSorter">
      <beer-list-item name="{{item.name}}" description="{{item.description}}">
      </beer-list-item>
    </template>
  ```

1. Then we add a `sort` attribute to the `dom-repeat` repeater, in a similar way as we did with filter, to declare a sorting function

  ```javascript
    alcoholSorter: function(a, b) {
      if (a.alcohol === b.alcohol) return 0;
      return b.alcohol - a.alcohol;
    }
  ```

So now we have our beers ordered by alcohol content.
  