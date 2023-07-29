(function () {
  "use strict";
  tinymce.util.Tools.resolve('tinymce.PluginManager').add('formula', function (editor, url) {
    var options = editor.getParam('formula') || {};
    var path = options.path || url;
    // console.log(path,editor);

    editor.addCommand('tinyMCEFormula', function () {
      // console.log("Adding Command::::::::::::::");
      const html = buildIFrame(editor, url)
      editor.windowManager.open({
        title: "Formula",
        size: "large",
        body: {
          type: 'panel',
          items: [{
            type: 'htmlpanel',
            html: html,
            name: 'formula'
          }]
        },
        buttons: [{
          type: 'cancel',
          name: 'cancel',
          text: 'Cancel'
        },
        {
          type: 'submit',
          name: 'save',
          text: 'Insert Formula',
          primary: true,
        }
        ],
        // initialData: { formula: html },
        onSubmit: function (e) {
          window.EditorObj.getEquationPng((src, mlang, equation) => {
            // console.log({src, mlang, equation});
            if (src) {
              editor.insertContent('<img class="fm-editor-equation" src="' + src + '" data-mlang="' + mlang + '" data-equation="' + encodeURIComponent(equation) + '"/>');
            }

            e.close()
          })
        }
      });
    });

    editor.ui.registry.addButton('formula', {
      // icon: path + '/img/formula.png',
      icon: 'insert-character',
      tooltip: 'Insert Formula',
      onAction: function () {
        // console.log("Adding Button:::::::::");
        editor.execCommand('tinyMCEFormula');
      }
    });

    editor.ui.registry.addMenuItem('formula', {
      icon: 'insert-character',
      text: 'Insert Formula',
      onAction: function () {
        // console.log("Adding to Menu:::::::::::::");
        editor.execCommand('tinyMCEFormula');
      }
    });

    function buildIFrame(editor, url) {
      var currentNode = editor.selection.getNode();
      var lang = editor.getParam('language') || 'en';
      var mlangParam = '';
      var equationParam = '';
      if (currentNode.nodeName.toLowerCase() == 'img' && currentNode.className.indexOf('fm-editor-equation') > -1) {
        if (currentNode.getAttribute('data-mlang')) mlangParam = "&mlang=" + currentNode.getAttribute('data-mlang');
        if (currentNode.getAttribute('data-equation')) equationParam = '&equation=' + currentNode.getAttribute('data-equation');
      }
      var html = '<iframe style="width: 100%; min-width: 100%; height: 500px; min-height: 100%;" name="tinymceFormula" id="tinymceFormula" src="' + url + '/index.html' + '?lang=' + lang + mlangParam + equationParam + '" scrolling="no" frameborder="0"></iframe>';
      return html;
    }
    return {};
  })
})();
