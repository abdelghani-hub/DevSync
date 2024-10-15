
    // Global variable to store the chart instance
    let chart;

    // Function to get chart options
    const getChartOptions = (data) => {
    return {
    series: [
    parseFloat(data.todo),
    parseFloat(data.pending),
    parseFloat(data.done),
    parseFloat(data.overdue)
    ],
    colors: ["#1C64F2", "#9061F9", "#52fc94", "#b2b2b2"],
    chart: {
    height: 420,
    width: "100%",
    type: "pie",
},
    title: {
    text: 'Tasks Statistics (' + data.tasks_total + ')',
    align: 'center',
    style: {
    fontSize: '20px',
    fontWeight: 'bold',
    color: '#70a6bb'
}
},
    stroke: {
    colors: ["white"],
    lineCap: "",
},
    plotOptions: {
    pie: {
    labels: {
    show: true,
},
    size: "100%",
    dataLabels: {
    offset: -25
}
},
},
    labels: ["Todo", "Pending", "Done", "Overdue"],
    dataLabels: {
    enabled: true,
    style: {
    fontFamily: "Inter, sans-serif",
},
},
    legend: {
    position: "bottom",
    fontFamily: "Inter, sans-serif",
},
    yaxis: {
    labels: {
    formatter: function (value) {
    return value + "%"
},
},
},
    xaxis: {
    labels: {
    formatter: function (value) {
    return value + "%"
},
},
    axisTicks: {
    show: false,
},
    axisBorder: {
    show: false,
},
},
}
};

    // Function to update the chart
    const updateChart = (data) => {
    const chartElement = document.getElementById("pie-chart");
    if (chartElement && typeof ApexCharts !== 'undefined') {
    if (data.tasks_total == 0) {
    if (chart) {
    chart.destroy();
    chart = null;
}
    chartElement.innerHTML = "<h1 class='text-center text-2xl text-gray-500 dark:text-gray-400'>No Tasks found!</h1>";
    return 0;
} else {
    chartElement.innerHTML = "";
    if (chart) {
    // If chart exists, update its data
    chart.updateOptions(getChartOptions(data));
} else {
    // If chart doesn't exist, create a new one
    chart = new ApexCharts(chartElement, getChartOptions(data));
    chart.render();
}
}
}
};

    // Function to make the POST request and update the chart
    const fetchDataAndUpdateChart = async () => {
    const form = document.querySelector('form[action="${pageContext.request.contextPath}/api/tasks"]');
    if (!form) return;

    try {
    const response = await fetch(form.action, {
    method: 'POST',
    headers: {
    'Content-Type': 'application/json',
},
    body: JSON.stringify({}),
});

    if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
}

    const data = await response.json();
    updateChart(data);
} catch (error) {
    console.error('Error fetching data:', error);
}
};

    // Call the function when the page loads
    document.addEventListener('DOMContentLoaded', fetchDataAndUpdateChart);

    // Update the chart when the form is submitted
    document.querySelector('form[action="${pageContext.request.contextPath}/api/tasks"]')?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const formData = new FormData(event.target);
    // get data from the form year and month
    const data = {
    month: formData.get('month'),
    year: formData.get('year')
};

    // Convert tags_ids to an array of strings
    data.tagsIds = formData.getAll('tags_ids[]').map(String);
    console.log(data.tagsIds);
    try {
    const response = await fetch(event.target.action, {
    method: 'POST',
    headers: {
    'Content-Type': 'application/json',
},
    body: JSON.stringify(data),
});

    if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
}

    const responseData = await response.json();
    updateChart(responseData);
} catch (error) {
    console.error('Error submitting form:', error);
}
});