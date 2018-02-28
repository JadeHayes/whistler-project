var lifts = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  prefetch: 'http://localhost:5000/lifts_search.json'
});

var skiruns = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  prefetch: 'http://localhost:5000/skiruns_search.json'
});

$('#multiple-datasets .typeahead').typeahead({
  highlight: true
},
{
  name: 'lift-names',
  display: 'name',
  source: lifts,
  templates: {
    header: '<h3 class="league-name">Lifts</h3>'
  }
},
{
  name: 'lift-names',
  display: 'name',
  source: skiruns,
  templates: {
    header: '<h3 class="league-name">Skiruns</h3>'
  }
});

$('.typeahead').bind('typeahead:select', function(ev, suggestion) {
  console.log('Selection: ' + suggestion.name);
  window.location.href = "/" + suggestion.name;
});