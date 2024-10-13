<%@ page import="org.youcode.devsync.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <title>DevSync _ Requests</title>
</head>
<body>

<jsp:include page="../layouts/header.jsp"/>

<div class="container dark:bg-gray-900 h-screen">

    <section class="bg-gray-50 dark:bg-gray-900 py-3 sm:py-5">
        <div class="px-4 mx-auto">
            <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg">
                <div>
                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-4 py-3">Requester</th>
                            <th scope="col" class="px-4 py-3">Task</th>
                            <th scope="col" class="px-4 py-3">Type</th>
                            <th scope="col" class="px-4 py-3">Requested at</th>
                            <th scope="col" class="px-4 py-3">Status</th>
                            <c:if test="${user.role == 'manager'}">
                                <th scope="col" class="px-4 py-3">Actions</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>

                        <c:if test="${empty requests}">
                            <tr>
                                <td colspan="6" class="text-center p-4 dark:text-white">No requests found</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty requests}">
                            <c:forEach var="request" items="${requests}">
                                <tr class="border-b dark:border-gray-600">
                                    <td
                                            class="px-4 py-2">
                                            ${request.requester.username}
                                    </td>
                                        <%-- Desc --%>
                                    <td class="px-4 py-2">
                                        <span class="bg-primary-100 text-primary-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-primary-900 dark:text-primary-300">
                                                ${request.task.title}
                                        </span>
                                    </td>
                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        <div class="flex">
                                            <c:if test="${request.type == 'MODIFICATION'}">
                                                <span class="bg-blue-100 text-blue-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                        Modification
                                                </span>
                                            </c:if>
                                            <c:if test="${request.type == 'DELETION'}">
                                                <span class="bg-red-100 text-red-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-red-900 dark:text-red-300">
                                                        Deletion
                                                </span>
                                            </c:if>
                                        </div>
                                    </td>

                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${request.requestedAt}</td>

                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        <div class="flex">
                                            <c:if test="${request.status == 'PENDING'}">
                                                <span class="bg-cyan-100 text-cyan-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-cyan-900 dark:text-cyan-300">
                                                        Pending
                                                </span>
                                            </c:if>
                                            <c:if test="${request.status == 'REJECTED'}">
                                                <span class="bg-yellow-100 text-yellow-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300">
                                                        Rejected
                                                </span>
                                            </c:if>
                                            <c:if test="${request.status == 'ACCEPTED'}">
                                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-green-900 dark:text-green-300">
                                                        Accepted
                                                </span>
                                            </c:if>
                                        </div>
                                    </td>

                                        <%-- Actions --%>
                                    <c:if test="${user.role == 'manager'}">
                                        <td class="flex items-center justify-center x-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            <c:if test="${request.status == 'PENDING' or request.status == 'REJECTED'}">
                                                <form action="${pageContext.request.contextPath}/requests?action=accept"
                                                      method="post"
                                                      class="flex p-0 m-0">
                                                    <input type="hidden" name="id" value="${request.id}">
                                                    <button type="submit" value="Delete"
                                                            class="delete-btn text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-600 dark:focus:ring-blue-900">
                                                        Accept
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${request.status == 'PENDING'}">
                                                <form action="${pageContext.request.contextPath}/requests?action=reject"
                                                      method="post"
                                                      class="flex p-0 m-0">
                                                    <input type="hidden" name="id" value="${request.id}">
                                                    <button type="submit" value="Delete"
                                                            class="delete-btn text-yellow-700 hover:text-white border border-yellow-700 hover:bg-yellow-800 focus:ring-4 focus:outline-none focus:ring-yellow-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-yellow-500 dark:text-yellow-500 dark:hover:text-white dark:hover:bg-yellow-600 dark:focus:ring-yellow-900">
                                                        Reject
                                                    </button>
                                                </form>
                                            </c:if>

                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

</div>

<jsp:include page="../layouts/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
<script>
    const deleteBtns = document.querySelectorAll('.delete-btn');
    deleteBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const isConfirmed = confirm('Are you sure you want to delete this task?');
            if (isConfirmed) {
                e.target.closest('form').submit();
            }
        });
    });
</script>
</body>
</html>