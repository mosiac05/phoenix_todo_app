# tinyMCE (v6) formula plugin

Formula plugin for tinyMCE (v6) WYSIWYG editor hook in a Phoenix Liveview project. Allows user to add equations and formulas inside tinymce.

This is an updated version of the tinyMCE Plugin. The original plugin was created by [TSAVDARIS Panagiotis](https://github.com/ptsavdar) and can be found at [https://github.com/ptsavdar/tinymce-formula].

## Browser compatibility

* IE8+
* Chrome
* Firefox
* Safari
* Opera

## Dependencies

* [tinyMCE](http://www.tinymce.com/)

## Usage for Phoenix Liveview project

Clone or download the repo into your `priv/static/images` directory.
Add configuration options for the formula plugin.

```javascript
external_plugins: {
    'formula': '/images/tinymce-formula/plugin.min.js'
},
```

Add the 'formula' plugin into the 'toolbar' option.
```javascript
toolbar: ... + 'formula',
```

## License

MIT licensed

Copyright (C) 2016 iCAP Lyon1, Panagiotis Tsavdaris
