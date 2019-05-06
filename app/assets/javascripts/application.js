// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require materialize-form
//= require vue
//= require_tree .

// @import "materialize";
// @import "https://fonts.googleapis.com/icon?family=Material+Icons";


// Flash fade
$(function() {
  $('.alert-box').fadeIn('normal', function() {
     $(this).delay(3700).fadeOut();
  });
});

$(document).ready(function() {
  $(".button-collapse").sideNav({
    edge: 'right',
  });
  $(".dropdown-button").dropdown({
    hover: true,
    belowOrigin: true,
    });
});

// Search submit on enter
$(document).ready(function() {
  function submitForm() {
    document.getElementById("search").submit();
  }
  document.onkeydown = function () {
    if (window.event.keyCode == '13') {
        submitForm();
    }
  }
});


(function(){
 
  $("#cart").on("mouseover", function() {
    $(".shopping-cart").fadeIn("fast");
  });
  
})();

(function(){
 
  $("#cart").on("mouseleave", function() {
    $(".shopping-cart").on("mouseleave", function() {$(".shopping-cart").fadeOut("fast");})
  });
  
})();

$(document).ready(function(){
  $('.collapsible').collapsible();
});

$(document).ready(function(){
  $('.materialboxed').materialbox();
});

$(document).ready(function(){
  $('.slider').slider();
});

// Sticky footer js
// Thanks to Charles Smith for this -- http://foundation.zurb.com/forum/posts/629-sticky-footer
// $(window).bind("load", function () {
//   var footer = $("#footer");
//   var pos = footer.position();
//   var height = $(window).height();
//   height = height - pos.top;
//   height = height - footer.height();
//   if (height > 0) {
//       footer.css({
//           'margin-top': height + 'px'
//       });
//   }
// });




// HIGHCHARTS GRAPH

Highcharts.chart('overview-chart', {
  
  title: {
      text: 'Total Sales'
  },

  yAxis: {
      title: {
          text: 'Sales'
      }
  },
  legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle'
  },

  plotOptions: {
      series: {
          label: {
              connectorAllowed: false
          },
          pointStart: 2010
      }
  },

  series: [{
      name: 'Revenue',
      data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
  },],

  responsive: {
      rules: [{
          condition: {
              maxWidth: 500
          },
          chartOptions: {
              legend: {
                  layout: 'horizontal',
                  align: 'center',
                  verticalAlign: 'bottom'
              }
          }
      }]
  }

});


Highcharts.chart('popular-items', {
  chart: {
    plotBackgroundColor: null,
    plotBorderWidth: null,
    plotShadow: false,
    type: 'pie'
  },
  title: {
    text: 'Item Popularity'
  },
  tooltip: {
    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
  },
  plotOptions: {
    pie: {
      allowPointSelect: true,
      cursor: 'pointer',
      dataLabels: {
        enabled: true,
        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
        style: {
          color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
        }
      }
    }
  },
  series: [{
    name: 'Items',
    colorByPoint: true,
    data: [{
      name: 'Sourdough',
      y: 61.41,
      sliced: true,
      selected: true
    }, {
      name: 'Apple Cherry',
      y: 11.84
    }, {
      name: 'Crossiant',
      y: 10.85
    }, {
      name: 'Blueberry Muffin',
      y: 4.67
    }, {
      name: 'Honey Wheat',
      y: 4.18
    }, {
      name: 'Apple Carrot Muffin',
      y: 1.64
    },]
  }]
});


Highcharts.chart('top-customers', {
  chart: {
      type: 'column'
  },
  title: {
      text: 'Top Customers'
  },
  xAxis: {
      categories: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
      ],
      crosshair: true
  },
  yAxis: {
      min: 0,
      title: {
          text: 'Orders'
      }
  },
  tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
          '<td style="padding:0"><b>{point.y} orders</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
  },
  plotOptions: {
      column: {
          pointPadding: 0.2,
          borderWidth: 0
      }
  },
  series: [{
      name: 'Alec Lam',
      data: [49, 71, 106, 129, 144, 176, 135, 148, 216, 194, 95, 54]

  }, {
      name: 'Prof H',
      data: [83, 78, 98, 93, 106, 84, 105, 104, 91, 83, 106, 92]

  }, {
      name: 'Perry the Platypus',
      data: [48, 38, 39, 41, 47, 48, 59, 59, 52, 65, 59, 51]

  }, {
      name: 'CJ May',
      data: [42, 33, 34, 39, 52, 75, 57, 60, 47, 39, 46, 51]

  }]
});