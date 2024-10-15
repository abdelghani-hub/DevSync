<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <link href="assets/css/style.css" rel="stylesheet"/>
    <title>DevSync _ Tasks-statistics</title>
</head>
<body>

<jsp:include page="layouts/header.jsp"/>

<section class="bg-gray-50 dark:bg-gray-900">

    <%--    Chart --%>
    <div class="max-w-screen-xl px-4 mx-auto lg:px-12 w-full">

        <div class="flex w-full py-4 justify-center items-center border-gray-200 border-b dark:border-gray-700">
            <%-- Period --%>
            <form action="${pageContext.request.contextPath}/api/tasks" method="post"
                  class="flex justify-between items-center gap-8">
                <%-- Month--%>
                <div class="flex justify-between items-center">
                    <!-- Button -->
                    <button
                            id="dropdownMonthButton"
                            data-dropdown-toggle="month-dropdown"
                            data-dropdown-placement="bottom"
                            class="text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-gray-900 text-center inline-flex items-center dark:hover:text-white"
                            type="button">
                        Month
                        <svg class="w-2.5 m-2.5 ms-1.5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                             fill="none" viewBox="0 0 10 6">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="m1 1 4 4 4-4"></path>
                        </svg>
                    </button>
                    <div id="month-dropdown"
                         class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">

                        <!-- Month Selector -->
                        <ul class="custom-radio-selector py-2 text-sm text-gray-700 dark:text-gray-200"
                            aria-labelledby="dropdownMonthButton">
                            <%-- All --%>
                            <li class="px-4">
                                <input type="radio" id="all_months" name="month" value="all">
                                <label for="all_months"
                                       class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    All
                                </label>
                            </li>
                            <%-- Jan --%>
                            <li class="px-4">
                                <input type="radio" id="jan" name="month" value="1">
                                <label for="jan" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    January
                                </label>
                            </li>
                            <%-- Feb --%>
                            <li class="px-4">
                                <input type="radio" id="feb" name="month" value="2">
                                <label for="feb" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    February
                                </label>
                            </li>
                            <%-- Mar --%>
                            <li class="px-4">
                                <input type="radio" id="mar" name="month" value="3">
                                <label for="mar" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    March
                                </label>
                            </li>
                            <%-- Apr --%>
                            <li class="px-4">
                                <input type="radio" id="apr" name="month" value="4">
                                <label for="apr" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    April
                                </label>
                            </li>
                            <%-- May --%>
                            <li class="px-4">
                                <input type="radio" id="may" name="month" value="5">
                                <label for="may" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    May
                                </label>
                            </li>
                            <%-- Jun --%>
                            <li class="px-4">
                                <input type="radio" id="jun" name="month" value="6">
                                <label for="jun" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    June
                                </label>
                            </li>
                            <%-- Jul --%>
                            <li class="px-4">
                                <input type="radio" id="jul" name="month" value="7">
                                <label for="jul" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    July
                                </label>
                            </li>
                            <%-- Aug --%>
                            <li class="px-4">
                                <input type="radio" id="aug" name="month" value="8">
                                <label for="aug" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    August
                                </label>
                            </li>
                            <%-- Sep --%>
                            <li class="px-4">
                                <input type="radio" id="sep" name="month" value="9">
                                <label for="sep" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    September
                                </label>
                            </li>
                            <%-- Oct --%>
                            <li class="px-4">
                                <input type="radio" id="oct" name="month" value="10">
                                <label for="oct" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    October
                                </label>
                            </li>
                            <%-- Nov --%>
                            <li class="px-4">
                                <input type="radio" id="nov" name="month" value="11">
                                <label for="nov" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    November
                                </label>
                            </li>
                            <%-- Dec --%>
                            <li class="px-4">
                                <input type="radio" id="dec" name="month" value="12">
                                <label for="dec" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    December
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>

                <%-- Year--%>
                <div class="flex justify-between items-center">
                    <!-- Button -->
                    <button
                            id="dropdownYearButton"
                            data-dropdown-toggle="year-dropdown"
                            data-dropdown-placement="bottom"
                            class="text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-gray-900 text-center inline-flex items-center dark:hover:text-white"
                            type="button">
                        Year
                        <svg class="w-2.5 m-2.5 ms-1.5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                             fill="none" viewBox="0 0 10 6">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="m1 1 4 4 4-4"></path>
                        </svg>
                    </button>
                    <div id="year-dropdown"
                         class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                        <!-- Year Selector -->
                        <ul class="custom-radio-selector py-2 text-sm text-gray-700 dark:text-gray-200"
                            aria-labelledby="dropdownYearButton">
                            <%-- All --%>
                            <li class="px-4">
                                <input type="radio" id="all_years" name="year" value="all">
                                <label for="all_years"
                                       class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    All
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2024" name="year" value="2024">
                                <label for="2024" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2024
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2023" name="year" value="2023">
                                <label for="2023" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2023
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2022" name="year" value="2022">
                                <label for="2022" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2022
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2021" name="year" value="2021">
                                <label for="2021" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2021
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2020" name="year" value="2020">
                                <label for="2020" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2020
                                </label>
                            </li>
                            <li class="px-4">
                                <input type="radio" id="2019" name="year" value="2019">
                                <label for="2019" class="w-full cursor-pointer transition duration-150 ease-in-out">
                                    2019
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>

                <%-- tags--%>
                <div class="flex items-center w-full space-x-3 md:w-auto">
                    <button id="filterDropdownButton" data-dropdown-toggle="filterDropdown"
                            class="flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-lg md:w-auto focus:outline-none hover:bg-gray-100 hover:text-primary-700 focus:z-10 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
                            type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="w-4 h-4 mr-2 text-gray-400"
                             viewbox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd"
                                  d="M3 3a1 1 0 011-1h12a1 1 0 011 1v3a1 1 0 01-.293.707L12 11.414V15a1 1 0 01-.293.707l-2 2A1 1 0 018 17v-5.586L3.293 6.707A1 1 0 013 6V3z"
                                  clip-rule="evenodd">
                            </path>
                        </svg>
                        Tags
                        <svg class="-mr-1 ml-1.5 w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                             xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                            <path clip-rule="evenodd" fill-rule="evenodd"
                                  d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z">
                            </path>
                        </svg>
                    </button>
                    <!-- Dropdown menu -->
                    <div id="filterDropdown" class="z-10 hidden w-48 p-3 bg-white rounded-lg shadow dark:bg-gray-700">
                        <ul class="space-y-2 text-sm" aria-labelledby="dropdownDefault">
                            <c:forEach var="tag" items="${tags}">
                                <li class="flex items-center">
                                    <input name="tags_ids[]" id="${tag.name}" type="checkbox" value="${tag.id}"
                                           class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500"/>
                                    <label for="${tag.name}"
                                           class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100">
                                            ${tag.name}
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <%-- Submit Button --%>
                <button type="submit"
                        class="flex items-center justify-center w-full px-6 py-2 text-sm font-medium text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 rounded-lg focus:outline-none focus:ring-4 focus:ring-cyan-300 dark:focus:ring-cyan-800 dark:hover:font-bold">
                    Filter
                </button>
            </form>
        </div>

        <!-- Line Chart -->
        <div class="py-6" id="pie-chart"></div>
    </div>

</section>

<jsp:include page="layouts/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<% /* Chart script */ %>
<script>
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
</script>
</body>
</html>