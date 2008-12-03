function JPowerFile(file, code){
    this.file = file;
    this.code = code;
    this.statements = {};
}

$.extend(JPowerFile.prototype, {
    show: function() {
//        console.log('Updating coverage for ' + this.file);

        var code = this.code;
        var newCode = '';
        var index = 0;
        var file = this;

        var statementCount = 0;
        var executedStatementCount = 0;

        for(var start in file.statements) {
            statementCount++;
            var statement = file.statements[start];
           // console.log(this.file + ':' + start + '(' + statement.length +  '):' + statement.executionCount);

            newCode += code.substr(index, start - index);

            var statementCode = code.substr(start, statement.length);
            var statementExecuted = statement.executionCount > 0;

            if (statementExecuted) executedStatementCount++;

            var spanClass =  statementExecuted ? 'coverage-hit' : 'coverage-not-hit';
            newCode += '<span class="' + spanClass + '">' + statementCode + '</span>';

            index = parseInt(start) + statement.length;
        }
        var theRest = code.substr(index, code.length - index);

        var lineCount = code.split('\n').length;

        var line_numbers = '';
        for(var i = 1; i <= lineCount; i++)
            line_numbers += i + '\n'

        line_numbers = line_numbers.substr(0, line_numbers.length - 1);

        var fileKey = JPower.codeKey(this.file);
        var coverageDivId = 'coverage-' + fileKey;

        $('#coverage #' + coverageDivId).remove();
        $('#coverage')
            .append('<div id="' + coverageDivId + '" class="coverage-file"></div>')
                .children('.coverage-file')
                .append('<div class="coverage-file-header"><span>' + this.file + '</span><span>'+ executedStatementCount +' of '+ statementCount +' statements hit</span></div>')
                .append('<pre class="line-numbers">'+line_numbers+'</pre>')
                .append('<pre class="code"><code class="javascript"></code></pre>')
                .append('<div style="clear:both"></div>')
                .children('.code').children('code')
                    .append(newCode + theRest);
    }
});

JPower = {
  files: {},
  
  codeKey: function(file) {
      return file.replace(/\./g, '-').replace(/\//g, '-');
  },

  code: function(file, code) {
      if (!JPower.files[file]) {
          JPower.files[file] = new JPowerFile(file, code);
      }
  },

  add: function(file, start, length) {
      var statement = JPower.files[file].statements[start] = {};
      statement.length = length;
      statement.executionCount = 0;
      JPower.files[file].show();
  },
  record: function(file, start) {
      var statement = JPower.files[file].statements[start];
      statement.executionCount++;
      JPower.files[file].show();
      return true;
  }
};


$(document).ready(function(){
    $('#testresult, #tests').livequery(function(){
      for(var file in JPower.files) { JPower.files[file].show(); }
    });
});