checkElement('a') //use whichever selector you want
  .then(() => setTargetBlank());


function setTargetBlank() {
  const links = document.getElementsByTagName('a');
  for (var i = 0; i < links.length; i++) {
      links[i].target = '_blank';
  }
}

function rafAsync() {
  return new Promise(resolve => {
      requestAnimationFrame(resolve); //faster than set time out
  });
}

async function checkElement(selector) {
  let querySelector = document.querySelector(selector);
  while (querySelector === null) {
      await rafAsync();
      querySelector = document.querySelector(selector);
  }
  return querySelector;
}

function generateGitHubStatistic(canvas) {
  const context = canvas.getContext("2d");
  new Chart(context, {
    type: 'horizontalBar',

    data: {
      labels: gitHub.repos,

      datasets: [{
        label: 'Additions',
        data: gitHub.additions,
        backgroundColor: 'rgba(147, 196, 125, .4)',
        borderColor: 'rgba(147, 196, 125, 1)',
        borderWidth: 1,
        datalabels: {
          anchor: 'end',
          align: 'right',
          color: 'rgba(147, 196, 125, 1)'
        }
      }, {
        label: 'Deletions',
        data: gitHub.deletions,
        backgroundColor: 'rgba(204, 65, 37, .4)',
        borderColor: 'rgba(204, 65, 37, 1)',
        borderWidth: 1,
        datalabels: {
          formatter: Math.abs,
          anchor: 'start',
          align: 'left',
          color: 'rgba(204, 65, 37, 1)'
        }
      }]
    },

    options: {
      scales: {

        xAxes: [{
          ticks: {
            suggestedMin: Math.min(...gitHub.deletions) * 1.5,
            suggestedMax: Math.max(...gitHub.additions) * 1
          }
        }],

        yAxes: [{
          stacked: true,
          ticks: {
            fontSize: 20,
            fontColor: '#fff',
            callback: function(value, index, values) {
              return (value + '\n (' + gitHub.files[index] + ' files changed)');
            }
          }
        }]
      },

      legend: {
        display: true,
        position: 'bottom',
        reverse: true,
        labels: {
          boxWidth: 100,
          fontSize: 12,
          fontStyle: 'normal',
          fontColor: '#fff'
        }
      },

      tooltips: {
        enabled: false,
        intersect: false,
        mode: 'index',
        position: 'nearest',
        callbacks: {
          label: function(tooltipItem, data) {
            var label = data.datasets[tooltipItem.datasetIndex].label || '';

            if (label) {
              label += ': ';
            }

            label += Math.abs(tooltipItem.xLabel);
            return label;
          }
        }
      },

      plugins: {
        datalabels: {
          display: true
        }
      }
    }
  });
}
