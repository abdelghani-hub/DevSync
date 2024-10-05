<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <title>DevSync _ users</title>
</head>
<body>

<!-- -->
<jsp:include page="../layouts/header.jsp"/>

<div class="container min-h-screen dark:bg-gray-900">

    <section class="bg-gray-50 dark:bg-gray-900 py-3 sm:py-5">
        <div class="px-4 mx-auto max-w-screen lg:px-12">
            <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg">
                <div class="overflow-y-scroll">
                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="p-4">
                                <div class="flex items-center">
                                    <input id="checkbox-all" type="checkbox"
                                           class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                    <label for="checkbox-all" class="sr-only">checkbox</label>
                                </div>
                            </th>
                            <th scope="col" class="px-4 py-3">UserName</th>
                            <th scope="col" class="px-4 py-3">Email</th>
                            <th scope="col" class="px-4 py-3">Role</th>
                            <th scope="col" class="px-4 py-3">First Name</th>
                            <th scope="col" class="px-4 py-3">Last name</th>
                            <th scope="col" class="px-4 py-3">Actions</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach var="user" items="${users}">
                        <tr class="border-b dark:border-gray-600 hover:bg-gray-100 dark:hover:bg-gray-700">
                            <td class="w-4 px-4 py-3">
                                <div class="flex items-center">
                                    <input id="checkbox-table-search-1" type="checkbox"
                                           class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                    <label for="checkbox-table-search-1" class="sr-only">checkbox</label>
                                </div>
                            </td>
                            <th scope="row"
                                class="flex items-center px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                <img src="https://flowbite.s3.amazonaws.com/blocks/application-ui/products/imac-front-image.png"
                                     alt="iMac Front Image" class="w-auto h-8 mr-3">
                                    ${user.username}
                            </th>
                            <td class="px-4 py-2">
                            <span class="bg-primary-100 text-primary-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-primary-900 dark:text-primary-300">
                                    ${user.email}
                            </span>
                            </td>
                            <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                <div class="flex items-center justify-center">
                                    <c:if test="${user.role == 'user'}">
                                        <span class="bg-violet-100 text-green-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-green-900 dark:text-green-300">
                                                ${user.role}
                                        </span>
                                    </c:if>
                                    <c:if test="${user.role == 'manager'}">
                                        <span class="bg-cyan-100 text-cyan-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-cyan-900 dark:text-yellow-300">
                                            ${user.role}
                                        </span>
                                    </c:if>
                                </div>
                            </td>
                            <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${user.firstName}</td>
                            <td class="px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">${user.lastName}</td>
                            <td class="flex items-center x-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                <%-- Edit --%>
                                <div>
                                    <a href="${pageContext.request.contextPath}/users/${user.id}/edit"
                                       class="text-gray-900 bg-gradient-to-r from-lime-200 via-lime-400 to-lime-500 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-lime-300 dark:focus:ring-lime-800 shadow-lg shadow-lime-500/50 dark:shadow-lg dark:shadow-lime-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Edit</a>
                                </div>

                                <%-- Delete --%>
                                <form action="${pageContext.request.contextPath}/users/delete"
                                        method="post"
                                        class="flex p-0 m-0">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <button type="submit" value="Delete"
                                        class="delete-btn text-white bg-gradient-to-r from-red-400 via-red-500 to-red-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 shadow-lg shadow-red-500/50 dark:shadow-lg dark:shadow-red-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
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
            const isConfirmed = confirm('Are you sure you want to delete this user?');
            if (isConfirmed) {
                e.target.closest('form').submit();
            }
        });
    });
</script>
</body>
</html>