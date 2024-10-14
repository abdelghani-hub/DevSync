<%@ page import="org.youcode.devsync.model.User" %>
<%@ page import="org.youcode.devsync.model.UserRole" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <title>DevSync _ Tasks</title>
</head>
<body>

<jsp:include page="../layouts/header.jsp"/>

<div class="container dark:bg-gray-900">

    <section class="bg-gray-50 dark:bg-gray-900 py-3 sm:py-5">
        <div class="px-4 mx-auto">
            <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg">
                <a href="${pageContext.request.contextPath}/tasks?action=create"
                   class="absolute top-1 right-2 bg-blue-300 text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-3 py-2 text-center me-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-500 dark:focus:ring-blue-800">
                    Add Task
                </a>
                <div>
                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="p-4">
                                Mark as
                            </th>
                            <th scope="col" class="px-4 py-3">Title</th>
                            <th scope="col" class="px-4 py-3">Description</th>
                            <th scope="col" class="px-4 py-3">Tags</th>
                            <th scope="col" class="px-4 py-3">Status</th>
                            <th scope="col" class="px-4 py-3">Assigned To</th>
                            <th scope="col" class="px-4 py-3">Start Date</th>
                            <th scope="col" class="px-4 py-3">End Date</th>
                            <%
                                if (user.getRole() == UserRole.manager) {
                            %>
                            <th scope="col" class="px-4 py-3 text-center">Used Tokens</th>
                            <%
                                }
                            %>
                            <th scope="col" class="px-4 py-3 text-center">Actions</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:if test="${empty tasks}">
                            <tr>
                                <td colspan="9" class="text-center p-4 dark:text-white">No tasks found</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty tasks}">
                            <c:forEach var="task" items="${tasks}">

                                <tr class="relative border-b dark:border-gray-600">
                                    <td class="w-4 px-4 py-3">
                                        <c:if test="${task.status == 'pending' }">
                                            <form action="${pageContext.request.contextPath}/tasks?action=done"
                                                  method="post"
                                                  class="flex items-center p-0 m-0">
                                                <input type="hidden" name="id" value="${task.id}">
                                                <button type="submit"
                                                        class="text-white bg-gradient-to-br from-purple-600 to-blue-500 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">
                                                    Mark as Done
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${task.status == 'todo' or task.status == 'done'}">
                                            <form action="${pageContext.request.contextPath}/tasks?action=pending"
                                                  method="post"
                                                  class="flex items-center p-0 m-0">
                                                <input type="hidden" name="id" value="${task.id}">
                                                <button type="submit"
                                                        class="text-gray-900 bg-gradient-to-r from-teal-200 to-lime-200 hover:bg-gradient-to-l hover:from-teal-200 hover:to-lime-200 focus:ring-4 focus:outline-none focus:ring-lime-200 dark:focus:ring-teal-700 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">
                                                    Mark as Pending
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                        <%-- Title --%>
                                    <td class="px-4 py-2">
                                        <c:if test="${task.createdBy.equals(task.assignedTo)}">
                                            <div class="absolute top-1 right-1 bg-purple-100 text-purple-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-purple-900 dark:text-purple-300">
                                                EXTRA
                                            </div>
                                        </c:if>
                                            ${task.title}
                                    </td>
                                        <%-- Desc --%>
                                    <td class="px-4 py-2">
                                        <span class="bg-primary-100 text-primary-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-primary-900 dark:text-primary-300">
                                                ${task.description}
                                        </span>
                                    </td>
                                        <%-- Tags --%>
                                    <td class="px-4 py-2 flex flex-wrap gap-1">
                                        <c:forEach var="tag" items="${task.tags}">
                                            <span class="bg-gray-100 text-gray-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-gray-900 dark:text-gray-300">
                                                    ${tag.name}
                                            </span>
                                        </c:forEach>
                                    </td>
                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        <div class="flex">
                                            <c:if test="${task.status == 'todo'}">
                                                <span class="bg-blue-100 text-blue-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                        Todo
                                                </span>
                                            </c:if>
                                            <c:if test="${task.status == 'pending'}">
                                                <span class="bg-cyan-100 text-cyan-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-cyan-900 dark:text-yellow-300">
                                                        Pending..
                                                </span>
                                            </c:if>
                                            <c:if test="${task.status == 'done'}">
                                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-green-900 dark:text-green-300">
                                                        Done
                                                </span>
                                            </c:if>
                                            <c:if test="${task.status == 'overdue'}">
                                                <span class="bg-gray-100 text-gray-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-gray-100 dark:text-gray-500">
                                                        Overdue!
                                                </span>
                                            </c:if>
                                        </div>
                                    </td>

                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${task.assignedTo.username}</td>
                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${task.startDate}</td>
                                    <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${task.deadline}</td>

                                    <%
                                        if (user.getRole() == UserRole.manager) {
                                    %>
                                        <td class="text-center px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            <span class="bg-pink-500 text-pink-100 text-xs font-medium px-2 py-0.5 rounded">
                                                    ${task.requests.size()}
                                            </span>
                                        </td>
                                    <%
                                        }
                                    %>

                                    <td class="flex items-center justify-center x-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white"
                                        style="min-width: 300px">
                                            <%-- Actions --%>
                                        <c:if test="${not task.createdBy.equals(task.assignedTo) and user.role != 'manager'}">
                                            <form action="${pageContext.request.contextPath}/requests?action=save&type=MODIFICATION"
                                                  method="post"
                                                  class="flex p-0 m-0">
                                                <input type="hidden" name="task_id" value="${task.id}">

                                                <button type="submit" value="Request Replace"
                                                        class="delete-btn text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-500 dark:focus:ring-blue-800">
                                                    Request Modify
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/requests?action=save&type=DELETION"
                                                  method="post"
                                                  class="flex p-0 m-0">
                                                <input type="hidden" name="task_id" value="${task.id}">
                                                <button type="submit" value="Request Delete"
                                                        class="delete-btn text-red-700 hover:text-white border border-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                                    Request Delete
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${task.createdBy.equals(task.assignedTo) or user.role == 'manager'}">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/tasks?action=edit&id=${task.id}"
                                                   class="text-blue-700 hover:text-white border border-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-green-500 dark:text-green-500 dark:hover:text-white dark:hover:bg-green-500 dark:focus:ring-green-800">
                                                    Edit
                                                </a>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/tasks?action=delete"
                                                  method="post"
                                                  class="flex p-0 m-0">
                                                <input type="hidden" name="id" value="${task.id}">
                                                <button type="submit" value="Delete"
                                                        class="delete-btn text-red-700 hover:text-white border border-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                                    Delete
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
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