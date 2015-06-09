# Polymer Beers - Polymer tutorial - Step 02 

In this step we are going to use create our first Polymer elements, a simple custom `beer-list`.
This element will use a JavaScript array as model and automatically generate a `beer-list-element` for each beer in the array.

## Creating the element file

We begin by creating a new file for the element, `elements/beer-list.html`. Inside it we put a basic Polymer element definition:

```
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
