<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html class="dark">
<head>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet"/>
    <title>DevSync _ tags</title>
</head>
<body>

<!-- -->
<jsp:include page="../layouts/header.jsp"/>

<section class="bg-gray-50 dark:bg-gray-900 py-3 sm:py-5 ">
    <div class="px-4 mx-auto lg:px-12 ">
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg">
            <div class="">
                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr class="w-full">
                        <th scope="col" class="px-4 py-3 text-center w-40">
                            <a href="${pageContext.request.contextPath}/tags?action=create"
                               class="bg-blue-300 text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-500 dark:focus:ring-blue-800">
                                Create Tag
                            </a>
                        </th>
                        <th scope="col" class="px-4 py-3 text-center">Name</th>
                        <th scope="col" class="px-4 py-3 text-center">Usages</th>
                        <th scope="col" class="px-4 py-3 text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:if test="${empty tags}">
                        <tr>
                            <td colspan="7" class="text-center p-4 dark:text-white">No tags found</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty tags}">
                        <c:forEach var="tag" items="${tags}">
                            <tr class="border-b dark:border-gray-600">
                                <td class="w-4 px-4 py-3">
                                    <div class="flex items-center">
                                        <input id="checkbox-table-search-1" type="checkbox"
                                               class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                        <label for="checkbox-table-search-1" class="sr-only">checkbox</label>
                                    </div>
                                </td>
                                <th scope="row"
                                    class="flex items-center justify-center px-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        ${tag.name}
                                </th>
                                <td class="px-4 py-2 text-center">
                                    <span class="bg-cyan-100 text-cyan-800 text-xs font-medium px-2 py-0.5 rounded dark:bg-cyan-900 dark:text-cyan-300">
                                            ${tag.getUsages()}
                                    </span>
                                </td>
                                <td class="flex items-center justify-center x-4 py-2 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        <%-- Edit --%>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/tags?action=edit&id=${tag.id}"
                                           class="text-blue-700 hover:text-white border border-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-green-500 dark:text-green-500 dark:hover:text-white dark:hover:bg-green-500 dark:focus:ring-green-800">Edit</a>
                                    </div>

                                        <%-- Delete --%>
                                    <form action="${pageContext.request.contextPath}/tags?action=delete"
                                          method="post"
                                          class="flex p-0 m-0">
                                        <input type="hidden" name="id" value="${tag.id}">
                                        <button type="submit" value="Delete"
                                                class="delete-btn text-red-700 hover:text-white border border-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600 dark:focus:ring-red-900">
                                            Delete
                                        </button>
                                    </form>
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

<jsp:include page="../layouts/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
<script>
    const deleteBtns = document.querySelectorAll('.delete-btn');
    deleteBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const isConfirmed = confirm('Are you sure you want to delete this tag?');
            if (isConfirmed) {
                e.target.closest('form').submit();
            }
        });
    });
</script>
</body>
</html>