# Polymer Beers - Polymer tutorial

*A work-in-progress tutorial for Polymer based on my [Angular Beers](https://github.com/LostInBrittany/angular-beers) tutorial for AngularJS*

I have built this [PolymerBeers](https://github.com/LostInBrittany/polymer-beers) tutorial quick entry point to [Polymer 1.0](https://www.polymer-project.org/1.0/). I've based it on a similar tutorial I did for [AngularJS](http://angular.io), [Angular Beers](https://github.com/LostInBrittany/angular-beers).

For the last several years, I've taught a web-development module in an Engineering School with a rather restrictive network. As I plan to use this tutorial in next year module, in order to explain Polymer to our students, I needed a tutorial that could be played without network acces, i.e. without Bower or Grunt. So *Polymer Beers* needed to be able to be done even behind a very restrictive proxy, and all the dependencies are included inside the git project.

![Screenshot](assets/screenshot-01.png)

## What are the objectives of this tutorial ##

Follow the tutorial to see how Polymer makes browsers smarter — without the use of native extensions or plug-ins:

+ See examples of how to use client-side data binding to build dynamic views of data that change immediately in response to user actions.
+ See how Polymer keeps your views in sync with your data without the need for DOM manipulation.
+ Learn how to technical elements to make common web tasks, such as getting data into your app, easier.

When you finish the tutorial you will be able to:

+ Create a dynamic application that works in all modern browsers.
+ Create custom elements, with its looks and its behaviour encapsulated inside, setting the bases of a true component architecture client-side
+ Use data binding to wire up your data model to your views.
+ Get data from a server using Polymer iron elements.

The tutorial guides you through the entire process of building a simple application. Experiments at the end of each step provide suggestions for you to learn more about Polymer and the application you are building.

You can go through the whole tutorial in a couple of hours or you may want to spend a pleasant day really digging into it. If you're looking for a shorter introduction to Polymer, check out the official website.

![Screenshot](assets/screenshot-02.png)

## What do I need to use this tutorial ##

Besides a web browser and a text-editor (we suggest the excellent [Sublime Text](http://www.sublimetext.com/)), you will only need a web-server to test your code.

If you have Python in your system, the easiest way would be to run the embeded SimpleHTTPServer. Go to the project directory and run `python -m SimpleHTTPServer` to start the web server. Now, open a browser window for the app and navigate to http://localhost:8000/app/index.html to see the current state of the app.

If you have [NodeJS](http://nodejs.org) in your system, we have put a minimalist JavaScript web-server on `./scripts/web-server.js`. To see the app running in a browser, open a separate terminal/command line tab or window, go to the project directory and then run `node ./scripts/web-server.js` to start the web server. Now, open a browser window for the app and navigate to http://localhost:8000/app/index.html to see the current state of the app.

## How is the tutorial organized ##

As the computer used for the course haven't Git, we have structurated the project to allow a Git-less use. The `app` directory is the main directory of the project, the working version of the code. The tutorial is divided in steps, each one in its own directory:

1. [Static HTML](./step-01/)
1. [Using Polymer elements](./step-02/)
1. [Creating a new element](./step-03/)
1. [Filtering and sorting](./step-04/)

In each step directory you have a README file that explain the objective of the step, that you will do in the working directory `app`. If you have problems or if you get lost, you also have the solution of each step in the step directories. 