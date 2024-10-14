<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <title>DevSync _ Tasks-Edit</title>
</head>
<body>

<!-- -->
<jsp:include page="../layouts/header.jsp"/>

<section class=" bg-gray-50 dark:bg-gray-900">
    <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto">
        <a href="${pageContext.request.contextPath}" class="flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white">
            <img class="w-8 h-8 mr-2" src="assets/images/logo.png" alt="logo">
            DevSync
        </a>
        <div class="w-1/2 bg-white rounded-lg shadow dark:border md:mt-0 dark:bg-gray-800 dark:border-gray-700">
            <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
                <h1 class="text-center text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
                    Modify Task
                </h1>
                <form class="space-y-4 md:space-y-6" action="${pageContext.request.contextPath}/requests?action=acceptModify"
                      method="post">
                    <input type="hidden" name="request_id" value="${request.id}">

                    <c:if test="${user.role == 'manager'}">
                        <div>
                            <label for="modified_to"
                                   class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Assign To</label>
                            <select id="modified_to" name="modified_to"
                                    class="block w-full p-2.5 text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-200 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                <c:forEach var="emp" items="${users}">
                                    <option value="${emp.id}">
                                        ${emp.username}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>

                    <button type="submit"
                            class="w-full text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
                        Assign Task
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layouts/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>