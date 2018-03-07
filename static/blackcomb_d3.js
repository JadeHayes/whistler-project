// <!-- Blackcomb -->

(function(){
var margin = {top: 20, right: 120, bottom: 20, left: 120},
    width = (960 - margin.left)/2,
    height = 600 - margin.top - margin.bottom;

function adjustx(x){
  // console.log(width,x);
  return x;
    // return width - x;
  }

  // If both whistler & bc are open draw line to connect p2p

  var left =true;

var i = 0,
    duration = 750,
    root;

var tree = d3.layout.tree()
    .size([height, width]);

var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

var svg = d3.select("#d3map").append("svg")
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + (margin.left+2) + "," + margin.top + ")");

d3.json("myflare.json", function(error, flare) {
  if (error) throw error;

  root = flare;
  root.x0 = height / 2;
  root.y0 = 0;

  function collapse(d) {
    if (d.children) {
      d._children = d.children;
      d._children.forEach(collapse);
      d.children = null;
    }
  }

  root.children.forEach(collapse);
  update(root,left);
});

d3.select(self.frameElement).style("height", "800px");

function update(source,leftSide ) {

  // Compute the new tree layout.
  var nodes = tree.nodes(root).reverse(),
      links = tree.links(nodes);

      var orientation = {
        left: {
          forEach: function(d) {d.y = d.depth * 180},
          x: function(d) { return d.children || d._children ?  -15:15 ; },
          textAnchor: function(d) { return d.children || d._children ? "end":"start" ; }
        },
        right: {
          forEach:function(d) {d.y = d.depth * -180},
          x:function(d) { return d.children || d._children ?  10:-10 ; },
          textAnchor:function(d) { return d.children || d._children ? "start":"end" ; }
        }
      }

      var api = orientation.left;
      if (!leftSide ){
        api = orientation.right;
      }


  // Normalize for fixed-depth.
  // nodes.forEach(function(d) { d.y = d.depth * -180; });
  nodes.forEach(api.forEach);

  // Update the nodes…
  var node = svg.selectAll("g.node")
      .data(nodes, function(d) { return d.id || (d.id = ++i); });

  // Enter any new nodes at the parent's previous position.
  var nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + source.y0 + "," + adjustx(source.x0) + ")"; })
      .on("click", click);

  nodeEnter.append("circle")
      .attr("r", 1e-6)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

  nodeEnter.append("text")
      .attr("x", api.x)
      .attr("dy", ".65em")
      .attr("text-anchor", api.textAnchor)
      .html(function(d) { 
                let run = d.name
                console.log(run)
                return "<a href=/" + encodeURIComponent(run) + ">" + run + "</a>"})
      .style("fill-opacity", 1e-6);

  // Transition nodes to their new position.
  var nodeUpdate = node.transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + d.y + "," + adjustx(d.x) + ")"; });

  nodeUpdate.select("circle")
      .attr("r", 4.5)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

  nodeUpdate.select("text")
      .style("fill-opacity", 1);

  // Transition exiting nodes to the parent's new position.
  var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + source.y + "," + adjustx(source.x) + ")"; })
      .remove();

  nodeExit.select("circle")
      .attr("r", 1e-6);

  nodeExit.select("text")
      .style("fill-opacity", 1e-6);

  // Update the links…
  var link = svg.selectAll("path.link")
      .data(links, function(d) { return d.target.id; });

  // Enter any new links at the parent's previous position.
  link.enter().insert("path", "g")
      .attr("class", "link")
      .attr("d", function(d) {
        var o = {x: adjustx(source.x0), y: source.y0};
        return diagonal({source: o, target: o});
      });

  // Transition links to their new position.
  link.transition()
      .duration(duration)
      .attr("d", diagonal);

  // Transition exiting nodes to the parent's new position.
  link.exit().transition()
      .duration(duration)
      .attr("d", function(d) {
        var o = {x: adjustx(source.x), y: source.y};
        return diagonal({source: o, target: o});
      })
      .remove();

  // Stash the old positions for transition.
  nodes.forEach(function(d) {
    d.x0 = adjustx(d.x);
    d.y0 = d.y;
  });
}

// Toggle children on click.
function click(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  update(d,true);
}})();